<%-- 
    Document   : createUserRequest
    Created on : Dec 21, 2011, 3:16:55 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetProjectMembers,org.apache.log4j.Logger" %>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil,com.eminentlabs.appraisal.ErmAppraisal,com.eminentlabs.dao.ModelDAO" %>
<%@page import="java.util.ArrayList,java.util.HashMap,java.util.Collection,java.util.Iterator,java.util.Calendar,java.util.GregorianCalendar" %>
<%
    Logger logger           =   Logger.getLogger("");
    int userId                  =   (Integer)session.getAttribute("uid");
    String empId            =   request.getParameter("employeeId");
    String frommonth        =   request.getParameter("frommonth");
    String fromyear         =   request.getParameter("fromyear");
    String tomonth          =   request.getParameter("tomonth");
    String toyear           =   request.getParameter("toyear");

    String comments         =   request.getParameter("comments");
    String accomplishments      =   request.getParameter("accomplishments");
    String ongoing      =   request.getParameter("ongoing");
    String nextcycle      =   request.getParameter("nextcycle");

    logger.info("From month"+frommonth);
    logger.info("From Year"+fromyear);
    logger.info("To Month"+tomonth);
    logger.info("To Year"+toyear);
    String period   =   frommonth+"-"+fromyear+"*"+tomonth+"-"+toyear;
    session.setAttribute("period", period);

    int appId   =   AppraisalUtil.createUserAppraisal(empId, userId,period,comments,accomplishments,ongoing,nextcycle);
   logger.info("Appraisal Id Created"+appId);

 
%>
<jsp:forward page="addAccomplishment.jsp">
    <jsp:param name="appId" value="<%=appId%>"/>
    <jsp:param name="period" value="<%=period%>"/>
</jsp:forward>
