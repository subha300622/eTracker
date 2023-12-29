/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ProjectDetail;
import com.eminent.issue.dao.IssueDAO;
import com.eminent.issue.dao.IssueDAOImpl;
import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.GetProjects;
import com.eminent.util.IssueDetails;
import com.eminent.util.MailReceiverDetails;
import com.eminentlabs.mom.ReadingEmail;
import dashboard.CurrentDay;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class CreateIssueFromEmail {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger("CreateIssueFromEmail");
    }

    public void createIssue(Date readingDate) {
        String issueidFormat = null;
        String to = "", from = "", result;
        String pmanager = null;
        IssueDAO issueDAO = new IssueDAOImpl();
        String pojectName = "NEL CIP", version = "1.0";
        try {
//            String pId = GetProjects.getProjectId(pojectName + ":" + version);
//            List<String> domains = issueDAO.getAllDomainsByProjectId(pId);
//            if (domains.contains(pojectName)) {
            logger.info("Issue creation called.");
            List<IssueFormBean> issues = ReadingEmail.read(readingDate);
            for (IssueFormBean ifb : issues) {
                ifb.setpName(pojectName);
                ifb.setVersion(version);
                ifb.setType("New Task");
                ifb.setSeverity("S3- Important");
                ifb.setPriority("P3-Medium");
                ifb.setmName("PS");
                ifb.setRootCause("Created from support@eminentlabs.net");
                ifb.setCreatedBy("104");
                if (ifb.getDescription().length() > 4000) {
                    ifb.setDescription(ifb.getDescription().substring(0, 3999));
                }
                issueidFormat = issueDAO.generateIssueIdSeq();
                if (issueidFormat == null || "".equals(issueidFormat)) {
                    logger.error("Problem in issue id geneartion.");
                } else {
                    ifb.setDueDate(IssueDetails.proposeDuedate(ifb.getpName(), ifb.getmName(), ifb.getVersion(), ifb.getSeverity(), ifb.getPriority()));
                    pmanager = GetProjectManager.getManager(ifb.getpName(), ifb.getVersion());
                    ProjectDetail projectDetail = issueDAO.getProjectDetailByProduct(ifb.getpName(), ifb.getVersion(), ifb.getmName());
                    if (issueDAO.checkDuplicateIssue(projectDetail.getPid(), ifb.getSubject()) > 0) {
                        logger.error("Duplicate issue subject." + ifb.getSubject());
                    } else {
                        result = issueDAO.createIssue(ifb.getDueDate(), issueidFormat, projectDetail.getPid(), ifb.getVersion(), ifb.getType(), projectDetail.getModuleId(), ifb.getSeverity(), ifb.getPriority(), ifb.getSubject(), ifb.getDescription(), ifb.getpName(), ifb.getRootCause(), ifb.getSubject(), ifb.getmName(), ifb.getCreatedBy(), pmanager);
                        if (result.equalsIgnoreCase("created")) {
                            from = GetProjectMembers.getMail(pmanager);
                            to = GetProjectMembers.getMail(ifb.getCreatedBy());
                            if ((to == null || "".equals(to)) || (from == null || "".equals(from))) {
                            } else {
                                ArrayList<String> al = dashboard.Project.getDetails(ifb.getpName() + ":" + ifb.getVersion());
                                ArrayList<String> dateAndTime = CurrentDay.getDateTime();

                                String name = GetProjectMembers.getUserDetail(Integer.parseInt(ifb.getCreatedBy())).get("username");
                                String pmName = GetProjectMembers.getUserName(pmanager);
                                ArrayList<String> hm = MailReceiverDetails.getDetails(issueidFormat);
                                if (hm.contains(pmanager)) {
                                    hm.remove((String) pmanager);
                                }
                                if (hm.contains(ifb.getCreatedBy())) {
                                    hm.remove((String) ifb.getCreatedBy());
                                }

                                String htmlContent = "<b><font color=blue >Project Details</font></b><br>"
                                        + "<table width=100% ><tr  bgcolor=#E8EEF7>"
                                        + "<td width = 18% ><b>Project</b></td>"
                                        + "<td width = 32% >" + ifb.getpName() + "</td>"
                                        + "<td width = 18% ><b> Customer </b> </td>"
                                        + "<td width = 32% >" + projectDetail.getCustomer() + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width   = 18% ><b> Version </b></td>"
                                        + "<td width = 32% >" + ifb.getVersion() + "</td>"
                                        + "<td width = 18% ><b>Manager</b> </td>"
                                        + "<td width = 32% >" + pmName + "</td>"
                                        + "</tr>"
                                        + "<tr  bgcolor=#E8EEF7>"
                                        + "<td width   = 18% ><b> Status </b></td>"
                                        + "<td width = 32% >" + al.get(4) + "</td>"
                                        + "<td width = 18% ><b>Phase</b> </td>"
                                        + "<td width = 32% >" + al.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr><td width   = 18% ><b>Start Date</b> </td>"
                                        + "<td width  = 32% >" + al.get(2) + "</td>"
                                        + "<td width  = 18% ><b>End Date</b> </td>"
                                        + "<td width = 32% >" + al.get(3) + "</td>"
                                        + "</tr>"
                                        + "</table>"
                                        + "<br><b><font color=blue>Issue Details</font></b>"
                                        + "<table width=100% ><tr  bgcolor=#E8EEF7>"
                                        + "<td width = 18% ><b>Issue ID</b></td>"
                                        + "<td width = 32% >" + issueidFormat + "</td>"
                                        + "<td width = 18% ><b>Type </b> </td>"
                                        + "<td width = 32% >" + ifb.getType() + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width = 18% ><b>Created By</b></td>"
                                        + "<td width = 32% >" + name + "</td>"
                                        + "<td width = 18% ><b>Creation On </b> </td>"
                                        + "<td width = 32% >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width   = 18% ><b>Priority </b></td>"
                                        + "<td width = 32% >" + ifb.getPriority() + "</td>"
                                        + "<td width = 18% ><b>Severity</b> </td>"
                                        + "<td width = 32% >" + ifb.getSeverity() + "</td>"
                                        + "</tr>"
                                        + "<tr ><td width   = 18% ><b>Module</b> </td>"
                                        + "<td width  = 32% >" + ifb.getmName() + "</td>"
                                        + "<td width  = 18% ><b>Platform</b> </td>"
                                        + "<td width = 32% >" + projectDetail.getPlatform() + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7><td width  = 18% ><b>Assigned To</b> </td>"
                                        + "<td width  = 32% >" + pmName + "</td>"
                                        + "<td width = 18% ><b>Fix Version </b> </td>"
                                        + "<td width = 32% >" + ifb.getVersion() + "</td>"
                                        + "</tr>"
                                        + "<tr ><td width  = 18% ><b>Updated By</b> </td>"
                                        + "<td width  = 32% >" + name + "</td>"
                                        + "<td width = 18% ><b>Updated On </b> </td>"
                                        + "<td width = 32% >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width  = 18% ><b>Subject</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + ifb.getSubject() + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width  = 18% ><b>Description</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + ifb.getDescription() + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width  = 18% ><b>Root Cause</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + ifb.getRootCause() + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width  = 18% ><b>Expected Result</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + ifb.getExpResult() + "</td>"
                                        + "</tr>"
                                        + "</table><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker";
                                MimeMessage msg = MakeConnection.getMailConnections();
                                msg.setFrom(new InternetAddress(to, name));
                                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
                                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to));
                                for (String s : hm) {
                                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                                }
                                msg.setSubject("eTracker Unconfirmed Issue :" + ifb.getSubject());
                                msg.setContent(htmlContent, "text/html");
                                ResourceBundle rb = ResourceBundle.getBundle("Resources");
                                String mail = rb.getString("mail");
                                if (mail.equalsIgnoreCase("yes")) {
                                    Transport.send(msg);
                                }
                            }
                        } else {
                            logger.error("Problem in issue creation.");
                        }
                    }
                }
            }
//            }

        } catch (MessagingException ex) {

        } catch (Exception ex) {
            Logger.getLogger(CreateIssueFromEmail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
