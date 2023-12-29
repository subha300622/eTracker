<%-- 
    Document   : crmCompany
    Created on : 20 Nov, 2019, 7:44:56 PM
    Author     : Muthu
--%>


<%@page import="java.util.Map"%>
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

    <jsp:useBean id="csr" class="com.eminentlabs.crm.CRMUtil"></jsp:useBean>
    <jsp:useBean id="cs" class="com.eminentlabs.crm.CRMSearch"></jsp:useBean>
    <%if (cs.getAl().containsKey(((Integer) assignedto).toString())) {
    %>

    <%Map<String, List<CRMSearchBean>> searchList = csr.getAllBycompany(request);

    %>

    <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>
                    CRM Search Result </b></font> </td>
        </tr>
    </table>
    <br/>

    <%
    if (!searchList.get("contact").isEmpty()) {%>
    <div>

        <table width=100% id="user" class="tablesorter">
            <thead>
              
                <tr  >

                    <th  width="10%"><font><b>Name</b></font></th>
                    <th width="18%" class="filter-select filter-match" data-placeholder="Select a Account"><font><b> Account</b></font></th>
                    <th width="11%"><font><b>Phone</b></font></th>
                    <th width="10%"><font><b>Email</b></font></th>
                    <th width="12%" class="filter-select filter-match" data-placeholder="Select a Owner"><font><b> Owner</b></font></th>
                    <th width="8%"><font><b>Due Date</b></font></th>
                    <th width="13%" class="filter-select filter-match" data-placeholder="Select a AssignedTO"><font><b>Assigned To</b></font></th>
                    <th  width="5%" TITLE="In Days" ALIGN="center" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>
                </tr>
            </thead>
            <tbody> 
                <% for (CRMSearchBean bean : searchList.get("contact")) {%>
                <tr  >
                    <td  title="<%=bean.getTitle()%>">
                        <a href="<%=request.getContextPath()%>/MyCRM/contactIssueView.jsp?contactid=<%=bean.getId()%>"><%=bean.getName()%>
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
                </tr>
                <%}%>
            </tbody>
            
        </table>
    </div>
    <%}%>


    <%if (!searchList.get("lead").isEmpty()) {%>
    <div>

        <table width=100% id="lead" class="tablesorter">
            <thead>
                               <tr  >

                    <th  width="10%"><font><b>Name</b></font></th>
                    <th width="18%" class="filter-select filter-match" data-placeholder="Select a Account"><font><b> Account</b></font></th>
                    <th width="11%"><font><b>Phone</b></font></th>
                    <th width="10%"><font><b>Email</b></font></th>
                    <th width="12%" class="filter-select filter-match" data-placeholder="Select a Owner"><font><b> Owner</b></font></th>
                    <th width="8%"><font><b>Due Date</b></font></th>
                    <th width="13%" class="filter-select filter-match" data-placeholder="Select a AssignedTO"><font><b>Assigned To</b></font></th>
                    <th  width="5%" TITLE="In Days" ALIGN="center" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>
                </tr>
            </thead>
            <tbody> 
                <% for (CRMSearchBean bean : searchList.get("lead")) {%>
                <tr  >
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
                </tr>
                <%}%>
            </tbody>            
        </table> 
    </div>
    <%}%>


    <%if (!searchList.get("opportunity").isEmpty()) {%>
    <div>

        <table width=100% id="opportunity" class="tablesorter">
            <thead>                
                <tr  >
                    <th  width="25%"><font><b>Opportunity Name</b></font></th>
                    <th  width="20%" class="filter-select filter-match" data-placeholder="Select a AssignedTO"><font><b>Assigned To</b></font></th>
                    <th  width="15%"><font><b>Deal Value</b></font></th>
                    <th  width="15%"><font><b>Close Date</b></font></th>
                    <th  width="15%"><font><b>Stage</b></font></th>
                </tr>
            </thead>
            <tbody> 
                <% for (CRMSearchBean bean : searchList.get("opportunity")) {%>
                <tr  >
                    <td width="25%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="opportunityIssueView.jsp?opportunityid=<%=bean.getId()%>"><%= bean.getName()%></A></font></td>
                    <td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getAssingedTo()%></font></td>
                    <td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getProbability()%></font></td>
                    <td width="15%" title="<%=bean.getModifiedon()%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=bean.getDuedate()%></font></td>
                    <td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= bean.getStatus()%></font></td>
                </tr>
                <%}%>
            </tbody>            
        </table>        
    </div>
    <%}%>



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

    <script type="text/javascript">




        $(document).ready(function () {

            
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
                    },
                    filter_formatter: {
                    }

                }

            });
        });
    </script>

    <style>        
        .tablesorter-blue tbody tr.odd > td {
            background-color: #E8EEF7;
        }
        .tablesorter-blue tbody tr.even > td {
            background-color: white;
        }
    </style>
</body>
</html>

