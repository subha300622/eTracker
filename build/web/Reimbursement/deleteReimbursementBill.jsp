<%-- 
    Document   : deleteReimbursementBill
    Created on : 1 Sep, 2016, 11:01:27 AM
    Author     : EMINENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<jsp:useBean id="rvc" class="com.eminentlabs.mom.reimbursement.controller.ReimbursementVouchersController"/>
<%
   String res= rvc.deleteReimbursementBill(request);
    
    out.print(res);
%>
