<%-- 
    Document   : timeSheetHS_SG
    Created on : 19 May, 2015, 12:47:25 PM
    Author     : EMINENT
--%>

<%@page import="java.util.Set"%>
<%@page import="com.eminentlabs.timesheet.controller.TimeSheetFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<jsp:useBean id="tsu" class="com.eminent.timesheet.TimeSheetUtil"></jsp:useBean>

    <!DOCTYPE html>
    <html>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
        <link title=STYLE href="<%=request.getContextPath()%>/css/eminentstyles.css?test=17" type="text/css" rel="STYLESHEET"/>

        <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/redmond/jquery-ui.css">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

        <style>
            .ui-datepicker-calendar {
                display: none;
            }

        </style>
    </head>
    <body>
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
        <%mmc.setSendMomAll(request);
            int assignedto = (Integer) session.getAttribute("uid");
//            Integer timeSheetApprovalUserId = tsu.findUserIdByStatus(0);
//            Integer accountApprovalUserId = tsu.findUserIdByStatus(2);
String mail = (String) session.getAttribute("theName");
        %>

        <jsp:useBean id="hssc" class="com.eminentlabs.timesheet.controller.HardShipAndSuggestionController"></jsp:useBean>
        <%hssc.setAll(request);
           if (assignedto == 200 ||assignedto == 103 || assignedto == 112 || mail.equals("accounts@eminentlabs.net"))  {%>
        <div class="" style="background-color: #C3D9FF;height: 22px;margin-bottom: 20px;margin-top: 20px;padding:2px;" >
            <form name="testForm" method="Post" action="HS_SG.jsp"  >
                <label for="startDate" style="font-weight: bold;">Pick Month & Year :</label>
                <input type="text" name="startDate" id="startDate" size="11" class="date-picker" readonly="" onchange="callNew();" value="<%=hssc.getStartDate()%>"/>
            </form>
        </div>
        <p><%
            Set<Integer> usersList = mmc.getTotalUsers();
            if (usersList.contains(assignedto)) {%>

            <a href="/eTracker/MOM/weekPerformers.jsp?performerid=<%=assignedto%>">My Plan/Actual</a>&nbsp;&nbsp;&nbsp;&nbsp<a href="<%=request.getContextPath()%>/MyTimeSheet/teamClosedIssueReport.jsp" >My Rank </a>&nbsp;&nbsp;&nbsp;&nbsp
            <%}
                if (assignedto == 200 ||assignedto == 103 || assignedto == 112 || mail.equals("accounts@eminentlabs.net")) {%>
            <a href="/eTracker/timeSheet/HS_SG.jsp" style="font-weight: bold;">Hardship & Suggestions</a>&nbsp;&nbsp;&nbsp;&nbsp
            <a href="/eTracker/timeSheet/timeSheetAssigned.jsp">Time Sheet Submission</a>&nbsp;&nbsp;&nbsp;&nbsp
            <%}%></p>
            <%if (hssc.getTimeSheetFormBeans() != null) {%>
        <table  style = "width: 100%;margin-top: 20px;" > <tr style="background-color: #C3D9FF;font-weight: bold;height: 21px; ">
                <td style="width: 16%;"> Name </td>
                <td style="width: 44%;">Hardship</td > <td>Suggestion</td> 
            </tr>
            <% int i = 0;
                for (TimeSheetFormBean timeSheetFormBean : hssc.getTimeSheetFormBeans()) {
                    i++;
                    if (i % 2 != 0) {%>
            <tr style="height: 21px;">
                <% } else {%>
            <tr style="background-color: #E8EEF7;height: 21px;">
                <%}%>


                <td ><%=timeSheetFormBean.getName()%></td>
                <td><%=timeSheetFormBean.getHardship()%></td>
                <td><%=timeSheetFormBean.getSuggestion()%></td>

            </tr>
            <% }
            %>
        </table>
        <%}
        } else {%>
        <div style="text-align: center;color: red;">You are not authorized to access this page</div>
        <%}%>
    </body>
    <script type="text/javascript">
        var date = new Date(); // 2012-03-31
        date.setMonth(date.getMonth() - 1);
        $(function() {
            $('.date-picker').datepicker({
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                dateFormat: 'MM yy',
                maxDate: date,
                showOn: "button",
                buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
                buttonImageOnly: true,
                onClose: function() {
                    var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                    $(this).datepicker('refresh');

                    document.testForm.action = "HS_SG.jsp?startDate=" + $('#startDate').val();
                    document.testForm.submit();
                },
                beforeShow: function() {
                    if ((selDate = $(this).val()).length > 0) {

                        iYear = selDate.substring(selDate.length - 4, selDate.length);
                        iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
//                        alert(iYear + "," +iMonth );
                        $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
                        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                    }
                }

            });

        });
        $(".date-picker").focus(function() {
            $(".ui-datepicker-calendar").hide();
            $("#ui-datepicker-div").position({
                my: "center top",
                at: "center bottom",
                of: $(this)
            });
        });

        $(".date-picker").blur(function() {
            $(".ui-datepicker-calendar").hide();
        });
    </script>
</html>
