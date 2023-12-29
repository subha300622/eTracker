<%-- 
    Document   : checkApplicantId
    Created on : Feb 17, 2014, 4:37:24 PM
    Author     : E0288
--%>
<%@page import="com.eminentlabs.erm.ErmApplicant"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String applicantId=request.getParameter("applicantId");
ErmApplicant ermApplicant=new ErmApplicant();
        ermApplicant=ERMUtil.findByApplicantId(applicantId);
if(ermApplicant==null){
    out.print("Ok");
}
%>
