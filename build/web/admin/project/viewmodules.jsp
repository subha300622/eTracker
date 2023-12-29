
<%@page import="dashboard.CheckCategory"%>
<%@page import="com.pack.controller.formbean.EditmoduleFormBean"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("VIEWMODULES");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%!
    int requestpage, pageone, pageremain, rowcount, pid;
    static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
%>
<%@ page import="com.pack.*,com.eminent.util.GetProjects"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type=text/css rel=STYLESHEET>

        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>

    </head>



    <jsp:useBean id="apmView" class="com.pack.controller.ViewModulesController"/>

    <body>

        <jsp:include page="/header.jsp" />

        <table cellpadding="0" cellspacing="0" width="100%">

            <tr border="2" bgcolor="#F5F5F5">

                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Project Administration</b></font> <FONT
                        SIZE="3" COLOR="#0000FF"> </FONT></td>

            </tr>

        </table>

        <br>

        <% int count=0;
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
                apmView.getAll(request);
        %>


        <table width="100%" border="0">
            <tr>

                <td align="left" width="100%">This list shows all the <b><%=apmView.getEditModuleList().size()%></b>
                    Modules for the <%=apmView.getProjectdetails()%>.</td>


            </tr>


        </table>

        <br>
<%     
                for (EditmoduleFormBean editModule : apmView.getEditModuleList()) {
                        count =count+editModule.getIssuecount().intValue();
                }
            %>

        <table width=100%>

            <TR bgcolor="#C3D9FF" height="21">
                <TD width="12%"><font><b>Module ID</b></font></TD>
                <TD width="12%"><font><b>Product ID</b></font></TD>
                <TD width="12%"><font><b>Product Name</b></font></TD>
                <TD width="12%"><font><b>Module(<%=count%>)</b></font></TD>
                <TD width="12%"><font><b>Module Target</b></font></TD>
                        <%if (apmView.getCategory().equalsIgnoreCase("SAP Project")) {%>
                <TD width="20%"><font><b>Customer Process Owner</b></font></TD>
                <TD width="20%"><font><b>Internal Process Owner</b></font></TD>
                        <%}%>
                <TD width="12%"><font><b>Manage</b></font></TD>
            </TR>

            <%       int i = 1;
                for (EditmoduleFormBean editModule : apmView.getEditModuleList()) {
                    if ((i % 2) != 0) {
            %>
            <tr bgcolor="white" height="21">
                <%
                } else {
                %>

            <tr bgcolor="#E8EEF7" height="21">
                <%
                    }
                    i++;
                %>

                <td width="12%"><%=editModule.getModuleid()%>
                </td>

                <td width="12%"><%=editModule.getPid()%>
                </td>

                <td width="12%"><%= StringUtil.encodeHtmlTag(apmView.getProject())%>
                </td>

                <td width="12%"><%= StringUtil.encodeHtmlTag(editModule.getModule())%>
                    <a href="<%= request.getContextPath()%>/admin/dashboard/modulewiseOpenIssue.jsp?project=<%=apmView.getProject()%>&mid=<%=editModule.getModuleid()%>&pid=<%=editModule.getPid()%>">(<%=editModule.getIssuecount()%>)</a>
                </td>
                <td style="">
                    <%=editModule.getTarget()%>
                </td>
                <%if (apmView.getCategory().equalsIgnoreCase("SAP Project")) {%>
                <td width="12%">
                    <%if (apmView.getTeamMembers().containsKey(String.valueOf(editModule.getcOwner()))) {%>
                    <%= apmView.getTeamMembers().get(String.valueOf(editModule.getcOwner()))%>
                    <%} else {%>
                    N/A
                    <%}%>
                    </font>
                </td>
                <td width="12%">
                    <%if (apmView.getTeamMembers().containsKey(String.valueOf(editModule.getiOwner()))) {%>
                    <%=  apmView.getTeamMembers().get(String.valueOf(editModule.getiOwner()))%>
                    <%} else {%>
                    N/A
                    <%}%>

                </td>
                <%}%>
                <td width="12%">
                    <a HREF="neweditmodule.jsp?mid=<%=editModule.getModuleid()%>">Edit</a></td>

            </tr>


            <%

                }%>
        </table>
        <%  } else {
        %>
        <BR>
        <table align="center">
            <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
        </table>
        <%
            }
        %>                        



    </body>

</html>