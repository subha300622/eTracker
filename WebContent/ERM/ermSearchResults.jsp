<%-- 
    Document   : ermSearchResults
    Created on : Feb 18, 2014, 12:35:54 PM
    Author     : E0288
--%>

<%@page import="java.net.URLEncoder"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminentlabs.erm.MyQuery"%>
<%@page import="com.eminentlabs.erm.ERMSearchResults"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("ermSearchResults");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
     <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
</head>
<body>
    <jsp:useBean id="esr" class="com.eminentlabs.erm.ERMSearchResults"></jsp:useBean>
       <%  esr.getQuery(request);
        List<ERMSearchResults> applicantList = esr.getErmSearch(esr.getQuery(), request);
    %>

    <br/>
    <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>
                        ERM Issues Search Result </b></font> </td>
        </tr>
    </table>
    <br/>
  
    <form method="POST" action="<%=request.getContextPath()%>/ERM/ermSearchSave.jsp">
        <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager" colspan="7" style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="6" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF">
                    <th ><font><b>Photo</b></font></th>
                    <th ><font><b>Ap ID</b></font></th>
                    <th ><font><b>Name</b></font></th>
                    <th class="filter-select filter-match" data-placeholder="Select a Employer"><font><b>Employer</b></font></th>
                    <th ><font><b>Mobile</b></font></th>
                    <th  class="filter-select filter-match" data-placeholder="Select a Location" ><font><b>Location</b></font></th>
                    <th  class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></th>
                    <th  class="filter-select filter-match" data-placeholder="Select a Ref"><font><b>Ref ID</b></font></th>
                    <th  class="filter-select filter-match" data-placeholder="Select a Education"><font><b>Education</b></font></th>
                    <th  class="filter-select filter-match" data-placeholder="Select a Skills"><font><b>Skills</b></font></th>
                    <th ><font><b>Total Exp</b></font></th>
                    <th ><font><b>SAP Exp</b></font></th>
                    <th  class="filter-select filter-match" data-placeholder="Select a Assigned"><font><b>Assigned To</b></font></th>
                </TR>
            </thead>
            <tbody>
            <%

                for (ERMSearchResults ep : applicantList) {

            %>
            <tr >
               <td><a href="<%=request.getContextPath()%>/ERM/viewApplicantDetails.jsp?apid=<%=ep.getApplicantId()%>">                    
                        <img width="120px" height="100px" src="<%=request.getContextPath()%>/Etracker_AttachedFiles/userPhotos/<%=ep.getPhotoPath()%>" onerror="if (this.src != '<%=request.getContextPath()%>/images/avator1.png') this.src = '<%=request.getContextPath()%>/images/avator1.png';">
                    </a>
                </td>
                <td><a href="<%=request.getContextPath()%>/admin/candidate/viewdetails.jsp?apid=<%=ep.getApplicantId()%>"><%=ep.getApplicantId()%></a></td>
                <td ><a target="_blank" href="<%=request.getContextPath()%>/Resume/<%=ep.getFileName()%>" title="Resume"><%=ep.getName()%></a>
                 <%if(ep.getIsFake()==1){%>
                <img src="<%=request.getContextPath()%>/images/mask.png" alt="Fake Candidate" title="Fake Candidate" style="height: 15px;vertical-align: bottom;">
                <%}%>
                </td>
                <td><%=ep.getEmployer()%></td>
                <td><%=ep.getMobile()%></td>
                <td><%=ep.getLocation()%></td>
                <td><%=ep.getAplstatus()%></td>
                <td title="<%=ep.getRefName()%>"><%=ep.getRefId()%></td>
                <td><%=ep.getEducation()%></td>
                <td><%=ep.getSkills()%></td>
                <td><%=ep.getTotalExp()%></td>
                <td><%=ep.getSapExp()%></td>                    
                <td>
                    <%if (ep.getAssignedTo().length() > 9) {%>
                    <%=ep.getAssignedTo().substring(0, 9) + ".."%>
                    <%} else {%>
                    <%=ep.getAssignedTo()%>
                    <%}%>
                </td>
            </tr>

            <%}
            %>
</tbody>
        <tfoot>
            <tr>
                <td colspan="13" style="background-color: #c3d9ff;">
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
        <table style="width: 100%;text-align: center;">
            <tr>
                <td><input type="hidden" name="querystring" value="<%=esr.getEncodedQuery()%>"></td>
                <td>
                    <%if (esr.getqId() != 0l) {%>
                    <input type="hidden" name="editQueryId" value="<%=esr.getqId()%>">
                    <%}%>
                    <%if (esr.getButtonvalue() != null) {%>
                    <input type="submit" name="submit" value="<%=esr.getButtonvalue()%>">
                    <%}%>
                </td>
            </tr>
        </table>
    </form>
 <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
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