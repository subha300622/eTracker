<%-- 
    Document   : deleteReimbursement
    Created on : 17 Aug, 2016, 11:57:49 AM
    Author     : EMINENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<jsp:useBean id="rvc" class="com.eminentlabs.mom.reimbursement.controller.ReimbursementVouchersController"/>
<%
   String res= rvc.deleteReimbursement(request);
    
    out.print(res);
%>
