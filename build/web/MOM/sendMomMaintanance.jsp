<%-- 
    Document   : sendMomMaintanance
    Created on : 18 Fev, 2021, 12:46:09 PM
    Author     : EMINENT
--%>

<%@page import="com.eminentlabs.mom.SendMomMaintenance"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.timesheet.TimesheetMaintanance"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=2" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/multiple-select.css"/>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <style type="text/css">
        select.custom-select {
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #CCC;
        }
    </style>

</head>
<body>
    <%@ include file="/header.jsp"%>
    <%
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId == 1) {
    %> 
    <jsp:useBean id="tmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"/>
    <%tmc.setAll(request);%>
    <div style="width: 100%;background-color: #C3D9FE;font-weight: bold;">Send MoM Maintenance </div>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <%if (tmc.getMessage() == null) {

        } else {%>
    <p style="color: green;font-weight: 700;">  <%=tmc.getMessage()%></p>
    <%}%>

    <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/MOM/sendMomMaintanance.jsp" onsubmit="return validate();">

        <table style="width: 90%;align-content: center">
            <thead>
                <tr>
                    <th style="color: black">User</th>
                    <th style="color: black">MoM Type</th>
                    <th style="color: black">Branch</th>
                </tr>
            </thead>
            <tbody id="tbody">          
                <tr id="1">
                    <td>
                        <select  name="userid" id="userid1">
                            <option value="">Select a User</option>
                            <%for (Map.Entry<Integer, String> team : tmc.getEminentUsers().entrySet()) {%>
                            <option value="<%=team.getKey()%>" <%if (tmc.getSendMomMaintenance() != null && team.getKey().intValue() == tmc.getSendMomMaintenance().getUserId().intValue()) {%> selected="true" <%}%>><%=team.getValue()%></option>
                            <%}%>
                        </select>
                    </td>
                    <td>
                        <select  name="momType" id="momType1">
                            <%for (Map.Entry<Integer, String> team : tmc.getMomTypeList().entrySet()) {%>
                            <option value="<%=team.getKey()%>"  <%if (tmc.getSendMomMaintenance() != null && team.getKey().intValue() == tmc.getSendMomMaintenance().getMomType().intValue()) {%> selected="true" <%}%> ><%=team.getValue()%></option>
                            <%}%>
                        </select>
                    </td>
                    <td>
                        <select  name="branch" id="branch1">
                            <%for (Map.Entry<Integer, String> team : tmc.getBranchMap().entrySet()) {%>
                            <option value="<%=team.getKey()%>"  <%if (tmc.getSendMomMaintenance() != null && team.getKey().intValue() == tmc.getSendMomMaintenance().getBranchId().intValue()) {%> selected="true" <%}%> ><%=team.getValue()%></option>
                            <%}%>
                        </select>
                    </td>
                    <td><a href="javascript:void(0);" class="addCF">Add</a></td>
                </tr>
            </tbody>
        </table>

        <br/>

        <center>
            <div style="text-align: center">
                <input type="submit" name="submit" id="submit"  value="Submit">
            </div>
        </center>
    </form>
    <%if (tmc.getSendMomMaintenances() != null && !tmc.getSendMomMaintenances().isEmpty()) {%>
    <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager"  style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="3" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">
                <th class="filter-select filter-match" data-placeholder="Select a User"><font><b>User</b></font></th>
                <th class="filter-select filter-match" data-placeholder="Select a MoM Type"> <font><b>MoM Type</b></font></th>
                <th class="filter-select filter-match" data-placeholder="Select a Branch"><font><b>Branch</b></font></th>
            </tr>
        </thead>
        <tbody>
            <%for (SendMomMaintenance u : tmc.getSendMomMaintenances()) {
                    if (tmc.getEminentUsers().containsKey(u.getUserId())) {%>
            <tr >
                <td ><a href="<%=request.getContextPath()%>/MOM/sendMomMaintanance.jsp?id=<%=u.getUserId()%>"><%=tmc.getEminentUsers().get(u.getUserId())%> </a></td>
                <td ><%=tmc.getMomTypeList().get(u.getMomType())%>   </td>
                <td ><%=tmc.getBranchMap().get(u.getBranchId())%>   <img src="<%=request.getContextPath()%>/images/remove.gif"  class="delete" id="<%=u.getId()%>"></img></td>
            </tr>
            <%}
                }%>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" style="background-color: #c3d9ff;">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
        </tfoot>
    </table>
    <%}%>
    <%} else {%>
    <BR>
    <table align="center">
        <tr align="center" ><td><font color="red">You are not authorized to access this page.</font></td></tr>
    </table>
    <%}%>

    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script> 

    <script src="<%=request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>    <script type="text/javascript">

        $(document).on("click", ".addCF", function () {
            var info = "<tr><td><select  name='userid'>";
            $("#userid1 option").each(function () {
                info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
            });
            info = info + "</select></td><td><select  name='momType'>";
            $("#momType1 option").each(function () {
                info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
            });
            info = info + "</select></td><td><select  name='branch'>";
            $("#branch1 option").each(function () {
                info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
            });
            info = info + "</select><img src='<%=request.getContextPath()%>/images/remove.gif'  class='delete' id='0'></img></td>";
            $("#tbody").append(info);
        });
        function validate() {
            $(".error1").remove();
            var count = 0;
            //            var issues = document.getElementsByName("timesheetApprover");
            //            for (var i = 0; i < issues.length; i++) {
            //                if ($.trim(issues[i].value).length === 0) {
            //                    count = 1;
            //                }
            //            }

            if (count === 0) {
                disableSubmit();
                return true;
            } else {
                $("<p class='error1' style='color:#FF0000;'>Please select user for each role</p>").insertAfter("#submit");
                return false;
            }
        }

        $(document).on("click", ".delete", function () {
            var obj = $(this).parent();
            var id = $.trim($(this).attr("id"));
            if (confirm("Do you want to delete?")) {
                if (id === "0") {
                    obj.parent().remove();
                } else {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/MOM/deleteSendMomUser.jsp',
                        data: {id: id, rand: Math.random(1, 10)},
                        async: false,
                        type: 'POST',
                        success: function (responseText, statusTxt, xhr) {
                            if (statusTxt == "success") {
                                var result = $.trim(responseText);
                                if (result === "success") {
                                    obj.parent().remove();
                                    $('#user').trigger('update');
                                } else {
                                    alert(result);
                                }
                            }
                        }
                    });
                }
            }
        });
    </script>


    <script>
        $(document).ready(function () {

            var $table = $('#user'),
                    $pager = $('.pager');
            $.tablesorter.customPagerControls({
                table: $table, // point at correct table (string or jQuery object)
                pager: $pager, // pager wrapper (string or jQuery object)
                pageSize: '.left a', // container for page sizes
                currentPage: '.right a', // container for page selectors
                ends: 2, // number of pages to show of either end
                aroundCurrent: 5, // number of pages surrounding the current page
                link: '<a href="#" class="pagerno">{page}</a>', // page element; use {page} to include the page number
                currentClass: 'current', // current page class name
                adjacentSpacer: ' | ', // spacer for page numbers next to each other
                distanceSpacer: ' \u2026 ', // spacer for page numbers away from each other (ellipsis &amp;hellip;)
                addKeyboard: true                      // add left/right keyboard arrows to change current page
            });
            $("#user").tablesorter({
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
                    },
                    filter_formatter: {
                    }

                }

            }).tablesorterPager({
                //target the pager markup - see the HTML block below
                container: $pager,
                size: 10,
                output: 'Displaying {startRow} - {endRow} of {filteredRows}'
            });
            $('#user').trigger('pageSize', 100);
        });
        $('.multiple').multipleSelect({
            filter: true,
            maxHeight: 150

        }
        );
    </script>
    <style>
        .pager a.current {
            color: #0080ff;
            font-weight: 800;            
        }
        .pager a {
            text-decoration: none;
            color: black;
        }
        .tablesorter-blue tbody tr.odd > td {
            background-color: #E8EEF7;
        }
        .tablesorter-blue tbody tr.even > td {
            background-color: white;
        }
    </style>
</body>

</html>