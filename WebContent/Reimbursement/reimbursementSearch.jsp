<%-- 
    Document   : reimbursementSearch
    Created on : 8 Sep, 2016, 4:15:37 PM
    Author     : EMINENT
--%>

<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementBill"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementVouchers"%>
<%@page import="java.util.List"%>
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
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=18" type="text/css" rel="STYLESHEET"/>
        <link href='<%=request.getContextPath()%>/css/fullcalendar.css?test=7' rel='stylesheet' />
        <link href='<%=request.getContextPath()%>/css/fullcalendar.print.css' rel='stylesheet' media='print' />
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
        <script src='<%=request.getContextPath()%>/javaScript/moment.min.js'></script>
        <script src='<%=request.getContextPath()%>/javaScript/fullcalendar.min.js'></script>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css?test=3">
        <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>


        <title>Leave Request</title>
        <style type="text/css">

            .ui-datepicker-calendar {
                display: none;
            }
            .error2{
                color: red;
                font-size:14px;
            }

        </style>

    </head>
    <body>
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="rvc" class="com.eminentlabs.mom.reimbursement.controller.ReimbursementVouchersController">
        </jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 

        <% int assignedto = (Integer) session.getAttribute("userid_curr");
        rvc.getAll(request);
            ResourceBundle rb = ResourceBundle.getBundle("Resources");
            String mods = rb.getString("mom-mods");
            String noOfIds[] = mods.split(",");
            List<String> modList = Arrays.asList(noOfIds);
            int wrmSize = mas.wrmIssues().size();
            SimpleDateFormat sdf = new SimpleDateFormat("MMM yyyy");
            String mail = (String) session.getAttribute("theName");
            if (rvc.getReimbursementModerator().contains(2) || assignedto==104|| mail.equals("accounts@eminentlabs.net")) {
        %>
        <div style="height: 21px;background-color: #C3D9FE;font-weight: bold;padding: 1px;margin-top: 12px;"><span>Reimbursement Voucher</span></div>

        <table cellpadding="0" cellspacing="0" width="100%" >

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;

                    <%
                        if (modList.contains(((Integer) assignedto).toString())) {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 } else {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer;">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                    <%
                        if (rvc.getReimbursementModerator().contains(2) || assignedto==104|| mail.equals("accounts@eminentlabs.net")) {
                    %>
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementSearch.jsp" style="cursor: pointer;font-weight: bold; ">Reimbursement Search</a> &nbsp;&nbsp;&nbsp;

                    <%}%>

                </td>
            </tr>
        </table>

        <div class="leaveForm">
            <form class="theForm" method="get" action="<%=request.getContextPath()%>/Reimbursement/reimbursementSearch.jsp" onsubmit="disableSubmit()">

                <div> 
                    <label> From Month </label><input type="text" name="fromDate" id="fromDate" maxlength="11" class="datepicker" value="<%=((rvc.getStartMonth() == null) ? "" : rvc.getStartMonth())%>"  readonly=""> 
                </div>

                <div> 
                    <label> To Month</label> <input type="text" name="toDate" class="datepicker2" id="toDate" maxlength="11" value="<%=((rvc.getEndMonth() == null) ? "" : rvc.getEndMonth())%>" readonly="">
                </div>
                <div style="width: 38%"><input type="submit" name="submit" id="submit" value="Search"/> </div>
            </form>
        </div>

        <br/>
        <table style="width: 100%;" id="filtersort">
            <thead style="background-color: #C3D9FF;height: 21px;font-weight: bold; ">
            <th>S.No</th>
            <th class="filter-select filter-match" data-placeholder="All">Requested By</th>
            <th>Period</th>
            <th class="filter-select filter-match" data-placeholder="All">Status</th>
            <th class="filter-select filter-match" data-placeholder="All">Assigned To</th>
            <th>Created On</th>
            <th>Excel & Bills</th>
            <th class="filter-false">Manage</th>
        </thead>
        <%int i = 0;
            for (ReimbursementVouchers reimbursementVouchers : rvc.getReimbursementVoucherses()) {
                if ((i % 2) == 0) {
        %>
        <tr class="zebralinealter" style="height: 21px;">
            <%} else {%>
        <tr class="zebraline" style="height: 21px;">
            <%}
                i++;%>
            <td class="background"><%=i%></td>
            <td class="background"><a href="<%=request.getContextPath()%>/Reimbursement/reimbursementEdit.jsp?rvid=<%=reimbursementVouchers.getRvid()%>" ><%=rvc.getAllEminentMembers().get(reimbursementVouchers.getRequestedBy())%></a></td>
            <td class="background"><%=sdf.format(reimbursementVouchers.getPeriod())%></td>
            <td class="background"><%=rvc.statusMapCollection().get(reimbursementVouchers.getStatus())%></td>
            <td class="background" title="<%=rvc.getAllEminentMembers().get(reimbursementVouchers.getUploadedBy())%>"><%=rvc.getAllEminentMembers().get(reimbursementVouchers.getAssignedTo())%></td>
            <td class="background" title="<fmt:formatDate pattern="dd-MMM-yyyy HH:mm:ss" value="<%=reimbursementVouchers.getModifiedon()%>"/>"><fmt:formatDate pattern="dd-MMM-yyyy HH:mm:ss" value="<%=reimbursementVouchers.getCreatedon()%>"/></td>
            <td class="background"><a href="<%=request.getContextPath()%>/Reimbursement_vouchers/<%=reimbursementVouchers.getFileName()%>" target="_blank"><%=reimbursementVouchers.getFileName()%></a>

                <%for (ReimbursementBill reimbursementBill : reimbursementVouchers.getReimbursementBillList()) {%>

                <div><a href="<%=request.getContextPath()%>/Reimbursement_vouchers/<%=reimbursementBill.getFilename()%>" target="_blank"><%=reimbursementBill.getFilename()%></a>
                    <%if (reimbursementVouchers.getStatus() == 0) {%>
                    <img src="<%=request.getContextPath()%>/images/remove.gif" alt="Remove Bil" style="cursor: pointer;" class="removebill" billid="<%=reimbursementBill.getBid()%>"/>
                    <%}%>
                </div>
                <%}%>
            </td>

            <td class="background">
                <%if (reimbursementVouchers.getStatus() == 0) {%>
                <a href="javascript:;" id="<%=reimbursementVouchers.getRvid()%>" class="rvDel">Delete</a>

                <%} else {%>
                <%}%>
            </td>
        </tr>
        <%}%>
    </table>

    <%} else {%> 
    <div style="color: red">You are not authorised to access this page.</div>
    <%}%>

    <script type="text/javascript">

        $("#fromDate,#toDate").datepicker({
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            showOn: "button",
            buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
            buttonImageOnly: true,
            dateFormat: 'MM yy',
            onClose: function(dateText, inst) {
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year, month, 1));
                var defultdate = $.datepicker.formatDate('MM yy', new Date(year, month, 1));
                $("#toDate").val(defultdate);
            },
            beforeShow: function(input, inst) {
                if ((datestr = $(this).val()).length > 0) {
                    year = datestr.substring(datestr.length - 4, datestr.length);
                    month = jQuery.inArray(datestr.substring(0, datestr.length - 5), $(this).datepicker('option', 'monthNames'));
                    $(this).datepicker('option', 'defaultDate', new Date(year, month, 1));
                    $(this).datepicker('setDate', new Date(year, month, 1));
                }
                var other = this.id == "fromDate" ? "#toDate" : "#fromDate";
                var option = this.id == "fromDate" ? "minDate" : "minDate";
                if ((selectedDate = $(other).val()).length > 0) {
                    var byear = selectedDate.substring(selectedDate.length - 4, selectedDate.length);
                    var bmonth = jQuery.inArray(selectedDate.substring(0, selectedDate.length - 5), $(this).datepicker('option', 'monthNames'));
                    $("#toDate").datepicker("option", option, new Date(byear, bmonth, 1));
                    //  $("#toDate").datepicker("setDate", new Date(byear, bmonth, 1));
                }
            }
        });
        $(document).on("click", "input[type='text'] ", function() {
            $(this).parent().children("img").click();
        });
        $(document).on('focus', "#fromDate ,.datepicker2,#submit", function() {
            $(".error2").remove();
        });
        $('#submit').click(function() {
            $(".theForm span.error2").remove();
            var count = 0;
            var fromDate = $("#fromDate").val();
            var todate = $('.datepicker2').val();
            var spitfrom = fromDate.split(" ");
            var splitTo = todate.split(" ");
            var fyear = parseInt(spitfrom[1]);
            var tyear = parseInt(splitTo[1]);
            var fmonth = new Date(Date.parse(spitfrom[0] + "1," + spitfrom[1])).getMonth();
            var tmon = new Date(Date.parse(splitTo[0] + "1," + splitTo[1])).getMonth();
            if (fromDate == "") {
                $("<span class='error2' style='margin-left:10px;'>from month can not be empty </span>").insertAfter("#submit");
                count = 1;
            } else if (todate == "") {
                $("<span class='error2' style='margin-left:10px;'>to month can not be empty </span>").insertAfter("#submit");
                count = 1;
            } else if (new Date(Date.parse(splitTo[0] + "1," + splitTo[1])) < new Date(Date.parse(spitfrom[0] + "1," + spitfrom[1]))) {
                $('.datepicker2').val('');
                $("<span class='error2' style='margin-left:10px;'>to month can not less than from month </span>").insertAfter("#submit");
                count = 1;
            } else {
                fmonth = parseInt(fmonth);
                tmon = parseInt(tmon);
                fyear = parseInt(fyear);
                tyear = parseInt(tyear);
                if (fmonth > 2 && fyear == tyear) {
                } else if ((fmonth < 3 && tmon > 2) && (fyear == tyear)) {
                    $('.datepicker2').val('');
                    $("<span class='error2' style='margin-left:10px;'>Please select single financial year period. </span>").insertAfter("#submit");
                    count = 1;
                } else if (fyear != tyear) {
                    if (fmonth > 2 && fyear < tyear) {
                        if (tmon < 3 && (fyear + 1) == tyear) {
                        } else {
                            $('.datepicker2').val('');
                            $("<span class='error2' style='margin-left:10px;'>Please select single financial year period. </span>").insertAfter("#submit");
                            count = 1;
                        }
                    } else if ((fmonth < 3 && tmon < 3) && (fyear != tyear)) {
                        $('.datepicker2').val('');
                        $("<span class='error2' style='margin-left:10px;'>Please select single financial year period.</span>").insertAfter("#submit");
                        count = 1;
                    } else if ((fmonth > 2 && tmon > 2) && (fyear != tyear)) {
                        $('.datepicker2').val('');
                        $("<span class='error2' style='margin-left:10px;'>Please select single financial year period.</span>").insertAfter("#submit");
                        count = 1;
                    } else if ((fmonth < 3 && tmon > 2) && (fyear != tyear)) {
                        $('.datepicker2').val('');
                        $("<span class='error2' style='margin-left:10px;'>Please select single financial year period.</span>").insertAfter("#submit");
                        count = 1;
                    }
                }
            }
            if (count == 1) {
                return false;
            } else {
                count = 0;
                return true;
            }

        });
        $('#submit').button();
        $.tablesorter.addParser({
            id: "ddMMMyy",
            is: function(s) {
                return false;
            },
            format: function(s, table) {
                var from = s.split("-");
                var year = "20" + from[2];
                var mon = from[1];
                var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                return new Date(year, month, from[0]).getTime() || '';
            },
            type: "numeric"
        });
        $(function() {

            // call the tablesorter plugin
            $("#filtersort").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                headers: {7: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMMyy'
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
                    filter_hideFilters: false,
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
                    }

                }

            });
        });

        $(".Ajax-loder").hide();
    </script>

</body>
</html>
