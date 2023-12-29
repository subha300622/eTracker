<%-- 
    Document   : teamClosedIssueReport
    Created on : May 6, 2014, 4:20:54 PM
    Author     : E0288
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript">
        function collapseimg(id) {

            $("#user" + id).toggleClass('treeExpand');
        }
    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
    <%tcir.setAll(request);%>
    <form name="theForm" id="theForm" method="post" action="teamClosedIssueReport.jsp" onsubmit="disableSubmit();">    
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgcolor="#C3D9FF">
                <td align="left" width="70%"><font size="4" COLOR="#0000FF"><b>Team Members Closed Issues for </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT>
                    <select name="month" id="month">
                        <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                                    if (month.getKey() == tcir.getMonth()) {%>
                        <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                        <%} else {%>
                        <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                        <%}
                                }%>
                    </select>
                    <select name='year' id='year' >

                        <%for (Integer year : tcir.getYears()) {%>
                        <%if (year == tcir.getYear()) {%>
                        <option value="<%=year%>" selected=""><%=year%></option>
                        <%} else {%>   
                        <option value="<%=year%>"><%=year%></option>
                        <%}
                                }%>
                    </select>
                    <input type="submit" id="submit" value="Submit" ></td>
                <td style="text-align: right;"><a href="<%=request.getContextPath()%>/excellentRatingExcelExport.jsp?month=<%=tcir.getMonth()%>&year=<%=tcir.getYear()%>&rating=Excellent" target="_blank" style="text-decoration: none;">Export</a>
                    &nbsp;&nbsp;<a href="<%=request.getContextPath()%>/MyTimeSheet/myRankPrint.jsp?month=<%=tcir.getMonth()%>&year=<%=tcir.getYear()%>" target="_blank" style="text-decoration: none;">My Rank Print</a></td>
            </tr>
        </table>
    </form>
    <br/>
    <table style="width: 100%;"><tr><td style="width: 75%;">The below list shows closed issues for <b><%=tcir.getMonths().get(tcir.getMonth())%>-<%=tcir.getYear()%></b></td><td style="text-align: right;color: #CC00CC;font-weight: bold;">PM's are in Pink color</td></div>
        <table  style="width: 70%;height:25px;text-align: left;font-weight: bold;"><tr style="background-color: #C3D9FF;"><td style="width:40%;text-align: center;">Name</td><td style="width:20%;text-align: center;"> Closed Count(Excellect Rating) </td><td style="width:10%;text-align: center;">Rank</td></tr></table>
        <%

            int j = 0;
            int closedSize = -1;
            int rank = 0;

            for (Map.Entry<Integer, List<IssueFormBean>> entry : tcir.getTeamClosedIssues().entrySet()) {
                String color = "black";
                if (tcir.getPmanagers().contains(entry.getKey())) {
                    color = "#CC00CC";
                }
                j++;
                if (closedSize == -1) {
                    closedSize = entry.getValue().size();
                    rank = j;
                } else if (closedSize == entry.getValue().size()) {

                } else {
                    rank = j;
                }
                if ((j % 2) != 0) {%>
        <table  style="width: 70%;height:25px;text-align: left;font-weight: bold;cursor:pointer;"><tr onclick="collapse('closed<%=entry.getKey()%>', 150);
                collapseimg('<%=entry.getKey()%>');
                return false;"><td style="width:40%;color: <%=color%>;" ><span id="user<%=entry.getKey()%>" class="treeclass"  ></span><%=tcir.getMember().get(entry.getKey())%></td><td style="width: 20%;text-align: center;"><%=entry.getValue().size()%>(<%=tcir.getRatingwise().get(entry.getKey())==null?"0":tcir.getRatingwise().get(entry.getKey())%>)</td><td style="width: 10%;text-align: center;"><%=rank%></td></tr></table>
                    <%} else {%>
        <table  style="width: 70%;height:25px;text-align: left;font-weight: bold;cursor:pointer;"><tr style="background-color: #E8EEF7;" onclick="collapse('closed<%=entry.getKey()%>', 150);
                collapseimg('<%=entry.getKey()%>');
                return false;"><td style="width:40%;color: <%=color%>;" ><span  id="user<%=entry.getKey()%>" class="treeclass" ></span><%=tcir.getMember().get(entry.getKey())%></td><td style="width: 20%;text-align: center;"><%=entry.getValue().size()%>(<%=tcir.getRatingwise().get(entry.getKey())==null?"0":tcir.getRatingwise().get(entry.getKey())%>)</td><td style="width: 10%;text-align: center;"><%=rank%></td></tr></table>  
                    <%}
                    %>

        <div id="closed<%=entry.getKey()%>" class="hide_me" >
            <table width="100%" height="23">
                <tr bgcolor="#C3D9FF">
                    <td width="1%" TITLE="Severity"><font><b>S</b></font></td>
                    <td width="11%"><font><b>Issue No</b></font></td>
                    <td width="3%" TITLE="Priority"><font><b>P</b></font></td>
                    <td width="12%"><font><b>Project</b></font></td>
                    <td width="7%"><font><b>Module</b></font></td>
                    <td width="29%"><font><b>Subject</b></font></td>
                    <td width="9%"><font><b>Status</b></font></td>
                    <td width="9%"><font><b>Due Date</b></font></td>
                    <td width="10%"><font><b>Assigned To</b></font></td>
                    <td width="7%"><font><b>Refer</b></font></td>
                    <td width="5%" TITLE="In Days"><font><b>Age</b></font></td>

                </tr>
                <%int i = 0;
                    if (!entry.getValue().isEmpty()) {
                        for (IssueFormBean isfb : entry.getValue()) {
                            if ((i % 2) != 0) {
                %>
                <tr bgcolor="#E8EEF7" height="21">
                    <%} else {%>
                <tr bgcolor="white" height="21">
                    <%                    }
                            i++;%>

                    <td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                    <td width="11%" title="<%=isfb.getType()%>"><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a></td>
                    <td width="3%"><%=isfb.getPriority()%></td>
                    <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                    <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                    <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                    <td width="9%" bgcolor="<%=isfb.getRatingColor()%>" title="<%=isfb.getFeedback()%>"> <%=isfb.getStatus()%></td>
                    <td width="9%" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                    <td width="10%" title="Created By <%=isfb.getCreatedBy()%>"><%=isfb.getAssignto()%></td>
                    <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                    <td width="7%"><%=isfb.getRefer()%></td>
                    <%} else {%>
                    <td width="7%"><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"
                                      ><%=isfb.getRefer()%></a></td>
                        <%}%>
                    <td width="5%" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>
                    <%}
                        } else {%>
                No Issues closed.
                <%}%>
            </table>
        </div>
        <%closedSize = entry.getValue().size();
                }%>
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

</body>
</html>
