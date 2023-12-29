<%-- 
    Document   : myIssueNext
    Created on : 16 Apr, 2015, 7:47:19 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="mi" class="com.eminent.issue.formbean.MyIssues" ></jsp:useBean>

    <table><tbody class='addCont'>
        <%mi.setAll(request);%>
        <%int i = 0;
            for (IssueFormBean isfb : mi.getIssuesList()) {
                if ((i % 2) != 0) {
        %>
        <tr class="zebralinealter odd"  height="28" style="padding: 5px;">
            <%} else {%>
        <tr class="zebraline even"  height="28" style="padding: 5px;">
            <%}
                i++;%>

            <td class="background" bgcolor="<%=isfb.getSeverity()%>"></td>
            <td class="background" title="<%=isfb.getType()%>"><a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=<%=isfb.getIssueId()%>">

                    <%=isfb.getIssueId()%></a>
            </td>
            <td class="background" ><%=isfb.getPriority()%></td>
            <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
            <td class="background"  width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
            <td class="background" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
            <td class="background"  onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
            <td class="background"  title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
            <td class="background" title="Assignedby <%=isfb.getLastAssigneeName()%> at <%=isfb.getLastModifiedOn()%>"><%=isfb.getAssignto()%></td>
            <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
            <td class="background" ><%=isfb.getRefer()%></td>
            <%} else {%>
            <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                <%}%>
            <td class="background" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>

        <%
            }%></tbody></table><%if (mi.getIssuesList().size() >= 15) {%>
<div class='otherclass'><div class="next jscroll-next-parent"><a class="jscroll-next" href="<%=request.getContextPath()%>/MyIssues/myIssueNext.jsp?pageNumber=<%=mi.getPageNo() + 1%>">next</a></div></div>

<%}%>

<div class='scriptremoval'>
    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>  
    <script type="text/javascript">
        $(document).ready(function () {
            $('#searchTable tbody').append($(".addCont").html());
            $('.jscroll-added').insertAfter($(".otherclass").html());
            $('.jscroll-added').remove();

        });
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

        $(document).ready(function () {

            $("#searchTable").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                headers: {6: {// <-- replace 6 with the zero-based index of your column
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
                    }, filter_formatter: {
                        6: function ($cell, indx) {
                            return $.tablesorter.filterFormatter.select2($cell, indx, {
                                match: false // exact match only
                            });
                        }
                    }

                }

            });

        });
    </script>
</div>

