<%-- 
    Document   : industryMaintenance
    Created on : 21 APr, 2020, 2:38:15 PM
    Author     : Muthu
--%>



<%@page import="com.eminent.branch.Branches"%>
<%@page import="com.eminentlabs.wrm.User"%>
<%@page import="com.eminent.issue.ApmWrmDay"%>
<%@page import="com.eminent.bpm.BpmPrintaccess"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("industryMaintenance");
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


</head>
<%@ include file="/header.jsp"%>
<body>
   <table width="100%">
        <tr>
            <td colspan="3">
                <%int roleId = (Integer) session.getAttribute("Role");
                    if (roleId == 1) {
                %>
                <a href="<%=request.getContextPath()%>/admin/customer/crmPerformance.jsp" style="cursor: pointer">CRM Performance Chart</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <%}%>
                <a href="<%=request.getContextPath()%>/MyCRM/crmSummary.jsp">CRM Summary</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <a href="<%=request.getContextPath()%>/MyCRM/crmAnalysis.jsp" style="">CRM Analysis</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MyCRM/industryMaintenance.jsp" style="cursor: pointer;font-weight: bold;">Industry Maintenance</a> &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>

    <br>
    <br>
    <jsp:useBean id="mwd" class="com.eminentlabs.crm.controller.IndustryController"></jsp:useBean>
    <%mwd.setAll(request);%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Industry Maintenance</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br/>

    <div class="error">
        <span style="color: <%=mwd.getMessage()== null ? "red" : "green"%> ">  <%=mwd.getMessage()== null ? "" : mwd.getMessage()%> </span>
    </div>
    <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/MyCRM/industryMaintenance.jsp" onsubmit="disableSubmit();">
        <table width="100%" bgColor=#e8eef7 border="0">

            <tr>
                <td width="10%"><strong>Industry</strong></td>
                <td>
                    <input type="text" name="industryName" required="" style="width: 250px"  value="<%=mwd.getIndustryName() == null ? "" : mwd.getIndustryName()%>"/>
                </td>
            </tr>
            <tr >
                <td width="10%">&nbsp;</td>
                
                <td>
                       <%if (mwd.getIndustryId()!= null) {%>
                    <input type="hidden" name="industryId" value="<%=mwd.getIndustryId()%>"/>
                    <%}%>
                    <input type="submit" id="submit" value="Submit"/></td></tr>
        </table>
    </form>
    <%if (!mwd.getIndustries().isEmpty()) {%>
    <table width=100% id="user" class="tablesorter">
        <thead>
            <tr bgColor="#C3D9FF" height="9">
                <th ><font><b>Indusrty Id</b></font></th>
                <th ><font><b>Industry Name</b></font></th>

            </tr>
        </thead>
        <tbody>
            <%for (Map.Entry<Integer, String> entry : mwd.getIndustries().entrySet()) {%>
            <tr >
                <td ><a href="<%=request.getContextPath()%>/MyCRM/industryMaintenance.jsp?industryId=<%=entry.getKey()%>"><%=entry.getKey()%></a> </td>
                <td ><%=entry.getValue()%> </td>
            </tr>
            <%}%>
        </tbody>

    </table>
    <%}%>

    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script> 

    <script src="<%=request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <script type="text/javascript">




        $(document).ready(function () {



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
            });
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