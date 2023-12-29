<%-- 
    Document   : exportExcelMail
    Created on : 29 Jun, 2017, 11:37:48 AM
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
<jsp:useBean id="admin" class="com.pack.AdminBean" />


<%
    response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\"");
    //Configuring log4j properties

    Logger logger = Logger.getLogger("excelExport");
    String type = request.getParameter("type");

    String headerSortUp = request.getParameter("headerSortUp");
    String headerSortDown = request.getParameter("headerSortDown");
    System.out.println(type + "," + headerSortDown + "," + headerSortUp);
    List<specifiedAllUsers> ul = new ArrayList<specifiedAllUsers>();
    if (type.equals("") && headerSortUp.equals("") && headerSortDown.equals("")) {
        ul.clear();

        ul = admin.getAllSpecificUsers();
        System.out.println("ul size is: " + ul.size());
        if (ul.size() > 0) {
%>
<table width=100% id="user" >

    <thead>

        <tr bgColor="#C3D9FF" >

            <td width="30%" ><font><b>Name</b></font></td>
            <td width="15%"  ><font><b>Type</b></font></td>
            <td width="20%" ><font><b>Company</b></font></td>
            <td width="23%" ><font><b>Status</b></font></td>
            <td width="20%" ><font><b>Email</b></font></td>
            <td width="10%" ><font><b>Mobile</b></font></td>
            <td width="10%" ><font><b>Phone</b></font></td>
        </tr>
    </thead> 
    <TBODY>
        <%
            for (specifiedAllUsers u : ul) {
        %>
        <tr >

            <td width="30%" ><%=u.getName()%></td>
            <td width="15%" ><%=u.getTeam()%></td>
            <td width="20%" ><%=u.getCompany()%></td>
            <td width="23%" ><%=u.getRoleName()%> </td>
            <td width="20%" ><%=u.getEmail()%></td>
            <td width="10%" >
                <%if (u.getMobile() == null) {%>                  
                <%} else {%>
                <%=u.getMobile()%>
                <%}%>
            </td>
            <td width="10%" ><%=u.getPhone()%></td>
        </tr>

        <%}%></TBODY></table>
        <%}
        } else {
            ul.clear();

            ul = mmc.getAllSpecificUsers(type, headerSortUp, headerSortDown);
            if (ul.size() > 0) {
        %>
<table width=100% id="user" class="tablesorter">

    <thead>

        <tr bgColor="#C3D9FF" >

            <td width="30%" ><font><b>Name</b></font></td>
            <td width="15%"  ><font><b>Type</b></font></td>
            <td width="20%" ><font><b>Company</b></font></td>
            <td width="23%" ><font><b>Status</b></font></td>
            <td width="20%" ><font><b>Email</b></font></td>
            <td width="10%" ><font><b>Mobile</b></font></td>
            <td width="10%" ><font><b>Phone</b></font></td>
        </tr>
    </thead> 
    <TBODY>
        <%
            for (specifiedAllUsers u : ul) {
        %>
        <tr >

            <td width="30%" ><%=u.getName()%></td>
            <td width="15%" ><%=u.getTeam()%></td>
            <td width="20%" ><%=u.getCompany()%></td>
            <td width="23%" ><%=u.getRoleName()%> </td>
            <td width="20%" ><%=u.getEmail()%></td>
            <td width="10%" >
                <%if (u.getMobile() == null) {%>                  
                <%} else {%>
                <%=u.getMobile()%>
                <%}%>
            </td>
            <td width="10%" ><%=u.getPhone()%></td>
        </tr>

        <%}%> </TBODY>
</TABLE>
<%
        }
    }%>

</HTML>