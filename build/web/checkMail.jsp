<%-- 
    Document   : checkMail
    Created on : 17 Aug, 2016, 12:47:06 PM
    Author     : Muthu
--%>

<%@page import="java.util.Date"%>
<%@page import="com.eminentlabs.mom.ReadingEmail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Mail</title>
    </head>
    <body>
        <jsp:useBean id="ci" class="com.eminent.issue.controller.CreateIssueFromEmail"></jsp:useBean>
            <h1>Check Your Mail</h1>
        <%ci.createIssue(new Date());%>
    </body>
</html>
