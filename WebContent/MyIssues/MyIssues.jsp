<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.issue.formbean.LastAssginForm"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, com.pack.StringUtil"%>
<%@ page import="pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate"%>
<%@ include file = "/include files/cacheRemover.jsp" %>
<%
    session.setAttribute("forwardpage", "/MyIssues/MyIssues.jsp");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("MyIssues");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<%@ include file="../header.jsp"%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
            <META NAME="Author" CONTENT="">
                <META NAME="Keywords" CONTENT="">
                    <META NAME="Description" CONTENT="">
                        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
                            <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
                            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
                            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
                            <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
                            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

                            <script type="text/javascript">
                                function showPrint(issueid) {
                                    window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
                                }



                            </script>
                            <script language="JavaScript">


                                function ValidateForm() {
                                    return true;
                                }


                                /** Java Script Function For Trimming A String To Get Only The Required String Input */

                                function trim(str) {
                                    while (str.charAt(str.length - 1) === " ")
                                        str = str.substring(0, str.length - 1);
                                    while (str.charAt(0) === " ")
                                        str = str.substring(1, str.length);
                                    return str;
                                }

                                /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

                                function isPositiveInteger(str) {
                                    var pattern = "E1234567890"
                                    var i = 0;
                                    do {
                                        var pos = 0;
                                        for (var j = 0; j < pattern.length; j++)
                                            if (str.charAt(i) === pattern.charAt(j)) {
                                                pos = 1;
                                                break;
                                            }
                                        i++;
                                    } while (pos === 1 && i < str.length)
                                    if (pos === 0)
                                        return false;
                                    return true;
                                }
                                var dtCh = "/";
                                var minYear = 1900;
                                var maxYear = 2100;

                                function isInteger(s) {
                                    var i;
                                    for (i = 0; i < s.length; i++)
                                    {
                                        var c = s.charAt(i);
                                        if (((c < "0") || (c > "9")))
                                            return false;
                                    }
                                    return true;
                                }

                                function stripCharsInBag(s, bag)
                                {
                                    var i;
                                    var returnString = "";
                                    for (i = 0; i < s.length; i++)
                                    {
                                        var c = s.charAt(i);
                                        if (bag.indexOf(c) === -1)
                                            returnString += c;
                                    }
                                    return returnString;
                                }

                                function daysInFebruary(year)
                                {
                                    return (((year % 4 === 0) && ((!(year % 100 === 0)) || (year % 400 === 0))) ? 29 : 28);
                                }
                                function DaysArray(n)
                                {
                                    for (var i = 1; i <= n; i++)
                                    {
                                        this[i] = 31;
                                        if (i === 4 || i === 6 || i === 9 || i === 11) {
                                            this[i] = 30;
                                        }
                                        if (i === 2) {
                                            this[i] = 29;
                                        }
                                    }
                                    return this;
                                }

                                function isDate(dtStr)
                                {
                                    var daysInMonth = DaysArray(12);
                                    var pos1 = dtStr.indexOf(dtCh);
                                    var pos2 = dtStr.indexOf(dtCh, pos1 + 1);
                                    var strMonth = dtStr.substring(3, 5);
                                    var strDay = dtStr.substring(1, 3);
                                    var strYear = dtStr.substring(5, 9);
                                    strYr = strYear;
                                    if (strDay.charAt(0) === "0" && strDay.length > 1)
                                        strDay = strDay.substring(1);
                                    if (strMonth.charAt(0) === "0" && strMonth.length > 1)
                                        strMonth = strMonth.substring(1);
                                    for (var i = 1; i <= 3; i++)
                                    {
                                        if (strYr.charAt(0) === "0" && strYr.length > 1)
                                            strYr = strYr.substring(1);
                                    }
                                    month = parseInt(strMonth);
                                    day = parseInt(strDay);
                                    year = parseInt(strYr);
                                    if (strMonth.length < 1 || month < 1 || month > 12)
                                    {
                                        alert("Please enter a valid Month in the Issue No(EDDMMYYYY001)");
                                        return false;
                                    }
                                    if (strDay.length < 1 || day < 1 || day > 31 || (month === 2 && day > daysInFebruary(year)) || day > daysInMonth[month])
                                    {
                                        alert("Please enter a valid Day  in the Issue No(EDDMMYYYY001)");
                                        return false;
                                    }
                                    if (strYear.length !== 4 || year === 0 || year < minYear || year > maxYear)
                                    {
                                        alert("Please enter a valid Year in the Issue No(EDDMMYYYY001)");
                                        return false;
                                    }
                                    var today = new Date;
                                    if (parseInt(today.getFullYear()) < year)
                                    {
                                        window.alert("Enter the valid Year in the Issue No(EDDMMYYYY001) ");
                                        return false;
                                    }
                                    if (parseInt(today.getFullYear()) === year)
                                    {
                                        //           alert(parseInt(today.getMonth())+1+"here"+month)
                                        if (month > (parseInt(today.getMonth()) + 1))
                                        {
                                            window.alert("Enter the valid Month in the Issue No(EDDMMYYYY001) ");
                                            return false;
                                        }
                                        if (month === (parseInt(today.getMonth()) + 1))
                                        {
                                            //alert(day+"here"+parseInt(today.getDate()));
                                            if (day > parseInt(today.getDate()))
                                            {
                                                window.alert("Enter the valid Day in the Issue No(EDDMMYYYY001) ");
                                                return false;
                                            }
                                        }
                                    }
                                    return true;
                                }

                                /** Function To Validate The Input Form Data */

                                function fun(theForm) {



                                    /** This Loop Checks Whether There Is Any Integer Present In The Company Field */

                                    if (!isPositiveInteger(trim(theForm.issueid.value))) {
                                        alert('Enter Issue NO in proper format like EDDMMYYYY001');
                                        document.theForm.issueid.value = "";
                                        theForm.issueid.focus();
                                        return false;
                                    }
                                    if (!isDate(trim(theForm.issueid.value))) {

                                        document.theForm.issueid.value = "";
                                        theForm.issueid.focus();
                                        return false;
                                    }


                                    if ((trim(theForm.issueid.value).length) < 12) {
                                        alert('Size of the Issue No should be 12 characters ');
                                        document.theForm.issueid.value = "";
                                        theForm.issueid.focus();
                                        return false;
                                    }
                                    if ((trim(theForm.issueid.value).length) > 12) {
                                        alert('Size of the Issue No should be 12 characters ');
                                        document.theForm.issueid.value = "";
                                        theForm.issueid.focus();
                                        return false;
                                    }

                                    if ((theForm.issueid.value === null) || (theForm.issueid.value === ""))
                                    {
                                        alert("Please Enter the Issue Number");
                                        theForm.issueid.focus();
                                        return false;
                                    }
                                    if (isDate(theForm.issueid.value) === false) {
                                        return false;
                                    }
                                    disableSubmit();
                                    return true;
                                }

                                /** Function To Set Focus On The First Name Field In The Form */

                                function setFocus() {
                                    document.theForm.issueid.focus();
                                }

                                window.onload = setFocus;

                                // window.onload = pageloadingtime;
                            </script>
                            </HEAD>

                            <style fprolloverstyle>
                                A:hover {
                                    color: #FF0000;
                                    font-weight: bold
                                }
                            </style>

                            <BODY BGCOLOR="#FFFFFF">
                                <form name="theForm" onsubmit="return fun(this);" action="<%= request.getContextPath()%>/Issuesummaryview.jsp">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr border="2" bgcolor="#E8EEF7">
                                            <td bgcolor="#E8EEF7" border="1" align="left"><font size="4" COLOR="#0000FF"> <b> My Issues </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                                            <td align="right"><b>Enter the Issue Number:</b></td>
                                            <td align="left"><input type="text" name="issueid" maxlength="12" size="15"></td>
                                            <td><input type="submit" name="submit" id="submit" value="Search"></td>
                                            <td width="25%" border="1" align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Export to <a href="<%=request.getContextPath()%>/excelExport.jsp?export=MyIssue" target="_blank">Excel</a></font></td>
                                        </tr>

                                    </table>
                                </form>

                                <br/>

                                <jsp:useBean id="mi" class="com.eminent.issue.formbean.MyIssues" /> 
                                <%mi.setAll(request);
                                    String team = (String) session.getAttribute("team");
                                    String mail = (String) session.getAttribute("theName");
                                    String url = null;
                                    if (mail != null) {
                                        url = mail.substring(mail.indexOf("@") + 1, mail.length());
                                    }
                                %>

                                <table width="100%">
                                    <tr height="10">
                                        <td width="80%">&nbsp;</td>

                                        <TD align="right" width="25">Severity</TD>
                                        <TD align="right" width="25" bgcolor="#FF0000">S1</TD>
                                        <TD align="right" width="25" bgcolor="#DF7401">S2</TD>
                                        <TD align="right" width="25" bgcolor="#F7FE2E">S3</TD>
                                        <TD align="right" width="25" bgcolor="#04B45F">S4</TD>
                                    </tr>
                                </table>
                                <br/>
                                <div class="tablecontent">
                                    <TABLE width="100%" id="searchTable" class="tablesorter">
                                        <thead>
                                            <TR bgcolor="#C3D9FF" height="21">
                                                <TH width="1%" TITLE="Severity" class="filter-false"><font><b>S</b></font></TH>
                                                <TH width="10%"><font><b>Issue No</b></font></TH>
                                                <TH width="2%" TITLE="Priority" class="filter-false"><font><b>P</b></font></TH>
                                                <TH width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></TH>
                                                <TH width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></TH>
                                                <TH width="28%"><font><b>Subject</b></font></TH>
                                                <TH width="9%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></TH>
                                                <TH width="8%" class="filter-false"><font><b>Due Date</b></font></TH>
                                                <TH width="13%" class="filter-select filter-match" data-placeholder="Select AssignTo"><font><b>AssignedTo</b></font></TH>
                                                <TH width="8%" class="filter-false"><font><b>Refer</b></font></TH>
                                                <TH width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TH>

                                            </TR>
                                        </thead>
                                        <tbody>
                                            <%int i = 1;
                                                for (IssueFormBean isfb : mi.getIssuesList()) {
                                                    if ((i % 2) != 0) {
                                            %>
                                            <tr class="zebralinealter" height="28" style="padding: 5px;">
                                                <%} else {%>
                                                <tr class="zebraline" height="28" style="padding: 5px;">
                                                    <%}
                                                        i++;%>

                                                    <td class="background" style="background: <%=isfb.getSeverity()%>"></td>
                                                    <input type="hidden" id="sorton" name="sorton"/>
                                                    <input type="hidden" id="sort_method" name="sort_method"/>
                                                    <td  class="background"title="<%=isfb.getType()%>"> <a href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible"><%=isfb.getIssueId()%>
                                                        </a>
                                                    </td>
                                                    <td class="background"><%=isfb.getPriority()%></td>
                                                    <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                                                    <td class="background" width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                                                    <td class="background"  id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                                                    <td class="background" onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
                                                    <td class="background"  title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                                                    <td class="background" title="Assignedby <%=isfb.getLastAssigneeName()%> at <%=isfb.getLastModifiedOn()%>"><%=isfb.getAssignto()%></td>
                                                    <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                                                    <td class="background"><%=isfb.getRefer()%></td>
                                                    <%} else {%>
                                                    <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                                                        <%}%>
                                                    <td class="background" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>

                                                <%
                                                    }%>
                                        </tbody></TABLE>
                                    <!--<div class="next jscroll-next-parent"><a class="jscroll-next" href="<%=request.getContextPath()%>/MyIssues/myIssueNext.jsp?pageNumber=2">next</a></div>
                                    -->
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
                            </BODY>
                            <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

                            <SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.jscroll.js"></SCRIPT>

                            <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
                            <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
                            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
                                <script type="text/javascript">

                                                /*  $(document).ready(function () {
                                                 $('.tablecontent').jscroll({
                                                 padding: 20,
                                                 loadingHtml: '<img class="imgloader" src="<%=request.getContextPath()%>/images/ajax-loader_1.gif"/>',
                                                 contentLoader: '.tablecontent #searchTable tbody tr:last',
                                                 nextSelector: 'a.jscroll-next:last'
                                                 });
                                                 });
                                                 
                                                 */
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

                                                function callissue(issueid) {
                                                    var d = new Date();
                                                    var n = d.getHours();
                                                    var team = '<%=team%>';
                                                    var mail = '<%=url%>';
                                                    var sorton;
                                                    var sort_method;
                                                    var headerSortDown = $('.tablesorter-headerAsc').text();

                                                    var headerSortUp = $(".tablesorter-headerDesc").text();

                                                    if (headerSortDown.length > 0) {
                                                        sorton = headerSortDown;
                                                        sort_method = "headerSortDown";
                                                    } else if (headerSortUp.length > 0) {
                                                        sorton = headerSortUp;
                                                        sort_method = "headerSortUp";
                                                    }

                                                    document.getElementById("sorton").value = sorton;
                                                    document.getElementById("sort_method").value = sort_method;

                                                    if (mail === 'eminentlabs.net') {
                                                        if (n > 8 && n < 18) {
                                                            var result;
                                                            $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkPlannedSeq.jsp',
                                                                data: {issueid: issueid, random: Math.random(1, 10)},
                                                                async: true,
                                                                type: 'GET',
                                                                success: function (data) {
                                                                    result = $.trim(data);
                                                                }, complete: function () {
                                                                    if (result === '') {
                                                                        location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyIssues&planSeq=yes';
                                                                    } else {
                                                                        alert(result);
                                                                    }
                                                                }
                                                            });
                                                        } else {
                                                            location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyIssues&planSeq=yes';
                                                        }
                                                    } else {
                                                        location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyIssues&planSeq=yes';

                                                    }
                                                }

                                </script>
                                </HTML>
