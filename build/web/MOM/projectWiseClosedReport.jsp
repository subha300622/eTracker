<%-- 
    Document   : ProjectWsieClosedReport
    Created on : May 28, 2014, 12:55:27 PM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminentlabs.mom.formbean.PMReportFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("projectWiseClosedReport");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
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
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
                <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript">
            function collapseimg(id) {

                $("#user" + id).toggleClass('treeExpand');
            }
            function trim(str)
            {
                while (str.charAt(str.length - 1) === " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) === " ")
                    str = str.substring(1, str.length);
                return str;
            }
            function isDate(str)
            {
                var pattern = "0123456789-";
                var i = 0;
                do
                {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) === pattern.charAt(j))
                        {
                            pos = 1;
                            break;
                        }
                    i++;
                }
                while (pos === 1 && i < str.length)
                if (pos === 0)
                    return false;
                return true;
            }
            function setDPDuration() {
                if (trim(document.theForm.fromdate.value) === '')
                {
                    alert("Please Enter the From Date ");
                    document.theForm.fromdate.focus();
                    return false;
                }
                if (!isDate(trim(theForm.fromdate.value)))
                {
                    alert('Please enter the valid From Date');
                    document.theForm.fromdate.value = "";
                    theForm.fromdate.focus();
                    return false;
                }
                if (trim(document.theForm.todate.value) === '')
                {
                    alert("Please Enter the To Date ");
                    document.theForm.todate.focus();
                    return false;
                }
                if (!isDate(trim(theForm.todate.value)))
                {
                    alert('Please enter the valid To Date');
                    document.theForm.todate.value = "";
                    theForm.todate.focus();
                    return false;
                }
                var str = document.theForm.fromdate.value;

                var first = str.indexOf("-");
                var last = str.lastIndexOf("-");
                var year = str.substring(last + 1, last + 5);
                var month = str.substring(first + 1, last);
                var date = str.substring(0, first);
                var form_date = new Date(year, month - 1, date);

                var str1 = document.theForm.todate.value;

                var first = str1.indexOf("-");
                var last = str1.lastIndexOf("-");
                var year = str1.substring(last + 1, last + 5);
                var month = str1.substring(first + 1, last);
                var date = str1.substring(0, first);
                var form_date1 = new Date(year, month - 1, date);

                if (form_date1 < form_date) {
                    alert('To Date cannot be less than From Date');
                    document.theForm.todate.value = "";
                    theForm.todate.focus();
                    return false;
                }
                disableSubmit();

            }

        </script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="pwcr" class="com.eminentlabs.mom.formbean.ProjectWiseClosedReport"></jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
 <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
  <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%mwd.getAllBranchMap();%>
    <%
       int wrmSize= mas.wrmIssues().size();
   pwcr.setAll(request);%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Project Wise Closed issue Report</b></font>

                </td>

            </tr>
        </table>
        <br/>
        <%int assignedto = (Integer) session.getAttribute("userid_curr");
         smmc.getLocationNBranch(assignedto);%>
        <form name="theForm" onsubmit='return setDPDuration(this);' action="projectWiseClosedReport.jsp" method="post">
            <table bgcolor="E8EEF7"  style="width: 100%;">
                <tr>
                    <td style="font-weight: bold;width: 24%;">Select Duration : </td>
                    <td style="width: 5%;"><B>From</B></td>

                    <td style="width: 15%;">

                        <input type="text" id="fromdate" name="fromdate" value="<%=pwcr.getStartDate()%>" maxlength="10" size="10" readonly  /><a href="javascript:NewCal('fromdate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a>
                    </td>
                    <td style="width: 2%;text-align: right;"><B>To</B></td>
                    <td style="width: 20%;">
                        <input type="text" id="todate" name="todate" value="<%=pwcr.getEndDate()%>"  maxlength="10" size="10" readonly  /><a href="javascript:NewCal('todate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                     <td>  <select id="branch" name="branch" >
                    <option value="">All Location</option>
                        <%if (!mwd.getBranchMap().isEmpty()) {
                                for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                                <option value="<%=entry.getKey()%>" <%if(pwcr.getBranch()==entry.getKey()){%> selected=""<%}%>><%=entry.getValue()%></option>
                        <%}
                            }%>                                                
                    </select>
                        </td>
                    <td><input type="submit" name="submit" id="submit" value="Search"></td>
                </tr>
            </table>
        </form>
        <br/>
        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                  <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer; font-weight: bold;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 } else {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <br/>
        <div>
            <%-- displaying best pm for given date range by muthuraja  --%>
            <%if (pwcr.getBestPManager() != null && pwcr.getBestPName() != null) {%>
            <p align="left" style="width: 100%;">Between <b><%=pwcr.getStartDate()%> to <%=pwcr.getEndDate()%> </b>  Winner is <font style="font-weight: bold;color: green;"><%=pwcr.getBestPManager()%> </font> for <font style="font-weight: bold;color: green;"><%=pwcr.getBestPName()%> </font> </p>
                <%}
                %>
            The below list shows closed issues from <b><%=pwcr.getStartDate()%> to <%=pwcr.getEndDate()%></b></div>
            <%-- action added  by muthuraja  --%>
        <form name="weeklyBestPM" method="post" action="saveBestPM.jsp">
            <input type="hidden" name="fromDate" value="<%=pwcr.getStartDate()%>">
            <input type="hidden" name="toDate" value="<%=pwcr.getEndDate()%>">
                                <input type="hidden" name="branch" value="<%=pwcr.getBranch()%>">

            <table  style="width: 100%;text-align: left;font-weight: bold;">
                <tr style="background-color: #C3D9FF;"> <td style="width: 5%;" ></td>
                    <td style="width:35%;">Project Name</td><td style="width:35%;">Project Manager</td><td style="width:10%;"> Closed Count </td><td style="width:10%;">Rating</td><td style="width:10%;">Rank</td></tr></table>
                    <%
                        int j = 0;
                        int closedSize = -1;
                        int rank = 0;
                        int totalCount = 0;
                        for (PMReportFormBean pmrfb : pwcr.getpWCIR()) {

                            j++;
                            if (closedSize == -1) {
                                closedSize = pmrfb.getClosedCount();
                                rank = j;
                            } else if (closedSize == pmrfb.getClosedCount()) {
                            } else {
                                rank = j;
                            }
                            if ((j % 2)
                                    != 0) {%>
            <table  style="width: 100%;height:25px;text-align: left;font-weight: bold;" >
                <tr >
                    <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>                  
                    <td style="width: 5%;">
                        <%-- radio button added for best pmid,pid  by muthuraja  --%>
                        <%if (pmrfb.getPname().equalsIgnoreCase(pwcr.getBestPName()) && pmrfb.getProjectManager().equalsIgnoreCase(pwcr.getBestPManager())) {%>
                        <input type="radio" name="bestPM" value="<%=pmrfb.getPid()%>,<%=pmrfb.getPmid()%>"  checked="true"/>                     
                        <%} else {%>
                        <input type="radio" name="bestPM" value="<%=pmrfb.getPid()%>,<%=pmrfb.getPmid()%>" />                    
                        <%}%>
                    </td>
                    <%}%>
                    <td style="width:35%; cursor: pointer;" onclick="collapse('closed<%=pmrfb.getPid()%>', 150);
                            collapseimg('<%=pmrfb.getPid()%>');
                            return false;"><span id="user<%=pmrfb.getPid()%>" class="treeclass" ></span><%=pmrfb.getPname()%></td>
                    <td style="width: 35%;"><%=pmrfb.getProjectManager()%></td>
                    <td style="width: 10%;"><%=pmrfb.getClosedCount()%></td>
                    <td style="width: 10%;" title="<%=pmrfb.getFeedback()%>"><%=pmrfb.getRating()%></td>
                    <td style="width: 10%;"><%=rank%></td>

                </tr>
            </table>
            <%} else {%>
            <table  style="width: 100%;height:25px;text-align: left;font-weight: bold;" >
                <tr style="background-color: #E8EEF7;"  >
                    <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>
                    <td style="width: 5%;" >
                        <%-- radio button added for best pmid,pid  by muthuraja  --%>
                        <%if (pmrfb.getPname().equalsIgnoreCase(pwcr.getBestPName()) && pmrfb.getProjectManager().equalsIgnoreCase(pwcr.getBestPManager())) {%>
                        <input type="radio" name="bestPM" value="<%=pmrfb.getPid()%>,<%=pmrfb.getPmid()%>"  checked="true"/>                      
                        <%} else {%>
                        <input type="radio" name="bestPM" value="<%=pmrfb.getPid()%>,<%=pmrfb.getPmid()%>" />                  
                        <%}%>
                    </td>
                    <%}%>
                    <td style="width:35%;cursor: pointer;"  onclick="collapse('closed<%=pmrfb.getPid()%>', 150);
                            collapseimg('<%=pmrfb.getPid()%>');
                            return false;"><span  id="user<%=pmrfb.getPid()%>" class="treeclass" ></span><%=pmrfb.getPname()%></td>
                    <td style="width: 35%;"><%=pmrfb.getProjectManager()%></td>
                    <td style="width: 10%;"><%=pmrfb.getClosedCount()%></td>
                    <td  style="width: 10%;" title="<%=pmrfb.getFeedback()%>"><%=pmrfb.getRating()%></td>
                    <td style="width: 10%;"><%=rank%></td>
                </tr>
            </table>  
            <%}
            %>

            <div id="closed<%=pmrfb.getPid()%>" class="hide_me" >
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
                        if (!pmrfb.getProjectWiseissuesList().isEmpty()) {
                            totalCount = totalCount + pmrfb.getProjectWiseissuesList().size();
                            for (IssueFormBean isfb : pmrfb.getProjectWiseissuesList()) {
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
            <%closedSize = pmrfb.getClosedCount();
                }
                if (totalCount > 0) {%>

            <table   border="1" style="width: 100%;height:21px;border-collapse: collapse;border: 1px lightblue;"><tr  > <td style="width: 5%;" ></td><td style="font-weight:bold;width:35%;text-align: center;color: blue;">Total Closed Issues</td><td style="width:35%;text-align: center;">=</td><td style="width:40%;color: blue;font-weight: bold;"><%=totalCount%></td></tr></table>

            <div style="text-align: center;width: 100%; ">
                <input type="submit" name="submit" id="submit" value="Submit" onclick="return checkBestPM(this);">
            </div>
            <%}%>
        </form>
        
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

    <script type="text/javascript">
        function checkBestPM() {
            var r = document.getElementsByName("bestPM");
            var c = -1;

            for (var i = 0; i < r.length; i++) {
                if (r[i].checked) {
                    c = i;
                }
            }
            if (c == -1) {
                alert("Please select the Best Project Manager.");
                return false;
            }
        }

    </script>
</html>
