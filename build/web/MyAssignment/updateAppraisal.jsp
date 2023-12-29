<%-- 
    Document   : updateAppraisal
    Created on : Dec 19, 2011, 12:47:15 PM
    Author     : Tamilvelan
--%>
<%@page import="java.util.List"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@page import="com.eminentlabs.appraisal.ErmAppraisalComment,java.sql.Timestamp"%>
<%@page import="com.eminentlabs.dao.ModelDAO,com.eminentlabs.dao.DAOFactory"%>
<%@page import="com.eminentlabs.appraisal.ErmAppraisal,com.eminentlabs.appraisal.ErmAppraisalStatus"%>
<%Logger logger = Logger.getLogger("updateAppraisal");
    Timestamp date = new Timestamp(new java.util.Date().getTime());

    String comments = request.getParameter("comments");
    String accomplishments = request.getParameter("accomplishments");
    String ongoing = request.getParameter("ongoing");
    String nextcycle = request.getParameter("nextcycle");
    String assignedTo = request.getParameter("assignedto");
    String status = request.getParameter("status");
    String appId = request.getParameter("appId");
    String attendance = request.getParameter("attendance");
    String createdIss = request.getParameter("createdIssue");
    String workedIss = request.getParameter("workedIssue");
    String closedIss = request.getParameter("closedIssue");
    String approvalPer = request.getParameter("approvalPercentage");
    String newLearning = request.getParameter("newLearnings");
    String secAppraiser = request.getParameter("secondAppraiser");
    String thrAppraiser = request.getParameter("thirdAppraiser");
    String statusName = AppraisalUtil.getAppraisalStatus(Integer.parseInt(status));
    String link = (String) session.getAttribute("forwardpage");
    ErmAppraisal app = (ErmAppraisal) ModelDAO.load(ErmAppraisal.class, Integer.parseInt(appId));
    app.setAssignedto(Integer.parseInt(assignedTo));
    app.setSecondAppraiser(Integer.parseInt(secAppraiser));
    app.setThirdAppraiser(Integer.parseInt(thrAppraiser));
    app.setErmAppraisalStatus((ErmAppraisalStatus) ModelDAO.load(ErmAppraisalStatus.class, Integer.parseInt(status)));
    if (attendance != null) {
        app.setAttendanceComments(attendance);
        app.setCreatedIssuesComment(createdIss);
        app.setWorkedIssuesComment(workedIss);
        app.setClosedIssuesComment(closedIss);
        app.setApprovalPercentage(approvalPer);
        app.setNewLearningsComment(newLearning);
    }
    if (statusName.equalsIgnoreCase("Approved")) {
        app.setApprovalStatus("Y");
    }
    if (statusName.equalsIgnoreCase("Rejected")) {
        app.setApprovalStatus("N");
    }
    app.setUpdatedon(date);
    if (statusName.equalsIgnoreCase("Approved")) {
        int userApp = Integer.parseInt(request.getParameter("userAppraisal"));
        app.setUserAppraisalPercentage(userApp);
    }
    DAOFactory.updateErmAppraisal(app);
    // Adding Project Summary
    int userId = (Integer) session.getAttribute("uid");
    try {

    } catch (Exception e) {
        logger.error(e.getMessage());
    }
    // Comments
    if (comments != null) {
        try {
            ErmAppraisalComment comment = new ErmAppraisalComment();
            comment.setComments(comments);
            comment.setErmAppraisal(app);
            comment.setCommentedBy(userId);
            comment.setCommentedTo(Integer.parseInt(assignedTo));
            comment.setStatus(Integer.parseInt(status));
            comment.setCommentedOn(date);
            ModelDAO.save("DAOConstants.ENTITY_ErmAppraisalComment", comment);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }
    List appRequest = AppraisalUtil.viewAppraisalrequest(userId);
    int noOfRequest = appRequest.size();
    if (noOfRequest > 0) {
%>
<jsp:forward page="<%=link%>">
    <jsp:param name="flag" value="true"/>
</jsp:forward>
<%} else {
%>
<jsp:forward page="/MyAssignment/UpdateIssue.jsp"></jsp:forward>
<%
    }%>

