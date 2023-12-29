<%-- 
    Document   : maintainWRM
    Created on : 21 Aug, 2019, 12:16:16 PM
    Author     : Muthu
--%>


<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.wrm.User"%>
<%@page import="com.eminent.issue.ApmWrmDay"%>
<%@page import="com.eminent.bpm.BpmPrintaccess"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("wrmMaintanance");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/multiple-select.css"/>

    <script type="text/javascript">
        function callProjectMom() {
            var pid = document.getElementById('pid').value;
            window.location = "<%=request.getContextPath()%>/admin/project/maintainWRM.jsp?pid=" + pid;
        }
    </script>
</head>
<%@ include file="/header.jsp"%>
<body>
    <br/>
    <jsp:useBean id="mwd" class="com.eminentlabs.wrm.controller.WrmMailMaintenanceController"></jsp:useBean>
    <%mwd.setAll(request);%>
    <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/admin/project/maintainWRM.jsp" onsubmit="disableSubmit();">
        <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr border="2">
                <td border="1" align="left" width="50%"><font size="4" COLOR="#0000FF"><b>Maintain WRM Mail Maintenance for <%=mwd.getPname()%></b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                <td border="1" align="right" width="50%"> <select name="pid" id="pid" onchange="callProjectMom(this);">
                        <%for (Map.Entry<Integer, String> entry : MoMUtil.getProjects().entrySet()) {
                                if (mwd.getPid() == entry.getKey()) {%>
                        <option value="<%=entry.getKey()%>" selected=""><%=entry.getValue()%></option>
                        <%} else {%><option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}
                            }%>
                    </select></td>
            </tr>
        </table>
        <br/>
        <table width="100%" border="0">
            <tr>
                <td>
                    <a href="<%=request.getContextPath()%>/admin/project/viewproject.jsp">View Project</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/viewWRM.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
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
        <table width="100%" bgColor=#e8eef7 border="0">
            <% if (!mwd.getInternalUsers().isEmpty()) {%>
            <tr>
                <td width="10%"><strong>Internal Users</strong></td>
                <td><select name="userIds" id="internalUsers" multiple="" data-placeholder="Select internal user" style="width: 250px;">
                        <%for (Map.Entry<Long, String> e : mwd.getInternalUsers().entrySet()) {%>
                        <option value="<%=e.getKey()%>"><%=e.getValue()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <%}%>
            <tr>
                <td width="10%"><strong>Client Users</strong></td>
                <td><select name="userIds" id="clientUsers" multiple="" data-placeholder="Select client user" style="width: 250px;">
                        <%for (Map.Entry<Long, String> e : mwd.getClientUsers().entrySet()) {%>
                        <option value="<%=e.getKey()%>"><%=e.getValue()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>

            <tr ><td width="10%">&nbsp;</td><td><input type="submit" id="submit" value="Submit"/></td></tr>
        </table>
    </form>
    <%if (!mwd.getWrmMailUsers().isEmpty()) {%>
    <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager"  style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="4" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">
                <th ><font><b>User Id</b></font></th>
                <th ><font><b>User Name</b></font></th>
                <th class="filter-select filter-match" data-placeholder="Select a Team"><font><b>Team</b></font></th>
                <th ><font><b>Email</b></font></th>
            </tr>
        </thead>
        <tbody>
            <%for (User u : mwd.getWrmMailUsers()) {%>
            <tr >
                <td class="userId"><%=u.getUserId()%> </td>
                <td class="name"><%=u.getFirstName()%>  <%=u.getLastName()%> </td>
                <td><%=u.getTeam()%></td>
                <td class="mail"><%=u.getEmailId()%><img src="<%=request.getContextPath()%>/images/remove.gif" alt="Delete" style="cursor: pointer;" class="delete_wrm" id="<%=u.getId()%>" /></td>
            </tr>
            <%}%>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4" style="background-color: #c3d9ff;">
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

    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script> 

    <script src="<%=request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
    <script type="text/javascript">




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
                    $('#internalUsers,#clientUsers').multipleSelect({
                        filter: true,
                        maxHeight: 150

                    }
                    );

                    $(document).on("click", ".delete_wrm", function () {
                        var obj = $(this).parent();
                        var id = $.trim($(this).attr("id"));
                        if (id.length == 0) {
                        } else {
                            var $row = $(this).closest("tr");    // Find the row
                            var userId = $row.find(".userId").text(); // Find the text
                            var name = $row.find(".name").text(); // Find the text
                            var mail = $row.find(".mail").text(); // Find the text
                            $.ajax({
                                url: '<%=request.getContextPath()%>/admin/project/deleteWRMMailId.jsp',
                                data: {id: id, random: Math.random(1, 10)},
                                async: false,
                                success: function (responseText, statusTxt, xhr) {
                                    if (statusTxt === "success") {
                                        var result = $.trim(responseText);
                                        if (result == "success") {
                                            var optionValues = [];
                                            if (mail.endsWith("@eminentlabs.net")) {
                                                $("#internalUsers").append("<option value='" + userId + "'>" + name + "</option>");

                                                $('#internalUsers option').each(function () {
                                                    if ($.inArray(this.value, optionValues) > -1) {
                                                        $(this).remove()
                                                    } else {
                                                        optionValues.push(this.value);
                                                    }
                                                });
                                                $('#internalUsers').multipleSelect();

                                            } else {
                                                $("#clientUsers").append("<option value=" + userId + ">" + name + "</option>");
                                                $('#clientUsers option').each(function () {
                                                    if ($.inArray(this.value, optionValues) > -1) {
                                                        $(this).remove()
                                                    } else {
                                                        optionValues.push(this.value);
                                                    }
                                                });
                                                $('#clientUsers').multipleSelect();

                                            }

                                            $row.remove();
                                            $('#user').trigger('update');

                                        } else {
                                            alert(result);
                                        }
                                    }
                                }});

                        }
                    });

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