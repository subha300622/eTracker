<%-- 
    Document   : daywiseEInvoiceCount
    Created on : 18 Oct, 2023, 10:05:48 AM
    Author     : Pavithra-P-ABAP
--%>


<%@page import="com.eminent.gstn.AccessKeyController"%>
<%@page import="com.eminent.gstn.Log"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
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
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=11" type="text/css" rel=STYLESHEET>
    <link href='<%=request.getContextPath()%>/css/fullcalendar.css?test=7' rel='stylesheet' />
    <link href='<%=request.getContextPath()%>/css/fullcalendar.print.css' rel='stylesheet' media='print' />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src='<%=request.getContextPath()%>/javaScript/moment.min.js'></script>
    <script src='<%=request.getContextPath()%>/javaScript/fullcalendar.min.js'></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
</head>
<body>
    <%@ include file="/header.jsp"%>

    <jsp:useBean id="akc" class="com.eminent.gstn.AccessKeyController"></jsp:useBean>
    <% int roleId = (Integer) session.getAttribute("Role");

    %>



    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF">
            <td border="1" align="left" width="70%">
                <font size="4" COLOR="#0000FF"><b> Daywise E-Invoicing</b></font>
            </td>                
        </tr>
    </table>
    <%  if (roleId == 1) {%> 
    <table width="100%" border="0">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
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
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" >GST 3in1 Cockpit</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp" style="cursor: pointer;">Issue Category</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;font-weight: bold;">Daywise E-Invoice</a>
            </td>
            <td></td>
        </tr>
    </table>
    <%}%> 
    <br/>
    <form>
        <table width="100%" bgColor=#E8EEF7 border="0" align="left">
            <tr>
                <td><strong>Project Name </strong></td>
                <td>
                    <select name="projectName" required="" id="projectName"  class="textbox_NoWidth">
                        <option>Select All</option>
                        <%for (String typ : akc.getEInvoicingproject()) {%>                                        
                        <option><%=typ%></option>
                        <%}%>                                  
                    </select>
                </td>

            </tr>
        </table>
    </form>

    <div id='calendar'>

    </div>



</body>

<style>



    #calendar {

        margin: 20px 20px auto;
        float: left;
    }

</style>
<script>

    $(document).ready(function() {
        callcalendar();

    });
    $('#projectName').on('change', function() {
        $('#calendar').fullCalendar('removeEventSource');
        var project = $('#projectName').find(":selected").text();
        var events = {
            url: '<%=request.getContextPath()%>/admin/project/getEInvoicingCal.jsp?flag=yes$project=' + project + '&month=3&year=2014&rand=' + Math.random(1, 10),
            type: 'GET'
        }


        $('#calendar').fullCalendar('addEventSource', events);
    });

//    $('.fc-prev').on('click', function() {
//        callcalendarx();
//
//    });



    function callcalendarx() {
        var event;
        var project = $('#projectName').find(":selected").text();
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/project/getEInvoicingCal.jsp?project=' + project + '&month=3&year=2014&rand=' + Math.random(1, 10),
            async: true,
            success: function(data) {
                event = $.trim(data);
            }, complete: function() {
                $('#calendar').fullCalendar('renderEvent', event, true);
            }
        });
    }
//    $('#calendar').fullCalendar({
//        header: {
//            left: 'prev,next stoday',
//            center: 'title'
//            },
//        editable: true
//    });
    function callcalendar() {
        var project = $('#projectName').find(":selected").text();
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next',
                center: 'title'
            },
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: '<%=request.getContextPath()%>/admin/project/getEInvoicingCal.jsp?project=' + project + '&month=3&year=2014&rand=' + Math.random(1, 10),
            eventMouseover: function(calEvent, jsEvent) {
                var tooltip = '<div class="tooltipevent" style="width:100px;height:90px;background:#FFF;position:absolute;z-index:10001;padding:10px;border :1px solid #CCC;border-radius:10px;">' + calEvent.title + '</div>';
                $("body").append(tooltip);
                $(this).mouseover(function(e) {
                    $(this).css('z-index', 10000);
                    $('.tooltipevent').fadeIn('500');
                    $('.tooltipevent').fadeTo('10', 1.9);
                }).mousemove(function(e) {
                    $('.tooltipevent').css('top', e.pageY + 10);
                    $('.tooltipevent').css('left', e.pageX + 20);
                });
            },
            eventMouseout: function(calEvent, jsEvent) {
                $(this).css('z-index', 8);
                $('.tooltipevent').remove();
            },
            eventRender: function(event, element) {
                element.find('span.fc-title').html(element.find('span.fc-title').text());
            }
        });

    }
</script>
</HTML>
