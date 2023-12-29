/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.controller.Escalation;
import com.eminent.issue.dao.EscalationDAO;
import com.eminent.issue.dao.EscalationDAOImpl;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.ResourceBundle;
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
 * @author vanithaalliraj
 */
public class EscalationIssues implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        EscalationDAO escalationDAO;
        List<Escalation> escalatdIssues;
        String content = "", contentHead = "", color = "white";
        int count;
        ResourceBundle rb = ResourceBundle.getBundle("Resources");
        String mail = rb.getString("mail");
        try {
            Calendar c = new GregorianCalendar();
            Date date = c.getTime();
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(date);
            if (holidaysList.isEmpty()) {
                escalationDAO = new EscalationDAOImpl();
                escalatdIssues = escalationDAO.getEscalation();
                if (escalatdIssues.size()>0) {
                    content = "<table style='width:99%;'>"
                            + "<tr style='background-color: red;height:21px;'>"
                            + "<td style='font-weight: bold;'>Issue#</td>"
                            + "<td style='font-weight: bold;'>Subject</td>"
                            + "<td style='font-weight: bold;'>Assigned To</td>"
                            + "<td style='font-weight: bold;'>Project Manager</td>"
                            + "<td style='font-weight: bold;'>Delivery Manager</td>"
                            + "<td style='font-weight: bold;'>Age</td>"
                            + "<td style='font-weight: bold;'>#days Escalated</td>"
                            + "<tr>";
                    count = 0;
                    for (Escalation e : escalatdIssues) {

                        if (count % 2 == 0) {
                            color = "white";
                        } else {
                            color = "#E8EEF7";
                        }
                        content = content + "<tr style='height:21px;background-color: " + color + ";'>"
                                + "<td >" + e.getIssueId() + "</td>"
                                + "<td >" + e.getSubject() + "</td>"
                                + "<td >" + e.getAssginedTo() + "</td>"
                                + "<td >" + e.getPmanager() + "</td>"
                                + "<td >" + e.getDmanager() + "</td>"
                                + "<td style=\"text-align: right;\">" + e.getDays() + "</td>"
                                + "<td style=\"text-align: right;\">" + e.getEscDays()+ "</td>"
                                + "</tr>";
                        count ++;
                    }
                    content = content + "</table>";
                    contentHead = "<div>Dear Escalation Team</div><br/> Please find below the  list of escalated issues <br/></br/>" + content;
                    contentHead = contentHead + "<br><br>Thanks,<br>eTracker&trade;<br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                    MimeMessage msg = MakeConnection.getMailConnections();
                    msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs\u2122 eTracker\u2122", "UTF-8"));
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress("pmuthuraaja@eminentlabs.net"));
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress("vanaja@eminentlabs.net"));
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress("tgopal@eminentlabs.net"));
                    msg.setSubject("List of " + escalatdIssues.size() + " Escalated Issues as on " + new SimpleDateFormat("dd-MM-yyyy").format(date));
                    msg.setContent(contentHead, "text/html");
                    if (mail.equalsIgnoreCase("Yes")) {
                        Transport.send(msg);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
