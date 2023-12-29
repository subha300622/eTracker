<%-- 
    Document   : disableAlerts
    Created on : 21 May, 2010, 2:29:34 PM
    Author     : ADAL
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.UpdateUserProject"%>



<%Logger logger = Logger.getLogger("disableAlerts");

    String alerts[] = request.getParameterValues("alerts");
    int userId = (Integer) session.getAttribute("userid_curr");
    String message = null;

    try {
        message = UpdateUserProject.UpdateAlerts(alerts, userId);
        if (message.equalsIgnoreCase("true")) {
%>
<jsp:forward page="profile.jsp">
    <jsp:param name="alertUpdate" value="Mail Alert Successfully Updated"/>
</jsp:forward>
<%
} else {
%>
<jsp:forward page="profile.jsp">
    <jsp:param name="alertUpdate" value="There is a problem in Alert Update"/>
</jsp:forward>
<%
    }
} catch (Exception e) {
    logger.error(e.getMessage());
%>
<jsp:forward page="profile.jsp">
    <jsp:param name="alertUpdate" value="There is a problem in Alert Update"/>
</jsp:forward>
<%
    }

%>
