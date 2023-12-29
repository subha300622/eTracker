/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.util.GetProjects;
import com.eminent.util.Project;
import com.eminentlabs.mom.MoMUtil;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
 * @author Muthu
 */
public class IssuePlanningRemainder implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            List<Project> projects = GetProjects.getPMandDMForWorkingInProgressProjects();
            Calendar c = new GregorianCalendar();
            Date date = c.getTime();
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(date);
            if (holidaysList.isEmpty()) {
                date = MoMUtil.nextDay(date);
                boolean flag = true;
                while (flag == true) {
                    holidaysList = HolidaysUtil.findByHolidayDate(date);
                    if (!holidaysList.isEmpty()) {
                        date = MoMUtil.nextDay(date);
                    } else {
                        flag = false;
                    }
                }
                Map<Long, Integer> getprojectwiseplannedcount = MoMUtil.getProjectwisePlannedIssuesCount(date);
                Map<Integer, List<Project>> pmwiseProjects = new HashMap<>();
                Map<Integer, List<Project>> dmwiseProjects = new HashMap<>();

                for (Project p : projects) {
                    List<Project> list = pmwiseProjects.get(p.getPmId());
                    if (list == null) {
                        list = new ArrayList<Project>();
                        pmwiseProjects.put(p.getPmId(), list);
                    }
                    list.add(p);

                    List<Project> lista = dmwiseProjects.get(p.getDmId());
                    if (lista == null) {
                        lista = new ArrayList<Project>();
                        dmwiseProjects.put(p.getDmId(), lista);
                    }
                    lista.add(p);
                }
                String mailid = "", name = "", content = "", contentHead = "", status = "", color = "white";
                int count = 0;
                for (Map.Entry<Integer, List<Project>> entry : pmwiseProjects.entrySet()) {
                    content = "<table style='width:80%;'><tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;'>Project</td><td style='font-weight: bold;'>Status</td><tr>";
                    count = 0;
                    for (Project p : entry.getValue()) {
                        if (count % 2 == 0) {
                            color = "white";
                        } else {
                            color = "#E8EEF7";
                        }
                        if (getprojectwiseplannedcount.containsKey(p.getPid())) {
                            content = content + "<tr style='height:21px;background-color: " + color + ";'><td >" + p.getPname() + " v" + p.getVerion() + "</td><td>Planned (" + getprojectwiseplannedcount.get(p.getPid()) + ")</td></tr>";
                        } else {
                            content = content + "<tr style='height:21px;background-color: " + color + ";'><td style='color=red;'>" + p.getPname() + " v" + p.getVerion() + "</td><td>Not Planned</td></tr>";
                            status = p.getPname() + " v" + p.getVerion() + "," + status;
                        }
                        name = p.getPmName();
                        mailid = p.getPmEMail();
                        count++;
                    }

                    if (!status.equalsIgnoreCase("")) {
                        content = content + "</table>";
                        contentHead = "<div>Dear  <b>" + name + "</b></div><br/> Please find your project's planning status for " + sdf.format(date) + "<br/></br/>" + content;
                        contentHead = contentHead + "<br/> Please plan the issues for <b>" + status.substring(0, status.length() - 1) + "</b> project(s) before 5 PM";
                        contentHead = contentHead + "<br><br>Thanks,<br>eTracker&trade;<br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                        MimeMessage msg = MakeConnection.getMailConnections();
                        msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs\u2122 eTracker\u2122", "UTF-8"));
                        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailid));
                        msg.addRecipient(Message.RecipientType.CC, new InternetAddress("ttamilvelan@eminentlabs.net"));
                        msg.setSubject("Project's Planning Status on " + sdf.format(date) + "");
                        msg.setContent(contentHead, "text/html");
                        Transport.send(msg);
                    }
                    status = "";

                }

                for (Map.Entry<Integer, List<Project>> entry : dmwiseProjects.entrySet()) {
                    content = "<table style='width:80%;'><tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;'>Project</td><td style='font-weight: bold;'>Status</td><tr>";
                    count = 0;
                    for (Project p : entry.getValue()) {
                        if (count % 2 == 0) {
                            color = "white";
                        } else {
                            color = "#E8EEF7";
                        }
                        if (getprojectwiseplannedcount.containsKey(p.getPid())) {
                            content = content + "<tr style='height:21px;background-color: " + color + ";'><td >" + p.getPname() + " v" + p.getVerion() + "</td><td>Planned (" + getprojectwiseplannedcount.get(p.getPid()) + ")</td></tr>";
                        } else {
                            content = content + "<tr style='height:21px;background-color: " + color + ";'><td style='color=red;'>" + p.getPname() + " v" + p.getVerion() + "</td><td>Not Planned</td></tr>";
                            status = p.getPname() + " v" + p.getVerion() + "," + status;
                        }
                        name = p.getDmName();
                        mailid = p.getDmEMail();
                        count++;
                    }
                    content = content + "</table>";
                    contentHead = "<div> Dear <b>" + name + "</b></div><br/> Please find your project's planning status for " + sdf.format(date) + "<br/></br/>" + content;
//                if (!status.equalsIgnoreCase("")) {
//                    contentHead = contentHead + "<br/> Please inform to PM for plan the issues for <b>" + status.substring(0, status.length() - 1) + "</b> project(s) before 5 PM";
//                }
                    status = "";
                    contentHead = contentHead + "<br>Thanks,<br>eTracker&trade;<br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                    MimeMessage msg = MakeConnection.getMailConnections();
                    msg.setFrom(new InternetAddress("admin@eminentlabs.net", "Eminentlabs\u2122 eTracker\u2122", "UTF-8"));
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailid));
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress("ttamilvelan@eminentlabs.net"));
                    msg.setSubject("Project's Planning Status on " + sdf.format(date) + "");
                    msg.setContent(contentHead, "text/html");
                    Transport.send(msg);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
