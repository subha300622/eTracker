 <%-- 
    Document   : createProcess
    Created on : 7 Sep, 2011, 8:40:53 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetProjectMembers,org.apache.log4j.Logger" %>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil" %>
<%@page import="java.util.ArrayList,java.util.HashMap,java.util.Collection,java.util.Iterator,java.util.Calendar,java.util.GregorianCalendar" %>
<%
    Logger logger           =   Logger.getLogger("");
    String userId           =   request.getParameter("userId");
    String designation      =   request.getParameter("designation");
    String empId            =   request.getParameter("employeeId");
    String frommonth        =   request.getParameter("frommonth");
    String fromyear         =   request.getParameter("fromyear");
    String tomonth          =   request.getParameter("tomonth");
    String toyear           =   request.getParameter("toyear");
    String firstAppraiser   =   request.getParameter("firstappraiser");
    String secAppraiser     =   request.getParameter("secondappraiser");
    String thirdAppraiser   =   request.getParameter("thirdappraiser");
    String account          =   request.getParameter("accountant");
    String initiater        =   request.getParameter("initiater");
    String comments         =   request.getParameter("comments");

//    logger.info("User ID-->"+userId);
//    logger.info("Designation"+designation);
//    logger.info("Emp Id"+empId);
    logger.info("From month"+frommonth);
    logger.info("From Year"+fromyear);
    logger.info("To Month"+tomonth);
    logger.info("To Year"+toyear);
    String period   =   frommonth+"-"+fromyear+"*"+tomonth+"-"+toyear;
//    logger.info("First Appraiser"+firstAppraiser);
//    logger.info("Second Appraiser"+secAppraiser);
//    logger.info("Third Appraiser"+account);
//    logger.info("Intiater"+initiater);
//    logger.info("Comments"+comments);
    AppraisalUtil.createAppraisal(empId, Integer.parseInt(userId), Integer.parseInt(firstAppraiser), Integer.parseInt(secAppraiser), Integer.parseInt(thirdAppraiser), Integer.parseInt(thirdAppraiser), Integer.parseInt(initiater),period,comments);
%>
<jsp:forward page="/admin/user/viewuser.jsp"/>
