<%-- 
    Document   : leaveView
    Created on : 15 May, 2015, 11:02:17 AM
    Author     : EMINENT
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="com.eminent.leaveUtil.Leave"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@  taglib  prefix="c"   uri="http://java.sun.com/jstl/core"  %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("momDetails");
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
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>   
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-jui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css?test=3">
    <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

    <title>Leave Request</title>
    <style type="text/css">
        input[type="text"],

        .uneditable-input {
            background-color: #ffffff;
            border: 1px solid #cccccc;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            -webkit-transition: border linear 0.2s, box-shadow linear 0.2s;
            -moz-transition: border linear 0.2s, box-shadow linear 0.2s;
            -o-transition: border linear 0.2s, box-shadow linear 0.2s;
            transition: border linear 0.2s, box-shadow linear 0.2s;
            height: 18px;
        }

        input[type="text"]:focus,

        .uneditable-input:focus {
            border-color: rgba(82, 168, 236, 0.8);
            outline: 0;
            outline: thin dotted \9;
            /* IE6-9 */

            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
        }
    </style>
    <script type="text/javascript">

        $.tablesorter.addParser({
            id: "ddMMMyy",
            is: function (s) {
                return false;
            },
            format: function (s, table) {
                var from = s.split("-");
                var year = "20" + from[2];
                var mon = from[1];
                var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                return new Date(year, month, from[0]).getTime() || '';
            },
            type: "numeric"
        });
        $(function () {
            // call the tablesorter plugin
            $("#filtersort").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                headers: {
                    2: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMyy'
                    }, 3: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMyy'
                    }},
                widgetOptions: {
                    // extra css class applied to the table row containing the filters & the inputs within that row
                    filter_cssFilter: 'tablesorter-filter',
                    // If there are child rows in the table (rows with class name from "cssChildRow" option)
                    // and this option is true and a match is found anywhere in the child row, then it will make that row
                    // visible; default is false
                    filter_childRows: false,
                    // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    filter_hideFilters: true,
                    // Set this option to false to make the searches case sensitive
                    filter_ignoreCase: true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset: '.reset',
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters: false,
                    // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                    // every character while typing and should make searching large tables faster.
                    filter_searchDelay: 300,
                    // Set this option to true to use the filter to find text from the start of the column
                    // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,
                    // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    // Add select box to 4th column (zero-based index)
                    // each option has an associated function that returns a boolean
                    // function variables:
                    // e = exact text from cell
                    // n = normalized value returned by the column parser
                    // f = search filter input value
                    // i = column index
                    filter_functions: {
                    }, filter_formatter: {
                        2: function ($cell, indx) {
                            return $.tablesorter.filterFormatter.uiDateCompare($cell, indx, {
                                dateFormat: "dd-mm-yy",
                                cellText: 'Dates', // text added before the input
                                compare: ['', '=', '>=', '<='],
                                selected: 2,
                                // jQuery UI datepicker options
                                // defaultDate : '1/1/2014', // default date
                                changeMonth: true,
                                changeYear: true

                            });
                        },
                        3: function ($cell, indx) {
                            return $.tablesorter.filterFormatter.uiDateCompare($cell, indx, {
                                dateFormat: "dd-mm-yy",
                                cellText: 'Dates', // text added before the input
                                compare: ['', '=', '>=', '<='],
                                selected: 3,
                                // jQuery UI datepicker options
                                // defaultDate : '1/1/2014', // default date
                                changeMonth: true,
                                changeYear: true

                            });
                        },
                    }


                }

            });
        });

    </script>
</head>
<body>
    <%@ include file="../header.jsp"%>
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <jsp:useBean id="lrc" class="com.eminent.leaveUtil.LeaveRequestController">
        
        <jsp:setProperty name="lrc" property="*"/>
    </jsp:useBean>
    <%int assignedto = (Integer) session.getAttribute("userid_curr");
        int roleId = (Integer) session.getAttribute("Role");
        String mail = (String) session.getAttribute("theName");
        lrc.setAll(request);
     smmc.getLocationNBranch(assignedto);%>
    <!-- edit by mukesh-->
    <div style="height: 21px;background-color: #C3D9FE;font-weight: bold;padding: 1px;margin-top: 12px;"><span>Leave Request</span>
        <span style="margin-left: 85%; text-align: center;"> 
            <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Export to: <a href="<%=request.getContextPath()%>/leave/exportLeave.jsp?export=leaveView&fromDate=<%=lrc.getStartDate()%>&toDate=<%= lrc.getEndDate()%>" target="_blank">Excel</a></font></span></div>
    <!-- edit by mukesh-->
    <table style="width: 100%;">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/UserProfile/employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProfile/holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProfile/leaveRequest.jsp"> Leave Management</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%        if (assignedto == 112 || assignedto == 103 || assignedto == 104 || roleId == 4 || mail.equals("accounts@eminentlabs.net")) { %>
                <a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp">Leave  Request For User </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <% }
                    if (assignedto == 112 || assignedto == 103 || assignedto == 104 || roleId == 4 || mail.equals("accounts@eminentlabs.net") || (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto)) {%>
                <a href="<%=request.getContextPath()%>/leave/leaveView.jsp" style="font-weight: bold;">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <% }%>


            </td>
        </tr></table>
    <div class="leaveForm">
        <form class="theForm" method="post" action="<%=request.getContextPath()%>/leave/leaveView.jsp" onsubmit="disableSubmit()">

            <div > 
                <label > From Date </label><input type="text" name="fromDate" id="fromDate" maxlength="11" class="datepicker" value="<%=lrc.getStartDate()%>" > 
            </div>
            <div> 
                <label> To Date</label> <input type="text" name="toDate" class="datepicker2" maxlength="11" value="<%= lrc.getEndDate()%>" >
            </div>
            <div ><input type="submit" name="submit" id="submit" value="Submit"/> </div>


        </form>
    </div>
    <div class="tablecontent" style="width: 100%;">
        <table style="width: 100%;" class="tablesorter" id="filtersort">
            <thead>
                <tr>
                    <td class="filter-select filter-match" data-placeholder="All">Leave Type</td>
                    <td class="filter-select filter-match" data-placeholder="All">Requested By</td>
                    <td  data-sorter="shortDate" data-date-format="ddmmyyyy" style="text-align: left;">From Date</td>
                    <td class="filter-false " data-sorter="shortDate" data-date-format="ddmmyyyy" >To Date</td>
                    <td class="filter-false">Created On</td>
                    <td class="filter-false">No of Leave days</td>
                    <td class="filter-false" >Assigned To</td>
                    <td class="filter-select filter-match" data-placeholder="All">Status</td>
                    <td class="filter-false">Approved By</td>
                </tr>
            </thead>
            <%
                for (Leave leaveRequest : lrc.getLeaveRequests()) {
            %>
            <tr>
                <td class="background"><a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp?userId=<%=leaveRequest.getRequestedby()%>&leaveid=<%=leaveRequest.getLeaveid()%>" title="<%=leaveRequest.getDuration()%>"><%=leaveRequest.getType()%></a></td>
                <td class="background"><%=GetProjectManager.getUserName(leaveRequest.getRequestedby().intValue())%></td>
                <td class="background"> <fmt:formatDate pattern="dd-MM-yyyy" value="<%=leaveRequest.getFromdate()%>"></fmt:formatDate></td>
                <td class="background"><fmt:formatDate pattern="dd-MM-yyyy" value="<%=leaveRequest.getTodate()%>"></fmt:formatDate></td>
                <td class="background"><fmt:formatDate pattern="dd-MMM-yyyy HH:mm:ss" value="<%=leaveRequest.getCreatedon()%>"></fmt:formatDate></td>
                <td class="background"><%=leaveRequest.getNoOfLeaveDays()%></td>
                <td class="background" title="<%=leaveRequest.getComments()%>"><%=GetProjectManager.getUserName(leaveRequest.getAssignedto().intValue())%></td>
                <td class="background"><%=lrc.getLeaveStatus().get(leaveRequest.getApproval().intValue())%></td>
                <%if (leaveRequest.getApprover() == null) {%>
                <td class="background">NA</td>
                <%} else {%>
                <td class="background"><%=GetProjectManager.getUserName(leaveRequest.getApprover().intValue())%></td>
                <%}%>
            </tr>
            <%}%>
        </table>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $(".datepicker").datepicker({
            showOn: "button",
            dateFormat: 'dd-M-yy',
            buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
            buttonImageOnly: true,
            changeMonth: true,
            changeYear: true,
            onSelect: function (selected) {
                $(".datepicker2").datepicker("option", "minDate", selected);
            }
        });
        $(".datepicker2").datepicker({
            showOn: "button",
            dateFormat: 'dd-M-yy',
            minDate: $('#fromDate').val(),
            buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
            buttonImageOnly: true,
            changeMonth: true,
            changeYear: true,
            onSelect: function (selected) {
                $(".datepicker").datepicker("option", "maxDate", selected);
            }
        });
        $(".datepicker,.datepicker2").datepicker("option", "showAnim", 'slide');

    });

    $(document).on("click", "input[type='text'] ", function () {
        $(this).parent().children("img").click();
    });
    $("#submit").button();
</script>

</html>
