<%-- 
    Document   : getEInvoicingCal
    Created on : 16 Nov, 2023, 4:11:56 PM
    Author     : Pavithra-P-ABAP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="akc" class="com.eminent.gstn.AccessKeyController"></jsp:useBean>
<%
    String json = akc.getEInvoicingcalender(request);
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.println(json);
%>