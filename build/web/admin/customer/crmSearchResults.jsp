<%-- 
    Document   : crmSearchResults
    Created on : Sep 16, 2014, 10:40:03 AM
    Author     : RN.Khans
--%>

<%@page import="com.pack.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.crm.CRMSearchBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Logger logger = Logger.getLogger("crmSearchResults");
    int assignedto = (Integer) session.getAttribute("userid_curr");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE html>
<html>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>

    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

</head>
<body>
    <%@ include file="/header.jsp"%>

    <jsp:useBean id="csr" class="com.eminentlabs.crm.CRMSearchResults"></jsp:useBean>
    <jsp:useBean id="cs" class="com.eminentlabs.crm.CRMSearch"></jsp:useBean>
    <%if (cs.getAl().containsKey(((Integer) assignedto).toString())) {
    %>

    <%
        session.setAttribute("forwardpage", "crmSearchResults.jsp");
        String crmType = "";
        if (request.getParameter("crmType") != null) {
            crmType = request.getParameter("crmType");
            csr.setQuery(request);
        } else if (session.getAttribute("crmType") != null) {
            crmType = (String) session.getAttribute("crmType");
            csr.setQuery((String) session.getAttribute("crmSearchQuery"));
        }

        List<CRMSearchBean> searchList = csr.getSearchQuery(csr.getQuery(), crmType);

        int count = 0;
    %>

    <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>
                    CRM Search Result </b></font> </td>
        </tr>
    </table>
    <br/>

    <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager" colspan="2" style="background-color: white">
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
                <%
                    if (crmType.equalsIgnoreCase("contact")) {
                        count = 8;
                %>
                <th  width="10%"><font><b>Name</b></font></th>
                <th width="18%" class="filter-select filter-match" data-placeholder="Select a Account"><font><b> Account</b></font></th>
                <th width="11%"><font><b>Phone</b></font></th>
                <th width="10%"><font><b>Email</b></font></th>
                <th width="12%" class="filter-select filter-match" data-placeholder="Select a Owner"><font><b> Owner</b></font></th>
                <th width="8%"><font><b>Due Date</b></font></th>
                <th width="13%" class="filter-select filter-match" data-placeholder="Select a AssignedTO"><font><b>Assigned To</b></font></th>
                <th  width="5%" TITLE="In Days" ALIGN="center" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>
                <%} else if (crmType.equalsIgnoreCase("lead")) {
                    count = 8;
                %>
                <th  width="15%"><font><b>Name</b></font></th>
                <th  width="20%" ><font><b>Company</b></font></th>
                <th  width="11%"><font><b>Phone</b></font></th>
                <th  width="18%"><font><b>Email</b></font></th>
                <th  width="10%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Lead Status</b></font></th>
                <th  width="8%"><font><b>Due Date</b></font></th>
                <th  width="13%" class="filter-select filter-match" data-placeholder="Select a AssignedTO"><font><b>Assigned To</b></font></th>
                <th  width="5%" TITLE="In Days" ALIGN="center" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>
                <%} else if (crmType.equalsIgnoreCase("opportunity")) {
                    count = 5;%>
                <th  width="25%"><font><b>Opportunity Name</b></font></th>
                <th  width="20%" class="filter-select filter-match" data-placeholder="Select a AssignedTO"><font><b>Assigned To</b></font></th>
                <th  width="15%"><font><b>Deal Value</b></font></th>
                <th  width="15%"><font><b>Close Date</b></font></th>
                <th  width="15%"><font><b>Stage</b></font></th>
                    <%} else if (crmType.equalsIgnoreCase("account")) {
                   count = 9; %>
                <th  width="20%"><font><b>Account Name</b></font></th>
                <th  width="10%"><font><b>Billing State</b></font></th>
                <th  width="12%"><font><b>Phone</b></font></th>
                <th  width="10%"><font><b>Type</b></font></th>
                <th  width="10%"><font><b>Deal Value</b></font></th>
                <th  width="13%"><font><b>Account Value</b></font></th>
                <th  width="12%"><font><b>Assigned To</b></font></th>
                <th  width="8%"><font><b>Due Date</b></font></th>
                <th  width="5%" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>
                    <%}%>
            </tr>
        </thead>
        <tbody> 
            <% for (CRMSearchBean bean : searchList) {%>
            <tr  height="9">
                <%if (crmType.equalsIgnoreCase("contact")) {%>
                <td  title="<%=bean.getTitle()%>">
                    <a href="<%=request.getContextPath()%>/admin/customer/editContact.jsp?contactid=<%=bean.getId()%>"><%=bean.getName()%>
                    </a>
                 <%if (bean.getContactType().equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (bean.getContactType().equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/>
                    <%}%>
                </td>
                <td>
                    <%=bean.getAccountName()%>
                </td>
                <td>
                    <%=bean.getPhone()%>
                </td>
                <td>
                    <%=bean.getEmail()%>
                </td>
                <td> <%=bean.getOwnerName()%> </td>
                <td> <%=bean.getDuedate()%> </td>
                <td> <%=bean.getAssingedTo()%> </td>
                <td style="text-align: center;">
                    <%=bean.getAge()%>
                </td>
                <%} else if (crmType.equalsIgnoreCase("lead")) {%>
                <td><A HREF="<%=request.getContextPath()%>/MyCRM/crmIssueView.jsp?leadid=<%=bean.getId()%>"><%=bean.getName()%></a>
                <%if (bean.getContactType().equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer Lead"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (bean.getContactType().equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker Lead"  style="cursor: pointer;height: 11px;"/>
                    <%}%>
                </td>
                <td> <%=bean.getCompany()%> </td>
                <td>
                    <%=bean.getPhone()%>
                </td>
                <td>
                    <%=bean.getEmail()%>
                </td>
                <td title="Rating : <%=bean.getRating()%>"> <%=bean.getStatus()%> </td>
                <td title="Last Modified On <%=bean.getModifiedon()%>"> <%=bean.getDuedate()%> </td>
                <td title="Ownername <%=bean.getOwnerName()%>"> <%=bean.getAssingedTo()%> </td>
                <td style="text-align: center;">
                    <%=bean.getAge()%>
                </td>
                <%} else if (crmType.equalsIgnoreCase("opportunity")) {%>
                <td width="25%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="opportunityIssueView.jsp?opportunityid=<%=bean.getId()%>"><%= bean.getName()%></A></font></td>
                <td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getAssingedTo()%></font></td>
                <td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getProbability()%></font></td>
                <td width="15%" title="<%=bean.getModifiedon()%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getDuedate()%></font></td>
                <td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getStatus()%></font></td>
                    <%} else if (crmType.equalsIgnoreCase("account")) {%>
                <td width="20%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="<%=request.getContextPath()%>/MyCRM/accountIssueView.jsp?accountid=<%=bean.getId()%>"><%=bean.getName()%></A></font></td>
                <td width="10%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getState()%></font></td> 
                <td width="12%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getPhone()%></font></td>
                <td width="10%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getStatus()%></font></td>
                <td width="10%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getDealValue()%></font></td>
                <td width="13%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getAmount()%></font></td>
                <td width="12%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getAssingedTo()%></font></td>
                <td width="8%" title="<%=bean.getModifiedon()%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getDuedate()%></font></td>
                <td width="5%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getAge()%></font></td>
                    <%}%>
            </tr>

            <%}%>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="<%=count%>" style="background-color: #c3d9ff;">
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

    <%} else {%>
    <div style="text-align: center; color: red;">          
        <p style="alignment-adjust: central"> You are not authorized to access this page.
        </p>
    </div>
    <%}%>


    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>

    <SCRIPT type="text/javascript" 	src="<%=request.getContextPath()%>/javaScript/jquery.min.js"></script>
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
