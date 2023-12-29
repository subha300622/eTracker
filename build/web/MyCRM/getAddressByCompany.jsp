<%-- 
    Document   : getAddressByCompany
    Created on : 20 Nov, 2019, 11:35:02 AM
    Author     : Muthu
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="crmu" class="com.eminentlabs.crm.CRMUtil"></jsp:useBean>
<%
    String json = crmu.getAddressByCompany(request);
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(json);
%>
