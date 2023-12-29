<%-- 
    Document   : createDomain
    Created on : 15 Jul, 2016, 2:02:07 PM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="ab" class="com.pack.AdminBean"/>
<%
    ab.doAction(request);
      if (ab.getDomain_name()!= "") {
        out.print(ab.getDomain_name());
}
%>