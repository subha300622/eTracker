<%-- 
    Document   : maintain<input type="text" id="ps" name="ps"/>
    Created on : 27 Oct, 2013, 7:08:08 PM
    Author     : Tamilvelan
--%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,dashboard.*"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("ViewProject");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <style type="text/css">
        .days table
        {
            border-collapse:collapse;
        }
        .days table, .days td, .days th 
        {
            border:1px solid lightblue;
        }
        input{
            width: 70%;
            outline-color: #53D9F0 ;
        }

    </style>
    <script type="text/javascript">

        function trim(str) {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function isPositiveInteger(str) {
            var pattern = "1234567890";
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
        function validate() {
            if ((document.getElementById('p1s1').value) === '') {
                alert('Please enter the P1S1 value ');
                document.getElementById('p1s1').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p1s1').value))) {
                alert('Please enter valid P1S1 value ');
                document.getElementById('p1s1').focus();
                return false;
            }
            if ((document.getElementById('p1s2').value) === '') {
                alert('Please enter the P1S2 value ');
                document.getElementById('p1s2').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p1s2').value))) {
                alert('Please enter valid P1S2 value ');
                document.getElementById('p1s2').focus();
                return false;
            }
            if ((document.getElementById('p1s3').value) === '') {
                alert('Please enter the P1S3 value ');
                document.getElementById('p1s3').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p1s3').value))) {
                alert('Please enter valid P1S3 value ');
                document.getElementById('p1s3').focus();
                return false;
            }
            if ((document.getElementById('p1s4').value) === '') {
                alert('Please enter the P1S4 value ');
                document.getElementById('p1s4').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p1s4').value))) {
                alert('Please enter valid P1S4 value ');
                document.getElementById('p1s4').focus();
                return false;
            }

            if ((document.getElementById('p2s1').value) === '') {
                alert('Please enter the P2S1 value ');
                document.getElementById('p2s1').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p2s1').value))) {
                alert('Please enter valid P2S1 value ');
                document.getElementById('p2s1').focus();
                return false;
            }
            if ((document.getElementById('p2s2').value) === '') {
                alert('Please enter the P2S2 value ');
                document.getElementById('p2s2').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p2s2').value))) {
                alert('Please enter valid P2S2 value ');
                document.getElementById('p2s2').focus();
                return false;
            }
            if ((document.getElementById('p2s3').value) === '') {
                alert('Please enter the P2S3 value ');
                document.getElementById('p2s3').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p2s3').value))) {
                alert('Please enter valid P2S3 value ');
                document.getElementById('p2s3').focus();
                return false;
            }
            if ((document.getElementById('p2s4').value) === '') {
                alert('Please enter the P2S4 value ');
                document.getElementById('p2s4').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p2s4').value))) {
                alert('Please enter valid P2S4 value ');
                document.getElementById('p2s4').focus();
                return false;
            }



            if ((document.getElementById('p3s1').value) === '') {
                alert('Please enter the P3S1 value ');
                document.getElementById('p3s1').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p3s1').value))) {
                alert('Please enter valid P3S1 value ');
                document.getElementById('p3s1').focus();
                return false;
            }
            if ((document.getElementById('p3s2').value) === '') {
                alert('Please enter the P3S2 value ');
                document.getElementById('p3s2').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p3s2').value))) {
                alert('Please enter valid P3S2 value ');
                document.getElementById('p3s2').focus();
                return false;
            }
            if ((document.getElementById('p3s3').value) === '') {
                alert('Please enter the P3S3 value ');
                document.getElementById('p3s3').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p3s3').value))) {
                alert('Please enter valid P3S3 value ');
                document.getElementById('p3s3').focus();
                return false;
            }
            if ((document.getElementById('p3s4').value) === '') {
                alert('Please enter the P3S4 value ');
                document.getElementById('p3s4').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p3s4').value))) {
                alert('Please enter valid P3S4 value ');
                document.getElementById('p3s4').focus();
                return false;
            }

            if ((document.getElementById('p4s1').value) === '') {
                alert('Please enter the P4S1 value ');
                document.getElementById('p4s1').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p4s1').value))) {
                alert('Please enter valid P4S1 value ');
                document.getElementById('p4s1').focus();
                return false;
            }
            if ((document.getElementById('p4s2').value) === '') {
                alert('Please enter the P4S2 value ');
                document.getElementById('p4s2').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p4s2').value))) {
                alert('Please enter valid P4S2 value ');
                document.getElementById('p4s2').focus();
                return false;
            }
            if ((document.getElementById('p4s3').value) === '') {
                alert('Please enter the P4S3 value ');
                document.getElementById('p4s3').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p4s3').value))) {
                alert('Please enter valid P4S3 value ');
                document.getElementById('p4s3').focus();
                return false;
            }
            if ((document.getElementById('p4s4').value) === '') {
                alert('Please enter the P4S4 value ');
                document.getElementById('p4s4').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('p4s4').value))) {
                alert('Please enter valid P4S4 value ');
                document.getElementById('p4s4').focus();
                return false;
            }
            monitorSubmit();
        }
    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>

    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Maintain Issue Resolution Days</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp" style="cursor: pointer;font-weight: bold;">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp" style="cursor: pointer;">Issue Category</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <%HashMap<String, Integer> resolutionDays = IssueDetails.getResolutionDays();%>
    <div id="loading">
        <form name=theForm onsubmit="return validate(this);" 	action="createResolutionDays.jsp" method=post">
            <table class="days" style="border-collapse:collapse;">
                <tr style="background-color:#C3D9FF;height: 21px; ">
                    <td><b>Priority</b></td><td><b>Severity</b></td><td><b>Days</b></td>
                    <td><b>Priority</b></td><td><b>Severity</b></td><td><b>Days</b></td>
                    <td><b>Priority</b></td><td><b>Severity</b></td><td><b>Days</b></td>
                    <td><b>Priority</b></td><td><b>Severity</b></td><td><b>Days</b></td>
                </tr>
                <tr >
                    <td style="color: blue;">P1</td><td style="color: blue;">S1</td><td><input type="text" id="p1s1" name="p1s1" size="1" maxlength="2" value="<%=resolutionDays.get("P1S1")%>"/></td>

                    <td style="color: blue;">P1</td><td style="color: blue;">S2</td><td><input type="text" id="p1s2" name="p1s2" size="1" maxlength="2" value="<%=resolutionDays.get("P1S2")%>"/></td>

                    <td style="color: blue;">P1</td><td style=" color: blue;">S3</td><td><input type="text" id="p1s3" name="p1s3" size="1" maxlength="2" value="<%=resolutionDays.get("P1S3")%>"/></td>

                    <td style="color: blue;">P1</td><td style=" color: blue;">S4</td><td><input type="text" id="p1s4" name="p1s4" size="1" maxlength="2" value="<%=resolutionDays.get("P1S4")%>"/></td>
                </tr>
                <tr style="background-color:#E8EEF7;">
                    <td style="color: blue;">P2</td><td style=" color: blue;">S1</td><td><input type="text" id="p2s1" name="p2s1" size="1" maxlength="2" value="<%=resolutionDays.get("P2S1")%>"/></td>

                    <td style="color: blue;">P2</td><td style=" color: blue;">S2</td><td><input type="text" id="p2s2" name="p2s2" size="1" maxlength="2" value="<%=resolutionDays.get("P2S2")%>"/></td>

                    <td style="color: blue;">P2</td><td style=" color: blue;">S3</td><td><input type="text" id="p2s3" name="p2s3" size="1" maxlength="2" value="<%=resolutionDays.get("P2S3")%>"/></td>

                    <td style=" color: blue;">P2</td><td style=" color: blue;">S4</td><td><input type="text" id="p2s4" name="p2s4" size="1" maxlength="2" value="<%=resolutionDays.get("P2S4")%>"/></td>
                </tr>
                <tr>
                    <td style=" color: blue;">P3</td><td style=" color: blue;">S1</td><td><input type="text" id="p3s1" name="p3s1" size="1" maxlength="2" value="<%=resolutionDays.get("P3S1")%>"/></td>

                    <td style=" color: blue;">P3</td><td style=" color: blue;">S2</td><td><input type="text" id="p3s2" name="p3s2" size="1" maxlength="2" value="<%=resolutionDays.get("P3S2")%>"/></td>

                    <td style=" color: blue;">P3</td><td style=" color: blue;">S3</td><td><input type="text" id="p3s3" name="p3s3" size="1" maxlength="2" value="<%=resolutionDays.get("P3S3")%>"/></td>

                    <td style=" color: blue;">P3</td><td style=" color: blue;">S4</td><td><input type="text" id="p3s4" name="p3s4" size="1" maxlength="2" value="<%=resolutionDays.get("P3S4")%>"/></td>
                </tr>
                <tr style="background-color:#E8EEF7;">
                    <td style=" color: blue;">P4</td><td style=" color: blue;">S1</td><td><input type="text" id="p4s1" name="p4s1" size="1" maxlength="2" value="<%=resolutionDays.get("P4S1")%>"/></td>

                    <td style=" color: blue;">P4</td><td style=" color: blue;">S2</td><td><input type="text" id="p4s2" name="p4s2" size="1" maxlength="2" value="<%=resolutionDays.get("P4S2")%>"/></td>

                    <td style=" color: blue;">P4</td><td style=" color: blue;">S3</td><td><input type="text" id="p4s3" name="p4s3" size="1" maxlength="2" value="<%=resolutionDays.get("P4S3")%>"/></td>

                    <td style=" color: blue;">P4</td><td style=" color: blue;">S4</td><td><input type="text" id="p4s4" name="p4s4" size="1" maxlength="2" value="<%=resolutionDays.get("P4S4")%>"/></td>
                </tr>
                <tr>
                    <td colspan="6" align="right" style="border: 0;"><input type="submit" id="submit"  value="Submit"  style="width: 30%;"/></td>

                </tr>
            </table>
        </form>
    </div>
    <noscript>
        <style>
            #loading {display:none}
        </style>
        <p  style="color: Red;text-align: center;font-size: 20px;">Please enable java script</font></p>
    </noscript>
</body>
</html>