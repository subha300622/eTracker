<%-- 
    Document   : getIssuesByPnameVersion
    Created on : 11 May, 2020, 10:59:12 AM
    Author     : vanithaalliraj
--%>

<%@page import="com.eminent.issue.controller.IssueController"%>
<%@page import="com.eminent.issue.Issue"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=11" type="text/css" rel="STYLESHEET"/>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
</head>
<body>
    <%
        List<Issue> list = IssueController.getIssuesByProject(request);
        String mainIssue = request.getParameter("mainIssue");
       if(mainIssue ==null)mainIssue="";
    %>
    <div>
        <span id="msg"><%if (!mainIssue.equals("")){%>
            Clear the main issue(<%=mainIssue%>) from table filter to show all issues
        <%}%>
        </span>
        <div style="height:300px;overflow:auto;" >
            <TABLE width="100%" id="filtersort" class="tablesorter">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <th></th><th data-value="<%=mainIssue%>"><b>Main Issue</b></th><th><b>Subject</b></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int i = 0;
                        String color = "white", ratingColor = "white";
                        for (Issue issue : list) {
                            color = "white";
                            if ((i % 2) != 0) {
                                color = "#E8EEF7";
                            }
                            if (issue.getIssuestatus().equalsIgnoreCase("Closed")) {
                                if (issue.getRating().equalsIgnoreCase("Excellent")) {
                                    ratingColor = "#336600";
                                } else if (issue.getRating().equalsIgnoreCase("Good")) {
                                    ratingColor = "#33CC66";
                                } else if (issue.getRating().equalsIgnoreCase("Average")) {
                                    ratingColor = "#CC9900";
                                } else if (issue.getRating().equalsIgnoreCase("Need Improvement")) {
                                    ratingColor = "#CC0000";
                                } else {
                                    ratingColor = color;
                                }
                            } else {
                                ratingColor = color;
                            }
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter">
                        <% } else {  %>
                    <tr class="zebraline" >
                        <%}%>

                        <td class="background">
                            <input type="radio" name="selectedIssue" value="<%=issue.getIssueid()%>">
                        </td> 
                        <td  style="background-color: <%=ratingColor%>">
                            <%=issue.getIssueid()%>
                        </td> 
                        <td class="background">
                            <%=issue.getSubject()%>
                        </td> 
                    </tr>
                    <% i++;
                        }%>
                </tbody>
            </table>
        </div>

        <input type="button" class="addtarget ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Select" >
    </div>

</body>
<style>
    .error2{
        color: red;
    }
    .addtarget{ 
        border: 1px solid #79b7e7;
        background: #d0e5f5 ;
        font-weight: bold;
        color: #1d5987;
        cursor: pointer;
        border-radius: 2px;
        margin-left:50px;
    }

</style>
<script>

    $(".addtarget").on("click", function () {
        $('span.error2').remove();
        if ($('input:radio:checked').length > 0) {
            $("#mainIssue").val($("input[name='selectedIssue']:checked").val())
            $(".addTargetCount").dialog("close");
        } else {
            $("<span class='error2'>Please select a main issue</span>").insertAfter(this);
        }


    });

</script>

<script type="text/javascript">

    $(document).ready(function ()
    {


        var $table = $('.tablesorter');

        var val = $("#search").val();
        
        if (val === '') {
            $table.trigger('refreshColumnSelector', [ [1, 2, 3] ]);
        } else {
            // show all columns
            $table.trigger('refreshColumnSelector', [ [1, 2, 3] ]);
        }
        // call the tablesorter plugin
        $table.tablesorter({
            theme: 'blue',
            // hidden filter input/selects will resize the columns, so try to minimize the change
            widthFixed: true,
            // initialize zebra striping and filter widgets
            widgets: ["zebra", "filter", "columnSelector"],

            widgetOptions: {
                          filter_columnFilters: true,
            filter_external: '.search',
            filter_defaultAttrib: 'data-value',
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

        });
    });
</script>
</html>