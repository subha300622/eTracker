<%-- 
    Document   : ermMyViews
    Created on : Feb 25, 2014, 10:58:10 AM
    Author     : E0288
--%>

<%@page import="java.net.URLDecoder"%>
<%@page import="com.eminent.util.MyViewUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminentlabs.erm.MyQuery"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
 
        Logger logger = Logger.getLogger("ermMyViews");
       
        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type="text/css" rel=STYLESHEET>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <br/>

        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="100%"><font size="4"
                                                               COLOR="#0000FF"><b> My Views </b></font> <FONT SIZE="3"
                                                               COLOR="#0000FF"></FONT></td></tr>
        </table>
        <br/>
        <table style="text-align: center;width: 100%;">
            <%
                List<MyQuery> myViews = ERMUtil.getMyViews(request);
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
                int i = 0;
                if (request.getParameter("status") != null) {
            %>

<br>
            <tr>
                <td align=center><FONT SIZE="4" COLOR="#33CC33" style="font-weight: bold;">You
                    have successfully Deleted the Search : </FONT> <FONT SIZE="4" COLOR="#0000FF">
                    <%= request.getParameter("status")%></FONT>
                </td>
            </tr>

            <%
        } else if (request.getParameter("saveView") != null) {%>
            <tr>
                <td align=center> <FONT SIZE="4" COLOR="#33CC33" style="font-weight: bold;">You
                    have successfully Saved the Search : </FONT> <FONT SIZE="4" COLOR="#0000FF" style="font-weight: bold;">
                    <%= request.getParameter("saveView")%></FONT>
                </td>
            </tr>
            <% } else if (request.getParameter("errormessage") != null) {%>
            <tr>
                <td align=center> <FONT SIZE="4" COLOR="red" style="font-weight: bold;">
                    <%= request.getParameter("errormessage")%></FONT>
                </td>
            </tr>
            <% }

            %>
        </table>
<table width="100%">
	<tr>
		<td align="left" width="100%">This list shows <b><%=myViews.size()%></b>
		views saved by you.</td>
		
	</tr>
</table>
        <table width="100%">
            <tr bgcolor="#C3D9FF" height="21">
                <td width="12%"><font><b>View Name</b></font></td>
                <td width="12%"><font><b>Description</b></font></td>
                <td width="12%"><font><b>Created On</b></font></td>
                <td width="12%"><font><b>Manage</b></font></td>
            </tr>
            <%for (MyQuery mq : myViews) {
                    if ((i % 2) != 0) {%>
            <tr bgcolor="#E8EEF7" height="21">
                <%} else {%>
            <tr bgcolor="white" height="21">
                <%}
                    i++;
                    %><td><%
                if(mq.getSearchType().equalsIgnoreCase("APM")){%>
                    <A HREF="<%=request.getContextPath()%>/MyQuery/MyQueryRun.jsp?query_id=<%= mq.getQueryId()%>"><%= mq.getName()%>(<%=MyViewUtils.getIssueCount(mq.getQueryString())%>)</A>
                <%}else if(mq.getSearchType().equalsIgnoreCase("ERM")){%>
                    <A HREF="<%=request.getContextPath()%>/ERM/ermSearchResults.jsp?query_id=<%= mq.getQueryId()%>"><%= mq.getName()%>(<%=MyViewUtils.getIssueCount(mq.getQueryString())%>)</A>
               <% }
                %>
                </td>
                <td><%=mq.getDescription()%></td>
                <td><%=sdf.format(mq.getCreatedon())%></td>
                <td><a href="<%=request.getContextPath()%>/ERM/ermSearch.jsp?queryId=<%= mq.getQueryId()%>"> Edit View </a> &nbsp; | <a href="<%=request.getContextPath()%>/ERM/ermDeleteView.jsp?queryId=<%= mq.getQueryId()%>"> Delete View</a></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
