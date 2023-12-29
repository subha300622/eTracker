<%-- 
    Document   : deleteTag
    Created on : 28 Jun, 2016, 4:51:12 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<jsp:useBean id="tic" class="com.eminent.tags.TagController"/>
<%
   String res= tic.deleteTag(request);
    
    out.print(res);
%>
