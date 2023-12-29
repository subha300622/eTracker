<%-- 
    Document   : userIssue
    Created on : 27 Jul, 2010, 1:52:36 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@ page import="org.apache.log4j.Logger,com.eminent.timesheet.CreateTimeSheet"%>
<%@ page import="java.sql.*, dashboard.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="com.eminent.util.*"%>
<%@ page import="java.util.*, java.text.*, com.pack.*"%>
<%@ page import="com.eminent.issue.formbean.LastAssginForm"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
   

    Logger logger = Logger.getLogger("UserOpenIssues");
    
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    </HEAD>

    <BODY>

        

        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
        <%mas.setAll(request);%>



        <%@ include file="/header.jsp"%>




            <div align="center">
                <center>
                    <br>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr border="2" bgcolor="#E8EEF7">
                            <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                                COLOR="#0000FF"> <b> User Assigned Issues  </b></font><FONT
                                    SIZE="3" COLOR="#0000FF"> </FONT>


                        </tr>
                    </table>
                    <br>
                

                 <%
                    

                        if (mas.getUrl().equalsIgnoreCase("eminentlabs.net")) {
                %>
                <table width="100%" border="0">
                    <tr height="10" >
                        <td align="left" colspan="10"><a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=mas.getUserId()%>&assignmentType=backlog"><%if (mas.getAssignmentType().equalsIgnoreCase("backlog")) {%><b style="color: blue;">Backlog(<%=mas.getbCount()%>)</b><%} else {%>Backlog(<%=mas.getbCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=mas.getUserId()%>&assignmentType=currentWeek"><%if (mas.getAssignmentType().equalsIgnoreCase("currentWeek")) {%><b style="color: blue;">Current Week(<%=mas.getCuCount()%>)</b><%} else {%>Current Week(<%=mas.getCuCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=mas.getUserId()%>&assignmentType=nextWeek"><%if (mas.getAssignmentType().equalsIgnoreCase("nextWeek")) {%><b style="color: blue;">Next Week(<%=mas.getNxCount()%>)</b><%} else {%>Next Week(<%=mas.getNxCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=mas.getUserId()%>&assignmentType=afterTwoWeeks"><%if (mas.getAssignmentType().equalsIgnoreCase("afterTwoWeeks")) {%><b style="color: blue;">After two weeks(<%=mas.getAtCount()%>)</b><%} else {%>After two weeks(<%=mas.getAtCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=mas.getUserId()%>&assignmentType=all"><%if (mas.getAssignmentType().equalsIgnoreCase("all")) {%><b style="color:blue;">All(<%=mas.getAlCount()%>)<%} else {%>All(<%=mas.getAlCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
                <% }
                %>
                <table width="100%">
                    <tr height="10">
                        <td align="left" width="100%"><%=mas.getAssignmentType() %> Issues assigned to <%=GetProjectManager.getUserName(mas.getUserId())%>.</td>
                        <TD align="right" width="25">Severity</TD>
                        <TD align="right" width="25" bgcolor="#FF0000">S1</TD>
                        <TD align="right" width="25" bgcolor="#FF9900">S2</TD>
                        <TD align="right" width="25" bgcolor="#FFFF00">S3</TD>
                        <TD align="right" width="25" bgcolor="#33FF33">S4</TD>
                    </tr>
                </table>
                
                <div class="tablecontent">
                    <TABLE width="100%" id="searchTable" class="tablesorter">
                        <thead>
                            <TR bgcolor="#C3D9FF">
                                <TH width="1%" TITLE="Severity"><font><b>S</b></font></TH>
                                <TH width="11%"><font><b>Issue No</b></font></TH>
                                <TH width="2%" TITLE="Priority"><font><b>P</b></font></TH>
                                <TH width="10%"><font><b>Project</b></font></TH>
                                <TH width="7%"><font><b>Module</b></font></TH>
                                <TH width="29%"><font><b>Subject</b></font></TH>
                                <TH width="9%"><font><b>Status</b></font></TH>
                                <TH width="8%"><font><b>Due Date</b></font></TH>
                                <TH width="13%"><font><b>Created By</b></font></TH>
                                <TH width="9%"><font><b>Refer</b></font></TH>
                                <TH width="3%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></TH>
                            </TR>
                        </thead>
                        <tbody>
                            <%int i = 0;
                                for (IssueFormBean isfb : mas.getIssuesList()) {
                                    if ((i % 2) != 0) {
                            %>
                            <tr class="zebralinealter" height="21">
                                <%} else {%>
                            <tr class="zebraline" height="21">
                                <%}
                            i++;%>

                                <td  bgcolor="<%=isfb.getSeverity()%>"></td>
                                <td  title="<%=isfb.getType()%>"><a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=<%=isfb.getIssueId()%>">

                                        <%=isfb.getIssueId()%></a><%if (mas.getPlannedIssuesList().contains(isfb.getIssueId())) {
                                        %>
                                    <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                                    <%
                                }%><%if (mas.wrmIssues().contains(isfb.getIssueId())) {
                                    %>
                                    <img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                                    <%
                                }%></td>
                                <td ><%=isfb.getPriority()%></td>
                                <td  title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                                <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                                <td  id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                                <td  ><%=isfb.getStatus()%></td>
                                <td  title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                                <td title="Assignedby <%=isfb.getLastAssigneeName()%> at <%=isfb.getLastModifiedOn()%>"><%=isfb.getCreatedBy()%></td>
                                <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                                <td ><%=isfb.getRefer()%></td>
                                <%} else {%>
                                <td ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                                    <%}%>
                                <td title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>

                            <%
                        }%>
                    </table>                   
            </center>
        </div>
                <div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Attached Files</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div id="IssuePopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

            </div>
        </div>
    </div>
    </BODY>
</HTML>

