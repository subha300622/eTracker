<%-- 
    Document   : exportexcelIssueByTag
    Created on : 08 Mar, 2019, 12:18:45 AM
--%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
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
    <jsp:useBean id="tagc" class="com.eminent.tags.TagIssueController"></jsp:useBean>

    <BODY BGCOLOR="#FFFFFF">

       
        <%
            response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\"");
            //Configuring log4j properties

            Logger logger = Logger.getLogger("excelExport");
            tagc.getAllIssueByTag(request);
            
        %>

        <table  style="width: 100%;height:40px">
            <tr>

                <TD align="right" style="width:25px;">Severity</td>
                <TD align="right" style="width:25px;background-color:#FF0000">S1</TD>
                <TD align="right" style="width:25px;background-color:#FF9900">S2</TD>
                <TD align="right" style="width:25px;background-color:#FFFF00">S3</TD>
                <TD align="right" style="width:25px;background-color:#33FF33">S4</TD>
            </tr>

        </table>



        <TABLE width="100%">
            <TR bgColor="#C3D9FF">
                <TD width="1%"><font><b>S</b></font></TD>
                <TD width="11%"><font><b>Issue No</b></font></TD>
                <TD width="7%"><font><b>Priority</b></font></TD>
                <TD width="13%"><font><b>Project</b></font></TD>
                <TD width="13%"><font><b>Module</b></font></TD>
                <TD width="29%"><font><b>Subject</b></font></TD>
                <TD width="9%"><font><b>Status</b></font></TD>
                <TD width="9%"><font><b>Due Date</b></font></TD>
                <TD width="13%"><font><b>Assigned To</b></font></TD>
                <TD width="13%"><font><b>Refer </b></font></TD>
                <TD width="8%"><font><b>Age(in Days)</b></font></TD>
            </TR>
            <%if (tagc.getListIssueFormBean()== null || tagc.getListIssueFormBean().isEmpty()) {
                } else {
                    String s1 = "S1- Fatal";
                    String s2 = "S2- Critical";
                    String s3 = "S3- Important";
                    String s4 = "S4- Minor";
                    int i = 1;
                    for (IssueFormBean issueFormBean : tagc.getListIssueFormBean()) {
                        if (i % 2 == 0) {

            %>
            <tr style="height: 22px;background-color:white">
                <%} else {%>
            <tr style="height: 22px;background-color:#E8EEF7">
                <%}%>

                <%     i++;
                    if (issueFormBean.getSeverity().equals(s1)) {
                %>
                <td width="1%" bgcolor="#FF0000"></td>
                <%                } else if (issueFormBean.getSeverity().equals(s2)) {
                %>
                <td width="1%" bgcolor="#DF7401"></td>
                <%                } else if (issueFormBean.getSeverity().equals(s3)) {
                %>
                <td width="1%" bgcolor="#F7FE2E"></td>
                <%                } else if (issueFormBean.getSeverity().equals(s4)) {
                %>
                <td width="1%" bgcolor="#33FF33"></td>
                <%                    }
                %>
                <td width="11%" height="40"><font face="Times New Roman" size="1"
                                                  color="#0033FF"><%=issueFormBean.getIssueId()%> </font></td>
                <td width="7%" height="40"><font face="Times New Roman" size="1"
                                                 color="#000000"><%=issueFormBean.getPriority()%></font></td>
                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= issueFormBean.getpName()%></font></td>
                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%=  issueFormBean.getmName()%></font></td>
                <td width="29%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%=  issueFormBean.getSubject()%></font></td>
               	<td width="9%" height="40"><font face="Times New Roman" size="1"
                                                 color="#000000"><%=  issueFormBean.getStatus()%></font></td>

                <%
                    if ((!issueFormBean.getDueDate().equalsIgnoreCase("NA")) && (CheckDate.getFlag(issueFormBean.getDueDate()) == true)) {

                %>
                <td width="9%" height="40"><font face="Times New Roman" size="1"
                                                 color="RED"><%= issueFormBean.getDueDate()%></font></td>
                        <%
                        } else {
                        %>
                <td width="9%" height="40"><font face="Times New Roman" size="1"
                                                 color="#000000"><%= issueFormBean.getDueDate()%></font></td>
                        <%
                            }
                     int asign = MoMUtil.parseInteger(issueFormBean.getAssignto(), 0);
                                String assignto = (String) tagc.getUserMap().get(asign);
                        %>

                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= assignto%> </font></td>

                <%  int count = 0;
                            if (tagc.getFileCountList().containsKey(issueFormBean.getIssueId())) {
                                count = tagc.getFileCountList().get(issueFormBean.getIssueId());
                            }
                            if (count > 0) {
                %>
                <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> ViewFiles(<%=count%>)</font></td>
                        <%
                        } else {
                        %>
                <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                        <%
                            }
                                 int age = 0;
                                for (Map.Entry<String, Integer> entrySet : tagc.getAgeofIssue().entrySet()) {
                                    if (entrySet.getKey().equalsIgnoreCase(issueFormBean.getIssueId())) {
                                        age = entrySet.getValue();
                                    }
                                }
                                int lastAsigneeAge = 1;
                                if (tagc.getLastAsigneeAgeList().containsKey(issueFormBean.getIssueId())) {
                                    lastAsigneeAge = tagc.getLastAsigneeAgeList().get(issueFormBean.getIssueId());
                                }
                                if (lastAsigneeAge == 1) {
                                    lastAsigneeAge = age;
                                }
                                if (lastAsigneeAge == 0) {
                                    lastAsigneeAge = lastAsigneeAge + 1;
                                }
                        %>

                <td width="8%" align="center" height="40"><font
                        face="Times New Roman" size="1" color="#000000"><%=lastAsigneeAge%></font></td>
            </tr>
            <%
                    }
                }%>

        </table>
            