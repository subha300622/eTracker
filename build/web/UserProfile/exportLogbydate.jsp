<%-- 
    Document   : exportLogbydate
    Created on : 28 Jul, 2016, 9:53:00 AM
    Author     : admin
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("momDetails");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
<script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css?test=3">
<script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

<title>server Log</title>
</head>
<body>
    <%String pid = "10043";
        String project = "eTracker:3.0";%>
    <%@ include file="../header.jsp"%>

    <div style="height: 21px;background-color: #C3D9FE;font-weight: bold;padding: 1px;margin-top: 12px;"><span>Server Log</span>
    </div>
    <table style="width: 100%;">
        <tr>
            <td>
            <td>
                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">Business Process Map Dashboard View</a>&nbsp;&nbsp;&nbsp;

                <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;


                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;

                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 

                <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;

            </td>

        </tr></table>
    <div class="leaveForm">
        <form class="theForm" method="Post" action="<%=request.getContextPath()%>/UserProfile/exportAllLog.jsp" onsubmit="disableSubmit()" >
            <div style="width: 30%"> 
                <label > From Date </label><input type="text" name="fromDate" id="fromDate" maxlength="11" class="datepicker" value=""  readonly=""> 
            </div>
            <div style="width: 30%"> 
                <label> To Date</label> <input type="text" name="toDate" class="datepicker2" id="toDate" maxlength="11" value="" readonly="">
            </div>
            <div style="width: 38%"><input type="submit" name="submit" id="submit" value="Submit" class="ui-button ui-widget ui-state-default ui-corner-all"/> </div>
        </form>
    </div>
    <script>
        $(function () {
            $("#fromDate").datepicker({
                showOn: "both",
                buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
                buttonImageOnly: true,
                showButtonPanel: true,
                dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true,
                onSelect: function (dateStr)
                {
                    $("#toDate").datepicker("option", {minDate: dateStr});
                }

            });
        });
        $(function () {
            $("#toDate").datepicker({
                showOn: "both",
                buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
                buttonImageOnly: true,
                showButtonPanel: true,
                dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true
            });
        });

        $(document).on('focus', "#fromDate ,#toDate,#submit", function () {
            $(".error2").remove();
        });
        $('#submit').click(function () {
            $(".theForm span.error2").remove();
            var count = 0;
            var fromDate = $("#fromDate").val();
            var todate = $('.datepicker2').val();
            if (fromDate == "") {
                $("<span class='error2' style='margin-left:10px;'>from month can not be empty </span>").insertAfter("#submit");
                count = 1;
            } else if (todate == "") {
                $("<span class='error2' style='margin-left:10px;'>to month can not be empty </span>").insertAfter("#submit");
                count = 1;
            }
            if (count == 1) {
                return false;
            } else {
                count = 0;
                  lockoutSubmit();
                return true;
            }
          
        });
        function lockoutSubmit() {
            setTimeout(function () {
                $('#submit').val("Submit");
               document.getElementById('submit').disabled = false;
            }, 2000);
        }
    </script>
</body>
</html>
