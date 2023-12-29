<%-- 
    Document   : saveFineAmount
    Created on : Aug 20, 2014, 9:29:56 AM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.FineUtil"%>
<%@page import="com.eminentlabs.mom.Fine"%>
<%@page import="com.eminentlabs.mom.FineAmountUsers"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        String userId = request.getParameter("userId");
        String reasonId = request.getParameter("reasonId");
        String fineDate = request.getParameter("finedate");
        String amount = request.getParameter("amount");
        int addedBy = (Integer) session.getAttribute("userid_curr");
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        FineAmountUsers fau = new FineAmountUsers();
        int fineamount = Integer.parseInt(amount);
        fau.setUserid(Integer.parseInt(userId));
        fau.setReasonid(Integer.parseInt(reasonId));
        fau.setAmount(fineamount);
        fau.setFineDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(fineDate)));
        fau.setAddedby(addedBy);
        fau.setAddedon(date);
        FineUtil.addFineAmtForUser(fau);
   
%>
<jsp:forward page="addFineAmtForUser.jsp">
    <jsp:param name="success" value="success"/>
</jsp:forward>

