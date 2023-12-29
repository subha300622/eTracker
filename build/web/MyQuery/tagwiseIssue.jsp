<%-- 
    Document   : tagwiseIssue
    Created on : 24 Jun, 2016, 3:30:35 PM
    Author     : admin
--%>

<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="dashboard.CheckDate"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file = "/include files/cacheRemover.jsp" %>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<style fprolloverstyle>
    a:hover {
        color: #FF0000;
        font-weight: bold
    }
</style>
<jsp:useBean id="tagc" class="com.eminent.tags.TagIssueController"></jsp:useBean>
<%
    tagc.getAllIssueByTag(request);
    Map<String, String> serVartiyColor = tagc.getServrityMap();
    int roleId = (Integer) session.getAttribute("Role");
    if (tagc.getListIssueFormBean().isEmpty()) {
%>
<div><b>NO Issue under this tag</b></div>
<%} else {%>
<div class="tablecontent">

    <div>
        <div style="float:left;width: 45%">
            Display total:<b><%=tagc.getListIssueFormBean().size()%></b>  Issues 
        </div>
        <div style="float: left;width: 40%;">
            <input type="button" id="addIssueToTag" value="Add Issue In Tag"><span id="errormsg"></span>
        </div>
        <div  style="float:right;width: 12%;">
            <span>Severity</span>
            <span style="background:#FF0000">S1</span>
            <span style="background:#DF7401">S2</span>
            <span style="background:#F7FE2E">S3</span>
            <span style="background:#04B45F">S4</span>
        </div>
    </div>
    <br/>
    <TABLE width="100%" id="filtersort" class="tablesorter">
        <thead>
            <TR style="background-color:#C3D9FF">
                <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                <td width="11%" ><font><b>Issue No</b></font></td>
                <td width="3%" class="filter-false"><font><b>P</b></font></td>
                <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                <td width="25%" ><font><b>Subject</b></font></td>
                <td width="12%" class="filter-select filter-match" data-placeholder="Select a status" ><font><b>Status</b></font></td>
                <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                <td width="13%" class="filter-select filter-match" data-placeholder="Select Created By"><font><b>Assigned To</b></font></td>
                <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
            </TR>
        </thead>


        <tbody>
            <%      int i = 0;
                for (IssueFormBean issueFormBean : tagc.getListIssueFormBean()) {
                    i++;
                    if ((i % 2) != 0) {
            %>
            <tr class="zebralinealter" height="21">
                <%
                } else {
                %>

            <tr class="zebraline" height="21">
                <%
                    }
                %>

                <%
                    for (Map.Entry<String, String> entrySet : serVartiyColor.entrySet()) {

                        if (issueFormBean.getSeverity().equalsIgnoreCase(entrySet.getKey())) {%>
                <td style="background-color: <%=entrySet.getValue()%>">&nbsp; </td>
                <% }
                    }

                    if (roleId == 1) {
                %>
                <td class="background"  title="<%=issueFormBean.getType()%>"><a  href="<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=<%=issueFormBean.getIssueId()%>"><%= issueFormBean.getIssueId()%></a></td>

                <%
                } else {
                %>
                <td  class="background"  title="<%=issueFormBean.getType()%>"><input type="checkbox" name="check" class="checkIssue"  value="<%=issueFormBean.getIssueId()%>" checked="true"/><a  href="<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=issueFormBean.getIssueId()%>" ><%= issueFormBean.getIssueId()%></a></td>
                    <%
                        }
                        String priority = issueFormBean.getPriority().substring(0, 2);
                    %>
                <td class="background" ><%= priority%></font></td>

                <td class="background"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= issueFormBean.getpName()%></font></td>

                <td class="background" width="8%" title="<%=issueFormBean.getmName()%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">
                    <% String module = issueFormBean.getmName();
                        if (module.length() > 10) {
                            module = module.substring(0, 10) + "...";
                        }%> 
                    <%= module%>
                    </font></td>
                <td class="background" id="<%=issueFormBean.getIssueId()%>tab" onmouseover="xstooltip_show('<%=issueFormBean.getIssueId()%>', '<%=issueFormBean.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=issueFormBean.getIssueId()%>');" ><div class="issuetooltip" id="<%=issueFormBean.getIssueId()%>"><%= issueFormBean.getDescription()%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= issueFormBean.getSubject()%></font></td>
                <td class="background"  onclick="showPrint('<%=issueFormBean.getIssueId()%>');" style="cursor: pointer;background-color: <%=issueFormBean.getRatingColor()%>"><%= issueFormBean.getStatus()%></font></td>

                <%

                    String dueDate = issueFormBean.getDueDate();
                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
                <td class="background" ><font face="Verdana, Arial, Helvetica, sans-serif"
                                              size="1" color="RED"><%= dueDate%></font></td>
                    <%
                    } else {
                    %>
                <td class="background" ><font face="Verdana, Arial, Helvetica, sans-serif"
                                              size="1" color="#000000"><%= dueDate%></font></td>
                    <%
                        }
                        int asign = MoMUtil.parseInteger(issueFormBean.getAssignto(), 0);
                        String assignto = (String) tagc.getUserMap().get(asign);
                    %>
                <td class="background"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= assignto%>
                    </font></td>



                <%

                    int count = 0;
                    if (tagc.getFileCountList().containsKey(issueFormBean.getIssueId())) {
                        count = tagc.getFileCountList().get(issueFormBean.getIssueId());
                    }
                    if (count > 0) {
                %>
                <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <a onclick="viewFileAttachForIssue('<%=issueFormBean.getIssueId()%>')" href="javascript:void(0)">View Files(<%=count%>)</a></font></td>
                    <%
                    } else {
                    %>
                <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                    <%
                        }
                        int age = 0;
                        for (Map.Entry<String, Integer> entrySet : tagc.getAgeofIssue().entrySet()) {
                            if (entrySet.getKey().equalsIgnoreCase(issueFormBean.getIssueId())) {
                                age = entrySet.getValue();
                            }
                        }
                        int lastAsigneeAge = 1;
                        if (tagc.getLastAsigneeAgeList().containsKey(issueFormBean.getIssueId())) {
                            lastAsigneeAge = tagc.getLastAsigneeAgeList().get(issueFormBean.getIssueId());
                        }
                        if (lastAsigneeAge == 1) {
                            lastAsigneeAge = age;
                        }
                        if (lastAsigneeAge == 0) {
                            lastAsigneeAge = lastAsigneeAge + 1;
                        }
                    %>
                <td class="background" title="<%=age%>"><%=lastAsigneeAge%></td>


            </tr>
            <%

                }
            %>
        </tbody>
    </table>

</div>

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

<%}%>

<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
<SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.jscroll.js"></SCRIPT>

<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">

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
                $(document).ready(function ()
                {
                    // call the tablesorter plugin
                    $(".tablesorter").tablesorter({
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
                            },
                            filter_formatter: {
                                8: function ($cell, indx) {
                                    return $.tablesorter.filterFormatter.select2($cell, indx, {
                                        match: false // exact match only
                                    });
                                }
                            }
                        }

                    });
                });

                $(".checkIssue").click(function () {
                    $('span.error2').remove();
                    var currThis = $(this);
                    var tag = $("#tagnames option:selected").val();
                    var issueId = $(this).val();
                    if (!$(this).is(':checked')) {
                        $.ajax({
                            url: '<%=request.getContextPath()%>/IssueSummary/deleteIssueTag.jsp',
                            data: {tagId: tag, issueId: issueId, random: Math.random(1, 10)},
                            async: true,
                            type: 'Post',
                            success: function (responseText, statusTxt, xhr) {
                                if (statusTxt === "success") {
                                    var result = $.trim(responseText);
                                    if (result == "true") {
                                        $("<span class='error2' style='color:green'>Issue delete successfully</span>").insertAfter("#errormsg");
                                        $(currThis).prop("checked", false);
                                    } else {
                                        $(currThis).prop("checked", true);
                                        $("<span class='error2'>Please Try/Again</span>").insertAfter("#errormsg");
                                    }
                                } else {
                                    $(currThis).prop("checked", true);
                                    $("<span class='error2'>Please Try/Again</span>").insertAfter("#errormsg");
                                }
                            }
                        });

                    }
                });

                $('#addIssueToTag').click(function () {
                    $('span.error2').remove();
                    var selected = [];
                    $("input:checkbox[name=check]:checked").each(function () {
                        selected.push($(this).val());
                    });
                    var tag = $("#tagnames option:selected").val();
                    if (selected.length == 0) {
                        $("<span class='error2'>Select at least one issue</span>").insertAfter("#errormsg");
                    } else if (isNaN(parseInt(tag))) {
                        $("<span class='error2'>Select a tag </span>").insertAfter("#errormsg");
                        $("#tagnames").focus();
                    } else {
                        var issueids = "";
                        for (var i = 0, n = selected.length; i < n; i++) {
                            issueids += selected[i] + ",";
                        }

                        var create = 'Create';
                        $.ajax({
                            url: '<%=request.getContextPath()%>/admin/project/createTagIssue.jsp',
                            data: {action: create, tagId: tag, issueId: issueids, random: Math.random(1, 10)},
                            async: true,
                            type: 'Post',
                            success: function (responseText, statusTxt, xhr) {
                                if (statusTxt === "success") {
                                    $("<span class='error2' style='color:green'>Issues added successfully </span>").insertAfter("#errormsg");
                                } else {
                                    $("<span class='error2'>Please Try/Again</span>").insertAfter("#errormsg");
                                }
                            }
                        });
                    }
                });
</script>
