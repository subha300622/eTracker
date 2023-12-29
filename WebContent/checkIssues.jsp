<%-- 
    Document   : checkIssues
    Created on : 7 Sep, 2015, 12:42:39 PM
    Author     : EMINENT
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <jsp:useBean id="dnc" class="com.eminent.issue.controller.DesktopNotificationController"/>
        <%
            Integer headeruserId = (Integer) session.getAttribute("userid_curr");
            String json = dnc.GetNotifyIssues(headeruserId);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        %>

