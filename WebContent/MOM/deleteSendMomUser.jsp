<%-- 
    Document   : deleteSendMomUser
    Created on : 18 Feb, 18, 15:33:43 PM
    Author     : Muthu
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="rvc" class="com.eminentlabs.mom.controller.SendMomMaintainController"/>
<%
   String res= rvc.deleteSendMomByUser(request);
    
    out.print(res);
%>
