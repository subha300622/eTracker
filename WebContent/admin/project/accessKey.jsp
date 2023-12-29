<%-- 
    Document   : gstLogs
    Created on : Mar 17, 2020, 09:33:02 AM
    Author     : E307-Muthu
--%>

<%@page import="dashboard.CountIssue"%>
<%@page import="com.eminent.gstn.AccessKey"%>
<%@page import="com.eminent.gstn.LogDetail"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.mom.formbean.FinePaymentBean"%>
<%@page import="com.eminentlabs.mom.formbean.FineAmountBean"%>
<%@page import="com.eminentlabs.mom.formbean.FineReportBean"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="org.apache.log4j.Logger"%>
<%@  taglib  prefix="c"   uri="http://java.sun.com/jstl/core"  %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("accessKey");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   
 <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>   
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-jui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css?test=3">
    <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <link href="<%=request.getContextPath()%>/multiple-select.css?test=1" rel="stylesheet"/>
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>


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
        $(function () {
            // call the tablesorter plugin
            $("#filtersort").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                headers: {
                    4: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMyy'
                    }, 5: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMyyHHmmss'
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
                        4: function ($cell, indx) {
                            return $.tablesorter.filterFormatter.uiDateCompare($cell, indx, {
								 dateFormat: "dd-mm-yy",
            cellText : 'Dates', // text added before the input
            compare : [ '', '=', '>=', '<=' ],
            selected : 4,
            // jQuery UI datepicker options
            // defaultDate : '1/1/2014', // default date
            changeMonth : true,
            changeYear : true


                            });
                        },
                        5: function ($cell, indx) {
                            return $.tablesorter.filterFormatter.uiDateCompare($cell, indx, {
                                dateFormat: "dd-mm-yy",
                                cellText: 'Dates', // text added before the input
                                compare: ['', '=', '>=', '<='],
                                selected: 5,
                                // jQuery UI datepicker options
                                // defaultDate : '1/1/2014', // default date
                                changeMonth: true,
                                changeYear: true

                            });
                        },
                    }


                }

            });
        });

    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>

    <jsp:useBean id="akc" class="com.eminent.gstn.AccessKeyController"></jsp:useBean>
    <% int roleId = (Integer) session.getAttribute("Role");
  akc.setAll(request);%>



    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF">
            <td border="1" align="left" width="70%">
                <font size="4" COLOR="#0000FF"><b> Access Key Maintenance </b></font>
            </td>

        </tr>
    </table>
  <%  if (roleId == 1) {        %> 

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
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">Attached Images</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;font-weight: bold;">GST 3in1 Cockpit</a>
            </td>
            <td></td>
        </tr>
    </table>
	  <% }   %> 

    <br/>

    <%if (akc.getMessage() != null) {%>
    <div class="message" style="">
        <%=akc.getMessage()%> <br/>
    </div>

    <%   }%> 

    <form name="form" action="<%=request.getContextPath()%>/admin/project/accessKey.jsp"  method="post" onSubmit="return validate();">

        <table width="70%" bgColor=#E8EEF7 border="0" align="left">
            <tr>
                <td><strong>Project Name </strong></td>
                <td>
                    <select name="projectName" required="" id="projectName"  class="textbox_NoWidth" >
                        <option value="">Select</option>
                        <%for (String typ : CountIssue.getAllSAPProject()) {%>                                        
                        <option <%if (typ.equalsIgnoreCase(akc.getProject())) {%> selected=""<%}%> ><%=typ%></option>
                        <%}%>                                  
                    </select>
                </td>
            </tr>

            <tr>
                <td><strong>Server </strong></td>
                <td>   
                    <select name="server" required="" id="serevr"  class="textbox_NoWidth" >
                        <option value="">Select</option>
                        <%for (String typ : akc.getServerType()) {%>                                        
                        <option <%if (typ.equalsIgnoreCase(akc.getServer())) {%> selected=""<%}%> ><%=typ%></option>
                        <%}%>                                  

                    </select>
                </td>
            </tr>

            <tr>
                <td><strong>Access Type </strong></td>
                <td>   
                    <select name="type" required="" id="type"  class="textbox_NoWidth" multiple="">
                        <%for (String typ : akc.getAccessType()) {
                                int count = 0;
                                for (String accType : akc.getAccessTypes()) {
                                    if (count == 0) {
                                        if (typ.equalsIgnoreCase(accType)) {
                                            count++;
                                        }
                                    }
                                }
                                if (count > 0) {
                        %>                                        
                        <option selected=""><%=typ%></option>
                        <%} else {%>                                  
                        <option><%=typ%></option>
                        <%   }
                        }%>
                    </select> 
                </td>
            </tr>


            <tr>
                <td>&nbsp;</td>
                <td><input type="submit" value="Submit" id="submit" name="submit" > 
                    <input type="reset" id="reset" value=" Reset "></td>
            </tr>             
        </table>

    </form>
    <%if (!akc.getAccessKeys().isEmpty()) {%>
    <br/>
    <div class="tablecontent" style="width: 100%;">
        <table style="width: 100%;" class="tablesorter" id="filtersort">
                <thead>
                    <TR bgcolor="#C3D9FF">
                <th class="filter-select filter-match" data-placeholder="Select a Project" style="color: black;">Project Name</th>
                <th class="filter-select filter-match" data-placeholder="Select a Server" style="color: black;">Server</th>
                <th class="filter-select filter-match" data-placeholder="Select a Type" style="color: black;">Access Types</th>
                <th class="header filter-false" style="color: black;">Access Key</th>
                <th  data-sorter="shortDate" data-date-format="ddmmyyyy" style="text-align: left;">Expire Date</th>
               <td  data-sorter="shortDate" data-date-format="ddmmyyyy" style="text-align: left;">Updated On</th>
            </tr>
        </thead>
        <tbody>
            <%for (AccessKey ak : akc.getAccessKeys()) {%>
            <tr height="23">
                <td class="background"> <%=ak.getProjectName()%></td>
                <td class="background"><a href="<%=request.getContextPath()%>/admin/project/accessKey.jsp?accessId=<%=ak.getKeyId()%>&projectName=<%=ak.getProjectName()%>&server=<%=ak.getServerType()%>"><%=ak.getServerType()%></a></td>
                <td class="background"><a href="<%=request.getContextPath()%>/admin/project/accessKey.jsp?accessId=<%=ak.getKeyId()%>"><%=ak.getAccessType()%></a></td>
                <td class="background"><%=ak.getAccessKey()%></td>
                <td class="background"> <fmt:formatDate pattern="dd-MM-yyyy" value="<%=ak.getExpiryDate()%>"></fmt:formatDate></td>
                <td class="background"><fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="<%=ak.getChangedOn()%>"></fmt:formatDate></td>
            </tr>
            <%}%>
        </tbody>
    </table>
	</div>
    <%}%>


 
    <script>
        $('#type').multipleSelect({
            filter: true,
            maxHeight: 150,
            width: 250

        }
        );

     
    </script>
</body>
</html>
