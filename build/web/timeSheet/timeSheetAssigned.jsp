<%-- 
    Document   : timeSheetAssigned
    Created on : 25 May, 2015, 2:03:15 PM
    Author     : EMINENT
--%>

<%@page import="com.eminentlabs.timesheet.controller.TimesheetApprovalFormbean"%>
<%@page import="java.util.Set"%>
<%@page import="com.eminentlabs.timesheet.controller.TimeSheetFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
        <link title=STYLE href="<%=request.getContextPath()%>/css/eminentstyles.css?test=17" type="text/css" rel="STYLESHEET"/>

        <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/redmond/jquery-ui.css">
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

        <style>
            .ui-datepicker-calendar {
                display: none;
            }

        </style>
        <script type="text/javascript">

            $(function() {

                // call the tablesorter plugin
                $(".tablesorter").tablesorter({
                    theme: 'blue',
                    // hidden filter input/selects will resize the columns, so try to minimize the change
                    widthFixed: true,
                    // initialize zebra striping and filter widgets
                    widgets: ["zebra", "filter"],
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
            });</script>
    </head>
    <body>
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
        <jsp:useBean id="tsu" class="com.eminent.timesheet.TimeSheetUtil"></jsp:useBean>
        <%mmc.setSendMomAll(request);
		String mail = (String) session.getAttribute("theName");
//        Integer timeSheetApprovalUserId = tsu.findUserIdByStatus(0);
//        Integer accountApprovalUserId = tsu.findUserIdByStatus(2);
        %>

        <jsp:useBean id="hsas" class="com.eminentlabs.timesheet.controller.TimesheetApprovalStatus"></jsp:useBean>
        <%hsas.setAll(request);

		   int roleId = (Integer) session.getAttribute("Role");
            if (hsas.getUserId() == 112 || hsas.getUserId() == 103 || roleId==4  || mail.equals("accounts@eminentlabs.net")) {%>
        <div class="" style="background-color: #C3D9FF;height: 22px;margin-bottom: 20px;margin-top: 20px;padding:2px;" >
            <form name="testForm" method="Post" action="timeSheetAssigned.jsp"  >
                <label for="startDate" style="font-weight: bold;">Pick Month & Year :</label>
                <input type="text" name="startDate" id="startDate" size="11" class="date-picker" readonly="" onchange="callNew();" value="<%=hsas.getStartDate()%>"/>
            </form>
        </div>
  <% if (hsas.getUserId() == 112 || hsas.getUserId() == 103  || mail.equals("accounts@eminentlabs.net")) {%>
        <p><%int assignedto = (Integer) session.getAttribute("uid");
            Set<Integer> usersList = mmc.getTotalUsers();
            if (usersList.contains(assignedto)) {%>

            <a href="/eTracker/MOM/weekPerformers.jsp?performerid=<%=assignedto%>">My Plan/Actual</a>&nbsp;&nbsp;&nbsp;&nbsp<a href="<%=request.getContextPath()%>/MyTimeSheet/teamClosedIssueReport.jsp" >My Rank </a>&nbsp;&nbsp;&nbsp;&nbsp
            <%}
                if (assignedto == 200 ||assignedto == 103 || assignedto == 112  || mail.equals("accounts@eminentlabs.net")) {%>
            <a href="/eTracker/timeSheet/HS_SG.jsp">Hardship & Suggestions</a>&nbsp;&nbsp;&nbsp;&nbsp
            <a href="/eTracker/timeSheet/timeSheetAssigned.jsp" style="cursor:pointer;font-weight: bold;">Time Sheet Submission</a>&nbsp;&nbsp;&nbsp;&nbsp
            <%}%></p>
			 <%}else{%>
			             <a href="<%=request.getContextPath()%>/admin/user/viewuser.jsp" >View User</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/timesheet/timeSheetAssigned.jsp" style="font: bold;">View Timesheet Status</a>&nbsp;&nbsp;&nbsp;&nbsp;


			  <%}%>
            <%if (!hsas.getTimeSheetFormBeans().isEmpty()) {%>
        <table  style = "width: 70%;margin-top: 20px;" class="tablesorter" >
            <thead> <tr style="background-color: #C3D9FF;font-weight: bold;height: 21px; ">
                    <th class="filter-false">SI NO</th>
                    <th  class="filter-select filter-match" data-placeholder="Select Name" > Name </th>
                    <th  class="filter-select filter-match" data-placeholder="Select Status">Status</th> 
                    <th class="filter-select filter-match" data-placeholder="Select Assigned To">Assigned To</th> 
                    <th>Requested On</th>
                    </tr>
            </thead>
        
        <% int i = 0;
            for (TimesheetApprovalFormbean timesheetApprovalFormbean : hsas.getTimeSheetFormBeans()) {
                i++;
                if (i % 2 != 0) {%>
        <tr style="height: 21px;">
            <% } else {%>
        <tr style="background-color: #E8EEF7;height: 21px;">
            <%}%>
            <td class="background"><%=i%></td>
            <td class="background"><%=timesheetApprovalFormbean.getName()%></td>
            <td class="background"><%=timesheetApprovalFormbean.getStatus()%></td>
            <td class="background"><%=timesheetApprovalFormbean.getAssignedTo()%></td>
            <td class="background"><%=timesheetApprovalFormbean.getRequestedOn()%></td>

        </tr>
        <% }
        %>
    </table>
    <%} else {%>
    <div style="text-align: center; ">No time sheets are available for this month</div> 
    <%}
    } else {%>
    <div style="text-align: center;color: red;">You are not authorized to access this page</div>
    <%}%>
</body>
<script type="text/javascript">
    var date = new Date();
    date.setMonth(date.getMonth() + 1);
    $(function() {
        $('.date-picker').datepicker({
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            dateFormat: 'MM yy',
            showOn: "button",
            buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
            buttonImageOnly: true,
            maxDate: date,
                    onClose: function() {
                        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                        $(this).datepicker('refresh');

                        document.testForm.action = "timeSheetAssigned.jsp?startDate=" + $('#startDate').val();
                        document.testForm.submit();
                    },
            beforeShow: function() {
                if ((selDate = $(this).val()).length > 0) {

                    iYear = selDate.substring(selDate.length - 4, selDate.length);
                    iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
//                        alert(iYear + "," +iMonth );
                    $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
                    $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                }
            }

        });

    });
    $(".date-picker").focus(function() {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });
    });

    $(".date-picker").blur(function() {
        $(".ui-datepicker-calendar").hide();
    });

</script>
</html>

