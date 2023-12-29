<%-- 
    Document   : addFineAmount
    Created on : Aug 19, 2014, 1:19:28 PM
    Author     : RN.Khans
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.mom.Fine"%>
<%@page import="com.eminentlabs.mom.formbean.MomTeamWiseFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("AddFineAmount");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");


%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }

%>
<%      Date date = new Date();
    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    String currentDate = dateFormat.format(date);
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript">
            function validate(theForm) {

                var date = theForm.finedate.value;
                var currentDate = theForm.currentDate.value;
                var parts = date.split('-');
                var date1 = new Date(parseInt(parts[2], 10), parseInt(parts[1], 10) - 1, parseInt(parts[0], 10));
                var parts1 = currentDate.split('-');
                var date2 = new Date(parseInt(parts1[2], 10), parseInt(parts1[1], 10) - 1, parseInt(parts1[0], 10));

                if ((theForm.userId.value) == '') {
                    alert('Select the User ');
                    theForm.userId.focus();
                    return false;
                }

                if ((theForm.reasonId.value) == '') {
                    alert('Select the reason ');
                    theForm.reasonId.focus();
                    return false;
                }

                if ((theForm.amount.value) == '' || (theForm.amount.value) == '0') {
                    alert('Enter the Fine Amount  ');
                    theForm.amount.focus();
                    return false;
                }
                if ((theForm.finedate.value) == '') {
                    alert('Enter the Fine Date  ');
                    theForm.finedate.focus();
                    return false;
                }
                if (Date.parse(date1) > Date.parse(date2)) {
                    alert('Fine Date is not in future date.');
                    theForm.finedate.focus();
                    return false;
                }


                monitorSubmit();
            }
        </script>
        <script type="text/javascript">
            function numbersonly(e) {
                var unicode = e.charCode ? e.charCode : e.keyCode
                if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
                    if (unicode < 48 || unicode > 57) //if not a number
                        return false;//disable key press
                }
            }
        </script>

    </head>
    <body oncontextmenu="return false;">
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="afa" class="com.eminentlabs.mom.AddFineAmtForUser"></jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 

    <%
       int wrmSize= mas.wrmIssues().size();
   afa.setAll(request);%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b> Fine Amount </b></font>
                </td>
            </tr>
        </table>

        <%int assignedto = (Integer) session.getAttribute("userid_curr");%>


        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;

                    <%if (afa.getModList().contains(((Integer) assignedto).toString())) {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer; font-weight: bold;">Add Fine</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/FinePayment.jsp" style="cursor: pointer;">Fine Collection</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/addReason.jsp" style="cursor: pointer;">Reason Maintain</a> &nbsp;&nbsp;&nbsp;      
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 }
                    %>

                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; " title="Due Date Report">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues  (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
<a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                </td>


            </tr>
        </table>

        <br/>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Add Fine Amount For User</b></font>
                </td>
            </tr>
        </table>
        <br/>
        <%if (afa.getModList().contains(((Integer) assignedto).toString())) {
        %>
        <form name="theForm" method="post" action="addFineAmtForUser.jsp" onsubmit="return validate(this)">
            <table width="70%" bgColor=#E8EEF7 border="0" align="center">
                <tr>
                    <td><strong>Name </strong></td>
                    <td>
                        <select name="userId" id="userId">
                            <option value="">Select</option>
                            <%for (Map.Entry<Integer, String> userBean : afa.getMember().entrySet()) {%>
                            <option value="<%=userBean.getKey()%>"><%=userBean.getValue()%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td><strong>Reason </strong></td>
                    <td> <select name="reasonId" id="reasonId">
                            <option value="">Select</option>
                            <%for (Fine fineBean : afa.getFineAmtList()) {%>
                            <option value="<%=fineBean.getId()%>"><%=fineBean.getReason()%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><strong>Amount</strong></td>
                    <td> <input type="text" id="amount" name="amount" maxlength="9"></td>
                </tr>
                <tr>
                    <td><strong>Date</strong></td>
                    <td> <input type="text" id="finedate" name="finedate"  maxlength="10" size="10" readonly  /><a href="javascript:NewCal('finedate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a>
                        <input type="hidden" id="currentDate" name="currentDate" value="<%=currentDate%>"/>

                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type=submit value=Submit name=submit id="submit"> <input
                            type="reset" id="reset" value=" Reset "></td>
                </tr>             
            </table>
        </form>

        <%
            if (afa.getResult() != null) {
                if (afa.getResult().equalsIgnoreCase("add")) {%>
        <div style="text-align: center; color: green; font-weight: bold;  ">
            -
            <p style="alignment-adjust: central"> Fine Amount Added Successfully.</p>
        </div>
        <%} else if (afa.getResult().equalsIgnoreCase("update")) {%> 
        <div style="text-align: center; color: green; font-weight: bold;  ">
            -
            <p style="alignment-adjust: central"> Fine Amount updated Successfully.</p>
        </div>
        <%} else {%> 
        <div style="text-align: center; color: red; font-weight: bold;  ">
            -
            <p style="alignment-adjust: central"> Fine amount is not added.</p>
        </div>
        <%}
            }%>

        <%                 } else {%>
        <div style="text-align: center; color: red;">          
            <p style="alignment-adjust: central"> You are not authorized to access this page.
            </p>
        </div>
        <%}%>
    </body>
    <script type="text/javascript">

        $(document).ready(function() {
            $("#amount").keydown(function(e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                        // Allow: Ctrl+A
                                (e.keyCode == 65 && e.ctrlKey === true) ||
                                // Allow: home, end, left, right
                                        (e.keyCode >= 35 && e.keyCode <= 39)) {
                            // let it happen, don't do anything
                            return;
                        }
                        // Ensure that it is a number and stop the keypress
                        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                            e.preventDefault();
                        }
                    });
        });

    </script>
</html>
