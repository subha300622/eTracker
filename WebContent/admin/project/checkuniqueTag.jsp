<%-- 
Document   : checkuniqueTag
    Created on : 1 Jun, 2016, 10:22:56 AM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tc" class="com.eminent.tags.TagController"/>
<%
   String res= tc.getUniqueTag(request);
    out.print(res);
%>

