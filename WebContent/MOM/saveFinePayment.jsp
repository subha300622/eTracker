<%-- 
    Document   : saveFinePayment
    Created on : Sep 2, 2014, 10:54:14 AM
    Author     : RN.Khans
--%>

<%@page import="com.eminent.issue.PlanStatus"%>
<%@page import="com.eminentlabs.mom.ErmFinePaid"%>
<%@page import="com.eminentlabs.mom.FineUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String userId = request.getParameter("userId");
    String fineDate = request.getParameter("date");
    String amount = request.getParameter("amount");
    String comments = request.getParameter("comments");
    int addedBy = (Integer) session.getAttribute("userid_curr");
    String status = PlanStatus.ACTIVE.getStatus();
    ErmFinePaid fau = new ErmFinePaid();
    int fineamount = Integer.parseInt(amount);
    fau.setUserid(Integer.parseInt(userId));
    fau.setAmount(fineamount);
    fau.setPaidDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(fineDate)));
    fau.setCollectedby(addedBy);
    fau.setComments(comments);
    fau.setStatus(status);
    FineUtil.addFinePayment(fau);    
%>
<jsp:forward page="FinePayment.jsp">
    <jsp:param name="success" value="success"/>
</jsp:forward>
