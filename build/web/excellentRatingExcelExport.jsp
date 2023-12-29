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

    <%tcir.setAll(request);%>
    <%String name = "Excellent_rating_report_for_";
        name = name + tcir.getMonths().get(tcir.getMonth()) + "-" + tcir.getYear();
        name = name + ".xls";
        response.setHeader("Content-Disposition", "attachment; filename=" + name + "");
        Logger logger = Logger.getLogger("excelExport");

    %>






    <%   String s1 = "S1- Fatal";
        String s2 = "S2- Critical";
        String s3 = "S3- Important";
        String s4 = "S4- Minor";
        int i = 1, m = 0;
        for (Map.Entry<Integer, List<IssueFormBean>> entry : tcir.getTeamClosedIssues().entrySet()) {%>
    <TABLE width="100%">
        <%if (m > 0) {%> <TR >
            <TD width="100%" colspan="10"></TD>
        </TR><%}%>
        <TR bgColor="#C3D9FF">
            <TD width="100%" colspan="10"><font><b><%=tcir.getMember().get(entry.getKey())%> - <%=entry.getValue().size()%></b></font></TD>
        </TR>
        <TR bgColor="#C3D9FF">
            <TD width="10%" ><font><b>#</b></font></TD>
            <TD width="10%" ><font><b>Issue #</b></font></TD>
            <TD width="10%" ><font><b>Type</b></font></TD>
            <TD width="10%" ><font><b>Severity</b></font></TD>
            <TD width="10%"  ><font><b>Priority</b></font></TD>
            <TD width="10%" ><font><b>Rating</b></font></TD>
            <TD width="15%" ><font><b>Customer</b></font></TD>
            <TD width="15%" ><font><b>Created By</b></font></TD>
            <TD width="10%" ><font><b>Created On</b></font></TD>
            <TD width="10%" ><font><b>Modified On</b></font></TD>
        </TR>
    </TABLE>
    <%
        m++;
        i=0;
        for (IssueFormBean issueFormBean : entry.getValue()) {
    %>
    <table>
        <tr bgcolor="white" height="22">
            <td width="10%" height="40"><font face="Times New Roman" size="1"
                                              ><%=++i%> </font></td> 
                                              <td width="10%" height="40"><font face="Times New Roman" size="1"
                                              ><%=issueFormBean.getIssueId()%> </font></td>
            <td width="10%" height="40"><font face="Times New Roman" size="1"
                                              ><%=issueFormBean.getType()%> </font></td>

                                                <%     i++;
                if (issueFormBean.getSeverity().equals("#FF0000")) {
            %>
            <td width="11%" bgcolor="#FF0000"><font face="Times New Roman" size="1">S1 </font></td>
                    <%                } else if (issueFormBean.getSeverity().equals("#FF9900")) {
                    %>
            <td width="11%" bgcolor="#DF7401"><font face="Times New Roman" size="1">S2</font></td>
                    <%                } else if (issueFormBean.getSeverity().equals("#FFFF00")) {
                    %>
            <td width="11%" bgcolor="#F7FE2E"><font face="Times New Roman" size="1">S3 </font></td>
                    <%                } else if (issueFormBean.getSeverity().equals("#00FF40")) {
                    %>
            <td width="11%" bgcolor="#33FF33"><font face="Times New Roman" size="1">S4</font></td>
                    <%}%>
                                              
            <td width="10%" height="40"><font face="Times New Roman" size="1"
                                             color="#000000"><%=issueFormBean.getPriority()%></font></td>
            <td width="10%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%= issueFormBean.getRating()%></font></td>
            <td width="15%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%=  issueFormBean.getpName()%></font></td>
            <td width="15%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%=  issueFormBean.getCreatedBy()%></font></td>
            <td width="10%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%=  issueFormBean.getCreatedOn()%></font></td>
            <td width="10%" height="40"><font face="Times New Roman" size="1"
                                              color="#000000"><%=  issueFormBean.getModifiedOn()%></font></td>

        </tr>


    </TABLE>
    <%
            }
        }
    %>
</BODY>
</html>

