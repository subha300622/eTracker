<%-- 
    Document   : fineReport
    Created on : Oct 28, 2014, 12:19:26 PM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.formbean.FinePaymentBean"%>
<%@page import="com.eminentlabs.mom.formbean.FineAmountBean"%>
<%@page import="com.eminentlabs.mom.formbean.FineReportBean"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("fineReport");
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
    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="far" class="com.eminentlabs.mom.FineReport"></jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 

    <%
       int wrmSize= mas.wrmIssues().size();
   far.setAll(request);%>

        <%int assignedto = (Integer) session.getAttribute("userid_curr");%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b> Monthly Fine Report  </b></font>
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
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer; ">Fine Amount </a> &nbsp;&nbsp;&nbsp;               
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer; font-weight: bold;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <br>
        <form name="theForm"  action="<%=request.getContextPath()%>/MOM/fineReport.jsp" method="post" onsubmit="javascript:disableSubmit();">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#E8EEF7">
                    <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                        COLOR="#0000FF"> <b> Fine Report for the Month of </b></font><FONT
                                                                        SIZE="3" COLOR="#0000FF"> </FONT>
                        <select name="month" id="month">
                            <%                            for (Entry<Integer, String> k : far.getMonthName().entrySet()) {

                                    if (k.getKey() == far.getMonth()) {
                            %>
                            <option value='<%=k.getKey()%>' selected><%=k.getValue()%></option>
                            <%
                            } else {
                            %>
                            <option value='<%=k.getKey()%>'><%=k.getValue()%></option>
                            <%
                                    }

                                }
                            %>

                        </select>



                        <select name='year' id='year' >
                            <%
                                for (Integer selectYear : far.getYears()) {
                                    if (selectYear == far.getYear()) {
                            %>
                            <option value='<%=selectYear%>' selected><%=selectYear%></option>
                            <%
                            } else {
                            %>
                            <option value='<%=selectYear%>'><%=selectYear%></option>
                            <%
                                    }

                                }

                            %>
                        </select>
                        <input type="submit" id="submit" value="Submit" ></td>
                </tr>
            </table>
        </form>
        <br/>

        <table  style="width: 100%;text-align: left;font-weight: bold;">
            <tr style="background-color: #C3D9FF;">
                <td style="width:24%; text-align: center;" >Name</td>
                <td style="width:18%; text-align: center;">Opening Balance</td>
                <td style="width:18%; text-align: center;"><%=far.getMonthName().get(far.getMonth())%>-<%=far.getYear()%> Fine Amount</td>
                <td style="width:18%; text-align: center;"><%=far.getMonthName().get(far.getMonth())%>-<%=far.getYear()%> Payment Amount</td>
                <td style="width:18%; text-align: center;">Closing Balance</td>
            </tr>
        </table>

        <% int size = 0;

            for (FineReportBean report : far.getReport()) {
                size++;
                if ((size % 2) != 0) {
        %>
        <table  style="width: 100%;height:25px;text-align: left;font-weight: bold;" >
            <tr>
                <td style="width:24%;"><%=report.getName()%></td>
                <td style="width:18%; text-align: center;"><%=report.getPrevBalance()%></td>
                <td style="width:18%; text-align: center;"> <a href="#" onclick="collapse('FAL<%=report.getUserId()%>', 150);
                        return false;"  class="trigger" ><%=report.getCurrMonFine()%></a></td>
                <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('FPL<%=report.getUserId()%>', 150);
                        return false;"  class="trigger" ><%=report.getCurrMonPaid()%></a></td>
                <td style="width:18%; text-align: center;"><%=report.getCloseBalance()%></td>
            </tr>          
        </table>
        <%} else {%>
        <table  style="width: 100%;height:25px;text-align: left;font-weight: bold;" >
            <tr style="background-color: #E8EEF7;">
                <td style="width:24%;"><%=report.getName()%></td>
                <td style="width:18%; text-align: center;"><%=report.getPrevBalance()%></td>
                <td style="width:18%; text-align: center;"> <a href="#" onclick="collapse('FAL<%=report.getUserId()%>', 150);
                        return false;"  class="trigger" ><%=report.getCurrMonFine()%></a></td>
                <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('FPL<%=report.getUserId()%>', 150);
                        return false;"  class="trigger" ><%=report.getCurrMonPaid()%></a></td>
                <td style="width:18%; text-align: center;"><%=report.getCloseBalance()%></td>
            </tr>          
        </table>
        <%}%>

        <div id="FAL<%=report.getUserId()%>" class="hide_me" >
            <table width="100%">
                <tr bgcolor="#C3D9FF" height="9" align="left">
                    <td width="25%"><font><b>Fine Date </b></font></td>
                    <td width="25%"><font><b>Amount</b></font></td>
                    <td width="50%"><font><b>Reason </b></font></td>  
                </tr>

                <% int a = 0;
                    for (FineAmountBean fab : report.getFineAmtList()) {
                        a++;
                        if ((a % 2) != 0) {
                %>
                <tr bgcolor="white" align="left">
                    <%} else {%>
                <tr bgcolor="#E8EEF7" align="left">
                    <%}%>
                    <td width="25%"><%=fab.getDate()%></td>
                    <td width="25%"><%=fab.getAmount()%></td>
                    <td width="50%"><%=fab.getReason()%> </td>  
                </tr>
                <%}%>

            </table></div>

        <div id="FPL<%=report.getUserId()%>" class="hide_me" >
            <table width="100%">
                <tr bgcolor="#C3D9FF" height="9" align="left">
                    <td width="25%"><font><b>Paid Date </b></font></td>
                    <td width="25%"><font><b>Amount</b></font></td>
                    <td width="50%"><font><b>Comments </b></font></td>  
                </tr>
                <% int b = 0;
                    for (FinePaymentBean fpb : report.getFinePaidList()) {
                        b++;
                        if ((b % 2) != 0) {
                %>
                <tr bgcolor="white" align="left">
                    <%} else {%>
                <tr bgcolor="#E8EEF7" align="left">
                    <%}%>
                    <td width="25%"><%=fpb.getDate()%></td>
                    <td width="25%"><%=fpb.getAmount()%></td>
                    <td width="50%"><%=fpb.getComments()%> </td>  
                </tr>
                <%}%>

            </table></div>
            <%}%>


    </body>
</html>
