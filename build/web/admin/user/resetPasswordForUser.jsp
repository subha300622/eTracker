<%-- 
    Document   : resetPasswordForUser
    Created on : 25 Mar, 2019, 3:38:49 PM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="uc" class="com.eminent.user.controller.UserController"></jsp:useBean>
<% String res = uc.resetPasswordForUser(request);
    out.print(res);%>
