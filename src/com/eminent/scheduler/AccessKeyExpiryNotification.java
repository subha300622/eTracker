/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.gstn.AccessKey;
import com.eminent.gstn.AccessKeyController;
import com.eminent.util.GetProjects;
import com.eminent.util.Project;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Eminent
 */
public class AccessKeyExpiryNotification implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        String content = "", contentHead = "", color = "white", name, pmid, dmid;
        int count = 0;
        try {

            List<AccessKey> accessKey = new AccessKeyController().getExpirySoon();
            if (!accessKey.isEmpty()) {
                Map<String, List<AccessKey>> acceesky = new HashMap<>();
                List<Project> projects = GetProjects.getPMandDMForWorkingInProgressProjects();

                for (AccessKey ak : accessKey) {
                    List<AccessKey> list = acceesky.get(ak.getProjectName());
                    if (list == null) {
                        list = new ArrayList<AccessKey>();
                        acceesky.put(ak.getProjectName(), list);
                    }
                    list.add(ak);
                }

                for (Map.Entry<String, List<AccessKey>> entry : acceesky.entrySet()) {
                    name = "";
                    pmid = "";
                    dmid = "";
                    for (Project p : projects) {
                        if ((p.getPname() + ":" + p.getVerion()).equalsIgnoreCase(entry.getKey())) {
                            name = p.getPmName();
                            pmid = p.getPmEMail();
                            dmid = p.getDmEMail();

                        }
                    }
                    if (!pmid.equals("")) {
                        content = "<table style='width:90%;'>"
                                + "<tr style='background-color: #E8EEF7;height:21px;'>"
                                + "<td style='font-weight: bold;'>Project</td>"
                                + "<td style='font-weight: bold;'>Server Type</td>"
                                + "<td style='font-weight: bold;'>Access Type</td>"
                                + "<td style='font-weight: bold;'>Access Key</td>"
                                + "<td style='font-weight: bold;'>Expiry Date</td>"
                                + "<tr>";
                        count = 0;
                        for (AccessKey p : entry.getValue()) {
                            if (count % 2 == 0) {
                                color = "white";
                            } else {
                                color = "#E8EEF7";
                            }
                            content = content + "<tr style='height:21px;background-color: " + color + ";'>"
                                    + "<td >" + p.getProjectName() + "</td>"
                                    + "<td >" + p.getServerType() + "</td>"
                                    + "<td >" + p.getAccessType() + "</td>"
                                    + "<td >" + p.getAccessKey() + "</td>"
                                    + "<td >" + p.getExpiryDate() + "</td>"
                                    + "</tr>";
                            count++;
                        }
                        content = content + "</table>";
                        contentHead = "<div>Dear  <b>" + name + "</b></div><br/> Please find access key status for " + entry.getKey() + "<br/></br/>" + content;
                        contentHead = contentHead + "<br><br>Thanks,<br>eTracker&trade;<br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                        MimeMessage msg = MakeConnection.getMailConnections();
                        msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs\u2122 eTracker\u2122", "UTF-8"));
                        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(pmid));
                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress(dmid));
                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress("ttamilvelan@eminentlabs.net"));
                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress("gst@eminentlabs.net"));
                        msg.setSubject("Access Key Expiry Notification for " + entry.getKey() + "");
                        msg.setContent(contentHead, "text/html");
                        Transport.send(msg);

                    }
                }
            }
        } catch (Exception e) {

        }
    }
}
