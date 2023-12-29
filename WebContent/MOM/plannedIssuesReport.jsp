<%-- 
    Document   : plannedIssuesReport
    Created on : Mar 5, 2014, 10:50:03 AM
    Author     : E0288
--%>

<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="com.eminent.issue.formbean.IssueCountFormBean"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("plannedIssuesReport");
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
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>   
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-select2.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>

</head>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
        <%@ include file="/header.jsp"%>
    <br/>
    <jsp:useBean id="pir" class="com.eminent.issue.formbean.PlannedIssueReport"></jsp:useBean>
    <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%
        int wrmSize = mas.wrmIssues().size();
        pir.planIssueReport(request);
        int role = (Integer) session.getAttribute("Role");
        int assignedto = (Integer) session.getAttribute("userid_curr");
        smmc.getLocationNBranch(assignedto);
        int c = GetProjectManager.checkProjectManager(String.valueOf(assignedto));%>
    <form name="theForm"  action="./plannedIssuesReport.jsp" onsubmit="disableSubmit();">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td style="font-weight: bold;width:30%;">MOM <a href="<%=request.getContextPath()%>/MOM/userplannedIssuesReport.jsp" style="cursor: pointer; font-weight: bold;">Userwise Planned</a></td>
                <td border="1" style="width: 40%;">
                    <font size="4" COLOR="#0000FF"><b>Daily Planned Issue Report On <input type="text" id="momdate" name="momdate" maxlength="10" size="10"
                                                                                           value="<%=pir.getPlannedDate()%>" readonly /><a
                                                                                           href="javascript:NewCal('momdate','ddmmmyyyy')"> <img
                                src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                                width="16" height="16" alt="Pick a date"></a></b></font>

                </td>
                <td><input type="submit" name="submit" id="submit" value="Submit"></td>
                <td><a href="plannedIssuesExcel.jsp?momdate=<%=pir.getPlannedDate()%>">Export</a></td>

            </tr>
        </table>
    </form>


    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="height: 25px;">
                <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                <%
                    if (role == 1 || c > 0) {%>
                <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                <%}
                    if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>
                <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                <%                 } else {
                %>
                <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues  (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <br/>

    <div id="dialog" title="Basic dialog">

    </div>

    <div class="tablecontent">
        <table width="100%"  id="countTable" class="tablesorter">
            <thead>
                <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
                    <th class="header" style="text-align:center;" ><font style="color: #000000">Project</font></th>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">Open Issues</font></th>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">WRM Issues</font></th>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">Planned</font></th>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">WRM Planned</font></th>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">Non WRM Planned</font></th>
                </tr>
            </thead>
            <tbody>
                <%
                    int a = 0;
                    int totPlanned = 0, totWRM = 0, totWRMPlanned = 0, totNonWRMPlanned = 0, totOpen = 0;
                    for (IssueCountFormBean countFormBean : pir.getCountList()) {
                        totOpen = totOpen + countFormBean.getOpenIssuesCount();
                        totPlanned = totPlanned + countFormBean.getPlannedIssuesCount();
                        totWRM = totWRM + countFormBean.getWrmIssuesCount();
                        totWRMPlanned = totWRMPlanned + countFormBean.getWrmPlannedIssuesCount();
                        totNonWRMPlanned = totNonWRMPlanned + countFormBean.getNonWrmPlannedIssuesCount();
                        if ((a % 2) != 0) {
                %>
                <tr class="zebraline" >
                    <%} else {%>
                <tr class="zebralinealter">
                    <%                    }
                        a++;%>                    
                    <td  >
                        <%if (pir.getProjectsList().contains(countFormBean.getProjectName())) {%>
                        <%=countFormBean.getProjectName()%>
                        <%} else {%>
                        <font color="red" ><%=countFormBean.getProjectName()%></font>
                        <%}%>
                    </td>
                    <td style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId= <%= countFormBean.getProjectId()%> &projectMoMStatus=altogether'><%=countFormBean.getOpenIssuesCount()%> </a></td>
                    <td style="text-align:center;"><span class='issuedisplay' heading="WRM" pName='<%=countFormBean.getProjectName()%>' countType='WI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  ><%=countFormBean.getWrmIssuesCount()%> </span> </td>
                    <td  style="text-align:center;"><span class='issuedisplay' heading="Planned"  pName='<%=countFormBean.getProjectName()%>' countType='PI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  > <%=countFormBean.getPlannedIssuesCount()%> </span></td>
                    <td  style="text-align:center;"><span class='issuedisplay' heading="WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='WPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  ><%=countFormBean.getWrmPlannedIssuesCount()%></span>  </td>
                    <td  style="text-align:center;"><span class='issuedisplay' heading="Non WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='NWPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  ><%=countFormBean.getNonWrmPlannedIssuesCount()%>  </span></td>
                </tr>


                <%}%>
            </tbody>
            <tfoot>
                <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
                    <td colspan=""  style="text-align:center;"> </td>
                    <td colspan=""  style="text-align:center;"><%=totOpen%></td>
                    <td colspan=""  style="text-align:center;"><%=totWRM%></td>
                    <td   style="text-align:center;"><span class='issuedisplay' heading="Total Planned " pName='' countType='totPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  ><%=totPlanned%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplay' heading="Total WRM Planned " pName='' countType='totWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  ><%=totWRMPlanned%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplay' heading="Total Non WRM Planned " pName='' countType='totNWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>' style="cursor: pointer; color: #0063d5; text-decoration: underline;"  ><%=totNonWRMPlanned%></span></td>
                </tr>
            </tfoot>
        </table>
    </div>
    <%
        boolean flag = true;
        for (String project : pir.getProjectsList()) {
            int i = 0;
            for (IssueFormBean isfb : pir.getIssuesList()) {
                if (isfb.getpName().equals(project)) {
                    if (pir.getPlannedIssuesList().contains(isfb.getIssueId()) && pir.getMomplannedIssuesList().contains(isfb.getIssueId())) {
                        if (i == 0) {
                            if (flag == true) {
    %>

    <div  style="border: 1px solid lightblue;"><div  style="width: 100%;background-color: #E8EEF7;text-align: left;font-weight: bold;color:blue;"><%=project%></div>
        <%flag = false;
            }%>


        <div style="font-weight: bold;text-align: center;">PM Planned Issues</div>
        <table width="100%" height="23">
            <TR bgcolor="#C3D9FF">
                <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                <TD width="11%"><font><b>Issue No</b></font></TD>
                <TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
                <TD width="12%"><font><b>Project</b></font></TD>
                <TD width="7%"><font><b>Module</b></font></TD>
                <TD width="29%"><font><b>Subject</b></font></TD>
                <TD width="9%"><font><b>Status</b></font></TD>
                <TD width="9%"><font><b>Due Date</b></font></TD>
                <TD width="10%"><font><b>AssignedTo</b></font></TD>
                <TD width="7%"><font><b>Refer</b></font></TD>
                <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

            </TR>
            <% }
                if ((i % 2) != 0) {
            %>
            <tr bgcolor="#E8EEF7" height="21">
                <%} else {%>
            <tr bgcolor="white" height="21">
                <%                    }
                    i++;%>

                <td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                <td width="11%" title="<%=isfb.getType()%>"><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a>
                    <%                        if (pir.getWrmIssuesByPid().containsKey(project)) {

                            if (pir.getWrmIssuesByPid().get(project).contains(isfb.getIssueId())) {
                    %>
                    <img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>                      
                    <% }
                        }%>
                </td>
                <td width="3%"><%=isfb.getPriority()%></td>
                <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                <td onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;" width="9%" ><%=isfb.getStatus()%></td>
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
                    }
                }%></table><%
                    int j = 0;
                    for (IssueFormBean isfb : pir.getIssuesList()) {
                        if (isfb.getpName().equals(project)) {
                            if (!pir.getPlannedIssuesList().contains(isfb.getIssueId()) && pir.getMomplannedIssuesList().contains(isfb.getIssueId())) {
                                if (j == 0) {
                                    if (flag == true) {%>

        <div  style="border: 1px solid lightblue;"><div style="width:100%;background-color: #E8EEF7;text-align: left;font-weight: bold;color:blue;"><%=project%></div>
            <%flag = false;
                }%>
            <div  style="font-weight: bold;text-align: center;">Other Issues planned in MOM</div>
            <table width="100%" height="23">
                <TR bgcolor="#C3D9FF">
                    <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                    <TD width="11%"><font><b>Issue No</b></font></TD>
                    <TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
                    <TD width="12%"><font><b>Project</b></font></TD>
                    <TD width="7%"><font><b>Module</b></font></TD>
                    <TD width="29%"><font><b>Subject</b></font></TD>
                    <TD width="9%"><font><b>Status</b></font></TD>
                    <TD width="9%"><font><b>Due Date</b></font></TD>
                    <TD width="10%"><font><b>AssignedTo</b></font></TD>
                    <TD width="7%"><font><b>Refer</b></font></TD>
                    <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

                </TR>
                <% }
                    if ((j % 2) != 0) {
                %>
                <tr bgcolor="#E8EEF7" height="21">
                    <%} else {%>
                <tr bgcolor="white" height="21">
                    <%                    }
                        j++;
                    %><td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                    <td width="11%" title="<%=isfb.getType()%>"><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a>
                        <%                        if (pir.getWrmIssuesByPid().containsKey(project)) {

                                if (pir.getWrmIssuesByPid().get(project).contains(isfb.getIssueId())) {
                        %>
                        <img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>                      
                        <% }
                            }%>
                    </td>
                    <td width="3%"><%=isfb.getPriority()%></td>
                    <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                    <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                    <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                    <td width="9%" onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
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
                    <%
                                }
                            }
                        }%></table></div>
                <%flag = true;
                    }%>
    </table>
    <%
        if (pir.getProjectsList().isEmpty()) {%>
    <div style="text-align: left;"> Neither PM planned nor MOM planned issues  for <%=pir.getPlannedDate()%> </div>
    <%}
    %>
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
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript">
                    $(".tablesorter").tablesorter({
                        widgets: ['zebra'],
                        widgetOptions: {
                            zebra: ["zebraline", "zebralinealter"]
                        }
                    });
    </script>

</body>
<script type="text/javascript">
    function showPrint(issueid) {
        window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
    }

    $(document).on('click', '.issuedisplay', function () {
        $(".Ajax-loder").show();
        var countType = $.trim($(this).attr('countType'));
        var plannedFor = $.trim($(this).attr('plannedFor'));
        var pid = $.trim($(this).attr('pid'));
        var heading = $.trim($(this).attr('heading'));
        var pName = $.trim($(this).attr('pName'));

        $.ajax({
            url: '<%=request.getContextPath()%>/MOM/plannedIssuesSummary.jsp',
            data: {countType: countType, plannedDate: plannedFor, pid: pid, random: Math.random(1, 10)},
            complete: function () {
                $(".Ajax-loder").hide();
            },
            async: true,
            type: 'POST',
            success: function (responseText, statusTxt, xhr) {
                if (statusTxt === "success") {

                    $('#dialog').html(responseText);
                    $("#dialog").dialog("open");
                    if (pName == '') {
                        $('.ui-dialog-title').html(heading + " Issues");
                    } else {
                        $('.ui-dialog-title').html(heading + " Issues for " + pName);
                    }
                }
            }
        });

    });
    $(function () {
        $("#dialog").dialog({
            autoOpen: false,
            width: 1000,
            maxHeight: 500,
            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "blind",
                duration: 1000
            }
        });
    });
    $(".Ajax-loder").hide();

</script>
</html>
