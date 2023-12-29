<%-- 
    Document   : assignedApplicants
    Created on : Feb 14, 2014, 2:52:31 PM
    Author     : E0288
--%>

<%@page import="com.eminentlabs.erm.AssignedApplicants"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminentlabs.erm.ErmApplicant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("assignedApplicants");

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
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script type="text/javascript">
        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;
        var xmlhttp = createRequest();
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
        function trim(str) {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function isValidIssue(str) {
            var pattern = "E1234567890";
            var i = 0;
            do {
                var pos = 0;
                for (var j = 0; j < pattern.length; j++)
                    if (str.charAt(i) === pattern.charAt(j)) {
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
        function daysInFebruary(year)
        {
            return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
        }
        function isValidDate(dtStr)
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
        var apIdresp;
        function checkApId(apId) {
            if (xmlhttp !== null) {

                xmlhttp.open("GET", "/eTracker/ERM/checkApplicantId.jsp?applicantId=" + encodeURIComponent(apId) + "&rand=" + Math.random(1, 10), false);

                xmlhttp.onreadystatechange = function () {
                    callbackapid();
                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }
        }
        function callbackapid() {

            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var comp = xmlhttp.responseText;

                    apIdresp = comp;
                }
            }
        }
        function fun(issueSearch) {
            /** This Loop Checks Whether There Is Any Integer Present In The Company Field */

            if (!isValidIssue(trim(document.getElementById('apid').value))) {
                alert('Enter Application Id in proper format like EDDMMYYYY001');
                document.getElementById('apid').focus();
                return false;
            }
            if (!isValidDate(trim(document.getElementById('apid').value))) {

                document.getElementById('apid').focus();
                return false;
            }


            if ((trim(document.getElementById('apid').value).length) < 12) {
                alert('Size of the Application Id should be 12 characters ');
                document.getElementById('apid').focus();
                return false;
            }
            if ((trim(document.getElementById('apid').value).length) > 12) {
                alert('Size of the Application Id should be 12 characters ');
                document.getElementById('apid').focus();
                return false;
            }

            if ((document.getElementById('apid').value === null) || (document.getElementById('apid').value === ""))
            {
                alert("Please Enter the Application Id");
                document.getElementById('apid').focus();
                return false;
            }
            if (isValidDate(document.getElementById('apid').value) === false) {
                return false;
            }
            checkApId(document.getElementById('apid').value);
            if (trim(apIdresp) === "Ok") {
                alert(document.getElementById('apid').value + ' Not exists');
                document.getElementById('apid').value = '';
                return false;
            }

            disableIssueSubmit();
            return true;
        }
    </script>
</head>
<%@ include file="/header.jsp"%>
<body>


    <jsp:useBean id="ap" class="com.eminentlabs.erm.AssignedApplicants"></jsp:useBean>
    <%
        ap.setAll(request);
    %>
    <form name="issueSearch" onsubmit="return fun(this);" action="<%= request.getContextPath()%>/ERM/viewApplicantDetails.jsp">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="30%">
                    <font size="4" COLOR="#0000FF"><b>ERM Issues </b></font>

                </td>
                <td> <b>Enter the Applicant Id:</b><input type="text" id="apid" name="apid" maxlength="12" size="15"><input type="submit" name="searchIssue" id="searchIssue" value="Search"></td>             
            </tr>

        </table>
    </form>
    <br/>
    <table width="100%" align=center border="0" >
        <tr>
            <td>
                <%if (ap.getUsCount() > 0) {
                        if (ap.getaStatus() == 0) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=0" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(0)%>(<%=ap.getUsCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=0" ><%=ERMUtil.ermApplicantStatus().get(0)%>(<%=ap.getUsCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }
                    if (ap.getReCount() > 0) {
                        if (ap.getaStatus() == 3) {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=3" style="font-weight: bold;"> <%=ERMUtil.ermApplicantStatus().get(3)%>(<%=ap.getReCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=3" > <%=ERMUtil.ermApplicantStatus().get(3)%>(<%=ap.getReCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }
                    if (ap.getScCount() > 0) {
                        if (ap.getaStatus() == 1) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=1" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(1)%>(<%=ap.getScCount()%>)</a>   &nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=1" ><%=ERMUtil.ermApplicantStatus().get(1)%>(<%=ap.getScCount()%>)</a>   &nbsp;&nbsp;&nbsp;&nbsp;
                <% }
                    }
                    if (ap.getHoldCount() > 0) {
                        if (ap.getaStatus() == 7) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=7" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(7)%> (<%=ap.getHoldCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=7" ><%=ERMUtil.ermApplicantStatus().get(7)%>(<%=ap.getHoldCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }
                    if (ap.getShCount() > 0) {
                        if (ap.getaStatus() == 2) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=2" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(2)%>(<%=ap.getShCount()%>)</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=2" ><%=ERMUtil.ermApplicantStatus().get(2)%>(<%=ap.getShCount()%>)</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }

                    if (ap.getJoCount() > 0) {
                        if (ap.getaStatus() == 4) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=4" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(4)%>(<%=ap.getJoCount()%>)</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=4" ><%=ERMUtil.ermApplicantStatus().get(4)%>(<%=ap.getJoCount()%>)</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }
                    if (ap.getOffCount() > 0) {
                        if (ap.getaStatus() == 5) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=5" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(5)%> (<%=ap.getOffCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=5" ><%=ERMUtil.ermApplicantStatus().get(5)%>(<%=ap.getOffCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }
                    if (ap.getDisCount() > 0) {
                        if (ap.getaStatus() == 6) {
                %>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=6" style="font-weight: bold;"><%=ERMUtil.ermApplicantStatus().get(6)%> (<%=ap.getDisCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%} else {%>
                <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=6" ><%=ERMUtil.ermApplicantStatus().get(6)%>(<%=ap.getDisCount()%>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    }

                    if (ap.getApmIssues() > 0) {%>
                You  have APM  <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp" ><%=ap.getApmIssues()%> </a> Issues
                <% }%>
            </td>
        </tr>
    </table>

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
                <TD width="11%"><font><b>Photo</b></font></TD>
                <th width="5%"><font><b>Ap ID</b></font></th>
                <th width="16%"><font><b>Name</b></font></th>
                <th width="15%" class="filter-select filter-match" data-placeholder="Select a Employer"><font><b>Employer</b></font></th>
                <th width="7%"><font><b>Mobile</b></font></th>
                <th width="7%" class="filter-select filter-match" data-placeholder="Select a Location"><font><b>Location</b></font></th>
                <th width="4%" class="filter-select filter-match" data-placeholder="Select a Ref ID"><font><b>Ref ID</b></font></th>
                <th width="6%" class="filter-select filter-match" data-placeholder="Select a Education"><font><b>Education</b></font></th>
                <th width="5%"><font><b>Skills</b></font></th>
                <th width="5%"><font><b>Total Exp</b></font></th>
                <th width="4%"><font><b>SAP Exp</b></font></th>
                <th width="7%"><font><b>Resume</b></font></th>
                <th width="11%" class="filter-select filter-match" data-placeholder="Select a Assigned"><font><b>Assigned To</b></font></th>                
            </TR>
        </thead>
        <tbody>
            <% for (AssignedApplicants ep : ap.getApllicantList()) {%>
            <tr>

                <td><a href="<%=request.getContextPath()%>/ERM/viewApplicantDetails.jsp?apid=<%=ep.getApplicantId()%>">                    
                        <img width="120px" height="120px" src="<%=request.getContextPath()%>/Etracker_AttachedFiles/userPhotos/<%=ep.getPhotoPath()%>" onerror="if (this.src != '<%=request.getContextPath()%>/images/avator1.png') this.src = '<%=request.getContextPath()%>/images/avator1.png';">
                    </a>
                </td>
                <td><a href="<%=request.getContextPath()%>/ERM/viewApplicantDetails.jsp?apid=<%=ep.getApplicantId()%>"><%=ep.getApplicantId()%></a></td>

                <td class="imagePopup" name="imagePopup" style="cursor: pointer;" onclick="showImage('<%=request.getContextPath()%>/Etracker_AttachedFiles/userPhotos/<%=ep.getPhotoPath()%>', '<%=ep.getName()%>', '<%=ep.getApplicantId()%>');"><%=ep.getName()%>
                 <%if(ep.getIsFake()==1){%>
                <img src="<%=request.getContextPath()%>/images/mask.png" alt="Fake Candidate" title="Fake Candidate" style="height: 15px;vertical-align: bottom;">
                <%}%>
                
                </td>
                <td><%=ep.getEmployer()%></td>
                <td><%=ep.getMobile()%></td>
                <td><%=ep.getLocation()%></td>
                <td title="<%=ep.getRefName()%>"><%=ep.getRefId()%></td>
                <td><%=ep.getEducation()%></td>
                <td><%=ep.getSkills()%></td>
                <td><%=ep.getTotalExp()%></td>
                <td><%=ep.getSapExp()%></td>
                <td><a target="_blank" href="<%=request.getContextPath()%>/Resume/<%=ep.getFileName()%>">
                        <%if (ep.getFileName().length() > 9) {%>
                        <%=ep.getFileName().substring(0, 9) + ".."%>
                        <%} else {%>
                        <%=ep.getFileName()%>
                        <%}%>
                    </a></td>
                <td>

                    <%if (ep.getAssignedTo().length() > 9) {%>
                    <%=ep.getAssignedTo().substring(0, 9) + ".."%>
                    <%} else {%>
                    <%=ep.getAssignedTo()%>
                    <%}%></td>


            </tr>

            <%
                }
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

    <div id="overlay"></div>
    <div id="imagePopups" class="popup" >

        <div class="popupHeading"  id="nameofEmp" style="font-weight: bold" style="font-size: 18" align="center" ><b>Name</b></div>

        <div>
            <table id="imagetable">
                <tr>

                    <td>
                        <img  name="userImage" id='userImage' alt="Image not found" src="#" style="visibility: hidden" width="250px" height="250px" onerror="this.src='<%=request.getContextPath()%>/images/avator1.png';"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">

                        <button class="custom-popup-close" onclick="javascript:closePopup();" type="button">close</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script type="text/javascript">
        $('.imagePopup').hover(function () {
            $(this).css("color", "blue");
        });

        $('.imagePopup').mouseout(function () {
            $(this).css("color", "");
        });
        function showImage(src, name, applicantId) {
            // console.log("src name is:" + src);
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $("#imagePopups").width(254).height(266);
            document.getElementById('nameofEmp').innerHTML = applicantId + ":" + name;
            $('#imagePopups').fadeIn('fast', 'swing');
            var img = document.getElementById('userImage');
            img.style.visibility = 'visible';
            document.getElementById('userImage').src = src;
        }
        function closePopup() {
            $('#overlay').fadeOut('fast', 'swing');
            $('#imagePopups').fadeOut('fast', 'swing');

        }
    </script>
    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
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
