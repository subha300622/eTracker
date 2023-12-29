<%-- 
    Document   : timeSheetApproval
    Created on : Oct 30, 2009, 12:04:33 PM
    Author     : Administrator
--%>

<%@page import="com.eminent.timesheet.TimesheetCrmDetail"%>
<%@page import="com.eminentlabs.timesheet.dao.TimesheetDAOImpl"%>
<%@page import="com.eminentlabs.timesheet.dao.TimesheetDAO"%>
<%@page import="com.eminent.timesheet.TimesheetMaintanance"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="com.eminentlabs.dao.DAOConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.timesheet.TimesheetIssue"%>
<%@page import="com.eminent.util.UserIssueCount"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="java.util.List"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="org.apache.log4j.*,com.eminent.timesheet.CreateTimeSheet" %>
<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");
    //Configuring log4j properties
    Logger logger = Logger.getLogger("timeSheetApproval");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <title>JSP Page</title>
</head>
<body>

    <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
    <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
    <jsp:useBean id="tsu" class="com.eminent.timesheet.TimeSheetUtil"></jsp:useBean>
    <%!    Connection connection;
                                                                                    %>
    <%            try {
            TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
            connection = MakeConnection.getConnection();
            int userId = (Integer) session.getAttribute("uid");
            int role = (Integer) session.getAttribute("Role");

            String status = request.getParameter("status");
            String timeSheetId = request.getParameter("timeSheetId");
            int owner = Integer.parseInt(timeSheetId.substring(7, timeSheetId.length()));

            TimesheetMaintanance timesheetMaintanance = timesheetDAO.findByRequester(owner);
            int timeSheetApprovalUserId = 112;
            if (timesheetMaintanance == null) {
            } else {
                if (timesheetMaintanance.getTimesheetApprover() != 0) {
                    timeSheetApprovalUserId = timesheetMaintanance.getTimesheetApprover();
                } else {
                    timeSheetApprovalUserId = 112;
                }
            }
            if (status.equals("Approved")) {
                String feedback = request.getParameter("feedback");
                String appreciation = request.getParameter("appreciation");
                String percentage = request.getParameter("percentage");
                String esplHours = request.getParameter("eminentHours");
                String meetingHours = request.getParameter("meetingHours");
                String wonAccounts = request.getParameter("wonaccount");
                String metdecisionmaker = request.getParameter("metdecisionmaker");
                String identifieddecisionmaker = request.getParameter("identifieddecisionmaker");
                String metinfluencers = request.getParameter("metinfluencers");
                String identifiedinfluencers = request.getParameter("identifiedinfluencers");
                CreateTimeSheet.ApproveTimeSheet(timeSheetId, Integer.parseInt(percentage), feedback, appreciation, userId, status, esplHours, meetingHours, wonAccounts, metdecisionmaker, identifieddecisionmaker, metinfluencers, identifiedinfluencers);
                if (role == 3) {
                    String wonAccountid[] = request.getParameterValues("wonaccountid");
                    String metdecisionmakerid[] = request.getParameterValues("metdecisionmakerid");
                    String identifieddecisionmakerid[] = request.getParameterValues("identifieddecisionmakerid");
                    String metinfluencersleadid[] = request.getParameterValues("metinfluencersleadid");
                    String metinfluencercontactid[] = request.getParameterValues("metinfluencercontactid");
                    String identifiedinfluencersleadid[] = request.getParameterValues("identifiedinfluencersleadid");
                    String identifiedinfluencercontactid[] = request.getParameterValues("identifiedinfluencercontactid");
                    if (wonAccounts != null && wonAccounts.equalsIgnoreCase("yes") && wonAccountid != null) {
                        for (String acc : wonAccountid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Account");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                    if (metdecisionmaker != null && metdecisionmaker.equalsIgnoreCase("yes") && metdecisionmakerid != null) {
                        for (String acc : metdecisionmakerid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Lead");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                    if (identifieddecisionmaker != null && identifieddecisionmaker.equalsIgnoreCase("yes") && identifieddecisionmakerid != null) {
                        for (String acc : identifieddecisionmakerid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Lead");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                    if (metinfluencers != null && metinfluencers.equalsIgnoreCase("yes") && metinfluencersleadid != null) {
                        for (String acc : metinfluencersleadid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Lead");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                    if (metinfluencers != null && metinfluencers.equalsIgnoreCase("yes") && metinfluencercontactid != null) {
                        for (String acc : metinfluencercontactid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Contact");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                      if (identifiedinfluencers != null && identifiedinfluencers.equalsIgnoreCase("yes") && identifiedinfluencersleadid != null) {
                        for (String acc : identifiedinfluencersleadid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Lead");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                    if (identifiedinfluencers != null && identifiedinfluencers.equalsIgnoreCase("yes") && identifiedinfluencercontactid != null) {
                        for (String acc : identifiedinfluencercontactid) {
                            TimesheetCrmDetail tcd = new TimesheetCrmDetail();
                            tcd.setCrmType("Contact");
                            tcd.setTimesheetid(timeSheetId);
                            tcd.setReferenceid(Integer.parseInt(acc));
                            ModelDAO.save("TimesheetCrmDetail", tcd);
                        }
                    }
                }
            } else if (status.equals("Need Info") && userId == timeSheetApprovalUserId) {

                String info = request.getParameter("needinfo");
                String assigned = request.getParameter("assignedto");

                CreateTimeSheet.GetInfo(timeSheetId, owner, Integer.parseInt(assigned), userId, status, info);
                logger.info("Info" + info);
                logger.info("assigned" + assigned);
            } else if (status.equals("Need Info")) {
                String info = request.getParameter("needinfo");
                int assigned = timeSheetApprovalUserId;
                CreateTimeSheet.GetInfo(timeSheetId, owner, assigned, userId, "Yet to approve", info);
            }

            List<TimesheetIssue> tsheetTotalissues = tsu.findIssuesByTimesheetId(timeSheetId);
            List<String> tsheetissues = new ArrayList<String>();
            for (TimesheetIssue timesheetIssue : tsheetTotalissues) {
                if (timesheetIssue.getWorkstatus() == 0) {
                    tsheetissues.add(timesheetIssue.getIssueid());
                }
            }
            List<String> coIssues = new ArrayList<String>();
            List<String> wIssues = new ArrayList<String>();
            Map<String, String[]> parameters = request.getParameterMap();
            for (String parameter : parameters.keySet()) {
                if (parameter.toLowerCase().startsWith("prev")) {
                    String[] values = parameters.get(parameter);
                    for (int i = 0; i < values.length; i++) {
                        if (values[i].length() > 11) {
                            if (values[i].endsWith("c")) {
                                coIssues.add(values[i].substring(0, 12));
                            } else {
                                wIssues.add(values[i].substring(0, 12));
                            }
                        }
                    }
                }
                if (parameter.toLowerCase().startsWith("curr")) {
                    String[] values = parameters.get(parameter);
                    for (int i = 0; i < values.length; i++) {
                        if (values[i].length() > 11) {
                            if (values[i].endsWith("c")) {
                                coIssues.add(values[i].substring(0, 12));
                            } else {
                                wIssues.add(values[i].substring(0, 12));
                            }
                        }
                    }
                    //your code here
                }

            }
            logger.info(coIssues);
            logger.info(wIssues);
            for (String issue : coIssues) {
                boolean flag = true;
                for (TimesheetIssue ts : tsheetTotalissues) {
                    if (issue.equals(ts.getIssueid())) {
                        if (ts.getWorkstatus() == 1) {
                            ts.setWorkstatus(0);
                            ModelDAO.update(DAOConstants.ENTITY_TIMESHEET_ISSUE, ts);
                            flag = false;
                        } else {
                            flag = false;
                        }
                    }
                }
                if (flag == true) {
                    TimesheetIssue tsi = new TimesheetIssue(issue, 0, timeSheetId);
                    ModelDAO.save(DAOConstants.ENTITY_TIMESHEET_ISSUE, tsi);
                }
            }
            for (String issue : wIssues) {
                boolean flag = true;
                for (TimesheetIssue ts : tsheetTotalissues) {
                    if (issue.equals(ts.getIssueid())) {
                        if (ts.getWorkstatus() == 0) {
                            ts.setWorkstatus(1);
                            ModelDAO.update(DAOConstants.ENTITY_TIMESHEET_ISSUE, ts);
                            flag = false;
                        } else {
                            flag = false;
                        }
                    }
                }
                if (flag == true) {
                    TimesheetIssue tsi = new TimesheetIssue(issue, 1, timeSheetId);
                    ModelDAO.save(DAOConstants.ENTITY_TIMESHEET_ISSUE, tsi);
                }
            }
            String user = String.valueOf(userId);
            int assinmentNo = UserIssueCount.getAssignmentCount(user);
            List tce = TestCasePlan.listUserExecution(userId);
            int crmIssues = CRMIssue.getCRMIssues(connection, userId);
            int noOfTce = tce.size();
            String leaveDetails[][] = LeaveUtil.waitingForApproval(userId);
            int noOfRequests = leaveDetails.length;
            List l = CreateTimeSheet.GetTimeSheet(userId);
            int noOfTimeSheet = l.size();
            int ermAssignment = ERMUtil.getAssignedApplicantCount(userId);
            int resourceRequest = ResourceRequest.getResourceRequestNo(connection, userId);
            String for_ward = CRMIssue.getHigestCRMIssues(connection, userId, userId);
            logger.info("noOfRequests" + noOfRequests);

            if (userId == GetProjectMembers.getAdminID()) {
                logger.info("testl");
    %>
    <jsp:forward page="viewTimesheetStatus.jsp"/>
    <%
    } else if (noOfTimeSheet > 0) {
    %>
    <jsp:forward page="/MyTimeSheet/timeSheetList.jsp"/>

    <%} else if (noOfRequests > 0) {
    %>

    <jsp:forward page="/UserProfile/editLeaveRequest.jsp"/>
    <%} else if (crmIssues > 0) {
    %>
    <jsp:forward page="/MyTimeSheet/performanceChart.jsp"/>
    <%} else if (assinmentNo > 0) {
    %>
    <jsp:forward page="/MyAssignment/UpdateIssue.jsp"/>
    <%} else if (noOfTce > 0) {
    %>
    <jsp:forward page="/MyAssignment/listTestCases.jsp"/>
    <%} else if (resourceRequest > 0) {
    %>
    <jsp:forward page="/ResourceRequest/viewResourceRequest.jsp"/>
    <%} else if (ermAssignment > 0) {
    %>
    <jsp:forward page="/ERM/assignedApplicants.jsp"/>
    <%} else {%>
    <jsp:forward page="/admin/dashboard/chartForUsers.jsp"/>
    <%}
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Exception:" + e);
        } finally {

            if (connection != null && !connection.isClosed()) {
                connection.close();

            }

        }%>
</body>
</html>
