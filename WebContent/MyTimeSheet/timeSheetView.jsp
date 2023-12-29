<%@page import="com.eminent.timesheet.TimeSheetUtil"%>
<%@page import="com.eminentlabs.crm.CRMSearchBean"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="com.eminentlabs.timesheet.dao.TimesheetDAOImpl"%>
<%@page import="com.eminentlabs.timesheet.dao.TimesheetDAO"%>
<%@page import="com.eminent.timesheet.TimesheetMaintanance"%>
<%@page import="com.eminent.timesheet.TimesheetIssue"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.holidays.Holidays"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
    <%@ page import="org.apache.log4j.Logger,com.eminent.timesheet.CreateTimeSheet,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmPtcm"%>
    <%@ page import="java.sql.*, dashboard.*,com.eminent.customer.CustomerUtil,com.eminent.timesheet.Timesheet"%>
    <%@ page import="java.util.HashMap,com.eminent.resource.ResourceUtil"%>
    <%@ page import="pack.eminent.encryption.*,com.eminent.tqm.TestCasePlan"%>
    <%@ page import="com.eminent.util.*,com.eminent.tqm.TqmTestcaseexecutionresult"%>
    <%@ page import="java.util.*, java.text.*, com.pack.*"%>
    <jsp:useBean id="tsu" class="com.eminent.timesheet.TimeSheetUtil"></jsp:useBean>

    <%
                response.addHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.addHeader("Cache-Control", "pre-check=0, post-check=0");
        response.setDateHeader("Expires", 0);

        //Configuring log4j properties

        Logger logger = Logger.getLogger("TimeSheetView");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("=========================Session Expired======================");
    %>
    <jsp:forward page="SessionExpired.jsp"></jsp:forward>
    <%
            //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
        }
         String workeduserid="0";
        if (request.getParameter("userId") == null) {
           // workeduserid = (String) session.getAttribute("WorkedIssueUser");
        } else {
            workeduserid = request.getParameter("userId");
            //session.setAttribute("WorkedIssueUser", workeduserid);
        }
        int userId = Integer.parseInt(workeduserid);
        TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
        TimesheetMaintanance timesheetMaintanance = timesheetDAO.findByRequester(userId);
        int timeSheetApprovalUserId = 112, needInfoUserId = 0;
        if (timesheetMaintanance == null) {
        } else {
            if (timesheetMaintanance.getTimesheetApprover() != 0) {
                timeSheetApprovalUserId = timesheetMaintanance.getTimesheetApprover();
            } else {
                timeSheetApprovalUserId = 112;
            }
            if (timesheetMaintanance.getNeedinfoApprover() != 0) {
                needInfoUserId = timesheetMaintanance.getNeedinfoApprover();
            }
        }
    %>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>

    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript">

        function trim(str) {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function textCounter(field, cntfield, maxlimit) {
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Accomplishments size is exceeding 1000 characters');
            } else
                cntfield.value = maxlimit - field.value.length;
        }

        function createRequest() {
            var reqObj = null;
            try {
                reqObj = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (err) {
                try {
                    reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (err2) {
                    try {
                        reqObj = new XMLHttpRequest();
                    } catch (err3) {
                        reqObj = null;
                    }
                }
            }
            return reqObj;
        }
        function assignedusers() {
            xmlhttp = createRequest();

            if (xmlhttp !== null) {
                var issueid = "E29092009002";
                var status = "Confirmed";
                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/MyTimeSheet/assignedToDetails.jsp?issueid=" + issueid + "&status=" + status + "&rand=" + Math.random(1, 10), false);

                xmlhttp.onreadystatechange = callassignedto;
                xmlhttp.send(null);
            }
        }
        function callassignedto()
        {
            var results = "";
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var results = "";
                    var result = xmlhttp.responseText.split(";");
                    //            alert("Result:"+result);
                    var results = result[1].split(",");
                    //         alert("Result:"+results);
                    objLinkList = eval("document.getElementById('assignedto')");
                    objLinkList.length = 0;
                    var assigned = document.getElementById('currentassign').value;
                    //                alert("Current Assigned"+assigned);

                    for (i = 0; i < results.length - 1; i++)
                    {

                        var k = results[i];


                        var id = k.substring(0, k.indexOf('-'));
                        var name = k.substring(k.indexOf('-') + 1, k.length);

                        objLinkList.length++;
                        objLinkList[i].text = name;
                        objLinkList[i].value = id;
                        if (assigned === id) {
                            objLinkList[i].selected = true;
                        }

                    }
                    var results = "";
                    var result = "";
                }
            }
        }
        function textCounter(field, cntfield, maxlimit) {
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Accomplishments size is exceeding 1000 characters');
            } else
                cntfield.value = maxlimit - field.value.length;
        }
        function isNumber(str) {
            var pattern = "0123456789.";
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
        function addRow() {
            if (document.getElementById('status').value === 'Approved') {
                var table = document.getElementById('approval');

                var rowCount = table.rows.length;
                //                      alert("No Of Rows"+rowCount);

                if (rowCount > 1) {
                    deleteRow();
                }
                var rowCount = table.rows.length;
                //                    alert("No Of Rows after"+rowCount);
                var row1 = table.insertRow(rowCount);

                var cell11 = row1.insertCell(0);

                cell11.innerHTML = "<b>Approval %";

                var cell12 = row1.insertCell(1);
                var approval = document.createElement("input");
                approval.type = "text";
                approval.name = "percentage";
                approval.id = "percentage";
                approval.size = "1";
                cell12.appendChild(approval);
                var row2 = table.insertRow(rowCount + 1);

                var cell21 = row2.insertCell(0);
                cell21.innerHTML = "<b>Appreciation";

                var cell22 = row2.insertCell(1);
                var appre = document.createElement("textarea");
                appre.name = "appreciation";
                appre.id = "appreciation";
                appre.cols = "70";
                appre.rows = "3";

                cell22.appendChild(appre);

                var row3 = table.insertRow(rowCount + 2);

                var cell31 = row3.insertCell(0);
                cell31.innerHTML = "<b>Feedback";

                var cell32 = row3.insertCell(1);
                var feed = document.createElement("textarea");
                feed.name = "feedback";
                feed.id = "feedback";
                feed.cols = "70";
                feed.rows = "3";
                cell32.appendChild(feed);

                var row4 = table.insertRow(rowCount + 3);

                var cell41 = row4.insertCell(0);
                cell41.innerHTML = "";

                var cell42 = row4.insertCell(1);
                cell42.align = "center";
                var sub = document.createElement("input");
                sub.type = "submit";
                sub.id = "submit";
                sub.name = "approve";
                sub.value = "Approve";

                var rst = document.createElement("input");
                rst.type = "reset";
                rst.name = "reset";
                rst.id = "reset";
                rst.value = "Reset";

                cell42.appendChild(sub);
                cell42.appendChild(rst);

            }
            if (document.getElementById('status').value === 'Need Info') {
                var table = document.getElementById('approval');

                var rowCount = table.rows.length;
                //                      alert("No Of Rows"+rowCount);

                if (rowCount > 1) {
                    deleteRow();
                }
                var rowCount = table.rows.length;
                //                    alert("No Of Rows after"+rowCount);
                var row1 = table.insertRow(rowCount);
                row1.setAttribute("align", "left");

                var cell11 = row1.insertCell(0);
                cell11.innerHTML = "<b>Assigned To";

                var cell12 = row1.insertCell(1);
                var assign = document.createElement("select");

                assign.name = "assignedto";
                assign.id = "assignedto";

                cell12.appendChild(assign);
                var row2 = table.insertRow(rowCount + 1);
                row2.setAttribute("align", "left");
                var cell21 = row2.insertCell(0);
                cell21.innerHTML = "<b>Need Info";

                var cell22 = row2.insertCell(1);
                var info = document.createElement("textarea");
                info.cols = "70";
                info.rows = "3";
                info.name = "needinfo";
                info.id = "needinfo";
                cell22.appendChild(info);


                assignedusers();

                var row3 = table.insertRow(rowCount + 2);

                var cell31 = row3.insertCell(0);
                cell31.innerHTML = "";

                var cell32 = row3.insertCell(1);
                cell32.align = "center";
                var sub = document.createElement("input");
                sub.type = "submit";

                sub.id = "submit";
                sub.value = "Need Info";


                var rst = document.createElement("input");
                rst.type = "reset";
                rst.name = "reset";
                rst.id = "reset";
                rst.value = "Reset";
                cell32.appendChild(sub);
                cell32.appendChild(rst);
                //			var cell32 = row3.insertCell(1);
                //			var info = document.createElement("textarea");
                //			info.name="needinfo";
                //			cell22.appendChild(info);



            }
        }

        function deleteRow() {
            var tables = document.getElementById("approval");
            var rowCounts = tables.rows.length;
            //                     alert(rowCounts);
            try {

                for (var i = 7; i < rowCounts; i++) {
                    var row = tables.rows[i];

                    tables.deleteRow(i);
                    rowCounts--;
                    i--;


                }
            } catch (e) {
                alert(e);
            }

        }

        function Validate() {
            if (document.getElementById('status').value === '--Select One--') {
                alert('Please select the status');
                document.getElementById('status').focus();
                return false;
            }
            if (document.getElementById('role').value === '3') {
                if (document.getElementById('eminentHours').value === '') {
                    alert('Please enter the total hours at eminent office ');
                    document.getElementById('eminentHours').focus();
                    return false;
                }
                if (document.getElementById('meetingHours').value === '') {
                    alert('Please select the total hours at client meeting');
                    document.getElementById('meetingHours').focus();
                    return false;
                }
                var wonaccount = $("input:radio[name=wonaccount]:checked").val();
                if ($("input:radio[name=wonaccount]:checked").length == 0) {
                    alert('Have you won a New Customer Purchase Order?');
                    return false;
                } else {
                    if (wonaccount === 'Yes') {
                        var items = document.getElementsByName('wonaccountid');
                        var selectedItems = 0;
                        for (var i = 0; i < items.length; i++) {
                            if (items[i].type == 'checkbox' && items[i].checked == true)
                                selectedItems++;
                        }
                        if (selectedItems < 1) {
                            alert('Please select the accounts');
                            return false;
                        }
                    } else {
                        var metdecisionmaker = $("input:radio[name=metdecisionmaker]:checked").val();
                        if ($("input:radio[name=metdecisionmaker]:checked").length == 0) {
                            alert('Have you met more than 5 decision makers?');
                            return false;
                        } else {
                            if (metdecisionmaker === 'Yes') {
                                var items = document.getElementsByName('metdecisionmakerid');
                                var selectedItems = 0;
                                for (var i = 0; i < items.length; i++) {
                                    if (items[i].type == 'checkbox' && items[i].checked == true)
                                        selectedItems++;
                                }
                                if (selectedItems < 5) {
                                    alert('Please select minimum 5 decision makers');
                                    return false;
                                }
                            } else {

                                var identifieddecisionmaker = $("input:radio[name=identifieddecisionmaker]:checked").val();
                                if ($("input:radio[name=identifieddecisionmaker]:checked").length == 0) {
                                    alert('Have you identified more than 10 decision makers for this ?');
                                    return false;
                                } else {
                                    if (identifieddecisionmaker === 'Yes') {
                                        var items = document.getElementsByName('identifieddecisionmakerid');
                                        var selectedItems = 0;
                                        for (var i = 0; i < items.length; i++) {
                                            if (items[i].type == 'checkbox' && items[i].checked == true)
                                                selectedItems++;
                                        }
                                        if (selectedItems < 10) {
                                            alert('Please select minimum 10 decision makers');
                                            return false;
                                        }
                                    } else {
                                        var metinfluencers = $("input:radio[name=metinfluencers]:checked").val();
                                        if ($("input:radio[name=metinfluencers]:checked").length == 0) {
                                            alert('Have you met more than 15 influencers?');
                                            return false;
                                        } else {
                                            if (metinfluencers === 'Yes') {
                                                var items = document.getElementsByName('metinfluencersleadid');
                                                var itemsa = document.getElementsByName('metinfluencercontactid');

                                                var selectedItems = 0;
                                                for (var i = 0; i < items.length; i++) {
                                                    if (items[i].type == 'checkbox' && items[i].checked == true)
                                                        selectedItems++;
                                                }
                                                for (var i = 0; i < itemsa.length; i++) {
                                                    if (itemsa[i].type == 'checkbox' && itemsa[i].checked == true)
                                                        selectedItems++;
                                                }
                                                if (selectedItems < 15) {
                                                    alert('Please select minimum 15 influencers');
                                                    return false;
                                                }
                                            } else {

                                                var identifiedinfluencers = $("input:radio[name=identifiedinfluencers]:checked").val();
                                                if ($("input:radio[name=identifiedinfluencers]:checked").length == 0) {
                                                    alert('Have you identified more than 30 influencers?');
                                                    return false;
                                                } else {
                                                    if (identifiedinfluencers === 'Yes') {
                                                        var items = document.getElementsByName('identifiedinfluencersleadid');
                                                        var itemsa = document.getElementsByName('identifiedinfluencercontactid');

                                                        var selectedItems = 0;
                                                        for (var i = 0; i < items.length; i++) {
                                                            if (items[i].type == 'checkbox' && items[i].checked == true)
                                                                selectedItems++;
                                                        }
                                                        for (var i = 0; i < itemsa.length; i++) {
                                                            if (itemsa[i].type == 'checkbox' && itemsa[i].checked == true)
                                                                selectedItems++;
                                                        }
                                                        if (selectedItems < 30) {
                                                            alert('Please select minimum 30 influencers');
                                                            return false;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (document.getElementById('status').value === 'Approved') {
                if (document.getElementById('percentage').value === '') {
                    alert('Please approve Time Sheet with Approval Percentage');
                    document.getElementById('percentage').focus();
                    return false;
                }
                if (!isNumber(document.getElementById('percentage').value)) {
                    alert('Please enter only Numerics in Approval Percentage');
                    document.getElementById('percentage').focus();
                    return false;
                }
                if (document.getElementById('percentage').value > 100) {
                    alert('Approval Percentage must be less than 100');
                    document.getElementById('percentage').focus();
                    return false;
                }
                if (document.getElementById('appreciation').value === '') {
                    alert('Please approve Time Sheet with Appreciation');
                    document.getElementById('appreciation').focus();
                    return false;
                }
                if (document.getElementById('appreciation').value.length > 1000) {
                    alert('Appreciation should not exceed 1000 character');
                    document.getElementById('appreciation').focus();
                    return false;
                }
                if (document.getElementById('feedback').value === '') {
                    alert('Please approve Time Sheet with Feedback');
                    document.getElementById('feedback').focus();
                    return false;
                }
                if (document.getElementById('feedback').value.length > 1000) {
                    alert('Feedback should not exceed 1000 character');
                    document.getElementById('feedback').focus();
                    return false;
                }
            }
            if (document.getElementById('status').value === 'Need Info') {
                //           document.getElementById('needinfo').focus();
                //           alert('Please enter the Need Info'+document.getElementById('needinfo').value);
                if (document.getElementById('currentassign').value === '<%=timeSheetApprovalUserId%>') {
                    if (trim(document.getElementById('needinfo').value) === "") {

                        alert('Please enter the Need Info');
                        document.getElementById('needinfo').focus();
                        return false;
                    }
                } else {
                    if (trim(CKEDITOR.instances.needinfo.getData()) === "") {
                        alert('Please enter the Need Info');
                        document.getElementById('needinfo').focus();
                        return false;
                    }
                }
                if (document.getElementById('needinfo').value.length > 1000) {
                    alert('Need Info should not exceed 1000 character');
                    document.getElementById('needinfo').focus();
                    return false;
                }
            }
            monitorSubmit();
            return true;
        }
        function setFocus()
        {
            document.timeSheetApproval.status.focus();
        }

    </script>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <link id="noscript_css" rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/eminentech support files/noscript.css" />
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <!--<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/loading.css" type="text/css" rel="STYLESHEET">-->
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
</head>

<BODY>

    <%!
        String start, end, timeSheetId;
        int i, year, month, timeSheetMonth, timeSheetYear, currentMonth, currentYear;
        String url = null;
        private static HashMap<Integer, String> monthSelect = new HashMap();

        static {

            monthSelect.put(0, "Jan");
            monthSelect.put(1, "Feb");
            monthSelect.put(2, "Mar");
            monthSelect.put(3, "Apr");
            monthSelect.put(4, "May");
            monthSelect.put(5, "Jun");
            monthSelect.put(6, "Jul");
            monthSelect.put(7, "Aug");
            monthSelect.put(8, "Sep");
            monthSelect.put(9, "Oct");
            monthSelect.put(10, "Nov");
            monthSelect.put(11, "Dec");

        }
    %>

    <jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>



    <%@ include file="/header.jsp"%>




    <%!
        int userid_curri, age, rowcount, currentUser, role;
        int maxday = 30;
                                                                                                                                                                                                                                                                                                                                                            %>

    <%
        currentUser = (Integer) session.getAttribute("uid");
        role = (Integer) session.getAttribute("Role");
        //      String timeSheetid = request.getParameter("userTimesheetid");
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        String msg = null;

        //   logger.info("Timesheet Id"+timeSheetid);
        try {

            //calculating start and end date of this month
            Calendar cal = new GregorianCalendar();
            currentYear = cal.get(Calendar.YEAR);
            currentMonth = cal.get(Calendar.MONTH);
            int currentDay = cal.get(Calendar.DAY_OF_MONTH);

            String selectYear = request.getParameter("year");
            String selectMonth = request.getParameter("month");
            timeSheetId = "T" + selectMonth + selectYear + request.getParameter("userId");
            //        logger.info("Selected Year"+selectYear);
            //        logger.info("Selected Month"+selectMonth);
            year = 0;
            month = 0;

            if (selectYear == null || selectYear.equals("")) {
                year = currentYear;
                month = cal.get(Calendar.MONTH);
                maxday = cal.get(Calendar.DAY_OF_MONTH);
            } else {
                year = Integer.parseInt(selectYear);
                month = Integer.parseInt(selectMonth);

                Calendar cale = Calendar.getInstance();
                cale.set(year, month, 1);
                maxday = cale.getActualMaximum(Calendar.DATE);
            }
            //       logger.info("Year"+year);
            //       logger.info("Month"+monthSelect.get(month));

            //       logger.info("MAX DAY of MOnth"+maxday);
            start = "1" + "-" + monthSelect.get(month) + "-" + year;
            end = maxday + "-" + monthSelect.get(month) + "-" + year;

            String selectedStartDate = year + "-" + (month + 1) + "-" + "01" + " 00:00:00";
            String selectedEndDate = year + "-" + (month + 1) + "-" + maxday + " 23:59:59";

            DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            java.util.Date stDate = (java.util.Date) format.parse(selectedStartDate);
            java.util.Date edDate = (java.util.Date) format.parse(selectedEndDate);

            String issueDetails[][] = IssueDetails.displayIssues(userId, start, end, "Closed");
            List<String> currMonthIssues = IssueDetails.currentMonthclosed(userId, start, end);
            rowcount = issueDetails.length;
            List<CRMSearchBean> accDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Account");
            List<CRMSearchBean> oppDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Opportunity");
            List<CRMSearchBean> leadDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Lead");
            List<CRMSearchBean> conDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Contact");
            String rrDetails[][] = ResourceUtil.displayRRIssues(userId, start, end);
            String timeSheet[][] = CustomerUtil.displayTimesheet(userId, start, end);
            String leaveRequest[][] = CustomerUtil.userLeave(userId, start, end);
            List<TimesheetIssue> tsheetTotalissues = tsu.findIssuesByTimesheetId(timeSheetId);
            List<String> tsheetissues = new ArrayList();
            for (TimesheetIssue timesheetIssue : tsheetTotalissues) {
                if (timesheetIssue.getWorkstatus() == 0) {
                    tsheetissues.add(timesheetIssue.getIssueid());
                }
            }
            int wrmcount = GetProjectManager.checkProjectManagerFromWRM(userId, start, end);
            String wrm[][] = null;
            if (wrmcount > 0) {
                wrm = TimeSheetUtil.getWRMRatings(userId, start, end);
            }
    %>

    <div align="center">
        <center>
            <br>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#E8EEF7">
                    <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                        COLOR="#0000FF"> <b> TimeSheet of <%=GetProjectMembers.getUserName(workeduserid)%> for the Month of <%=monthSelect.get(month)%> <%=year%></b></font>

                </tr>
            </table>
            <br>
            <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat sdftimestamp = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");

                String mail = (String) session.getAttribute("theName");

                if (mail != null) {
                    url = mail.substring(mail.indexOf("@") + 1, mail.length());
                }


            %>

            <br>
            <%    String selectedPeriod = monthSelect.get(month) + " " + year;
                if (accDetails.size() > 0 || oppDetails.size() > 0 || leadDetails.size() > 0 || conDetails.size() > 0) {

            %>
            <table width="100%" bgcolor="" border="0">
                <tr bgcolor="#D8D8D8" align="left"><td colspan="7"><b>CRM Block</b></td></tr>
                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('crm', 150);
            return false;" style="text-decoration: none;color: black" class="trigger" title="CRM" >The total <b style="color: blue">CRM Worked Issues</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=(conDetails.size() + leadDetails.size() + oppDetails.size() + accDetails.size())%>.</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td>
                        <div id="crm" class="hide_me" >
                            <table border="0" width="100%">
                                <%
                                    if (conDetails.size() > 0) {
                                %>

                                <tr align="left"><td colspan="7"><b>CRM Contacts</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left">
                                    <td width="25%"><font><b>Name</b></font></td>
                                    <td width="25%"><font><b>Company</b></font></td>

                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    try {
                                        int s = 0;
                                        String age = "NA", assignedto = "NA", dueDate = "NA";

                                        for (CRMSearchBean bean : conDetails) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%s++;
                                                    }
                                                } catch (Exception e) {
                                                    logger.error(e.getMessage());
                                                }
                                            }
                                            if (leadDetails.size() > 0) {
                                        %>
                                <tr align="left"><td colspan="7"><b>CRM Leads</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left">
                                    <td width="20%"><font><b>Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : leadDetails) {
                                        age = "NA";
                                        assignedto = "NA";
                                        dueDate = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                            assignedto = "NA";
                                        }
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%s++;
                                                }
                                            }
                                            if (oppDetails.size() > 0) {
                                        %>
                                <tr align="left" align="left"><td colspan="7"><b>CRM Opportunity</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left">
                                    <td width="25%"><font><b>Opportunity Name</b></font></td>
                                    <td width="20%"><font><b>Stage</b></font></td>

                                    <td width="15%"><font><b>Probability</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="15%"><font><b>CloseDate</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>
                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : oppDetails) {
                                        age = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        } else {
                                            age = "NA";
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                            assignedto = "NA";
                                        }
                                        dueDate = "NA";
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }

                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%s++;
                                                }
                                            }
                                            if (accDetails.size() > 0) {
                                        %>
                                <tr align="left"><td colspan="7"><b>CRM Account</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="25%"><font><b>Account Name</b></font></td>
                                    <td width="20%"><font><b>Billing State</b></font></td>
                                    <td width="15%"><font><b>Type</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="15%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>


                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : accDetails) {
                                        age = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        } else {
                                            age = "NA";
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                            assignedto = "NA";
                                        }
                                        dueDate = "NA";
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }

                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getEmail()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%s++;
                                                }

                                            }
                                        %>
                            </table>
                        </div>

                    </td>
                </tr>

            </table>
            <%}%>
            <form name="timeSheetApproval" onSubmit="return Validate(this);" action="<%=request.getContextPath()%>/MyTimeSheet/timeSheetApproval.jsp" method="post" onReset="return setFocus();">

                <table width="100%" height="23" border="0">
                    <tr align="left"><td width="100%" colspan="11" bgcolor="#D8D8D8"><b> APM Block</b></td></tr>

                    <tr height="10">
                        <td colspan="11">
                            <table width="100%">
                                <tr height="10">
                                    <td align="left" width="100%"><a href="#" onclick="collapse('apm', 150);
                                            return false;" style="text-decoration: none;color: black" class="trigger" title="APM" >The total <b style="color: blue">APM Closed Issues</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=rowcount%>.</a>
                                        </b></td>
                                    <td align="right" width="25">Severity</td>
                                    <td align="right" width="25" bgcolor="#FF0000">S1</td>
                                    <td align="right" width="25" bgcolor="#FF9900">S2</td>
                                    <td align="right" width="25" bgcolor="#FFFF00">S3</td>
                                    <td align="right" width="25" bgcolor="#33FF33">S4</td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr><td>
                            <div id="apm" class="hide_in" >
                                <table border="0" width="100%">

                                    <TR bgcolor="#C3D9FF" align="left">
                                        <td width="6%" TITLE="Co-Ordination/Work"><font><b>C/W</b></font></td>
                                        <td width="1%" TITLE="Severity"><font><b>S</b></font></td>
                                        <td width="9%"><font><b>Issue No</b></font></td>
                                        <td width="3%" TITLE="Priority"><font><b>P</b></font></td>
                                        <td width="10%"><font><b>Project</b></font></td>
                                        <td width="7%"><font><b>Module</b></font></td>
                                        <td width="25%"><font><b>Subject</b></font></td>
                                        <td width="9%"><font><b>Status</b></font></td>
                                        <td width="8%"><font><b>Due Date</b></font></td>
                                        <td width="9%"><font><b>AssignedTo</b></font></td>
                                        <td width="7%"><font><b>Refer</b></font></td>
                                        <td width="5%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></td>
                                    </TR>

                                    <%
                                        int duedateexceeded = 0, exlnt = 0, good = 0, avrg = 0, ndimp = 0;
                                        int curMonthClosed = 0;
                                        for (i = 0; i < rowcount; i++) {

                                            String iss = issueDetails[i][0];
                                            if (currMonthIssues.contains(iss)) {
                                                curMonthClosed++;
                                            }
                                        }
                                        if (curMonthClosed > 0) {%>
                                    <tr bgcolor="#C3D9FF"><td colspan="12">Current Month Worked And Closed Issues = <%=curMonthClosed%> </td></tr>
                                    <% }
                                        int j = 1;
                                        for (i = 0; i < rowcount; i++) {

                                            String iss = issueDetails[i][0];
                                            if (currMonthIssues.contains(iss)) {
                                                j++;
                                                String project1 = issueDetails[i][1];
                                                String type = issueDetails[i][2];
                                                String status = issueDetails[i][3];
                                                String sub = issueDetails[i][4];
                                                String desc = issueDetails[i][5];
                                                String pri = issueDetails[i][6];
                                                String sev = issueDetails[i][7];
                                                String createdBy = issueDetails[i][8];
                                                String createdOn = issueDetails[i][9];
                                                String assignedTo = issueDetails[i][10];
                                                String modifiedOn = issueDetails[i][11];
                                                String dueDateFormat = issueDetails[i][12];
                                                String rating = issueDetails[i][13];
                                                String feedback = issueDetails[i][14];
                                                String module = issueDetails[i][15];
                                                String fullModule = module;
                                                if (module.length() > 10) {
                                                    module = module.substring(0, 7) + "...";
                                                }
                                                if (sub.length() > 42) {
                                                    sub = sub.substring(0, 42) + "...";
                                                }
                                                if (rating == null) {
                                                    rating = "NA";
                                                }
                                                int current = Integer.parseInt(assignedTo);
                                                String p = "NA";
                                                if (pri != null) {
                                                    p = pri.substring(0, 2);
                                                }

                                                assignedTo = GetName.getUserName(assignedTo);
                                                assignedTo = assignedTo.substring(0, assignedTo.indexOf(" ") + 2);

                                                session.setAttribute("theissno", iss);

                                                String dueDate = "NA";
                                                if (dueDateFormat != null) {
                                                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                                                }

                                                String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
                                                String create = sdf.format(dateConversion.parse(createdOn));

                                                String s1 = "S1- Fatal";
                                                String s2 = "S2- Critical";
                                                String s3 = "S3- Important";
                                                String s4 = "S4- Minor";
                                                age = CustomerUtil.getIssueAge(create, status, dateString1);
                                                if ((j % 2) != 0) {
                                    %>
                                    <tr bgcolor="#E8EEF7" height="23" align="left">
                                        <%
                                        } else {
                                        %>

                                    <tr bgcolor="white" height="23" align="left">
                                        <%
                                            }
                                        %>

                                        <td width="5%"  >
                                            <%if (tsheetissues.contains(iss)) {%>
                                            <input type="radio" name="prev<%=j%>" value="<%=iss%>c" checked style="vertical-align: middle; margin: 0px;"/>
                                            <input type="radio" name="prev<%=j%>" value="<%=iss%>w"  style="vertical-align: middle; margin: 0px;"/>
                                            <%} else {%>
                                            <input type="radio" name="prev<%=j%>" value="<%=iss%>c"  style="vertical-align: middle; margin: 0px;"/>
                                            <input type="radio" name="prev<%=j%>" value="<%=iss%>w" checked style="vertical-align: middle; margin: 0px;"/>
                                            <%}%>
                                        </td>
                                        <% if (sev.equals(s1)) {%>
                                        <td width="1%" bgcolor="#FF0000"></td>
                                        <%} else if (sev.equals(s2)) {%>
                                        <td width="1%" bgcolor="#FF9900"></td>
                                        <%} else if (sev.equals(s3)) {%>
                                        <td width="1%" bgcolor="#FFFF00"></td>
                                        <%} else if (sev.equals(s4)) {%>
                                        <td width="1%" bgcolor="#00FF40"><br>
                                        </td>
                                        <%}%>
                                        <td width="9%" TITLE="<%= type%>"><a
                                                HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
                                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                                </font></a></td>
                                        <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                             size="1" color="#000000"><%= p%> </font></td>
                                                <%

                                                    if (project1.length() < 15) {
                                                %>
                                        <td width="10%"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1%></font></td>
                                                <%
                                                } else {
                                                %>
                                        <td width="10%"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0, 15) + "..."%></font></td>
                                                <%
                                                    }
                                                %>
                                        <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                     size="1" color="#000000"><%=module%></font></td>
                                        <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                                <%
                                                    String color = "";

                                                    if (status.equalsIgnoreCase("Closed")) {
                                                        if (rating.equalsIgnoreCase("Excellent")) {
                                                            color = "#336600";
                                                            exlnt++;
                                                        } else if (rating.equalsIgnoreCase("Good")) {
                                                            color = "#33CC66";
                                                            good++;
                                                        } else if (rating.equalsIgnoreCase("Average")) {
                                                            color = "#CC9900";
                                                            avrg++;
                                                        } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                            color = "#CC0000";
                                                            ndimp++;
                                                        }
                                                        if (feedback == null) {
                                                            feedback = "";
                                                        }
                                                    }

                                                %>

                                        <td width="9%" bgcolor="<%=color%>" title="<%=feedback%>"  onclick="showPrint('<%=iss%>');"style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                                                  size="1" color="#000000"><%= status%> </font></td>
                                                <%

                                                    if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                                                        duedateexceeded++;
                                                %>
                                        <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                                            duedateexceeded++;
                                        %>
                                        <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else {
                                        %>
                                        <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td width="9%" title="Created By <%=GetName.getUserName(createdBy)%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                                            </font></td>
                                            <%
                                                int fileCount = IssueDetails.displayFiles(iss);
                                                if (fileCount > 0) {%>
                                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                             size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#"
                                                                        >ViewFiles(<%=fileCount%>)</A></font></td>
                                                    <%} else {%>
                                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                             size="1" color="#000000">No Files</font></td>
                                                <%}%>
                                        <td width="5%" align=center><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= age%></font>
                                        </td>
                                    </tr>

                                    <%
                                            }
                                        }
                                        if ((rowcount - curMonthClosed) > 0) {%>
                                    <tr><td colspan="12" bgcolor="#C3D9FF">Previous Month Worked And Closed Issues = <%=rowcount - curMonthClosed%> </td></tr>
                                    <% }
                                        j = 1;
                                        for (i = 0; i < rowcount; i++) {

                                            String iss = issueDetails[i][0];
                                            if (!currMonthIssues.contains(iss)) {
                                                j++;
                                                String project1 = issueDetails[i][1];
                                                String type = issueDetails[i][2];
                                                String status = issueDetails[i][3];
                                                String sub = issueDetails[i][4];
                                                String desc = issueDetails[i][5];
                                                String pri = issueDetails[i][6];
                                                String sev = issueDetails[i][7];
                                                String createdBy = issueDetails[i][8];
                                                String createdOn = issueDetails[i][9];
                                                String assignedTo = issueDetails[i][10];
                                                String modifiedOn = issueDetails[i][11];
                                                String dueDateFormat = issueDetails[i][12];
                                                String rating = issueDetails[i][13];
                                                String feedback = issueDetails[i][14];
                                                String module = issueDetails[i][15];
                                                String fullModule = module;
                                                if (module.length() > 10) {
                                                    module = module.substring(0, 7) + "...";
                                                }
                                                if (sub.length() > 42) {
                                                    sub = sub.substring(0, 40) + "...";
                                                }
                                                if (rating == null) {
                                                    rating = "NA";
                                                }
                                                int current = Integer.parseInt(assignedTo);
                                                String p = "NA";
                                                if (pri != null) {
                                                    p = pri.substring(0, 2);
                                                }

                                                assignedTo = member.get(current);

                                                session.setAttribute("theissno", iss);

                                                String dueDate = "NA";
                                                if (dueDateFormat != null) {
                                                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                                                }

                                                String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
                                                String create = sdf.format(dateConversion.parse(createdOn));

                                                String s1 = "S1- Fatal";
                                                String s2 = "S2- Critical";
                                                String s3 = "S3- Important";
                                                String s4 = "S4- Minor";
                                                //                  logger.info("Processing data........"+i);

                                                //                                  age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                                                //                      logger.info("Calculated time........"+i);
                                                //                           //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                                                age = CustomerUtil.getIssueAge(create, status, dateString1);
                                                if ((j % 2) != 0) {
                                    %>
                                    <tr bgcolor="#E8EEF7" height="23" align="left">
                                        <%
                                        } else {
                                        %>

                                    <tr bgcolor="white" height="23" align="left">
                                        <%
                                            }
                                        %>

                                        <td width="5%">
                                            <%if (tsheetissues.contains(iss)) {%>
                                            <input type="radio" name="curr<%=j%>" value="<%=iss%>c" checked style="vertical-align: middle; margin: 0px;"/>
                                            <input type="radio" name="curr<%=j%>" value="<%=iss%>w" style="vertical-align: middle; margin: 0px;"/>
                                            <%} else {%>
                                            <input type="radio" name="curr<%=j%>" value="<%=iss%>c"  style="vertical-align: middle; margin: 0px;"/>
                                            <input type="radio" name="curr<%=j%>" value="<%=iss%>w" checked style="vertical-align: middle; margin: 0px;"/>
                                            <%}%>
                                        </td>
                                        <% if (sev.equals(s1)) {%>
                                        <td width="1%" bgcolor="#FF0000"></td>
                                        <%} else if (sev.equals(s2)) {%>
                                        <td width="1%" bgcolor="#FF9900"></td>
                                        <%} else if (sev.equals(s3)) {%>
                                        <td width="1%" bgcolor="#FFFF00"></td>
                                        <%} else if (sev.equals(s4)) {%>
                                        <td width="1%" bgcolor="#00FF40"><br>
                                        </td>
                                        <%}%>
                                        <td width="9%" TITLE="<%= type%>"><a
                                                HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
                                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                                </font></a></td>
                                        <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                             size="1" color="#000000"><%= p%> </font></td>
                                                <%

                                                    if (project1.length() < 15) {
                                                %>
                                        <td width="10%"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1%></font></td>
                                                <%
                                                } else {
                                                %>
                                        <td width="10%"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0, 15) + "..."%></font></td>
                                                <%
                                                    }
                                                %>
                                        <td width="7%" title="<%=fullModule%>"  ><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                       size="1" color="#000000"><%=module%></font></td>
                                        <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                                <%

                                                    String color = "";
                                                    //                    logger.info("Closed issue rating-->"+status);
                                                    if (status.equalsIgnoreCase("Closed")) {
                                                        //                      logger.info("Closed issue rating-->"+rating);
                                                        if (rating.equalsIgnoreCase("Excellent")) {
                                                            color = "#336600";
                                                            exlnt++;
                                                        } else if (rating.equalsIgnoreCase("Good")) {
                                                            color = "#33CC66";
                                                            good++;
                                                        } else if (rating.equalsIgnoreCase("Average")) {
                                                            color = "#CC9900";
                                                            avrg++;
                                                        } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                            color = "#CC0000";
                                                            ndimp++;
                                                        }
                                                        if (feedback == null) {
                                                            feedback = "";
                                                        }
                                                    } else {
                                                        feedback = "";
                                                    }


                                                %>

                                        <td width="9%" bgcolor="<%=color%>" title="<%=feedback%>" onclick="showPrint('<%=iss%>');"style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                                                 size="1" color="#000000"><%= status%> </font></td>
                                                <%

                                                    if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                                                        duedateexceeded++;
                                                %>
                                        <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                                            duedateexceeded++;
                                        %>
                                        <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else {
                                        %>
                                        <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td width="9%" title="Created By <%=member.get(Integer.parseInt(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                                            </font></td>
                                            <%
                                                int fileCount = IssueDetails.displayFiles(iss);
                                                if (fileCount > 0) {%>
                                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                             size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#"
                                                                        >ViewFiles(<%=fileCount%>)</A></font></td>
                                                    <%} else {%>
                                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                             size="1" color="#000000">No Files</font></td>
                                                <%}%>
                                        <td width="5%" align=center><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= age%></font>
                                        </td>
                                    </tr>

                                    <%}
                                        }
                                        if (rowcount > 0) {
                                    %>
                                    <tr align="left" bgcolor="#E8EEF7"><td colspan="12">Number of Due Date exceeded issues:    <%=duedateexceeded%></td></tr>
                                    <tr align="left" bgcolor=""><td colspan="7">Number of Closed Issues with Rating:</td></tr>
                                    <tr align="left" bgcolor="#E8EEF7"><td colspan="2">Excellent</td><td><%=exlnt%></td><td>Good</td><td><%=good%></td><td>Average:</td><td><%=avrg%></td><td>Need Improvement</td><td colspan="4"><%=ndimp%></td></tr>

                                    <%
                                        }
                                    %>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>


                <table width="100%" >
                    <%
                        try {
                            List l = TestCasePlan.getTestCases(userId, stDate, edDate);
                            int noOfRecords = l.size();
                            if (noOfRecords > 0) {
                    %>

                    <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> TQM Block</b></td></tr>
                    <tr height="10">
                        <td colspan="11">
                            <table width="100%">
                                <tr height="10">
                                    <td align="left" width="100%"><a href="#" onclick="collapse('tqm', 150);
                                            return false;" style="text-decoration: none;color: black" class="trigger" title="TQM" >The total <b style="color: blue">TQM Worked Test Cases</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=noOfRecords%>.
                                            </b></a></td>

                            </table>
                        </td>
                    </tr>
                    <tr><td>
                            <div id="tqm" class="hide_in" >
                                <table border="0" width="100%">
                                    <tr bgcolor="#C3D9FF" align="left">
                                        <td width="8%"><b>TestCaseId</b></td>
                                        <td width="15%"><b>Project</b></td>
                                        <td width="20%"><b>Functionality</b></td>
                                        <td width="22%"><b>Description</b></td>
                                        <td width="20%"><b>Expected Result</b></td>
                                        <td width="10%"><b>Createdby</b></td>
                                        <td width="10%"><b>Status</b></td>
                                    </tr>
                                    <%
                                        int k = 1;
                                        HashMap statusMap = TestCasePlan.getTescaseStatus();
                                        for (Iterator i = l.iterator(); i.hasNext(); k++) {
                                            TqmTestcaseexecutionresult rslt = (TqmTestcaseexecutionresult) i.next();

                                            String ptcid = rslt.getPtcid().getPtcid();
                                            String func = rslt.getPtcid().getFunctionality();
                                            String desc = rslt.getPtcid().getDescription();
                                            String reslt = rslt.getPtcid().getExpectedresult();
                                            String project = GetProjects.getProjectName(((Integer) rslt.getPtcid().getPid()).toString());
                                            //      String created      =   "NA";
                                            String created = GetProjectManager.getUserName(rslt.getPtcid().getCreatedby());
                                            String status = (String) statusMap.get(rslt.getStatusid());

                                            java.util.Date date = rslt.getPtcid().getCreatedon();
                                            SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
                                            String requestedOn = sdfs.format(date);

                                            project = project.replace(":", " v");
                                            String funcTitle = func;
                                            String descTitle = desc;
                                            String rsltTitle = reslt;
                                            if (func.length() > 30) {
                                                func = func.substring(0, 30) + "...";
                                            }
                                            if (desc.length() > 30) {
                                                desc = desc.substring(0, 30) + "...";
                                            }
                                            if (reslt.length() > 30) {
                                                reslt = reslt.substring(0, 30) + "...";
                                            }

                                            if ((k % 2) != 0) {
                                    %>
                                    <tr bgcolor="white" height="22" align="left">
                                        <%
                                        } else {
                                        %>

                                    <tr bgcolor="#E8EEF7" height="22" align="left">
                                        <%
                                            }
                                        %>
                                        <td><a href="<%=request.getContextPath()%>/admin/tqm/viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%></a></td>
                                        <td><%=project%></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
                                        <td><%=created%></td>
                                        <td><%=status%></td>
                                    </tr>



                                    <%
                                        }%></table>
                            </div>
                        </td>
                    </tr>
                    <%}
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }

                    %>

                </table>

                <table width="100%">
                    <%    try {

                            if (rrDetails.length > 0) {
                    %>

                    <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> ERM Block</b></td></tr>
                    <tr height="10">
                        <td colspan="11">
                            <table width="100%">
                                <tr height="10">
                                    <td align="left" width="100%"><a href="#" onclick="collapse('erm', 150);
                                            return false;" style="text-decoration: none;color: black" class="trigger" title="ERM" >The total <b style="color: blue">ERM Worked Resource Requests</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=rrDetails.length%>.
                                            </b></a></td>

                            </table>
                        </td>
                    </tr>
                    <tr><td><div id="erm" class="hide_in" >
                                <table>
                                    <tr bgcolor="#C3D9FF" height="9" align="left">
                                        <td width="10%"><font><b>Request ID</b></font></td>
                                        <td width="10%"><font><b>Project</b></font></td>
                                        <td width="7%"><font><b>Team</b></font></td>
                                        <td width="12%"><font><b>RequestedBy</b></font></td>
                                        <td width="10%"><font><b>Position</b></font></td>
                                        <td width="10%"><font><b>Expertise</b></font></td>
                                        <td width="5%"><font><b>Experience</b></font></td>
                                        <td width="5%"><font><b>Status</b></font></td>
                                        <td width="12%"><font><b>AssignedTo</b></font></td>
                                        <td width="8%"><font><b>Due Date</b></font></td>
                                        <td width="3%" align="center"><font><b>Age</b></font></td>


                                    </tr>

                                    <%
                                        for (int s = 0; s < rrDetails.length; s++) {
                                            String one = rrDetails[s][0];
                                            String two = rrDetails[s][1];
                                            String three = rrDetails[s][2];
                                            String four = rrDetails[s][3];
                                            String five = rrDetails[s][4];
                                            String six = rrDetails[s][5];
                                            String seven = rrDetails[s][6];
                                            String eight = rrDetails[s][7];
                                            String requestedBy = rrDetails[s][8];
                                            String assignedTo = rrDetails[s][9];
                                            String createdOn = rrDetails[s][10];
                                            String age = "NA";
                                            if (createdOn != null) {
                                                age = sdf.format(dateConversion.parse(createdOn));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();

                                            }

                                            String dueDate = "NA";
                                            if (eight != null) {
                                                dueDate = sdf.format(dateConversion.parse(eight));
                                            }

                                            assignedTo = GetName.getUserName(assignedTo);
                                            requestedBy = GetName.getUserName(requestedBy);
                                            String color = "";
                                            if ((s % 2) != 0) {
                                                color = "white";
                                            } else {
                                                color = "#E8EEF7";
                                            }
                                    %>
                                    <tr bgcolor="<%=color%>" align="left"><td><%=one%></td><td><%=two%></td><td><%=three%></td><td><%=requestedBy.substring(0, requestedBy.indexOf(" ") + 2)%></td><td><%=four%></td><td><%=five%></td><td><%=six%></td><td><%=seven%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                            <%
                                                }
                                                                                %></table>
                            </div>
                        </td>
                    </tr>
                    <%}
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }

                    %>

                </table>

                <%    try {

                        if (timeSheet.length > 0) {
                %>
                <table width="100%">
                    <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> Timesheet Block</b></td></tr>
                    <tr height="10">
                        <td colspan="11">
                            <table width="100%">
                                <tr height="10">
                                    <td align="left" width="100%"><a href="#" onclick="collapse('timesheet', 150);
                                            return false;" style="text-decoration: none;color: black" class="trigger" title="ERM" >The total <b style="color: blue">ERM Timesheets Evaluated</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=timeSheet.length%>.
                                            </b></a></td>

                            </table>
                        </td>
                    </tr>
                    <tr><td><div id="timesheet" class="hide_in" >
                                <table width="100%">
                                    <tr bgcolor="#C3D9FF" height="9" align="left">
                                        <td width="15%"><font><b>Timesheet ID</b></font></td>
                                        <td width="20%"><font><b>RequestedBy</b></font></td>
                                        <td width="15%"><font><b>RequestedOn </b></font></td>
                                        <td width="15%"><font><b>Period </b></font></td>
                                        <td width="15%"><font><b>Approval Status</b></font></td>
                                        <td width="20%"><font><b>AssignedTo</b></font></td>


                                    </tr>

                                    <%
                                        for (int s = 0; s < timeSheet.length; s++) {
                                            String timesheetId = timeSheet[s][0];
                                            String owner = timeSheet[s][1];
                                            String approvalStatus = timeSheet[s][2];
                                            String assignedTo = timeSheet[s][3];
                                            String requestedOn = timeSheet[s][4];

                                            String period = timesheetId.substring(1, timesheetId.length() - 3);
                                            String month = timesheetId.substring(1, 3);
                                            String year = timesheetId.substring(3, 7);
                                            String timesheetPeriod = monthSelect.get(Integer.parseInt(month)) + " " + year;

                                            String requestDate = "NA";
                                            if (requestedOn != null) {
                                                requestDate = sdf.format(dateConversion.parse(requestedOn));
                                            }
                                            String status = "Yet To Approve";
                                            if (approvalStatus != null) {
                                                status = approvalStatus;
                                            }

                                            assignedTo = GetName.getUserName(assignedTo);
                                            owner = GetName.getUserName(owner);
                                            String color = "";
                                            if ((s % 2) != 0) {
                                                color = "white";
                                            } else {
                                                color = "#E8EEF7";
                                            }
                                    %>
                                    <tr bgcolor="<%=color%>" align="left"><td><%=timesheetId%></td><td><%=owner.substring(0, owner.indexOf(" ") + 2)%></td><td><%=requestDate%></td><td><%=timesheetPeriod%></td><td><%=status%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td></tr>
                                            <%
                                                }
                                            %>
                                </table></div></td></tr>
                </table>
                <%}
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }

                %>

                <%if (wrmcount > 0 && (wrm != null && wrm.length > 0)) {
                %>
                <br/>
                <table width="100%">                                
                    <thead>
                        <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">
                            <%
                                try {
                                    String projSplit = "", title = "";
                                    for (String s : wrm[0]) {
                                        if (s == null) {
                                            s = "";
                                        }
                                        try {
                                            if (s.equals("")) {
                                                projSplit = "Project";
                                                title = "";
                                            } else {
                                                projSplit = s.substring(0, s.indexOf("&&&"));
                                                title = s.substring(s.indexOf("&&&") + 3, s.length());
                                            }
                                        } catch (Exception e) {
                                            //              logger.error(e.getMessage());
                                            projSplit = "";
                                            title = "";
                                        }
                            %>  
                            <th  style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                <%
                                        }
                                    } catch (Exception e) {
                                        logger.error(e.getMessage());
                                    }
                                %>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 1; i < wrm.length; i++) {
                        %>
                        <tr <%if (i % 2 == 0) {%>class="zebraline"<%} else {%>class="zebralinealter"<%}%>>
                            <%
                                String color = "", rating = "", wrmDate = "", rat = "Not Done", momClientId = "";
                                int count = 0;
                                for (int k = 0; k < wrm[i].length; k++) {
                                    momClientId = "";
                                    rat = wrm[i][k];
                                    if (rat == null) {
                                        rat = "Not Done";
                                    } else {
                                        if (!rat.equals("Not Done")) {
                                            try {
                                                if (rat.contains(",")) {
                                                    rating = "";
                                                    wrmDate = "";
                                                    count = 0;
                                                    for (String val : rat.split(",")) {
                                                        wrmDate = val.replace("&&&", " @ ") + "," + wrmDate;
                                                        if (count == 0) {
                                                            rating = val.split("&&&")[0];
                                                        }
                                                        count++;
                                                    }
                                                    if (wrmDate.contains("@@@@")) {
                                                        momClientId = wrmDate.split("@@@@")[1];
                                                        momClientId = momClientId.substring(0, momClientId.length() - 1);
                                                        wrmDate = wrmDate.substring(0, wrmDate.indexOf("@@@@"));
                                                    }
                                                } else {
                                                    rating = rat.split("&&&")[0];
                                                    wrmDate = rat.split("&&&")[1];
                                                    if (wrmDate.contains("@@@@")) {
                                                        momClientId = wrmDate.split("@@@@")[1];
                                                        wrmDate = wrmDate.substring(0, wrmDate.indexOf("@@@@"));
                                                    }
                                                }
                                                if (rating.equalsIgnoreCase("Excellent")) {
                                                    color = "#336600";
                                                } else if (rating.equalsIgnoreCase("Good")) {
                                                    color = "#33CC66";
                                                } else if (rating.equalsIgnoreCase("Average")) {
                                                    color = "#CC9900";
                                                } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                    color = "#CC0000";
                                                } else {
                                                    rating = "<b>" + rating + "</b>";
                                                    wrmDate = wrmDate;
                                                }
                                            } catch (Exception e) {
                                                rating = rat;
                                                wrmDate = "";
                                                color = "";
                                            }
                                        } else {
                                            rating = rat;
                                            wrmDate = "";
                                            color = "red";
                                        }
                                    }
                            %>
                            <td style=" border: 1px solid #ccccff; background-color: <%=color%>" title="<%=wrmDate%>">
                                <%if (!momClientId.equals("")) {%>
                                <a href="/eTracker/MOM/printWRM.jsp?momClientId=<%=momClientId%>" class="rating" target="_blank"> <%=rating%> </a>
                                <%} else {%>
                                <%=rating%>
                                <%
                                    }
                                %>    
                            </td>
                            <% }    %>
                        </tr>
                        <%  }    %>
                    </tbody>
                </table>
                <%  }    %>

                <%    try {

                        if (leaveRequest.length > 0) {
                %>
                <table width="100%">
                    <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> Leave Approval Management </b></td></tr>
                    <tr height="10">
                        <td colspan="11">
                            <table width="100%">
                                <tr height="10">
                                    <td align="left" width="100%"><a href="#" onclick="collapse('leave', 150);
                                            return false;" style="text-decoration: none;color: black" class="trigger" title="LAM" >The total <b style="color: blue">LAM Leave Request</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=leaveRequest.length%>.
                                            </b></a></td>

                            </table>
                        </td>
                    </tr>
                    <tr><td><div id="leave" class="hide_in" >
                                <table width="100%">
                                    <tr bgcolor="#C3D9FF" height="9" align="left">
                                        <td width="10%"><font><b>Leave Type</b></font></td>
                                        <td width="10%"><font><b>RequestedBy</b></font></td>
                                        <td width="10%"><font><b>From Date </b></font></td>
                                        <td width="10%"><font><b>To Date </b></font></td>
                                        <td width="10%"><font><b>Approval Status</b></font></td>
                                        <td width="10%"><font><b>AssignedTo</b></font></td>
                                        <td width="10%"><font><b>Approver</b></font></td>
                                        <td width="17%"><font><b>Requested On</b></font></td>
                                        <td width="23%"><font><b>Approved On</b></font></td>

                                    </tr>

                                    <% HashMap<Integer, String> hm = new HashMap();
                                        hm.put(0, "Yet to Approve");
                                        hm.put(1, "Approved");
                                        hm.put(-1, "Rejected");
                                        hm.put(-2, "Cancelled");
                                        String fDate = "NA";
                                        String tDate = "NA";
                                        String requestDate = "NA";
                                        String modifiedDate = "NA";
                                        String status = "Yet To Approve";

                                        for (int s = 0; s < leaveRequest.length; s++) {
                                            fDate = "NA";
                                            tDate = "NA";
                                            requestDate = "NA";
                                            modifiedDate = "NA";
                                            status = "Yet To Approve";
                                            String type = leaveRequest[s][0];
                                            String requester = leaveRequest[s][1];
                                            String approvalStatus = leaveRequest[s][2];
                                            String fromDate = leaveRequest[s][3];
                                            String toDate = leaveRequest[s][4];
                                            String requestedOn = leaveRequest[s][5];
                                            String assignedTo = leaveRequest[s][6];
                                            String approver = leaveRequest[s][7];
                                            String modifiedOn = leaveRequest[s][8];

                                            if (requestedOn != null) {
                                                fDate = sdf.format(dateConversion.parse(fromDate));
                                            }
                                            if (requestedOn != null) {
                                                tDate = sdf.format(dateConversion.parse(toDate));
                                            }
                                            if (requestedOn != null) {
                                                requestDate = sdftimestamp.format(timestamp.parse(requestedOn));
                                            }

                                            if (approvalStatus != null) {
                                                status = approvalStatus;
                                            }
                                            if (modifiedOn != null && !approvalStatus.equals("0")) {
                                                modifiedDate = sdftimestamp.format(timestamp.parse(modifiedOn));
                                            }

                                            assignedTo = GetName.getUserName(assignedTo);
                                            requester = GetName.getUserName(requester);
                                            if (approver != null) {
                                                approver = member.get(Integer.parseInt(approver));
                                            } else {
                                                approver = "NA";
                                            }
                                            String color = "";
                                            if ((s % 2) != 0) {
                                                color = "white";
                                            } else {
                                                color = "#E8EEF7";
                                            }

                                    %>
                                    <tr bgcolor="<%=color%>" align="left"><td><%=type%></td><td><%=requester.substring(0, requester.indexOf(" ") + 2)%></td><td><%=fDate%></td><td><%=tDate%></td><td><%=hm.get((Integer) Integer.parseInt(approvalStatus))%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td><td><%=approver%></td><td><%=requestDate%></td><td><%=modifiedDate%></td></tr>
                                            <%
                                                }%></table></div></td></tr>
                </table><br/>
                <%}

                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }

                %>

                <table width="100%">
                    <%        float present = 0f;
                        float leaveDays = 0f;
                        leaveDays = CustomerUtil.getLeavedays(userId, start, end);
                        float presentDays = maxday - leaveDays;
                        java.util.Date startDate = sdf.parse(start);
                        java.util.Date endDate = sdf.parse(end);
                        int day = cal.get(Calendar.DAY_OF_MONTH);
                        if ((new java.util.Date()).compareTo(endDate) < 0) {
                            present = day - leaveDays;
                        } else {
                            present = presentDays;
                        }
                        Set<java.util.Date> holidayDatesList = new HashSet();
                        List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidays(startDate, endDate);
                        if (!holidaysList.isEmpty()) {
                            for (Holidays holday : holidaysList) {
                                holidayDatesList.add(holday.getHolidayDate());
                            }
                        }
                        logger.info(".size()" + holidayDatesList);
                        maxday = maxday - holidayDatesList.size();
                        present = present - holidayDatesList.size();
                        int workingdays = LeaveUtil.getWorkingDaysBetweenTwoDates(startDate, endDate);
                        workingdays = workingdays - holidayDatesList.size();
                        int workinghours = workingdays * 8;
                    %>
                    <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="6" ><b> Leave Approval Management </b></td></tr>
                    <tr bgcolor="#E8EEF7" align="left"><td colspan="2">No of Working Days:   <b><%=maxday%></b></td><td colspan="2">Leave Taken:     <b>
                                <%
                                    if (leaveDays > 0) {
                                %>
                                <a href="<%=request.getContextPath()%>/leaveTaken.jsp?period=<%=selectedPeriod%>&start=<%=start%>&end=<%=end%>&userId=<%=userId%>" target="_blank"><%=leaveDays%></a>
                                <%} else {%>
                                <%=leaveDays%>
                                <%}%>

                            </b></td><td colspan="2">Present:     <b><%=present%></b> Days</td></tr>
                </table>
                <br>
                <br>
                <table bgcolor="E8EEF7" width="100%" id="approval" border="0"> 
                    <tr  align="left"><td><input type="hidden" name="currentassign" id="currentassign" value="<%=currentUser%>"/></td><td><input type="hidden" name="timeSheetId" id="timeSheetId" value="<%=timeSheetId%>"/></td></tr>
                            <%
                                Timesheet timesheet = CreateTimeSheet.GetTimeSheetDetails(timeSheetId);
                                String accomplishment = timesheet.getAccomplishments();
                                if (accomplishment == null) {
                                    accomplishment = "NA";
                                }
                                String learning = timesheet.getLearning();
                                if (learning == null) {
                                    learning = "NA";
                                }
                                String status = timesheet.getApprovalstatus();
                                logger.info("Stat from DB" + status);
                                if (status == null) {
                                    status = "NA";
                                }
                                String stat = "NA";
                                if (status.equalsIgnoreCase("NA")) {
                                    stat = "--Select One--";
                                } else {
                                    stat = status;
                                }
                                String availableStatus[] = {"--Select One--", "Need Info", "Approved"};

                                String suggestions = timesheet.getSuggestion();
                                if (suggestions == null) {
                                    suggestions = "NA";
                                }
                                String hardship = timesheet.getHardship();
                                if (hardship == null) {
                                    hardship = "NA";
                                }
                                String plan = timesheet.getPlan();
                                if (plan == null) {
                                    plan = "NA";
                                }
                            %>
                    <tr align="left"><td width="10%"><b>Accomplishments</b></td><td><%=accomplishment%></td>
                    <tr align="left"><td width="10%"><b>Learnings</b></td><td><%=learning%></td>
                    <tr align="left"><td width="10%"><b>Suggestions</b></td><td><%=suggestions%></td>
                    <tr align="left"><td width="10%"><b>Hardship Faced</b></td><td><%=hardship%></td>

                    <tr align="left"><td width="10%"><b>Next Month Plan </b></td><td><%=plan%>
                            <input type="hidden" id="role" value="<%=role%>"/>
                        </td>
                        <%
                            if (role == 3 && currentUser == userId) {%>

                    <tr align="left" >
                        <td width="30%"><b>Total hours at Eminentlabs office for CRM activities :</b></td>
                        <td>
                            <input type="number"  id="eminentHours" name="eminentHours" min="0"> &nbsp; <span style="font-weight: bold">Total Hours: <%=workinghours%></SPAN>
                        </td>
                    </tr>
                    <tr align="left">
                        <td width="30%"><b>Total hours at Client Place meetings :</b></td>
                        <td>
                            <input type="number"  id="meetingHours" name="meetingHours" min="0">
                        </td>
                    </tr>              


                    <tr align="left" id="wonaccounttr">
                        <td width="30%"><b>Have you won a New Customer Purchase Order for this <%=monthSelect.get(month)%> <%=year%></b></td>
                        <td>
                            <input type="radio" name="wonaccount"  value="Yes" >Yes 
                            <input type="radio" name="wonaccount"  value="No" > No
                        </td>
                    </tr>
                    <tr align="left" id="accounts" style="display: none;"> 
                        <td colspan="6">
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="25%"><font><b>Account Name</b></font></td>
                                    <td width="20%"><font><b>Billing State</b></font></td>
                                    <td width="15%"><font><b>Type</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="15%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>
                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : accDetails) {
                                        age = "NA";
                                                                                        assignedto = "NA";
                                        dueDate = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        } else {
                                        age = "NA";
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                                                                         assignedto = "NA";
                                        }
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }

                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><input type="checkbox" name="wonaccountid" class="wonaccountid" onclick="updateaccountCount()" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getEmail()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%s++;
                                            }
                                        %>
                            </TABLE>

                        </TD>
                    </tr>
                    <tr align="left" id="metdecisionmakertr" style="display: none;">
                        <td width="30%"><b>Have your met more than 5 decision makers for this <%=monthSelect.get(month)%> <%=year%></b></td>
                        <td>
                            <input type="radio" name="metdecisionmaker"  value="Yes" >Yes 
                            <input type="radio" name="metdecisionmaker"  value="No" > No
                        </td>
                    </tr>
                    <tr align="left" id="metdecisionmakertable" style="display: none;"> 
                        <td colspan="6">
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="20%"><font><b>Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    s = 0;
                                    for (CRMSearchBean bean : leadDetails) {
                                        if (bean.getContactType().equalsIgnoreCase("Decision Maker")) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><input type="checkbox" name="metdecisionmakerid" class="metdecisionmakerid" onclick="updatemetdecisionmakerCount()" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>

                                <% s++;
                                        }
                                    }
                                %>
                            </TABLE>

                        </TD>
                    </tr>
                    <tr align="left" id="identifieddecisionmakertr" style="display: none;">
                        <td width="30%"><b>Have you identified more than 10 decision makers for this <%=monthSelect.get(month)%> <%=year%></b></td>
                        <td>
                            <input type="radio" name="identifieddecisionmaker"  value="Yes" >Yes 
                            <input type="radio" name="identifieddecisionmaker"  value="No" > No
                        </td>
                    </tr>
                    <tr align="left" id="identifieddecisionmakertable" style="display: none;"> 
                        <td colspan="6">
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="20%"><font><b>Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    s = 0;
                                    for (CRMSearchBean bean : leadDetails) {
                                        if (bean.getContactType().equalsIgnoreCase("Decision Maker")) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td>  <input type="checkbox" name="identifieddecisionmakerid" class="identifieddecisionmakerid" onclick="updateidtdecisionmakerCount()" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>

                                <% s++;
                                        }
                                    }
                                %>
                            </TABLE>

                        </TD>
                    </tr>
                    <tr align="left" id="metinfluencerstr" style="display: none;"> 
                        <td width="30%"><b>Have you met more than 15 influencers for this <%=monthSelect.get(month)%> <%=year%></b></td>
                        <td>
                            <input type="radio" name="metinfluencers"  value="Yes" >Yes 
                            <input type="radio" name="metinfluencers"  value="No" > No
                        </td>
                    </tr>
                    <tr align="left" id="metinfluencerstable" style="display: none;"> 
                        <td colspan="6">
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="20%"><font><b>Lead Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    s = 0;
                                    for (CRMSearchBean bean : leadDetails) {
                                        if (bean.getContactType().equalsIgnoreCase("Influencer")) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td>  <input type="checkbox" class="metinfluencersid" onclick="updatemetinfluencerCount()" name="metinfluencersleadid" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>

                                <% s++;
                                        }
                                    }
                                %>
                            </TABLE>
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="20%"><font><b>Contact Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <% s = 0;
                                    for (CRMSearchBean bean : conDetails) {
                                        if (bean.getContactType().equalsIgnoreCase("Influencer")) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td>  <input type="checkbox" class="metinfluencersid" onclick="updatemetinfluencerCount()" name="metinfluencercontactid" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>

                                <%s++;
                                        }
                                    }
                                %>
                            </TABLE>

                        </TD>
                    </tr>
                    <tr align="left" id="identifiedinfluencerstr" style="display: none;">
                        <td width="30%"><b>Have you identified more than 30 influencers this <%=monthSelect.get(month)%> <%=year%></b></td>
                        <td>
                            <input type="radio" name="identifiedinfluencers"  value="Yes" >Yes 
                            <input type="radio" name="identifiedinfluencers"  value="No" > No
                        </td>
                    </tr>
                    <tr align="left" id="identifiedinfluencerstable" style="display: none;"> 
                        <td colspan="6">
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="20%"><font><b>Lead Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    s = 0;
                                    for (CRMSearchBean bean : leadDetails) {
                                        if (bean.getContactType().equalsIgnoreCase("Influencer")) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td>         <input type="checkbox" class="idinfluencersid" onclick="updateidinfluencerCount()" name="identifiedinfluencersleadid" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%s++;
                                                }
                                            }
                                        %>
                            </TABLE>
                            <TABLE width="90%">
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="20%"><font><b>Contact Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    s = 0;
                                    for (CRMSearchBean bean : conDetails) {
                                        if (bean.getContactType().equalsIgnoreCase("Influencer")) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td> <input type="checkbox" class="idinfluencersid" onclick="updateidinfluencerCount()" name="identifiedinfluencercontactid" value="<%=bean.getId()%>"><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>

                                <% s++;
                                        }
                                    }
                                %>
                            </TABLE>

                        </TD>
                    </tr>
                    <tr id="approvalTr" style="display: none;"><td><b>Approval %</b></td><td><input type="text" name="percentage" id="percentage" size="1" readonly></td></tr>
                    <tr id="appreciationTr" style="display: none;"><td><b>Appreciation</b></td><td><textarea name="appreciation" id="appreciation" cols="70" rows="3" readonly></textarea></td></tr>
                    <tr id="feedbackTr" style="display: none;"><td><b>Feedback</b></td><td><textarea name="feedback" id="feedback" cols="70" rows="3" readonly></textarea></td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="hidden" name="status" id="status" value="Approved">
                            <input type="submit" id="submit" value="Submit"/><input type="reset" id="reset" value="Reset"/>
                        </td>
                    </tr>
                    <% } else {%>
                    <%if (currentUser == timeSheetApprovalUserId) { %>
                    <tr align="left">
                        <td width="10%"><b>Status</b></td>
                        <td>

                            <select name="status" id="status" size="1" onchange="addRow();" >
                                <%                    for (int i = 0; i < availableStatus.length; i++) {
                                        if (status.equalsIgnoreCase(availableStatus[i])) {
                                %>
                                <option value="<%= availableStatus[i]%>" selected><%= availableStatus[i]%></option>
                                <% } else {%>
                                <option value="<%= availableStatus[i]%>" ><%= availableStatus[i]%></option>

                                <% }
                                    } %>
                            </select>
                        </td>

                    </tr>
                    <%
                        }
                        if (status.equalsIgnoreCase("Need Info") && currentUser != timeSheetApprovalUserId) {

                    %>
                    <tr>
                        <td>
                            <b>Info</b>
                        </td>
                        <td>
                            <textarea cols="70" rows="3" name="needinfo" id="needinfo"></textarea>
                            <script type="text/javascript">

                                CKEDITOR.replace('needinfo', {height: 100});
                                var editor_data = CKEDITOR.instances.needinfo.getData();

                            </script>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="status" id="status" value="<%=status%>">
                        </td>
                        <td align="center">
                            <input type="submit" id="submit" value="Add Info"/><input type="reset" id="reset" value="Reset"/>
                        </td>
                    </tr>
                    <% }
                        } %>



                </table>
            </form>
            <%            List l = CreateTimeSheet.GetCommentDetails(timeSheetId);
                int noOfRecords = l.size();
                if (noOfRecords > 0) {
            %>
            <iframe src="comments.jsp?timeSheetId=<%= timeSheetId%>" scrolling="auto" frameborder="2" height="20%" width="100%"></iframe>
                <%
                    }
                %>


            <%
                } catch (Exception e) {
                    e.printStackTrace();
                    logger.error("Exception:" + e);
                    logger.error(e.getMessage());
                }


            %>
        </center>
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
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script> 
    <script src="<%= request.getContextPath()%>/javaScript/jquery.min.js"></script>

    <script type="text/javascript">
                    function showPrint(issueid) {
                        window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
                    }
                    $(document).ready(function () {
                        if (<%=currentUser%> == <%=timeSheetApprovalUserId%>) {
                            addRow();
                        }
                        if ($("#assignedto").length == 0) {
                            //it doesn't exist
                        } else {
                            $("#assignedto").val(<%=needInfoUserId%>);
                        }
                        $('input:radio[name="wonaccount"]').change(function () {
                            $('#percentage').val('');
                            $('#appreciation').val('');
                            $('#feedback').val('');
                            $('#approvalTr').hide();
                            $('#appreciationTr').hide();
                            $('#feedbackTr').hide();
                            $('#metdecisionmakertr').hide();
                            $('#metdecisionmakertable').hide();
                            $('#identifieddecisionmakertr').hide();
                            $('#identifieddecisionmakertable').hide();
                            $('#metinfluencerstr').hide();
                            $('#metinfluencerstable').hide();
                            $('#identifiedinfluencerstr').hide();
                            $('#identifiedinfluencerstable').hide();
                            $('input:radio[name="metdecisionmaker"]').removeAttr("checked");
                            if ($(this).val() === 'Yes') {
                                $('#accounts').show();
                            } else {
                                $('#accounts').hide();
                                $('#metdecisionmakertr').show();
                            }
                        });

                        $('input:radio[name="metdecisionmaker"]').change(function () {
                            $('#percentage').val('');
                            $('#appreciation').val('');
                            $('#feedback').val('');
                            $('#approvalTr').hide();
                            $('#appreciationTr').hide();
                            $('#feedbackTr').hide();
                            $('input:radio[name="identifieddecisionmaker"]').removeAttr("checked");
                            $('#identifieddecisionmakertr').hide();
                            $('#identifieddecisionmakertable').hide();
                            $('#metinfluencerstr').hide();
                            $('#metinfluencerstable').hide();
                            $('#identifiedinfluencerstr').hide();
                            $('#identifiedinfluencerstable').hide();
                            if ($(this).val() === 'Yes') {
                                $('#metdecisionmakertable').show();
                            } else {
                                $('#metdecisionmakertable').hide();
                                $('#identifieddecisionmakertr').show();
                            }
                        });

                        $('input:radio[name="identifieddecisionmaker"]').change(function () {
                            $('input:radio[name="metinfluencers"]').removeAttr("checked");
                            $('#percentage').val('');
                            $('#appreciation').val('');
                            $('#feedback').val('');
                            $('#approvalTr').hide();
                            $('#appreciationTr').hide();
                            $('#feedbackTr').hide();
                            $('#metinfluencerstr').hide();
                            $('#metinfluencerstable').hide();
                            $('#identifiedinfluencerstr').hide();
                            $('#identifiedinfluencerstable').hide();
                            if ($(this).val() === 'Yes') {
                                $('#identifieddecisionmakertable').show();
                            } else {
                                $('#identifieddecisionmakertable').hide();
                                $('#metinfluencerstr').show();
                            }
                        });
                        $('input:radio[name="metinfluencers"]').change(function () {
                            $('#percentage').val('');
                            $('#appreciation').val('');
                            $('#feedback').val('');
                            $('#approvalTr').hide();
                            $('#appreciationTr').hide();
                            $('#feedbackTr').hide();
                            $('input:radio[name="identifiedinfluencers"]').removeAttr("checked");

                            $('#identifiedinfluencerstr').hide();
                            $('#identifiedinfluencerstable').hide();
                            if ($(this).val() === 'Yes') {
                                $('#metinfluencerstable').show();
                            } else {
                                $('#metinfluencerstable').hide();
                                $('#identifiedinfluencerstr').show();
                            }
                        });
                        $('input:radio[name="identifiedinfluencers"]').change(function () {
                            $('#percentage').val('');
                            $('#appreciation').val('');
                            $('#feedback').val('');
                            $('#approvalTr').hide();
                            $('#appreciationTr').hide();
                            $('#feedbackTr').hide();
                            if ($(this).val() === 'Yes') {
                                $('#identifiedinfluencerstable').show();
                            } else {
                                $('#identifiedinfluencerstable').hide();
                                $('#identifiedinfluencerstr').show();
                                $('#percentage').val('0');
                                $('#appreciation').val('Poor');
                                $('#feedback').val('Warning for your poor performance for this <%=monthSelect.get(month)%> <%=year%>');
                                $('#approvalTr').show();
                                $('#appreciationTr').show();
                                $('#feedbackTr').show();
                            }
                        });




                        window.updateaccountCount = function () {
                            var x = $(".wonaccountid:checked").length;
                            if (x >= 1) {
                                $('#percentage').val('100');
                                $('#appreciation').val('Excellent');
                                $('#feedback').val('Excellent approved with 100% for <%=monthSelect.get(month)%> <%=year%> ');
                                $('#approvalTr').show();
                                $('#appreciationTr').show();
                                $('#feedbackTr').show();
                            } else {
                                $('#percentage').val('');
                                $('#appreciation').val('');
                                $('#feedback').val('');
                                $('#approvalTr').hide();
                                $('#appreciationTr').hide();
                                $('#feedbackTr').hide();
                            }
                        };
                        window.updatemetdecisionmakerCount = function () {
                            var x = $(".metdecisionmakerid:checked").length;
                            if (x >= 5) {
                                $('#percentage').val('50');
                                $('#appreciation').val('Very Good');
                                $('#feedback').val('Keep up your good work and win a new customer PO next <%=monthSelect.get(currentMonth)%> <%=year%> . All the best. ');
                                $('#approvalTr').show();
                                $('#appreciationTr').show();
                                $('#feedbackTr').show();
                            } else {
                                $('#percentage').val('');
                                $('#appreciation').val('');
                                $('#feedback').val('');
                                $('#approvalTr').hide();
                                $('#appreciationTr').hide();
                                $('#feedbackTr').hide();
                            }
                        };
                        window.updateidtdecisionmakerCount = function () {
                            var x = $(".identifieddecisionmakerid:checked").length;
                            if (x >= 10) {
                                $('#percentage').val('33');
                                $('#appreciation').val('Good');
                                $('#feedback').val('Try to meetup the decision makers and express your maximum on what you know about Eminentlabs and win them for a new order next <%=monthSelect.get(currentMonth)%> <%=year%> . All the best.');
                                $('#approvalTr').show();
                                $('#appreciationTr').show();
                                $('#feedbackTr').show();
                            } else {
                                $('#percentage').val('');
                                $('#appreciation').val('');
                                $('#feedback').val('');
                                $('#approvalTr').hide();
                                $('#appreciationTr').hide();
                                $('#feedbackTr').hide();
                            }
                        };
                        window.updatemetinfluencerCount = function () {
                            var x = $(".metinfluencersid:checked").length;
                            if (x >= 15) {
                                $('#percentage').val('25');
                                $('#appreciation').val('Average');
                                $('#feedback').val('Try to meetup the influencers and find the decision makers and express your maximum on what you know about Eminentlabs and win them for a new order next <%=monthSelect.get(currentMonth)%> <%=year%>. All the best.');
                                $('#approvalTr').show();
                                $('#appreciationTr').show();
                                $('#feedbackTr').show();
                            } else {
                                $('#percentage').val('');
                                $('#appreciation').val('');
                                $('#feedback').val('');
                                $('#approvalTr').hide();
                                $('#appreciationTr').hide();
                                $('#feedbackTr').hide();
                            }
                        };
                        window.updateidinfluencerCount = function () {
                            var x = $(".idinfluencersid:checked").length;
                            if (x >= 30) {
                                $('#percentage').val('10');
                                $('#appreciation').val('Need Improvement');
                                $('#feedback').val('Try meeting the influencers with a fixed appointment and find the decision makers.approved with 10% for this <%=monthSelect.get(currentMonth)%> <%=year%>. All the best.');

                                $('#approvalTr').show();
                                $('#appreciationTr').show();
                                $('#feedbackTr').show();
                            } else {
                                $('#percentage').val('');
                                $('#appreciation').val('');
                                $('#feedback').val('');
                                $('#approvalTr').hide();
                                $('#appreciationTr').hide();
                                $('#feedbackTr').hide();
                            }
                        };


                    });


    </script>
</BODY>
</HTML>


