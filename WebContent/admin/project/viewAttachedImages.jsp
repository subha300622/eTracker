<%-- 
    Document   : viewAttachedImages
    Created on : 7 Mar, 2019, 3:51:18 PM
    Author     : Muthu
--%>

<%@page import="com.eminent.issue.IssueImageUrl"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("trDisplay");
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
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">


    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>


    <script type="text/javascript">



    </script>

</head>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>  
        <%@ include file="/header.jsp"%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="50%"><font size="4" COLOR="#0000FF"><b>View Attached Images</b></font></font></td>
            <td border="1" align="right" width="50%"> <a href="javascript:SetChecked()"><font
                            face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
                        href="javascript:resetChecked()"><font
                            face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a><font size="4" COLOR="#0000FF"><b> <a class="issueImage" href='<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp?sync=true'> Sync It</a></b></font></td>
        </tr>
    </table>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp" >Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" style="cursor: pointer;">TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;font-weight: bold;">View Attached Images</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  

            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <jsp:useBean id="iiurlc" class="com.eminent.issue.controller.IssueImageURLController"></jsp:useBean>
    <%
        iiurlc.extractImageURL(request);
        if(!iiurlc.getIssueImageUrls().isEmpty()){
    %>
    <form action="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp"  method="post">
    <table class="tablesorter" id="filtersort" style="width: 95%">
        <thead>
            <tr class="tablesorter-ignoreRow" bgColor="white" >
                <td class="pager" colspan="3" style="background-color: white">
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
            <tr>
                <th></th>
                <th style="width: 5%">Issue Id</th>
                <th style="width: 10%" class="filter-select" data-placeholder="RowId">Row Id of comments</th>
                <th style="width: 5%" class="filter-select" data-placeholder="Status">Local URL Status</th>
                <th style="width: 20%" >Local URL</th>
                <th style="width: 5%" class="filter-select" data-placeholder="Status" >Original URL Status</th>
                <th style="width: 30%" >Original URL</th>
            </tr>
        </thead>
        <tbody>
            <%                for (IssueImageUrl iiu : iiurlc.getIssueImageUrls()) {
    
            %>
            <tr >
                
               
                 
                <td class="background"><input type="checkbox" name="checkedIds" value="<%=iiu.getImageId()%>" /> </td>
                <td class="background">
                    <%=iiu.getIssueId()%></td>
                <td class="background"><%=iiu.getIssueRowId()%></td>
                <td class="background">
                    <%if (iiu.getLocalUrlStatus() == null) {%>
                  Status  Not Available
                    <%}else if (iiu.getLocalUrlStatus() == 1) {%>
                    Not Available
                    <%} else {%>
                     Available 
                    <%}%>
                </td>

                <td class="background"><a target="_blank" href="<%= iiu.getLocalUrl()%>"><%= iiu.getLocalUrl()%></a></td>
                
                 <td class="background">
                    <%if (iiu.getGoogleUrlStatus()== null) {%>
                    Status  Not Available
                    <%}else if (iiu.getGoogleUrlStatus() == 1) {%>
                    Not Available
                    <%} else {%>
                     Available 
                    <%}%>
                </td>
                <td class="background"><a target="_blank" href="<%= iiu.getOrginialUrl()%>"><%= iiu.getOrginialUrl()%></a></td>

            </tr>
            <%}%>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="7" style="background-color: #9fbfdf;">
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
                <input type="submit" id="submit" value="Submit"/>
                </form>
                   <%}%>
    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>


    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
                      var $table = $('#filtersort'),
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

            $("#filtersort").tablesorter({
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
            $('#filtersort').trigger('pageSize', 100);

        });
        $(".Ajax-loder").hide();
$(document).on('click', '.issueImage', function() {
            $(".Ajax-loder").show();

        });
        
          function SetChecked()
            {
                //$('input:checkbox').removeAttr('checked');
                var test1 = $("tr[class=odd] input:checkbox");
                var testeven = $("tr[class=even] input:checkbox");
                var rowslen = test1.length;
                var testevenlen = testeven.length;
                for (var m = 0; m < rowslen; m++) {
                    test1[m].checked = true;
                }
                for (var m = 0; m < testevenlen; m++) {
                    testeven[m].checked = true;
                }
            }

            function resetChecked() {
                var test1 = $("tr[class=odd] input:checkbox");
                var testeven = $("tr[class=even] input:checkbox");
                var rowslen = test1.length;
                var testevenlen = testeven.length;
                for (var m = 0; m < rowslen; m++) {
                    test1[m].checked = false;
                }
                for (var m = 0; m < testevenlen; m++) {
                    testeven[m].checked = false;
                }
            }
  $("#submit").click(function () {
     var checked = $("input:checked").length > 0;
    if (!checked){
        alert("Please check at least one checkbox");
        return false;
    }else{
         $(".Ajax-loder").show();
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
