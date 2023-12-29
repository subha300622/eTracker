<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ page language="java"
         contentType="application/vnd.ms-excel;"
         pageEncoding="UTF-8"%>
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


<BODY BGCOLOR="#FFFFFF">

    <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"/>

    <%tcir.getTeamwise(request);%>
    <%String name = tcir.getTeam() == "" ? "All Team" : tcir.getTeam();
        name = name + "-Closed Issues-";
        name = name + tcir.getMonths().get(tcir.getMonth()) + "-" + tcir.getYear();
        name = name + ".xls";
        System.out.println("name : " + name);
        response.setHeader("Content-Disposition", "attachment; filename=" + name + "");
        //Configuring log4j properties

        Logger logger = Logger.getLogger("excelExport");

    %>

    <table width="100%" height="15">
        <tr>
            <TD align="right" width="25" height="40">Severity</td>
            <TD align="right" width="25" height="40" bgcolor="#FF0000">S1</TD>
            <TD align="right" width="25" height="40" bgcolor="#FF9900">S2</TD>
            <TD align="right" width="25" height="40" bgcolor="#FFFF00">S3</TD>
            <TD align="right" width="25" height="40" bgcolor="#33FF33">S4</TD>
        </tr>
    </table>




    <%     int m = 0;
        for (Map.Entry<Integer, List<IssueFormBean>> entry : tcir.getTeamClosedIssues().entrySet()) {%>
    <TABLE width="100%">
        <%if (m > 0) {%> <TR >
            <TD width="100%" colspan="11"></TD>
        </TR><%}%>
        <TR bgColor="#C3D9FF">
            <TD width="100%" colspan="11"><font><b><%=tcir.getMember().get(entry.getKey())%> - <%=entry.getValue().size()%></b></font></TD>
        </TR>
        <TR bgColor="#C3D9FF">
            <TD width="1%"><font><b>S</b></font></TD>
            <TD width="11%"><font><b>Issue No</b></font></TD>
            <TD width="7%"><font><b>Priority</b></font></TD>
            <TD width="13%"><font><b>Project</b></font></TD>
            <TD width="13%"><font><b>Module</b></font></TD>
            <TD width="29%"><font><b>Subject</b></font></TD>
            <TD width="9%"><font><b>Status</b></font></TD>
            <TD width="9%"><font><b>Rating</b></font></TD>
            <TD width="9%"><font><b>Due Date</b></font></TD><TD width="13%"><font><b>Created By</b></font></TD>
            <TD width="8%"><font><b>Age(in Days)</b></font></TD>
        </TR>
    </table>
    <%m++;
        for (IssueFormBean isfb : entry.getValue()) {%>
    <table>
        <tr bgcolor="white" height="22">
            <td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
            <td width="11%" height="40"><font face="Times New Roman" size="1"
                                              color="#0033FF"><%=isfb.getIssueId()%> </font></td>
            <td width="7%" height="40"><font face="Times New Roman" size="1"
                                             color="#000000"><%= isfb.getPriority()%></font></td>
            <td width="13%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%= isfb.getRedPName()%></font></td>
            <td width="13%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%= isfb.getRedMName()%></font></td>
            <td width="29%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%= isfb.getSubject()%></font></td>
            <td width="9%" height="40" bgcolor="<%=isfb.getRatingColor()%>"><font face="Times New Roman" size="1"
                                             ><%=isfb.getStatus()%></font></td>
            <td width="9%" height="40"><font face="Times New Roman" size="1"
                                             ><%=isfb.getRating()%></font></td>

            <td width="9%" height="40"><font face="Times New Roman" size="1"
                                             color="<%= isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></font></td>
            <td width="13%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%= isfb.getCreatedBy()%> </font></td>

            <td width="8%" align="center" height="40"><font
                    face="Times New Roman" size="1" color="#000000"><%=isfb.getAge()%></font></td>
        </tr>


    </TABLE>
    <%
            }
        }
    %>
</BODY>
</html>

