<%-- 
    Document   : plannedIssuesReport
    Created on : Mar 5, 2014, 10:50:03 AM
    Author     : E0288
--%>

<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminentlabs.mom.MomMaintanance"%>
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

    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
    <link href="<%=request.getContextPath()%>/multiple-select.css?test=2" rel="stylesheet"/>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

    <style>
       
        tr:first-child .up, tr:last-child .down {
  display:none;
}
    </style>

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
    <jsp:useBean id="vmc" class="com.eminentlabs.mom.controller.MomMaintananceController"></jsp:useBean>
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>

    <%
        List<String> wrmIssues = mas.wrmIssues();
        pir.userplanIssueReport(request);
        int role = (Integer) session.getAttribute("Role");
        int assignedto = (Integer) session.getAttribute("userid_curr");
        smmc.getLocationNBranch(assignedto);
        int c = GetProjectManager.checkProjectManager(String.valueOf(assignedto));
    %>
    <form name="theForm"  action="./userplannedIssuesReport.jsp" onsubmit="disableSubmit();">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td style="font-weight: bold;width:30%;">MOM</td>
                <td border="1" style="width: 40%;">
                    <font size="4" COLOR="#0000FF"><b>Daily Planned Issue Report On <input type="text" id="momdate" name="momdate" maxlength="10" size="10"
                                                                                           value="<%=pir.getPlannedDate()%>" readonly /></b></font>

                </td>
                <td><input type="submit" name="submit" id="submit" value="Submit"></td>
                <td><a href="userplannedIssuesExcel.jsp?momdate=<%=pir.getPlannedDate()%>">Export</a></td>

            </tr>
        </table>
    </form>


    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="height: 25px;">
                <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                <%                    if (role == 1 || c > 0) {%>
                <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;font-weight: bold;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
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
                <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues  (<%=wrmIssues.size()%>)</a> &nbsp;&nbsp;&nbsp;
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
                    <th class="header" rowspan="4" style="text-align:center;" ><font style="color: #000000">User</font></th>
                    <th class="header"  rowspan="4" style="text-align:center;" ><font style="color: #000000">My Assignment</font></th>
                    <th class="header"  rowspan="4" style="text-align:center;" ><font style="color: #000000">Planned</font></th>
                    <th class="header"  rowspan="4" style="text-align:center;" ><font style="color: #000000">Untouched</font></th>
                    <th class="header" colspan="3" style="text-align:center;" ><font style="color: #000000">WRM</font></th>
                    <th class="header" colspan="3" style="text-align:center;" ><font style="color: #000000">NON WRM</font></th>
                </tr>
                <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">

                    <th class="header"  style="text-align:center;" ><font style="color: #000000">Planned</font></th>
                    <th class="header"  style="text-align:center;" ><font style="color: #000000">Actual</font></th>
                    <th class="header"  style="text-align:center;" ><font style="color: #000000"> Untouched</font></th>
                    <th class="header"  style="text-align:center;" ><font style="color: #000000">Planned</font></th>
                    <th class="header"  style="text-align:center;" ><font style="color: #000000">Actual</font></th>
                    <th class="header"  style="text-align:center;" ><font style="color: #000000">Untouched</font></th>
                </tr>
            </thead>
            <tbody>
                <%
                    int a = 0;
                    int totPlanned = 0, totWRM = 0, totWRMPlanned = 0,totUntouched = 0,untouched = 0, totNonWRMPlanned = 0, totOpen = 0, totWRMAct = 0, totNonWRMAct = 0;
                    for (IssueCountFormBean countFormBean : pir.getCountList()) {
                        totOpen = totOpen + countFormBean.getOpenIssuesCount();
                        totPlanned = totPlanned + countFormBean.getPlannedIssuesCount();
                        totWRM = totWRM + countFormBean.getWrmIssuesCount();
                        totWRMPlanned = totWRMPlanned + countFormBean.getWrmPlannedIssuesCount();
                        totWRMAct = totWRMAct + countFormBean.getWrmActualIssuesCount();
                        totNonWRMPlanned = totNonWRMPlanned + countFormBean.getNonWrmPlannedIssuesCount();
                        totNonWRMAct = totNonWRMAct + countFormBean.getNonWrmActualIssuesCount();
                        untouched = countFormBean.getPlannedIssuesCount() - (countFormBean.getWrmActualIssuesCount() + countFormBean.getNonWrmActualIssuesCount());
                        totUntouched =totUntouched+untouched; 
                        if ((a % 2) != 0) {
                %>
                <tr class="zebraline" >
                    <%} else {%>
                <tr class="zebralinealter">
                    <%                    }
                        a++;%>                    
                    <td  >
                        <%if (countFormBean.getPlannedIssuesCount() > 0) {%>
                        <%=countFormBean.getProjectName()%>
                        <%} else {%>
                        <b style="color: red;"><%=countFormBean.getProjectName()%></b> 
                        <%}%>
                    </td>
                    <td style="text-align:center;"><span class='issuedisplay' style="cursor: pointer;text-decoration: underline;color: blue;" heading=""  pName='<%=countFormBean.getProjectName()%>' countType='PI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getOpenIssuesCount()%> </span></td>
                    <td  style="text-align:center;"><span class='issuedisplaya' heading="Planned"  pName='<%=countFormBean.getProjectName()%>' countType='PI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  > <%=countFormBean.getPlannedIssuesCount()%> </span></td>
                                        <td  style="text-align:center;"><span class='issuedisplay' heading="WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='WPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=untouched%></span>  </td>

                    <td  style="text-align:center;"><span class='issuedisplaya' heading="WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='WPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getWrmPlannedIssuesCount()%></span>  </td>
                    <td  style="text-align:center;"><span class='issuedisplaya' heading="WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='WPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getWrmActualIssuesCount()%></span>  </td>
                    <td  style="text-align:center;"><span class='issuedisplaya' heading="WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='WPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getWrmPlannedIssuesCount() - countFormBean.getWrmActualIssuesCount()%></span>  </td>
                    <td  style="text-align:center;"><span class='issuedisplaya' heading="Non WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='NWPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getNonWrmPlannedIssuesCount()%>  </span></td>
                    <td  style="text-align:center;"><span class='issuedisplaya' heading="Non WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='NWPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getNonWrmActualIssuesCount()%>  </span></td>
                    <td  style="text-align:center;"><span class='issuedisplaya' heading="Non WRM Planned" pName='<%=countFormBean.getProjectName()%>' countType='NWPI'  pid='<%=countFormBean.getProjectId()%>' plannedFor='<%=pir.getPlannedDate()%>'  ><%=countFormBean.getNonWrmPlannedIssuesCount() - countFormBean.getNonWrmActualIssuesCount()%>  </span></td>
                </tr>
                <%}%>
            </tbody>
            <tfoot>
                <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
                    <td colspan=""  style="text-align:center;"> </td>
                    <td colspan=""  style="text-align:center;"><%=totOpen%></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total Planned " pName='' countType='totPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totPlanned%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total WRM Planned " pName='' countType='totWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totUntouched%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total WRM Planned " pName='' countType='totWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totWRMPlanned%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total WRM Actual " pName='' countType='totWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totWRMAct%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total WRM Planned " pName='' countType='totWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totWRMPlanned - totWRMAct%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total Non WRM Planned " pName='' countType='totNWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totNonWRMPlanned%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total Non WRM Planned " pName='' countType='totNWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totNonWRMAct%></span></td>
                    <td   style="text-align:center;"><span class='issuedisplaya' heading="Total Non WRM Planned " pName='' countType='totNWPI'  pid='' plannedFor='<%=pir.getPlannedDate()%>'  ><%=totNonWRMPlanned - totNonWRMAct%></span></td>
                </tr>
            </tfoot>
        </table>
    </div>
    <form name="theForma"  method="post" action="./userplannedIssuesReport.jsp" onsubmit="update();">
        <div class="tablecontent" id="accordion" style="width: 100%;">
            <input type="hidden" name="momdate" value="<%=pir.getPlannedDate()%>"/>
            <%
                String escalationColor = "";
                int i = 0, count = 0;
                for (Map.Entry<Integer, String> user : pir.getUsersList().entrySet()) {
                    if (pir.getUserwise().containsKey(user.getKey())) {
                        count = pir.getUserwise().get(user.getKey()).size();
                    } else {
                        count = 0;
                    }
            %>
            <h3 style="    
                cursor: pointer;
                position: relative;
                margin: 2px 0 0 0;
                padding: .5em .5em .5em .7em;
                min-height: 0;
                font-size: 100%; font-weight: bold;color:  <%if (count > 0) {  %> blue;<%} else {%>red;<%}%>"><%=user.getValue()%>(<%=count%>)
                <input type="hidden" name="userId" value="<%=user.getKey()%>"/> 
            </h3>
            <%if (count > 0) {%>
            <TABLE width="100%" class="move" id="<%=user.getKey()%>">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <td width="3%"  TITLE="Severity"><font><b>#</b></font></td>
                        <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                        <TD width="12%"><font><b>Issue No</b></font></TD>
                        <TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
                        <TD width="12%"><font><b>Project</b></font></TD>
                        <TD width="7%"><font><b>Module</b></font></TD>
                        <TD width="29%"><font><b>Subject</b></font></TD>
                        <TD width="9%"><font><b>Status</b></font></TD>
                        <TD width="9%"><font><b>Due Date</b></font></TD>
                        <TD width="10%"><font><b>Created By</b></font></TD>
                        <TD width="7%"><font><b>Refer</b></font></TD>
                        <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

                    </TR>
                </thead>
                <tbody>
                    <%  i = 0;
                        for (IssueFormBean isfb : pir.getUserwise().get(user.getKey())) {
                            if ((i % 2) != 0) {%>
                    <tr bgcolor="#E8EEF7" height="21" >
                        <%} else {%>
                    <tr bgcolor="white" height="21" >
                        <%                    }
                            i++;%>
                        <td width="3%" >
                         
                            <input type="checkbox" name="<%=user.getKey()%>PlannedIssues" value="<%=isfb.getIssueId()%>" checked='true'/> 
                            <%=i%></td>
                        <td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                        <td width="12%" title="<%=isfb.getType()%>"><%=isfb.getIssueId()%>
                            <%if (wrmIssues.contains(isfb.getIssueId())) {%>
                            <img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>                      
                            <% }%> <a href="javascript:void(0)" class ='up'><a href="javascript:void(0)" class ='up'><img style='position: realtive;cursor:pointer;height: 12px;width: 12px;' src='<%=request.getContextPath()%>/images/up_arrow.png' title="Up"  style="cursor: pointer"/></a>
                                <a href="javascript:void(0)" class='down'><img style='position: realtive;cursor:pointer;height: 12px;width: 12px;' src='<%=request.getContextPath()%>/images/down_arrow.png' title="Down"  style="cursor: pointer"/></a>
                                
                            </a>
                        </td>
                        <td width="3%"><%=isfb.getPriority()%></td>
                        <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td  style="color: <%=escalationColor%>" width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                        <td onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;" width="9%" ><%=isfb.getStatus()%></td>
                        <td width="9%" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td width="10%" title="Created By <%=isfb.getCreatedBy()%>"><%=isfb.getCreatedBy()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td width="7%"><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td width="7%"><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"
                                          ><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td width="5%" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>

                    <%}%>
                </tbody>
            </table>
            <%} else {%>
            <p>Neither PM planned nor MOM planned issues </p>
            <%}%>
            <%}%>
        </div>
        <div style="text-align: center;"><input type="submit" id="Update" name="submit" value="Submit" /></div>

    </form>
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
// $(function() {
//                $("#accordion").accordion({
//                    collapsible: false,
//                    heightStyle: "content"
//                    collaps
//
//                });
//            });

    $("#momdate").datepicker({
        showOn: "button",
        changeMonth: true,
        changeYear: true,
        buttonImage: "../images/newhelp.gif",
        buttonImageOnly: true,
        maxDate: 3,
        dateFormat: "dd-M-yy"
    });
    $('#momdate').click(function () {
        $('#momdate').datepicker('show');
    });
    var source;

    function isbefore(a, b) {
        if (a.parentNode == b.parentNode) {
            for (var cur = a; cur; cur = cur.previousSibling) {
                if (cur === b) {
                    return true;
                }
            }
        }
        return false;
    }

   
    $(document).on('click', '.issuedisplay', function () {
        $(".Ajax-loder").show();

        var name = $.trim($(this).attr('pName'));
        var userId = $.trim($(this).attr('pid'));
        $.ajax({
            url: '<%=request.getContextPath()%>/MOM/userMyAssignIssues.jsp',
            data: {userId: userId, random: Math.random(1, 10)},
            complete: function () {
                $(".Ajax-loder").hide();
            },
            async: true,
            type: 'POST',
            success: function (responseText, statusTxt, xhr) {
                if (statusTxt === "success") {

                    $('#dialog').html(responseText);
                    $("#dialog").dialog("open");
                    $('.ui-dialog-title').html(name + "'s My Assignment Issues");
                }
            }
        });
    });
    $(".up,.down").click(function () {
               
         var $element = this;
         var row = $($element).parents("tr:first");
         
         if($(this).is('.up')){
             row.insertBefore(row.prev());
         }
         
         else{
              row.insertAfter(row.next());
         }
       
    });
    
    function update() {
    document.getElementById('Update').value = 'Processing';
    document.getElementById('Update').disabled = true;
    document.getElementById('submit').disabled = true;
    return true;
}
    
</script>
</html>
