<%-- 
    Document   : fileAttachIssue
    Created on : 28 Jun, 2015, 2:06:59 PM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="afc" class="com.eminentlabs.erm.ERMAttachFileController"/>
<%
    String url = afc.setAllForSingle(request, paERMFileAttachCandidateIEgeContext.getServletContext());
    String message = afc.getMessage();
    String link = url+"&message="+message;    
%>
<jsp:forward page="<%=link%>"/>
