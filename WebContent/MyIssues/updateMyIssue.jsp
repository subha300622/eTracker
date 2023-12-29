<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminent.util.ProjectPlanUtil"%>
<%@page import="com.eminent.issue.PlanStatus"%>
<%@page import="com.eminent.issue.ProjectPlannedIssue"%>
<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="com.eminentlabs.mom.ApmAdditionalClosed"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.TeamWiseMom"%>
<%@page import="org.apache.log4j.*,java.util.*,javax.xml.parsers.*,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage,pack.eminent.encryption.*,java.text.*"%>
<%@page import="com.eminent.tqm.TqmUtil,com.pack.*,dashboard.CheckDate,com.eminent.util.*,java.sql.Date, com.eminent.validation.StatusValidation"%>
<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("UpdateMyIssue");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.Calendar"%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <LINK title=STYLE
          href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
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
            location = '/eTracker/fileAttach.jsp?attach=' + attach;
            parent.treeframe.location.reload();

        }

        function printpost(post)
        {
            pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }
    </script>
</HEAD>

<BODY onload="check();">
    <%@ include file="../header.jsp"%>
    <br>
    <br>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
    <%@ page import="java.sql.*"%>
    <%!    String recipientMobile, recipientOperator, from, subject, host;
                                                                                                                        %>

    <%
        java.util.Date d = new java.util.Date();

        Calendar cal = Calendar.getInstance();
        cal.setTime(d);

        //Timestamp ts = new Timestamp(cal.getTimeInMillis());
        Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());
        Connection connection = null;
        PreparedStatement ps = null;

        String fname = (String) session.getAttribute("fName");
        String lname = (String) session.getAttribute("lName");
        String Name = fname + " " + lname;

        String uid = "" + session.getAttribute("uid");

        connection = MakeConnection.getConnection();

        String pName = request.getParameter("project");
        String mName = request.getParameter("module");
        String severity = request.getParameter("severity");
        String priority = request.getParameter("priority");
        String fix_version = request.getParameter("fversion");

        logger.info("Project Name" + pName);
        logger.info("version Name" + fix_version);
        String pid = ProjectFinder.getProjectId(pName, fix_version);
        String mid = ProjectFinder.getModuleId(pName, fix_version, mName);
        logger.info("Project Id" + pid);
        logger.info("Module Id" + mid);
        String dueDate = request.getParameter("date");
        String storeDate = null;
        String Subject = null;
        java.sql.Date dbDate = null;
        if (!dueDate.equalsIgnoreCase("NA")) {
            dueDate = dueDate.trim();
            storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
            dbDate = java.sql.Date.valueOf(storeDate);
        }
        String issueStatus = request.getParameter("issuestatus");
        String assignedto = request.getParameter("assignedto");
        String comments = request.getParameter("comments");
        String[] issueComponent = request.getParameterValues("issues");
        String projecttype = request.getParameter("projecttype");
        String phase = request.getParameter("phase");
        String subphase = request.getParameter("subphase");
        String subsubphase = request.getParameter("subsubphase");
        String subsubsubphase = request.getParameter("subsubsubphase");
        String que1 = request.getParameter("que1");
        String que2 = request.getParameter("que2");
        String que3 = request.getParameter("que3");
        String que4 = request.getParameter("que4");
        String que5 = request.getParameter("que5");
        String que6 = request.getParameter("que6");
        String que7 = request.getParameter("que7");
        String que8 = request.getParameter("que8");
        String que9 = request.getParameter("que9");
        String que10 = request.getParameter("que10");
        String mainIssue = request.getParameter("mainIssue");
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
        String escalator = request.getParameter("escalation");
        if (escalator == null) {
            escalator = "No";
        }
        String type = request.getParameter("newType");
        if (type == null) {
            type = request.getParameter("type");
        }
        logger.info("SEVERITY:" + severity);
        logger.info("PRIORITY:" + priority);
        logger.info("ISSUESTATUS:" + issueStatus);
        logger.info("ASSIGNEDTO:" + assignedto);
        logger.info("Project Type" + projecttype);

        String issueId = request.getParameter("issueId");
        session.setAttribute("myIssueId", issueId);
        int x = 0, y = 0, z = 0;

        //Checking the status to make sure that it's a valid
        if (projecttype != null) {
            issueStatus = StatusValidation.isSAPStatusCorrect(projecttype, issueStatus, issueId);
        } else {
            issueStatus = StatusValidation.isStatusCorrect(issueStatus, issueId);
        }
        EscalationDAO escalationDAO = new EscalationDAOImpl();
        String escStaus = escalationDAO.getEscalationStatus(issueId);
        if (escalator == null) {
            escalator = escStaus;
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

        String rating = request.getParameter("feedback");
        String feedback = request.getParameter("feedbackString");

        String newModule = request.getParameter("newModule");
        int newModuleId = 0;
        if (newModule != null) {
            newModuleId = MoMUtil.parseInteger(newModule, newModuleId);
        }
        String extendedQuery = "";
        if (newModuleId > 0) {
            mid = newModule;
            extendedQuery = extendedQuery + ",module_id=?";
        }
        logger.info(newModuleId);
        try {
            logger.info("DATE:" + new java.sql.Date(cal.getTimeInMillis()));
            String usub = request.getParameter("usub");
            String udes = request.getParameter("udes");
            String uexpected_result = request.getParameter("uexpected_result");
            if (issueStatus.equalsIgnoreCase("Closed")) {
                if (rating == null || rating == "") {
                    rating = "Good";
                }
            }

            if (usub != null && udes != null && uexpected_result != null) {
                ps = connection.prepareStatement("update issue set severity=?,priority=?,assignedto=?,modifiedon=?, due_date = ?, rating = ?, feedback = ?, subject =?, description=?,EXPECTED_RESULT=?,ESCALATION=?,type=?" + extendedQuery + " where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, severity);
                ps.setString(2, priority);
                ps.setString(3, assignedto);
                ps.setDate(4, new java.sql.Date(cal.getTimeInMillis()));
                ps.setDate(5, dbDate);
                ps.setString(6, rating);
                ps.setString(7, feedback);
                ps.setString(8, usub);
                ps.setString(9, udes);
                ps.setString(10, uexpected_result);
                ps.setString(11, escalator);
                ps.setString(12, type);
                int i = 13;
                if (newModuleId > 0) {
                    ps.setString(i, mid);
                    i++;
                }
                ps.setString(i, issueId);
            } else {
                ps = connection.prepareStatement("update issue set severity=?,priority=?,assignedto=?,modifiedon=?, due_date = ?, rating = ?, feedback = ?,ESCALATION=?,type=?" + extendedQuery + " where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, severity);
                ps.setString(2, priority);
                ps.setString(3, assignedto);
                ps.setDate(4, new java.sql.Date(cal.getTimeInMillis()));
                ps.setDate(5, dbDate);
                ps.setString(6, rating);
                ps.setString(7, feedback);
                ps.setString(8, escalator);
                ps.setString(9, type);

                int i = 10;
                if (newModuleId > 0) {
                    ps.setString(i, mid);
                    i++;
                }
                ps.setString(i, issueId);
            }
            y = ps.executeUpdate();
            logger.debug("updating the issue:");
            logger.info("Updated second row:\t" + y);
        } catch (Exception e) {
            logger.error("Exception:" + e);
        } finally {
            if (ps != null) {
                ps.close();
            }
        }

        try {
            ps = connection.prepareStatement("update issuestatus set status=? where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, issueStatus);
            ps.setString(2, issueId);
            z = ps.executeUpdate();
            logger.info("Updated third row:\t" + z);
        } catch (Exception e) {
            logger.error("Exception in IssueStatus:" + e);
        } finally {
            if (ps != null) {
                ps.close();
            }
        }
        try {
            if (projecttype != null) {
                if (projecttype.equals("Implementation")) {
                    logger.info("Implementation Update");

                    PreparedStatement insertPhase_St = connection.prepareStatement("update issue_implementation set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");
                    insertPhase_St.setString(1, phase);
                    insertPhase_St.setString(2, subphase);
                    insertPhase_St.setString(3, subsubphase);
                    insertPhase_St.setString(4, subsubsubphase);
                    insertPhase_St.setString(5, projecttype);
                    insertPhase_St.setString(6, issueId);
                    int upg = insertPhase_St.executeUpdate();
                    connection.commit();
                    logger.info("Implementation Update success" + upg);
                    if (insertPhase_St != null) {
                        insertPhase_St.close();
                    }
                } else if (projecttype.equals("Upgradation")) {

                    logger.info("Upgradation Update");

                    PreparedStatement insertPhase_St3 = connection.prepareStatement("update issue_upgradation set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");
                    insertPhase_St3.setString(1, phase);
                    insertPhase_St3.setString(2, subphase);
                    insertPhase_St3.setString(3, subsubphase);
                    insertPhase_St3.setString(4, subsubsubphase);
                    insertPhase_St3.setString(5, projecttype);
                    insertPhase_St3.setString(6, issueId);
                    insertPhase_St3.executeUpdate();
                    connection.commit();
                    if (insertPhase_St3 != null) {
                        insertPhase_St3.close();
                    }

                } else if (projecttype.equals("Support")) {

                    logger.info("Support Update");

                    PreparedStatement insertPhase_St6 = connection.prepareStatement("update issue_support set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED

                    insertPhase_St6.setString(1, phase);
                    insertPhase_St6.setString(2, subphase);
                    insertPhase_St6.setString(3, subsubphase);
                    insertPhase_St6.setString(4, subsubsubphase);
                    insertPhase_St6.setString(5, projecttype);
                    insertPhase_St6.setString(6, issueId);
                    insertPhase_St6.executeUpdate();
                    connection.commit();
                    if (insertPhase_St6 != null) {
                        insertPhase_St6.close();
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Exception in Phase Details:" + e);
        } finally {
            if (ps != null) {
                ps.close();
            }
        }
        // Adding Test Cases
        try {
            int userId = (Integer) session.getAttribute("uid");
            String addTestCase = request.getParameter("testcaseindev");
            logger.info("Dev Test case" + addTestCase);
            if (issueStatus.equalsIgnoreCase("QA-BTC") || addTestCase != null) {
                String descriptionComments = "";
                String[] functionality = request.getParameterValues("functionality");
                String[] expectedresult = request.getParameterValues("expectedresult");
                String[] description = request.getParameterValues("description");
                int pId = Integer.parseInt(pid);
                int mId = Integer.parseInt(mid);
                if (functionality != null) {
                    for (int i = 0; i < functionality.length; i++) {
                        logger.info("Func->" + functionality[i] + "--Result->" + expectedresult[i] + "-->Desc" + description[i]);
                        TqmUtil.createIssuePTC(pId, mId, functionality[i], description[i], expectedresult[i], userId, issueId);
                        descriptionComments = description[i];
                    }
                    comments = "Added Test Case: " + descriptionComments;
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        try {
            if (connection != null) {
                //               if(issueStatus.equalsIgnoreCase("Closed")){
                UpdateValue.updateUserValue(connection, Integer.parseInt(uid));
                //               GetValues.UpdateValue(issueId);
                //               }
            }
        } catch (Exception e) {
            logger.error("Exception in User Value update" + e);
        }
        try {
            if (issueStatus.equalsIgnoreCase("Closed")) {
                pid = ProjectFinder.getProjectId(pName, fix_version);
                TeamWiseMom t = new TeamWiseMom();
                long prid = MoMUtil.parseLong(pid, 0l);
                int wrmid = t.findMaxWRMDay(prid);
                if (wrmid != 0) {
                    ApmWrmPlan apmWrmPlan = new ApmWrmPlan();
                    apmWrmPlan = t.findByWRMId(wrmid);
                    ApmAdditionalClosed apmAdditionalClosed = new ApmAdditionalClosed(0l, issueId, apmWrmPlan);
                    ModelDAO.save("ApmAdditionalClosed", apmAdditionalClosed);
                }

            }
        } catch (Exception e) {
            logger.error("Exception in ApmAdditionalClosed" + e);
        }
        try {
            atc.addIssues(issueComponent, issueId);
        } catch (Exception e) {
            logger.error("Exception in component" + e);
        }
        Session ses1 = null;

        if (x > 0 || y > 0 || z > 0) {
            Statement username = connection.createStatement();
            ResultSet res = username.executeQuery("select email,mobile,mobileoperator from users where userid=" + assignedto);
            try {

                res.next();
                String to = res.getString(1);
                recipientMobile = res.getString(2);
                recipientOperator = res.getString(3);

                logger.info("Mail to" + to);

                subject = request.getParameter("sub");
                String description = request.getParameter("des");
                String customer = request.getParameter("customer");
                String project = request.getParameter("project");
                String version = request.getParameter("version");
                String module = request.getParameter("module");
                String platform = request.getParameter("platform");
                String rootCause = request.getParameter("rootcause");
                String expectedResult = request.getParameter("expected_result");
                String createdby = request.getParameter("createdby");

                logger.info("Mail to Subject" + subject);

                logger.info("Desc" + description);
                logger.info("Root Cause" + rootCause);
                logger.info("Expected Result" + expectedResult);

                from = (String) session.getAttribute("theName");
                logger.info("Project" + project + "Version" + version);
                ArrayList<String> al = dashboard.Project.getDetails(project + ":" + version);
                ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();

                String createdOn = (String) session.getAttribute("createdOn");
                String foundVersion = (String) session.getAttribute("foundVersion");
                String fixVersion = (String) session.getAttribute("fixVersion");
                DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                java.util.Date da = df.parse(dueDate);
                String viewDueDate = sdf.format(da);
                String font = "#000000";
                if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(viewDueDate) == true)) {
                    font = "RED";
                }

                Subject = "eTracker " + issueStatus + " Issue :  " + subject;
                if (issueStatus.equalsIgnoreCase("Closed")) {
                    Subject = "eTracker " + issueStatus + " Issue with " + rating + " Rating :  " + subject;
                }
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
                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + dateTime.get(0) + " " + dateTime.get(1) + "</td>"
                        + "</tr>"
                        + "<tr bgcolor=#E8EEF7><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue Status </b> </td>"
                        + "<td width = ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issueStatus + "</td>"
                        + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Due Date</b> </td>"
                        + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 color='" + font + "'>" + viewDueDate + "</font></td>"
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
                if (issueStatus.equalsIgnoreCase("Closed")) {
                    String ratingColor = "#000000";
                    if (rating == "Excellent") {
                        ratingColor = "#74DF00";
                    } else if (rating == "Need Improvement") {
                        ratingColor = "#FF0000";
                    } else if (rating == "Average") {
                        ratingColor = "#F78181";
                    } else if (rating == "Good") {
                        ratingColor = "#088A4B";
                    }

                    htmlContent = htmlContent + "<tr><td width  = 18%  bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Rating</b> </td>"
                            + "<td width  = 82% colspan=3 bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 color='" + ratingColor + "'>" + rating + "</td>"
                            + "</tr>";
                    if (feedback != null && feedback != "") {
                        htmlContent = htmlContent + "<tr><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Feedback</b> </td>"
                                + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + feedback + "</td>"
                                + "</tr>";
                    }
                }

                String endLine = "</table><br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br><b><a href=http://www.eminentlabs.net/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br>";

                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.net/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;

                SendMail.mailUpdate(issueId, Subject, htmlContent, Name, assignedto);
                if ((escalator != null && "yes".equalsIgnoreCase(escalator)) && ("no".equalsIgnoreCase(escStaus))) {
                    MoMUtil.createTask(Integer.parseInt(assignedto), issueId, Integer.parseInt(uid), "Issue", "Planned");
                    java.util.Date plann = new java.util.Date();
                    long plannedId = ProjectPlanUtil.uniqueProjectPlan(Long.parseLong(pid), issueId, plann);
                    if (plannedId == 0l) {
                        ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(Long.valueOf(pid), issueId, Integer.parseInt(uid), plann, plann, plann, PlanStatus.ACTIVE.getStatus());
                        ProjectPlanUtil.createProjectPlanIssue(projectPlannedIssue);
                    } else {
                        ProjectPlannedIssue ppi = new ProjectPlannedIssue();
                        ppi.setId(plannedId);
                        ppi.setIssueId(issueId);
                        ppi.setpId(Long.valueOf(pid));
                        ppi.setPlannedBy(Integer.parseInt(uid));
                        ppi.setStatus(PlanStatus.getACTIVE().getStatus());
                        ppi.setPlannedOn(plann);
                        ppi.setCreatedOn(plann);
                        ppi.setModifiedOn(plann);
                        ProjectPlanUtil.updateProjectPlanIssue(ppi);
                    }
                    try {
                        ps = connection.prepareStatement("insert into ESCALATION_ISSUE values(?,?,?,?,?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ps.setString(1, issueId);
                        ps.setString(2, que1);
                        ps.setString(3, que2);
                        ps.setString(4, que3);
                        ps.setString(5, que4);
                        ps.setString(6, que5);
                        ps.setString(7, que6);
                        ps.setString(8, que7);
                        ps.setString(9, que8);
                        ps.setString(10, que9);
                        ps.setString(11, que10);
                        ps.setTimestamp(12, ts);
                        ps.setInt(13, Integer.parseInt(uid));
                        x = ps.executeUpdate();

                    } catch (Exception e) {
                        logger.error("Exception in comment insertion:" + e);
                    } finally {
                        if (ps != null) {
                            ps.close();
                        }
                    }
                    Subject = "Escalation Issue : " + issueId + " - " + subject;
                    htmlContent = "<table style='width:99%;'><tr style='background-color: red;height:21px;'><td style='font-weight: bold;'>Checklist</td><td style='font-weight: bold;'>Answer</td><tr>"
                            + "<tr style='height:21px;background-color: white;'><td><b>Is requirement provided clearly?</b></td><td>" + que1 + "</td></tr>"
                            + "<tr style='height:21px;background-color: #E8EEF7;'><td><b>Is QA-BTC reviewed to make the requirement understandable to all?</b></td><td>" + que2 + "</td></tr>"
                            + "<tr style='height:21px;background-color: white;'><td><b>Is the issue highlighted in WRM before escalation?</b></td><td>" + que3 + "</td></tr>"
                            + "<tr style='height:21px;background-color: #E8EEF7;'><td><b>Is the  WRM highlighted issue planned daily?</b></td><td>" + que4 + "</td></tr>"
                            + "<tr style='height:21px;background-color: white;'><td><b>Is the issue escalated in production?</b></td><td>" + que5 + "</td></tr>"
                            + "<tr style='height:21px;background-color: #E8EEF7;'> <td><b>Is the issue replicable in quality?</b></td><td>" + que6 + "</td></tr>"
                            + "<tr style='height:21px;background-color: white;'>  <td><b>Is access to Development,Quality and Production provided?</b></td><td>" + que7 + "</td></tr>"
                            + "<tr style='height:21px;background-color: #E8EEF7;'><td><b>Is sufficient authorization provided with debug option to resolve this issue?</b></td><td>" + que8 + "</td></tr>"
                            + "<tr style='height:21px;background-color: white;'> <td><b>Is sufficient time provided to resolve this issue?</b></td><td>" + que9 + "</td></tr>"
                            + "<tr style='height:21px;background-color: #E8EEF7;'> <td><b>Is the issue escalated questioning the capability of Eminentlabs?</b></td><td>" + que10 + "</td></tr>";
                    htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                    SendMail.escalationMail(htmlContent, Subject, Name, assignedto);
                }

                if (comments.contains("googleusercontent")) {
                    UpdateIssue.updateIssueImageURL(issueId, comments);
                }
                if (mainIssue != null && !mainIssue.equals("")) {
                    new IssueDAOImpl().updateMainIssue(mainIssue, issueId);
                }
            } catch (Exception exec) {
                logger.error("Exception in Sending Mail:" + exec);
                logger.error(exec.getMessage());
            } finally {
                logger.info("In the finally block");
                if (username != null) {
                    username.close();
                }
                if (res != null) {
                    res.close();
                }
                if (connection != null) {
                    connection.close();
                    logger.info("Connection Closed");
                }
            }
    %>


    <%
        }


    %>
</BODY>
</HTML>







