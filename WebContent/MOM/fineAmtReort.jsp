<%-- 
    Document   : fineAmtReort
    Created on : Aug 21, 2014, 9:37:19 AM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.formbean.FineAmountBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("Fine Amount Report");
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
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css">
        <script type="text/javascript">
            function trim(str)
            {
                while (str.charAt(str.length - 1) === " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) === " ")
                    str = str.substring(1, str.length);
                return str;
            }
            function isDate(str)
            {
                var pattern = "0123456789-";
                var i = 0;
                do
                {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) === pattern.charAt(j))
                        {
                            pos = 1;
                            break;
                        }
                    i++;
                }
                while (pos === 1 && i < str.length)
                if (pos === 0)
                    return false;
                return true;
            }
            function setDPDuration() {
                if (trim(document.theForm.fromdate.value) === '')
                {
                    alert("Please Enter the From Date ");
                    document.theForm.fromdate.focus();
                    return false;
                }
                if (!isDate(trim(theForm.fromdate.value)))
                {
                    alert('Please enter the valid From Date');
                    document.theForm.fromdate.value = "";
                    theForm.fromdate.focus();
                    return false;
                }
                if (trim(document.theForm.todate.value) === '')
                {
                    alert("Please Enter the To Date ");
                    document.theForm.todate.focus();
                    return false;
                }
                if (!isDate(trim(theForm.todate.value)))
                {
                    alert('Please enter the valid To Date');
                    document.theForm.todate.value = "";
                    theForm.todate.focus();
                    return false;
                }
                var str = document.theForm.fromdate.value;

                var first = str.indexOf("-");
                var last = str.lastIndexOf("-");
                var year = str.substring(last + 1, last + 5);
                var month = str.substring(first + 1, last);
                var date = str.substring(0, first);
                var form_date = new Date(year, month - 1, date);

                var str1 = document.theForm.todate.value;

                var first = str1.indexOf("-");
                var last = str1.lastIndexOf("-");
                var year = str1.substring(last + 1, last + 5);
                var month = str1.substring(first + 1, last);
                var date = str1.substring(0, first);
                var form_date1 = new Date(year, month - 1, date);

                if (form_date1 < form_date) {
                    alert('To Date cannot be less than From Date');
                    document.theForm.todate.value = "";
                    theForm.todate.focus();
                    return false;
                }
                disableSubmit();

            }

        </script>
        <script type="text/javascript">


            function calc() {
                var tbl = document.getElementById("filtersort");
                var rows = tbl.getElementsByTagName('tr');
                var totalAmount = document.getElementById('totalAmount');
                var amount = new Number();
                var len = rows.length;
                for (var m = 2; m < len; m++) {
                    if (rows[m].className === 'odd' || rows[m].className === 'even') {
                        var famount = tbl.rows[m].cells[3].innerHTML;
                        var famount1 = new Number(famount);
                        amount = amount + famount1;
                    }
                }
                totalAmount.innerHTML = "";
                totalAmount.innerHTML = amount;
            }
        </script>


        <script type="text/javascript">
            $(function() {
                // call the tablesorter plugin
                $("#filtersort").tablesorter({
                    theme: 'blue',
                    // hidden filter input/selects will resize the columns, so try to minimize the change
                    widthFixed: true,
                    // initialize zebra striping and filter widgets
                    widgets: ["zebra", "filter"],
                    // headers: { 5: { sorter: false, filter: false } },

                    widgetOptions: {
                        // extra css class applied to the table row containing the filters & the inputs within that row
                        filter_cssFilter: 'tablesorter-filter',
                        // If there are child rows in the table (rows with class name from "cssChildRow" option)
                        // and this option is true and a match is found anywhere in the child row, then it will make that row
                        // visible; default is false
                        filter_childRows: false,
                        // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                        // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                        filter_hideFilters: true,
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
                        }

                    }


                });
            });
        </script>



    </head>
    <body onload="calc();">
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="far" class="com.eminentlabs.mom.FineAmtReport"></jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 

    <%
       int wrmSize= mas.wrmIssues().size();
   far.setAll(request);%>

        <%int assignedto = (Integer) session.getAttribute("userid_curr");%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b> Fine Amount Report</b></font>
                </td>
            </tr>
        </table>

        <table cellpadding="0" cellspacing="0" width="100%" >

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                    <%if (far.getModList().contains(((Integer) assignedto).toString())) {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Add Fine</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/FinePayment.jsp" style="cursor: pointer;">Fine Collection</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addReason.jsp" style="cursor: pointer; ">Reason Maintain</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer; font-weight: bold;">Fine Amount </a> &nbsp;&nbsp;&nbsp;               
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues  (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;

                </td>
            </tr>
        </table>

        <form name="theForm" onsubmit='return setDPDuration(this);' action="fineAmtReort.jsp" method="post">
            <table bgcolor="E8EEF7"  style="width: 100%;">
                <tr>
                    <td style="font-weight: bold;width: 24%;">Select Duration : </td>
                    <td style="width: 5%;"><B>From</B></td>

                    <td style="width: 15%;">

                        <input type="text" id="fromdate" name="fromdate" value="<%=far.getStartDate()%>" maxlength="10" size="10" readonly  /><a href="javascript:NewCal('fromdate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a>
                    </td>
                    <td style="width: 2%;text-align: right;"><B>To</B></td>
                    <td style="width: 20%;">
                        <input type="text" id="todate" name="todate" value="<%=far.getEndDate()%>"  maxlength="10" size="10" readonly  /><a href="javascript:NewCal('todate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                    <td><input type="submit" name="submit" id="submit" value="Search"></td>
                </tr>
            </table>
        </form>    <br/>
        <div>

            The below list shows fine amount from <b><%=far.getStartDate()%> to <%=far.getEndDate()%></b></div>
        <br/>
        <!--        <table align="left"  border="1" style="width: 50%;height:21px;border-collapse: collapse;border: 1px lightblue;"><tr  ><td style="font-weight:bold;width:50%;text-align: center;color: blue;">Total Fine Amount</td>
                        <td style="width:40%;color: blue;font-weight: bold;" id="totalAmount"></td></tr></table>
        
                <br/>        -->
        <%if (far.getResult() != null) {
                if (far.getResult().equalsIgnoreCase("success")) {
        %>
        <div style="text-align: center; color: green; font-weight: bold;  ">

            <p style="alignment-adjust: central"> Fine Amount Revoked Successfully.</p>
        </div>
        <%}
            }%>

        <br/>
        <%if (!far.getFineList().isEmpty()) {%>
        <table width="100%" align="left"  class="tablesorter" id="filtersort">
            <thead>
                <tr style="background-color: #C3D9FF;" >
                    <td width="30%"  class="filter-select filter-match" data-placeholder="Select a Name" ><b>Name</b></td>
                    <td width="10%" class="filter-select" data-placeholder="Select a Reason"><b>Reason</b></td>
                    <td width="10%" data-placeholder="Select Date" class="filter-select"><b>Date</b></td>
                    <td width="10%" class="filter-false"><b>Amount</b></td>
                </tr>
            </thead>
            <tbody>

                <% int i = 0, j = 2;

                    for (FineAmountBean amtList : far.getFineList()) {

                        if ((i % 2) != 0) {
                %>


                <tr bgcolor="#E8EEF7" height="21">
                    <%} else {%>
                <tr bgcolor="white" height="21">
                    <%                    }
                        i++;%>
                    <td style="width:30%;"><%=amtList.getName()%></td>
                    <td style="width:35%;"><%=amtList.getReason()%></td>
                    <td style="width:20%;"><%=amtList.getDate()%></td>

                    <td style="width:15%;" id="<%=j%>amount">
                        <%if (far.getRevokeUsers().contains(((Integer) assignedto).toString())) {
                        %>
                        <a href="<%=request.getContextPath()%>/MOM/fineAmtRevoke.jsp?fineId=<%=amtList.getFineId()%>&sDate=<%=far.getStartDate()%>&eDate=<%=far.getEndDate()%>" > <%=amtList.getAmount()%></a>
                        <%} else {%>
                        <%=amtList.getAmount()%>
                        <%}%>
                </tr>              </td>

                <%j++;
                    }%>
            </tbody>
        </table>

        <%}%>

    </body> 
    <script type="text/javascript">

        $(".tablesorter-filter").attr("onchange", "calc()");
    </script>
</html>
