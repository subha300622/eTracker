<%-- 
    Document   : displayAllIssueAjax
    Created on : 26 May, 2016, 3:13:43 PM
    Author     : admin
--%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="dashboard.CheckDate"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=11" type="text/css" rel="STYLESHEET"/>

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">

        <title></title>
    </head>
    <body>
        <style fprolloverstyle>
            a:hover {
                color: #FF0000;
                font-weight: bold
            }
        </style>
        <jsp:useBean id="mydeshboard" class="dashboard.controller.MydashboardController"></jsp:useBean>
        <%
            mydeshboard.getDisplayAllIssue(request);
            Map<String, String> serVartiyColor = mydeshboard.getServrityMap();
            int roleId = (Integer) session.getAttribute("Role");
        
        %>
        <div class="tablecontent">

           <div>
               <div style="float:left;width: 80%">
                Display total:<b><%=mydeshboard.getListIssueFormBean().size()%></b>  Issues </b>
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
                        <td width="13%" class="filter-select filter-match" data-placeholder="Select Created By"><font><b>Created By</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>


                <tbody>
                    <%      int i = 0;
                        for (IssueFormBean issueFormBean : mydeshboard.getListIssueFormBean()) {
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
                        <td  class="background"  title="<%=issueFormBean.getType()%>"><a  href="<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=issueFormBean.getIssueId()%>"><%= issueFormBean.getIssueId()%></a></td>
                            <%
                                }
                            %>
                        <td class="background" ><%= issueFormBean.getPriority()%></font></td>

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
                         <td class="background"  onclick="showPrint('<%=issueFormBean.getIssueId()%>');" style="cursor: pointer;"><%= issueFormBean.getStatus()%></font></td>

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
                                int originator = MoMUtil.parseInteger(issueFormBean.getCreatedBy(), 0);
                                String creator = (String) mydeshboard.getUserMap().get(originator);
                            %>

                      
                        <td class="background"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= creator%>
                            </font></td>



                        <%

                            int count = 0;
                            if (mydeshboard.getFileCountList().containsKey(issueFormBean.getIssueId())) {
                                count = mydeshboard.getFileCountList().get(issueFormBean.getIssueId());
                            }
                            if (count > 0) {
                        %>
                        <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <a onclick="viewFileAttachForIssue('<%=issueFormBean.getIssueId()%>');" href="#;">View Files(<%=count%>)</a></font></td>
                            <%
                            } else {
                            %>
                        <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                            <%
                                }
                                int age = 0;
                                for (Map.Entry<String, Integer> entrySet : mydeshboard.getAgeofIssue().entrySet()) {
                                    if (entrySet.getKey().equalsIgnoreCase(issueFormBean.getIssueId())) {
                                        age = entrySet.getValue();
                                    }
                                }
                                int lastAsigneeAge = 1;
                                if (mydeshboard.getLastAsigneeAgeList().containsKey(issueFormBean.getIssueId())) {
                                    lastAsigneeAge = mydeshboard.getLastAsigneeAgeList().get(issueFormBean.getIssueId());
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
                        8: function($cell, indx) {
                            return $.tablesorter.filterFormatter.select2($cell, indx, {
                                match: false // exact match only
                            });
                        }
                    }
                    }

                });
            });
        </script>
    </body>
</html>