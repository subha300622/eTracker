<%@ page import="org.apache.log4j.*,java.util.*,javax.xml.parsers.*,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage,pack.eminent.encryption.*,java.text.*"%>
<%@page import="com.pack.*,dashboard.CheckDate,com.eminent.util.*,java.sql.Date,com.pack.MyAuthenticator, com.eminent.validation.StatusValidation"%>
<%

    //Configuring log4j properties
    Logger logger = Logger.getLogger("UpdateComments");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%    
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.Calendar"%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <LINK title=STYLE
          href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <meta http-equiv="Content-Type" content="text/html ">
    <script language="JavaScript">
        function check()
        {
            
            var attach = 'no';
            location = 'fileAttach.jsp?attach=' + attach
            
            
        }
        
        function printpost(post)
        {
            pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }
    </script>
</HEAD>

<BODY onload="check()">
    <%@ include file="header.jsp"%>
    <br>
    <br>

    <%@ page import="java.sql.*"%>
    <%!    
        String recipientMobile, recipientOperator, from, subject, host;
    %>

    <%    
        java.util.Date d = new java.util.Date();
    
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);

        //Timestamp ts = new Timestamp(cal.getTimeInMillis());
        Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());
        Connection connection = null;
        PreparedStatement ps = null;
        String Subject = null;
    
        String fname = (String) session.getAttribute("fName");
        String lname = (String) session.getAttribute("lName");
        String Name = fname + " " + lname;
        String uid = "" + session.getAttribute("uid");
    
        connection = MakeConnection.getConnection();
    
        String severity = request.getParameter("severity");
        String priority = request.getParameter("priority");
        String createdby = request.getParameter("creby");
    
        String dueDate = request.getParameter("duedate");
        String storeDate = null;
        java.sql.Date dbDate = null;
        if (!dueDate.equalsIgnoreCase("NA")) {
            dueDate = dueDate.trim();
            storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
            dbDate = java.sql.Date.valueOf(storeDate);
        }
    
        String issueStatus = request.getParameter("issuestatus");
        String assignedto = request.getParameter("assignedto");
        String comments = request.getParameter("comments");
    
        String projecttype = request.getParameter("projecttype");
        String phase = request.getParameter("phase");
        String subphase = request.getParameter("subphase");
        String subsubphase = request.getParameter("subsubphase");
        String subsubsubphase = request.getParameter("subsubsubphase");
        if (subphase != null) {
            if (subphase.equalsIgnoreCase("--Select One--")) {
                subphase = null;
            }
        }
        if (subsubphase != null) {
            if (subsubphase.equalsIgnoreCase("--Select One--")) {
                subsubphase = null;
            }
        }
        if (subsubsubphase != null) {
            if (subsubsubphase.equalsIgnoreCase("--Select One--")) {
                subsubsubphase = null;
            }
        }
    
        logger.info("SEVERITY:" + severity);
        logger.info("PRIORITY:" + priority);
        logger.info("ISSUESTATUS:" + issueStatus);
        logger.info("ASSIGNEDTO:" + assignedto);
        logger.info("Project Type" + projecttype);
    
        String issueId = request.getParameter("issueId");
        session.setAttribute("teamInputIssueId", issueId);
        logger.info("ISSUEID from Session:" + issueId);
        int x = 0, y = 0, z = 0;

        //Checking the status to make sure that it's a valid
        if (projecttype != null) {
            issueStatus = StatusValidation.isSAPStatusCorrect(projecttype, issueStatus, issueId);
        } else {
            issueStatus = StatusValidation.isStatusCorrect(issueStatus, issueId);
        }
    
        if (comments.length() > 0) {
            try {
                ps = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, issueId);
                ps.setString(2, uid);
                ps.setTimestamp(3, ts);
                ps.setString(4, request.getParameter("comments"));
                ps.setString(5, issueStatus);
                ps.setString(6, assignedto);
                ps.setDate(7, dbDate);
                ps.setString(8, priority);
                ps.setString(9, severity);
                x = ps.executeUpdate();
                logger.info("Inserted one row:\t" + x);
            } catch (Exception e) {
                logger.error("Exception in Comments:" + e);
            } finally {
                if (ps != null) {
                    ps.close();
                }
                logger.debug("Comments are not empty");
            }
        }
    
        try {
            UpdateIssue.updateModifiedOn(issueId);
        } catch (Exception e) {
            e.getMessage();
        }
    
        Session ses1 = null;
    
        try {
        
            Statement username = connection.createStatement();
            ResultSet res = username.executeQuery("select email,mobile,mobileoperator from users where userid=" + assignedto);
        
            res.next();
            String to = res.getString(1);
            recipientMobile = res.getString(2);
            recipientOperator = res.getString(3);

            /* Eliminating hyphen in mobile no*/
            recipientMobile = recipientMobile.replaceAll("-", "");
        
            logger.info("Mail to" + to);
            logger.info("Mail to Mobile " + recipientMobile);
            logger.info("Mail to Mobile Operator" + recipientOperator);
        
            subject = request.getParameter("sub");
            String description = request.getParameter("des");
            String customer = request.getParameter("customer");
            String project = request.getParameter("project");
            String version = request.getParameter("version");
            String module = request.getParameter("module");
            String platform = request.getParameter("platform");
            String type = request.getParameter("type");
            String rootCause = request.getParameter("rootcause");
            String expectedResult = request.getParameter("expected_result");
            String viewDueDate = request.getParameter("viewDueDate");
        
            logger.info("Mail to Subject" + subject);
        
            from = (String) session.getAttribute("theName");
        
            ArrayList<String> al = dashboard.Project.getDetails(project + ":" + version);
            ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();
        
            String createdOn = (String) session.getAttribute("createdOn");
            String foundVersion = (String) session.getAttribute("foundVersion");
            String fixVersion = (String) session.getAttribute("fixVersion");
        
            String font = "#000000";
        
            if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(viewDueDate) == true)) {
                font = "RED";
            }
        
            Subject = "eTracker " + issueStatus + " Issue :  " + subject;
            HashMap cr = IssueDetails.getCRID(issueId);
            logger.info("No Of CR" + cr);
            String crHtml = "";
            if (cr.size() > 0) {
                Collection setCR = cr.keySet();
                Iterator iterCR = setCR.iterator();
                while (iterCR.hasNext()) {
                
                    String key = (String) iterCR.next();
                    String desc = (String) cr.get(key);
                    logger.info("ID-->" + key);
                    logger.info("Desc-->" + desc);
                
                    crHtml = "<tr height='21'><td width='13%'><B><font face=Verdana, Arial, Helvetica, sans-serif size=2 >CR ID </B></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + key + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >CR ID Desc.</b></td><td colspan=2><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + desc + "</td></tr>";
                
                }
            }
            String htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% >"
                    + "<tr bgcolor=#E8EEF7 ><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Project</b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + project + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b> Customer </b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + customer + "</td>"
                    + "</tr>"
                    + "<tr><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b> Version </b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + version + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Manager</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(al.get(0)) + "</td> "
                    + "</tr>"
                    + "<tr  bgcolor=#E8EEF7><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b> Status </b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(4) + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Phase</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(1) + "</td> "
                    + "</tr>"
                    + "<tr><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Start Date</b> </td>"
                    + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(2) + "</td>"
                    + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>End Date</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(3) + "</td>"
                    + "</tr></table><br><font color=blue><b>Updated Issue details</b></font><table width=100% >"
                    + "<tr bgcolor=#E8EEF7><td width = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue ID</b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issueId + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Type </b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + type + "</td>"
                    + "</tr>" + "<tr  >"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created By</b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(createdby) + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created On</b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + createdOn + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td width   = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Priority </b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + priority + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Severity</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + severity + "</td> "
                    + "</tr>"
                    + "<tr ><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Module</b> </td>"
                    + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + module + "</td>"
                    + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Platform</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + platform + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Assigned To</b> </td>"
                    + "<td width  = 32%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(assignedto) + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Fix Version </b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + fixVersion + "</td>"
                    + "</tr>"
                    + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated By</b> </td>"
                    + "<td width  = 32%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated On </b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + dateTime.get(0) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue Status </b> </td>"
                    + "<td width = ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issueStatus + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Due Date</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=" + font + ">" + viewDueDate + "</font></td>"
                    + "</tr>" + crHtml
                    + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Subject</b> </td>"
                    + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + subject + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Description</b> </td>"
                    + "<td width  = 82%  colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + description + "</td>"
                    + "</tr>"
                    + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Root Cause</b> </td>"
                    + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + rootCause + " </td>"
                    + "</tr>"
                    + "<tr ><td width  = 18% bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Expected Result</b> </td>"
                    + "<td width  = 82% colspan=3  bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + expectedResult + "</td>"
                    + "</tr>"
                    + "<tr><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Comments</b> </td>"
                    + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + comments + "</td>"
                    + "</tr>";
            String endLine = "</table><br>Thanks,";
            String signature = "<br>eTracker&trade;<br>";
            String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak = "<br>";
        
            String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
        
            htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
        
            SendMail.mailUpdate(issueId, Subject, htmlContent, Name, assignedto);
            if (comments.contains("googleusercontent")) {
                UpdateIssue.updateIssueImageURL(issueId, comments);
            }
        } catch (Exception exec) {
            logger.error("Exception in Sending Mail:" + exec);
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
        /*
         Sending SMS while Updating issue

         */
    

    %>



</BODY>
</HTML>







