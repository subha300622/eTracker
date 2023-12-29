<%-- 
    Document   : getTotalFineAmt
    Created on : Sep 2, 2014, 10:26:34 AM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.FineUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userId = request.getParameter("userId");
    String id = request.getParameter("paymentId");
    long paymentId;
    if(id == null){
        paymentId =0l;
    }else{
        paymentId = Long.valueOf(id);
    }
    int amount = FineUtil.getTotalFineAmt(userId,paymentId);
    out.print(amount);
%>
