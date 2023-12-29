<%-- 
    Document   : createAccomplishment
    Created on : Jan 25, 2012, 2:01:33 PM
    Author     : Tamilvelan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%

	//Configuring log4j properties



	Logger logger = Logger.getLogger("Create Accomplishments");
	
        String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{

		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
        %>
<%
        String[] issueId = request.getParameterValues("accIssue");
        String type      = request.getParameter("type");
        logger.info("Type of Accomplishment:::"+type);
        int appId        = Integer.parseInt(request.getParameter("appId"));
        AppraisalUtil.createAccomplishedIssues(issueId,type,appId);

        if(type.equalsIgnoreCase("A")){
            logger.info("Forwarding to Activities"+type);
            %>
                <jsp:forward page="addActivities.jsp"></jsp:forward>
<%
        }else if(type.equalsIgnoreCase("O")){
            logger.info("Forwarding to Plan"+type);
            %>
                <jsp:forward page="addPlan.jsp"></jsp:forward>
<%
        }else if(type.equalsIgnoreCase("P")){
            logger.info("Forwarding to View"+type);
            String edit =   (String)session.getAttribute("edit");
            if(edit==null){
            %>
                <jsp:forward page="viewAppraisal.jsp"></jsp:forward>
<%
            }else{
%>
                <jsp:forward page="editAppraisal.jsp?appId=<%=appId%>"></jsp:forward>
<%
            }
        }else{
            logger.info("Forwarding to View"+type);
            %>
                <jsp:forward page="viewAppraisal.jsp"></jsp:forward>
<%
            }
%>