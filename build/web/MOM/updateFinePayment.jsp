<%-- 
    Document   : updateFinePayment
    Created on : Sep 11, 2014, 10:59:29 AM
    Author     : RN.Khans
--%>

<%@page import="com.eminent.issue.PlanStatus"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminentlabs.mom.ErmFinePaid"%>
<%@page import="com.eminentlabs.mom.FineUtil"%>
<%@page import="com.eminentlabs.mom.Fine"%>
<%@page import="com.eminentlabs.mom.FineAmountUsers"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("FinePayment");
    String userId = request.getParameter("userId");
    String fineDate = request.getParameter("date");
    String amount = request.getParameter("amount");
    String comments = request.getParameter("comments");
    int addedBy = Integer.parseInt(request.getParameter("collectedById"));
    long paymentId = Long.valueOf(request.getParameter("paymentId"));
    String type = request.getParameter("type");
    int modifiedby = (Integer) session.getAttribute("userid_curr");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
    Date date = new Date();
    Date modifiedon = sdf.parse(sdf.format(date));
    ErmFinePaid fau = new ErmFinePaid();
    int fineamount = Integer.parseInt(amount);
    String status ="";

    fau.setId(paymentId);
    fau.setUserid(Integer.parseInt(userId));
    fau.setAmount(fineamount);
    fau.setPaidDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(fineDate)));
    fau.setCollectedby(addedBy);
    fau.setModifiedby(modifiedby);
    fau.setModifiedon(modifiedon);
    fau.setComments(comments);
    logger.info("type"+type);
    if (type.equalsIgnoreCase("edit")) {
        status = PlanStatus.ACTIVE.getStatus();
    } else if(type.equalsIgnoreCase("delete")){
        status = PlanStatus.INACTIVE.getStatus();
    }else{
        status="";
    }
    if(status != ""){
        fau.setStatus(status);
    }
    FineUtil.updateFinePayment(fau);

%>
<jsp:forward page="FinePayment.jsp"/>

