/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmIssueTeststepId;
import com.eminent.issue.Issue;
import com.eminent.issue.ProjectDetail;
import com.eminent.issue.dao.IssueDAO;
import com.eminent.issue.dao.IssueDAOImpl;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminent.util.MailReceiverDetails;
import com.eminent.util.UpdateIssue;
import com.eminentlabs.dao.DAOFactory;
import com.pack.StringUtil;
import dashboard.CurrentDay;
import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;
import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Muthu
 */
public class IssueController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("IssueController");
    }

    String message = null;

    public String createIssue(HttpServletRequest request, ServletContext context) {
        FileAttachDAO fileAttachDAO = new FileAttachDAO();
        IssueDAO issueDAO = new IssueDAOImpl();

        String saveFile = null;
        FileItem fileItem = null;
        String issueidFormat = null;
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                HttpSession session = request.getSession();
                String to = "", from = "";
                String pmanager = null;
                String product = request.getParameter("project");
                String version = request.getParameter("version");
                String type = request.getParameter("type");
                String module = request.getParameter("module");
                String severity = request.getParameter("severity");
                String priority = request.getParameter("priority");
                String dueDate = request.getParameter("date");
                String subject = request.getParameter("subject");
                String desc = request.getParameter("descriptions");
                String rootCause = request.getParameter("rootCause");
                String expectedResult = request.getParameter("expectedResult");
                String teststepId = request.getParameter("teststepId");
                String filePath = context.getInitParameter("file-upload");
                String mainIssue = context.getInitParameter("mainIssue");
                String dirName = filePath;
                String optionalFileName = "";

                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) //your code for getting form fields
                    {
                        String name = fileItemTemp.getFieldName();
                        if (name.equalsIgnoreCase("project")) {
                            product = fileItemTemp.getString().trim();
                        }
                        if (name.equalsIgnoreCase("version")) {
                            version = fileItemTemp.getString().trim();
                        }
                        if (name.equalsIgnoreCase("type")) {
                            type = fileItemTemp.getString().trim();
                        }

                        if (name.equalsIgnoreCase("module")) {
                            module = fileItemTemp.getString().trim();
                        }
                        if (name.equalsIgnoreCase("severity")) {
                            severity = fileItemTemp.getString().trim();
                        }

                        if (name.equalsIgnoreCase("priority")) {
                            priority = fileItemTemp.getString().trim();
                        }
                        if (name.equalsIgnoreCase("date")) {
                            dueDate = fileItemTemp.getString().trim();
                        }
                        if (name.equalsIgnoreCase("subject")) {
                            subject = fileItemTemp.getString().trim();
                        }

                        if (name.equalsIgnoreCase("descriptions")) {
                            desc = fileItemTemp.getString().trim();
                        }

                        if (name.equalsIgnoreCase("rootCause")) {
                            rootCause = fileItemTemp.getString().trim();
                        }

                        if (name.equalsIgnoreCase("expectedResult")) {
                            expectedResult = fileItemTemp.getString().trim();
                        }

                        if (name.equalsIgnoreCase("teststepId")) {
                            teststepId = fileItemTemp.getString().trim();
                        }
                        if (name.equalsIgnoreCase("mainIssue")) {
                            mainIssue = fileItemTemp.getString().trim();
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }

                if (desc == null) {
                    desc = "";
                }
                if ("".equals(desc)) {
                    desc = subject;
                }

                if (expectedResult == null) {
                    expectedResult = "";
                }
                if ("".equals(expectedResult)) {
                    expectedResult = subject;
                }
                if (rootCause == null) {
                    rootCause = "Nil";
                } else if ("".equals(rootCause)) {
                    rootCause = "Nil";
                }
                String user2 = "";
                int userid_curri = 0;
                Integer userid_curr = null;
                userid_curr = (Integer) session.getAttribute("userid_curr");
                if (userid_curr == null) {
                    message = "Session is expired. Please login again";
                    logger.info("Session is expired. Please login again.");
                } else {
                    userid_curri = userid_curr.intValue();
                    user2 = userid_curr.toString();
                    issueidFormat = issueDAO.generateIssueIdSeq();
                    if (issueidFormat == null || "".equals(issueidFormat)) {
                        message = "Problem in issue id geneartion.";
                        logger.info("Problem in issue id geneartion.");
                    } else {

                        pmanager = GetProjectManager.getManager(product, version);
                        ProjectDetail projectDetail = issueDAO.getProjectDetailByProduct(product, version, module);
                        String result = issueDAO.createIssue(dueDate, issueidFormat, projectDetail.getPid(), version, type, projectDetail.getModuleId(), severity, priority, subject, desc, product, rootCause, expectedResult, module, user2, pmanager);
                        if (result.equalsIgnoreCase("created")) {

                            if (desc.contains("googleusercontent")) {
                                UpdateIssue.updateIssueImageURL(issueidFormat, desc);
                            }
                            if (mainIssue != null && !mainIssue.equals("")) {
                                issueDAO.updateMainIssue(mainIssue, issueidFormat);
                            }
                            if (teststepId != null) {
                                if (!teststepId.trim().equals("null")) {
                                    ApmIssueTeststepId aiti = new ApmIssueTeststepId();
                                    aiti.setPid(projectDetail.getPid());
                                    aiti.setTeststepId(Integer.parseInt(teststepId));
                                    aiti.setIssueId(issueidFormat);
                                    aiti.setCreatedby(userid_curri);
                                    Calendar c = new GregorianCalendar();
                                    java.util.Date cdate = c.getTime();
                                    aiti.setCreatedon(cdate);
                                    DAOFactory.addTESTSTEPID(aiti);
                                }
                            }

                            if (fileItem == null) {
                            } else {
                                String fileName = fileItem.getName();
                                if (fileItem.getSize() > 0 & fileItem.getSize() < 12582912) {
                                    if (optionalFileName.equals("")) {
                                        fileName = FilenameUtils.getName(fileName);
                                    } else {
                                        fileName = optionalFileName;
                                    }
                                    int count = IssueDetails.displayFiles(issueidFormat);
                                    count = count + 1;
                                    File saveTo = new File(dirName + count + "." + issueidFormat + "_" + StringUtil.convertSpecialCharacters(fileName));
                                    saveFile = count + "." + issueidFormat + "_" + StringUtil.convertSpecialCharacters(fileName);
                                    try {
                                        fileItem.write(saveTo);
                                        int owner = ((Integer) request.getSession().getAttribute("uid")).intValue();
                                        int fileId = fileAttachDAO.getFilesIdIssue();
                                        fileAttachDAO.saveFilesForIssue(fileId, issueidFormat, saveFile, owner, "Unconfirmed");
                                    } catch (Exception e) {
                                        message = "Error Occured in file upload";
                                        logger.error(e.getMessage());
                                    }
                                } else if (fileItem.getSize() == 0) {
                                } else {
                                    message = "The file you were trying to upload exceeds 12MB.Please upload file less than 12MB.";
                                }
                            }

                            from = GetProjectMembers.getMail(pmanager);
                            to = GetProjectMembers.getMail(user2);
                            if ((to == null || "".equals(to)) || (from == null || "".equals(from))) {
                            } else {
                                ArrayList<String> al = dashboard.Project.getDetails(product + ":" + version);
                                ArrayList<String> dateAndTime = CurrentDay.getDateTime();
                                String fname = (String) session.getAttribute("fName");
                                String lname = (String) session.getAttribute("lName");
                                String name = fname + " " + lname;
                                String pmName = GetProjectMembers.getUserName(pmanager);
                                ArrayList<String> hm = MailReceiverDetails.getDetails(issueidFormat);
                                if (hm.contains(pmanager)) {
                                    hm.remove((String) pmanager);
                                }
                                if (hm.contains(user2)) {
                                    hm.remove((String) user2);
                                }

                                String htmlContent = "<b><font color=blue >Project Details</font></b><br>"
                                        + "<table width=100% ><tr  bgcolor=#E8EEF7>"
                                        + "<td width = 18% ><b>Project</b></td>"
                                        + "<td width = 32% >" + product + "</td>"
                                        + "<td width = 18% ><b> Customer </b> </td>"
                                        + "<td width = 32% >" + projectDetail.getCustomer() + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width   = 18% ><b> Version </b></td>"
                                        + "<td width = 32% >" + version + "</td>"
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
                                        + "<td width = 32% >" + type + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width = 18% ><b>Created By</b></td>"
                                        + "<td width = 32% >" + name + "</td>"
                                        + "<td width = 18% ><b>Creation On </b> </td>"
                                        + "<td width = 32% >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width   = 18% ><b>Priority </b></td>"
                                        + "<td width = 32% >" + priority + "</td>"
                                        + "<td width = 18% ><b>Severity</b> </td>"
                                        + "<td width = 32% >" + severity + "</td>"
                                        + "</tr>"
                                        + "<tr ><td width   = 18% ><b>Module</b> </td>"
                                        + "<td width  = 32% >" + module + "</td>"
                                        + "<td width  = 18% ><b>Platform</b> </td>"
                                        + "<td width = 32% >" + projectDetail.getPlatform() + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7><td width  = 18% ><b>Assigned To</b> </td>"
                                        + "<td width  = 32% >" + pmName + "</td>"
                                        + "<td width = 18% ><b>Fix Version </b> </td>"
                                        + "<td width = 32% >" + version + "</td>"
                                        + "</tr>"
                                        + "<tr ><td width  = 18% ><b>Updated By</b> </td>"
                                        + "<td width  = 32% >" + name + "</td>"
                                        + "<td width = 18% ><b>Updated On </b> </td>"
                                        + "<td width = 32% >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width  = 18% ><b>Subject</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + subject + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width  = 18% ><b>Description</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + desc + "</td>"
                                        + "</tr>"
                                        + "<tr bgcolor=#E8EEF7>"
                                        + "<td width  = 18% ><b>Root Cause</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + rootCause + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td width  = 18% ><b>Expected Result</b> </td>"
                                        + "<td width  = 82% colspan=3 >" + expectedResult + "</td>"
                                        + "</tr>"
                                        + "</table><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker";
                                MimeMessage msg = MakeConnection.getMailConnections();
                                msg.setFrom(new InternetAddress(to, name));
                                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
                                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to));
                                for (String s : hm) {
                                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(GetProjectMembers.getMail(s)));
                                }
                                // hard coded for SRIPL
                                if (projectDetail.getPid() == 10144) {
                                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress("g.thantry@schenckprocess.com"));

                                }
                                msg.setSubject("eTracker Unconfirmed Issue :" + subject);
                                msg.setContent(htmlContent, "text/html");
                                ResourceBundle rb = ResourceBundle.getBundle("Resources");
                                String mail = rb.getString("mail");
                                if (mail.equalsIgnoreCase("yes")) {
                                    Transport.send(msg);
                                }
                            }

                        } else {
                            message = "Problem in issue creation.";
                            logger.error(message);
                        }
                    }
                }
            }
        } catch (Exception e1) {
            logger.error(e1.getMessage());
            e1.printStackTrace();
        }

        return issueidFormat;

    }

    public static List<Issue> getIssuesByProject(HttpServletRequest request) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        List<Issue> issueList = new ArrayList<Issue>();
        String project = request.getParameter("pname");
        String version = request.getParameter("ver");
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select i.issueid,subject,u.firstname,u.lastname,i.rating,s.status from issue i,ISSUESTATUS s,users u where i.issueid = s.issueid and u.userid = i.createdby and s.STATUS != 'Closed'  and pid = (select pid from project where pname= '" + project + "' and version= '" + version + "') order by CREATEDON desc";
            logger.info(query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                Issue issue = new Issue();
                issue.setIssueid(resultset.getString(1));
                issue.setSubject(resultset.getString(2));
                issue.setRating(resultset.getString(5));
                issue.setIssuestatus(resultset.getString(6));
                issueList.add(issue);
            }
            logger.info("issueList :" + issueList.size());
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
