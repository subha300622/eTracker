<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.TeamWiseMom"%>
<%@page import="com.eminentlabs.mom.ApmAdditionalClosed"%>
<%@ page import="org.apache.log4j.*,com.eminent.tqm.TqmUtil,com.eminent.issue.*"%>
<%@ page import="com.pack.MyAuthenticator,com.eminent.util.*, com.eminent.validation.StatusValidation"%>
<%@ page import="javax.mail.*,dashboard.*"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="pack.eminent.encryption.*,com.pack.ChangeFormat,com.eminent.issue.ApmComponentIssues,com.eminent.issue.Issuecomments"%>
<%@ page language="java"%>

<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("Modify MyAssginment Issue");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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

<BODY >
    <%@ include file="../header.jsp"%>
    <br>
    <br>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
    <%!    String recipientMobile, recipientOperator, from, host;
                                                                                                                                                                                                                                            %>
    <%@ page import="java.sql.*,java.text.*"%>
    <%@ page import="java.util.Calendar"%>
    <script language="JavaScript">
        <%
            java.util.Date d = new java.util.Date();

            Calendar cal = Calendar.getInstance();
            cal.setTime(d);
            //Timestamp ts = new Timestamp(cal.getTimeInMillis());
            Timestamp ts = new Timestamp(new java.util.Date().getTime());
            Connection connection = null;
            PreparedStatement ps = null, insertPhase_St_A = null;
            Statement stForType = null, ischeckTypeIssue = null;
            ResultSet rsForType = null, isRPtypeIssue = null;
            String pid = null, mid = null;

            GetName g = null;

            String theissu = "";
            String estimatedTime = null;
            String fname = (String) session.getAttribute("fName");
            String lname = (String) session.getAttribute("lName");
            String Name = fname + " " + lname;
            String uid = "" + session.getAttribute("uid");

            connection = MakeConnection.getConnection();
            String issueId = request.getParameter("issueId");
       //     session.setAttribute("myAssignmentIssueId", issueId);
            String pName = null;
            String mName = null;
            if (request.getParameter("project") != null) {
                pName = request.getParameter("project");
            }
            
            if (request.getParameter("module") != null) {
                mName = request.getParameter("module");
            }
            String severity = request.getParameter("severity");
            String priority = request.getParameter("priority");
            String issueStatus = request.getParameter("issuestatus");

            String assignedto = request.getParameter("assignedto");
            String[] issueComponent = request.getParameterValues("issues");
            String comments = request.getParameter("comments");
            String fix_version = request.getParameter("fix_version");
            logger.info("---------" + fix_version);
            String dueDate = request.getParameter("date");
            if (request.getParameter("timeestimation") != null) {
                estimatedTime = request.getParameter("timeestimation");
                logger.info("estimatedTimeinside request" + estimatedTime);
            }
            if (estimatedTime == null) {
                estimatedTime = "0";
            }
            if (estimatedTime.equalsIgnoreCase("null")) {
                estimatedTime = "0";
                logger.info("estimatedTime" + estimatedTime);
            }
            String sapIssueType = request.getParameter("sapissuetype");

            logger.info("Sap Issue Type" + sapIssueType);
            String storeDate = null;
            java.sql.Date dbDate = null;
            if (dueDate != null) {
                if (!dueDate.equalsIgnoreCase("NA")) {
                    dueDate = dueDate.trim();
                    storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
                    dbDate = java.sql.Date.valueOf(storeDate);
                }
            }
            String projecttype = request.getParameter("projecttype");
            String phase = request.getParameter("phase");
            String subphase = request.getParameter("subphase");
            String subsubphase = request.getParameter("subsubphase");
            String subsubsubphase = request.getParameter("subsubsubphase");
            String escalator = request.getParameter("escalation");
            String mainIssue = request.getParameter("mainIssue");
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
            if (comments != "") {
                try {
                    //                        CommentAccess.UpdateComments(issueId, uid, comments, priority, severity, dbDate, assignedto, issueStatus);
                    ps = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?) RETURNING ROWID INTO ? ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
                    
                    //		logger.info("Inserted one row:\t"+l);

                } catch (Exception e) {
                    logger.error("Exception in comment insertion:" + e);
                } finally {
                    if (ps != null) {
                        ps.close();
                    }
                }
            }

            String rating = request.getParameter("feedback");
            String newModule = request.getParameter("newModule");
            String feedback = request.getParameter("feedbackString");
            String type = request.getParameter("newType");
            try {
                // When issue is moved to new version need to update project id and module id
                pid = ProjectFinder.getProjectId(pName, fix_version);
                mid = ProjectFinder.getModuleId(pName, fix_version, mName);

                String fversion = request.getParameter("oldfixversion");
                String usub = request.getParameter("usub");
                String udes = request.getParameter("udes");
                String uexpected_result = request.getParameter("uexpected_result");

                String extendedQuery = "";
                int newModuleId = 0;
                if (newModule != null) {
                    newModuleId = MoMUtil.parseInteger(newModule, newModuleId);
                }
                if (!fversion.equalsIgnoreCase(fix_version)) {

                    extendedQuery = ",pid=?,module_id=?";

                }
                if (newModuleId > 0) {
                    mid = newModule;
                    extendedQuery = extendedQuery + ",module_id=?";
                }
                if (issueStatus.equalsIgnoreCase("Closed")) {
                    if (rating == null || rating == "") {
                        rating = "Good";
                    }
                }
                if (type == null) {
                    type = (String) session.getAttribute("typeName");
                }
                logger.info("DATE:" + new java.sql.Date(cal.getTimeInMillis()));
                if (usub != null && udes != null && uexpected_result != null) {
                    ps = connection.prepareStatement("update issue set severity=?, priority=?, assignedto=?, modifiedon=?, due_date = ?, rating = ?, feedback = ?,estimated_time=?,sap_issue_type=?, subject =?, description=?,EXPECTED_RESULT=?,ESCALATION=?,type=?  " + extendedQuery + "where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, severity);
                    ps.setString(2, priority);
                    ps.setString(3, assignedto);
                    ps.setDate(4, new java.sql.Date(cal.getTimeInMillis()));
                    ps.setDate(5, dbDate);
                    ps.setString(6, rating);
                    ps.setString(7, feedback);
                    ps.setString(8, estimatedTime);
                    ps.setString(9, sapIssueType);
                    ps.setString(10, usub);
                    ps.setString(11, udes);
                    ps.setString(12, uexpected_result);
                    ps.setString(13, escalator);
                    ps.setString(14, type);
                    int i = 15;
                    logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                    if (!fversion.equalsIgnoreCase(fix_version)) {
                        logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                        ps.setString(i, pid);
                        ps.setString(i + 1, mid);
                        i = i + 2;
                    } else if (newModuleId > 0) {
                        ps.setString(i, mid);
                        i++;
                    }
                    ps.setString(i, issueId);
                } else {
                    ps = connection.prepareStatement("update issue set severity=?, priority=?, assignedto=?, modifiedon=?, due_date = ?, rating = ?, feedback = ?,estimated_time=?,sap_issue_type=?,ESCALATION=?,type=? " + extendedQuery + "where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, severity);
                    ps.setString(2, priority);
                    ps.setString(3, assignedto);
                    ps.setDate(4, new java.sql.Date(cal.getTimeInMillis()));
                    ps.setDate(5, dbDate);
                    ps.setString(6, rating);
                    ps.setString(7, feedback);
                    ps.setString(8, estimatedTime);
                    ps.setString(9, sapIssueType);
                    ps.setString(10, escalator);
                    ps.setString(11, type);
                    int i = 12;
                    logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                    if (!fversion.equalsIgnoreCase(fix_version)) {
                        logger.info("fuVersion!=fxVersion" + fversion + "," + fix_version);
                        ps.setString(10, pid);
                        ps.setString(11, mid);
                        i = 12;
                    } else if (newModuleId > 0) {
                        ps.setString(i, mid);
                        i++;
                    }
                    ps.setString(i, issueId);
                }
                y = ps.executeUpdate();

            } catch (Exception e) {
                logger.error("Exception in issue update:" + e);
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }

            session.removeAttribute("moduleName");
            session.removeAttribute("projectName");
            session.removeAttribute("versionValue");
            session.removeAttribute("typeName");

            try {
                ps = connection.prepareStatement("update issuestatus set status=? where issueid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, issueStatus);
                ps.setString(2, issueId);
                z = ps.executeUpdate();
                logger.info("Updated the issue status:\t" + z);
            } catch (Exception e) {
                logger.error("Exception in issue status update:" + e);
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            try {
                if (projecttype != null) {
                    if (projecttype.equals("Implementation")) {
                        PreparedStatement insertPhase_St = connection.prepareStatement("update issue_implementation set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED
                        insertPhase_St.setString(1, phase);
                        insertPhase_St.setString(2, subphase);
                        insertPhase_St.setString(3, subsubphase);
                        insertPhase_St.setString(4, subsubsubphase);
                        insertPhase_St.setString(5, projecttype);
                        insertPhase_St.setString(6, issueId);
                        insertPhase_St.executeUpdate();
                        connection.commit();
                    } else if (projecttype.equals("Upgradation")) {
                        PreparedStatement insertPhase_St3 = connection.prepareStatement("update issue_upgradation set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED
                        insertPhase_St3.setString(1, phase);
                        insertPhase_St3.setString(2, subphase);
                        insertPhase_St3.setString(3, subsubphase);
                        insertPhase_St3.setString(4, subsubsubphase);
                        insertPhase_St3.setString(5, projecttype);
                        insertPhase_St3.setString(6, issueId);
                        insertPhase_St3.executeUpdate();
                        connection.commit();
                    } else if (projecttype.equals("Support")) {
                        PreparedStatement insertPhase_St6 = connection.prepareStatement("update issue_support set phase=?,subphase=?,subsubphase=?,subsubsubphase=?,projecttype=? where issueid=?");//CHANGED
                        insertPhase_St6.setString(1, phase);
                        insertPhase_St6.setString(2, subphase);
                        insertPhase_St6.setString(3, subsubphase);
                        insertPhase_St6.setString(4, subsubsubphase);
                        insertPhase_St6.setString(5, projecttype);
                        insertPhase_St6.setString(6, issueId);
                        insertPhase_St6.executeUpdate();
                        connection.commit();
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

                String fversion = request.getParameter("oldfixversion");
                String newprojecttype = null;
                if (!fversion.equalsIgnoreCase(fix_version)) {
                    pid = ProjectFinder.getProjectId(pName, fix_version);
                    logger.info("pid------------>" + pid);
                    stForType = connection.createStatement();
                    rsForType = stForType.executeQuery("select type from project_type where pid = " + pid);
                    if (rsForType.next()) {
                        newprojecttype = rsForType.getString("type");
                        logger.info("pid------------>" + newprojecttype);
                    }
                    ischeckTypeIssue = connection.createStatement();
                    isRPtypeIssue = ischeckTypeIssue.executeQuery("select issueid from Issue_" + newprojecttype + " where issueid = '" + issueId + "'");
                    boolean createIssueType = true;
                    if (isRPtypeIssue.next()) {
                        createIssueType = false;
                    }
                    if (createIssueType == true) {
                        String fixphase = null, fixsubphase = null, fixsubsubphase = null, fixsubsubsubphase = null;
                        if (newprojecttype != null) {
                            fixphase = "Project Preparation";
                            fixsubphase = "Actual situation analysis";
                            if (newprojecttype.equals("Implementation")) {

                                fixsubphase = "Implementation Scope";
                                fixsubsubphase = "Project deliverables";
                                insertPhase_St_A = connection.prepareStatement("insert into issue_implementation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                insertPhase_St_A.setString(1, issueId);
                                insertPhase_St_A.setString(2, fixphase);
                                insertPhase_St_A.setString(3, fixsubphase);
                                insertPhase_St_A.setString(4, fixsubsubphase);
                                insertPhase_St_A.setString(5, fixsubsubsubphase);
                                insertPhase_St_A.setString(6, newprojecttype);
                                insertPhase_St_A.executeUpdate();

                            } else if (newprojecttype.equals("Upgradation")) {

                                insertPhase_St_A = connection.prepareStatement("insert into issue_upgradation(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                insertPhase_St_A.setString(1, issueId);
                                insertPhase_St_A.setString(2, fixphase);
                                insertPhase_St_A.setString(3, fixsubphase);
                                insertPhase_St_A.setString(4, fixsubsubphase);
                                insertPhase_St_A.setString(5, fixsubsubsubphase);
                                insertPhase_St_A.setString(6, newprojecttype);
                                insertPhase_St_A.executeUpdate();

                            } else if (newprojecttype.equals("Support")) {

                                insertPhase_St_A = connection.prepareStatement("insert into issue_support(issueid,phase,subphase,subsubphase,subsubsubphase,projecttype) values(?,?,?,?,?,?)");//CHANGED
                                insertPhase_St_A.setString(1, issueId);
                                insertPhase_St_A.setString(2, fixphase);
                                insertPhase_St_A.setString(3, fixsubphase);
                                insertPhase_St_A.setString(4, fixsubsubphase);
                                insertPhase_St_A.setString(5, fixsubsubsubphase);
                                insertPhase_St_A.setString(6, newprojecttype);
                                insertPhase_St_A.executeUpdate();

                            }
                        }
                    }
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                if (stForType != null) {
                    stForType.close();
                }
                if (rsForType != null) {
                    rsForType.close();
                }
                if (insertPhase_St_A != null) {
                    insertPhase_St_A.close();
                }
                if (ischeckTypeIssue != null) {
                    ischeckTypeIssue.close();
                }
                if (isRPtypeIssue != null) {
                    isRPtypeIssue.close();
                }

            }
            try {
                if (connection != null) {
                    UpdateValue.updateUserValue(connection, Integer.parseInt(uid));
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

                if (mainIssue != null && !mainIssue.equals("")) {
                    new IssueDAOImpl().updateMainIssue(mainIssue, issueId);
                }
                if (comments.contains("googleusercontent")) {
                    UpdateIssue.updateIssueImageURL(issueId, comments);
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

                    /* Eliminating hyphen in mobile no*/
                    recipientMobile = recipientMobile.replaceAll("-", "");

                    logger.info("Mail " + to);
                    logger.info("Mail to Mobile " + recipientMobile);
                    logger.info("Mail to Mobile Operator" + recipientOperator);

                    String subject = request.getParameter("sub").trim();
                    String issStatus = request.getParameter("issuestatus");
                    String description = request.getParameter("des");
                    String customer = request.getParameter("customer");
                    String project = request.getParameter("project");
                    String version = request.getParameter("version");
                    String module = request.getParameter("module");
                    String platform = request.getParameter("platform");
                    String createdby = request.getParameter("creby");
                    String rootCause = request.getParameter("rootcause");
                    String expectedResult = request.getParameter("expected_result");

                    logger.info("Mail Subject " + subject);
                    logger.info("Mail Root Cause " + rootCause);
                    logger.info("Mail Expected Result " + expectedResult);
                    logger.info("Mail Desc " + description);

                    ArrayList<String> al = dashboard.Project.getDetails(project + ":" + version);
                    ArrayList<String> dateAndTime = CurrentDay.getDateTime();

                    //     logger.error(dateAndTime.toString());
                    String createdOn = (String) session.getAttribute("createdOn");
                    String foundVersion = (String) session.getAttribute("foundVersion");
                    String font = "#000000";

                    DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                    java.util.Date da = df.parse(dueDate);
                    String viewDueDate = sdf.format(da);

                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(viewDueDate) == true)) {
                        font = "RED";
                    }
                String    Subject = "eTracker " + issStatus + " Issue :  " + subject;

                    if (issStatus.equalsIgnoreCase("Closed")) {
                        Subject = "eTracker " + issStatus + " Issue with " + rating + " Rating :  " + subject;
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
                    String htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% > <font face=Verdana, Arial, Helvetica, sans-serif size=2 >"
                            + "<tr bgcolor=#E8EEF7 ><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Project</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + project + "</font></td>"
                            + "<td width = 18% ><b> <font face=Verdana, Arial, Helvetica, sans-serif size=2 >Customer </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + customer + "</td>"
                            + "</tr>"
                            + "<tr><td width   = 18% ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 > Version </b></td>"
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
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + fix_version + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated By</b> </td>"
                            + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Updated On </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Issue Status </b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + issStatus + "</td>"
                            + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Due Date</b> </td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=" + font + ">" + viewDueDate + "</font></td>"
                            + "</tr>" + crHtml
                            + "<tr><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Subject</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + subject + "</td>"
                            + "</tr>"
                            + "<tr bgcolor=#E8EEF7><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Description</b> </td>"
                            + "<td width  = 82%  colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + description + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Root Cause</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + rootCause + "</td>"
                            + "</tr>"
                            + "<tr ><td width  = 18% bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Expected Result</b> </td>"
                            + "<td width  = 82% colspan=3  bgcolor=#E8EEF7><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + expectedResult + "</td>"
                            + "</tr>"
                            + "<tr><td width  = 18%  ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Comments</b> </td>"
                            + "<td width  = 82% colspan=3 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + comments + "</td>"
                            + "</tr>"
                            + "</font>";
                    if (issStatus.equalsIgnoreCase("Closed")) {
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
                                + "<td width  = 82% colspan=3 bgcolor=#E8EEF7><font color='" + ratingColor + "' face=Verdana, Arial, Helvetica, sans-serif size=2 >" + rating + "</td>"
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
                    new Thread(new Runnable() {
                        public void run() {
                            SendMail.mailUpdate(issueId, Subject, htmlContent, Name, assignedto);
                        }
                    }).start();

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
                        htmlContent = "<table style='width:99%;'><tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;'>Question</td><td style='font-weight: bold;'>Answer</td><tr>"
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
                        new Thread(new Runnable() {
                            public void run() {
                                SendMail.escalationMail(htmlContent, Subject, Name, assignedto);
                            }
                        }).start();
                    }

                } catch (Exception exec) {
                    logger.error("Exception in mail sending:" + exec.getMessage());

                } finally {
                    if (username != null) {
                        username.close();
                    }
                    if (res != null) {
                        res.close();
                    }
                }
                /* Sending SMS while Updating issue

                 */
                try {
                    if (recipientOperator.equals("AIRTEL")) {
                    }
                } catch (Exception sms) {
                    System.err.println("Error while sending an SMS:" + sms);
                    logger.error(sms.getMessage());
                } finally {
                    if (connection != null) {
                        connection.close();
                    }
                }

            }

        %>
    </script>
    <jsp:forward page="/MyAssignment/UpdateIssue.jsp"/>
</BODY>
</HTML>
