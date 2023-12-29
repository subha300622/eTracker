<%-- 
    Document   : exportExcelMailNotSentContact
    Created on : 4 Jul, 2017, 7:44:03 PM
    Author     : EMINENT
--%>



<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.timesheet.specifiedAllUsers"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@ page language="java" contentType="application/vnd.ms-excel;"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, org.apache.log4j.*"%>
<%@ page import="com.eminent.util.*, dashboard.CheckDate"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">

    <style>
        td{
            border: 1px solid black;
            text-align: center;
        }
    </style>
</HEAD>

<jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController" />



<%int i = 0;
    response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\"");
    //Configuring log4j properties

    Logger logger = Logger.getLogger("excelExport");
    List<String> ul = mmc.getMailnotSent();
    
    if (ul.size() > 0) {
%>
<table width=100% id="user" >

    <thead>

        <tr bgColor="#C3D9FF" >

            <td width="5%" ><font><b>S.No</b></font></td>

            <td width="30%" ><font><b>Email</b></font></td>

        </tr>
    </thead> 
    <TBODY>
        <%
            for (String u : ul) {
                i++;
        %>
        <tr >

            <td width="5%"><%=i%></td>
            <td width="30%" ><%=u%></td>


        </tr>

        <%}%></TBODY></table>
        <%}%>



</HTML>