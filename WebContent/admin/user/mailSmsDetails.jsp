<%-- 
    Document   : mailSmsDetails
    Created on : 27 Jun, 2017, 2:27:14 PM
    Author     : EMINENT
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController"/>
<%  LinkedHashMap<Integer, String> mapVal = new LinkedHashMap<Integer, String>();
    if (request.getParameter("id") != null && request.getParameter("action").equalsIgnoreCase("delete")) {
        mmc.deleteMailContent(request);
    } else if (request.getParameter("id") != null && request.getParameter("id").length() > 0 && request.getParameter("action").equalsIgnoreCase("edit")) {
        mmc.getMailsmsDetailsById(request);
    } else {
        mmc.getMailsmsDetails(request);
    }
    if (mmc.getSendsmsdetails() != "") {
        out.print(mmc.getSendsmsdetails());
    }
    if (mmc.getMessage().length() > 0) {
        out.print(mmc.getMessage());
    }
    if (mmc.getSendSmslist().size() > 0) {
        mapVal = mmc.getSendSmslist();
        String json = new Gson().toJson(mapVal);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
%>
