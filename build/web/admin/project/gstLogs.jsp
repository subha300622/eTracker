<%-- 
    Document   : gstLogs
    Created on : Mar 17, 2020, 09:33:02 AM
    Author     : E307-Muthu
--%>

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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
    <link title=STYLE href="<%=request.getContextPath()%>/css/eminentstyles.css?test=17" type="text/css" rel="STYLESHEET"/>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
    <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/redmond/jquery-ui.css">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

    <style>
        .ui-datepicker-calendar {
            display: none;
        }
        .showCount,.showActionCounta {
            cursor: pointer; color: #0063d5; text-decoration: underline;
        }

    </style>


</head>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
        <%@ include file="/header.jsp"%>

    <jsp:useBean id="far" class="com.eminent.gstn.GstnLogController"></jsp:useBean>

    <%
        far.setAll(request);
int roleId = (Integer) session.getAttribute("Role");
    %>



    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF">
            <td border="1" align="left" width="70%">
                <font size="4" COLOR="#0000FF"><b> GST 3in1 Cockpit </b></font>
             <a href="<%=request.getContextPath()%>/admin/project/accessKey.jsp">Access Key Maintenance</a> </td>
        </tr>
    </table>
  <%  if (roleId == 1) {        %> 
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
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
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;font-weight: bold;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;font-weight: bold;">Daywise E-Invoice</a>
            </td>
            <td></td>
        </tr>
    </table>
            <%}%>    <br/>
    <form name="testForm" method="Post" action="gstLogs.jsp"  >
        <label for="startDate" style="font-weight: bold;">Pick Month & Year :</label>
        <input type="text" name="startDate" id="startDate" size="11" class="date-picker" readonly="" onchange="callNew();" value="<%=far.getStartDate()%>"/>
    </form>
    <br/>

    <table  style="width: 100%;text-align: left;font-weight: bold;">
        <tr style="background-color: #C3D9FF;">
            <td style="width:24%; text-align: center;" >Project</td>
            <td style="width:18%; text-align: center;">Total</td>
            <td style="width:18%; text-align: center;">e-Invoicing</td>
            <td style="width:18%; text-align: center;">e-Way Bill</td>
            <td style="width:18%; text-align: center;">GST Filing</td>
        </tr>
    </table>

    <%int size = 0;
        int a = 0;
        int eInvoice = 0, eWay = 0, gstr = 0, tot = 0, challan = 0, auth = 0, gstr1 = 0, gstr2a = 0, gstr3b = 0, gstr6a = 0, gstr6 = 0, gstr9 = 0, ledger = 0, status = 0, gstintot = 0;
        for (Map.Entry<String, Map<String, Map<String, List<LogDetail>>>> entry : far.getProjectwise().entrySet()) {
            size++;

            eInvoice = 0;
            eWay = 0;
            gstr = 0;
            tot = 0;
            for (Map.Entry<String, Integer> count : far.getIndCount().get(entry.getKey()).entrySet()) {
               
                if (count.getKey().equalsIgnoreCase("e-Invoice")) {
                    eInvoice = count.getValue();
                } else if (count.getKey().equalsIgnoreCase("e-Way")) {
                    eWay = count.getValue();
                } else if (count.getKey().equalsIgnoreCase("GSTR")) {
                    gstr = count.getValue();
                }
                tot = eInvoice + eWay + gstr;
            }
            if ((size % 2) != 0) {
    %>
    <table  style="width: 100%;text-align: left;font-weight: bold;">
        <tr bgcolor="white" align="left">
            <td style="width:24%; text-align: center;" ><%=entry.getKey()%></td>
            <td style="width:18%; text-align: center;"><%=tot%></td>
            <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('<%=entry.getKey()%>e-Invoice', 150);
                    return false;"  class="trigger" ><%=eInvoice%></a></td>
            <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('<%=entry.getKey()%>e-Way', 150);
                    return false;"  class="trigger" ><%=eWay%></a></td>
            <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('<%=entry.getKey()%>GSTR', 150);
                    return false;"  class="trigger" ><%=gstr%></a></td>
        </tr>
    </table>
    <%} else {%>
    <table  style="width: 100%;text-align: left;font-weight: bold;">
        <tr bgcolor="#E8EEF7" align="left">
            <td style="width:24%; text-align: center;" ><%=entry.getKey()%></td>
            <td style="width:18%; text-align: center;"><%=tot%></td>
            <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('<%=entry.getKey()%>e-Invoice', 150);
                    return false;"  class="trigger" ><%=eInvoice%></a></td>
            <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('<%=entry.getKey()%>e-Way', 150);
                    return false;"  class="trigger" ><%=eWay%></a></td>
            <td style="width:18%; text-align: center;"><a href="#" onclick="collapse('<%=entry.getKey()%>GSTR', 150);
                    return false;"  class="trigger" ><%=gstr%></a></td>
        </tr>
    </table>
    <%}%>



    <div id="<%=entry.getKey()%>e-Invoice" class="hide_me" style="height: auto;">
        <table width="100%" id="eInvoice">
            <tr bgcolor="#E8EEF7" align="left">
                <th>GSTIN</th>
                <th>Authenticate</th>
                <th>Generate IRN</th>
                <th>Generate EWB By IRN</th>
                <th>Get IRN</th>
                <th>Cancel IRN</th>
                <th>Total</th>
            </tr>

            <% if (entry.getValue().containsKey("e-Invoice")) {

                    a = 0;

                    for (Map.Entry<String, List<LogDetail>> name : entry.getValue().get("e-Invoice").entrySet()) {
                        auth = 0;
                        gstr1 = 0;
                        gstr2a = 0;
                        gstr3b = 0;
                        gstr6 = 0;

                        a++;
                        for (LogDetail ld : name.getValue()) {
                            if (ld.getCategory().equals("AUTHENTICATE")) {
                                auth += ld.getTotCount();
                            } else if (ld.getCategory().equals("GENERATE IRN")) {
                                gstr1 += ld.getTotCount();
                            } else if (ld.getCategory().equals("GETIRN")) {
                                gstr2a += ld.getTotCount();
                            } else if (ld.getCategory().equals("CANCEL IRN")) {
                                gstr3b += ld.getTotCount();
                            } else if (ld.getCategory().equals("GENERATE EWB")) {
                                gstr6 += ld.getTotCount();
                            }

                        }
                        if ((a % 2) != 0) {
            %>
            <tr bgcolor="white" align="left">
                <%} else {%>
            <tr bgcolor="#E8EEF7" align="left">
                <%}%>
                <td ><%=name.getKey()%></td>

                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Invoice"  gstin="<%=name.getKey()%>" category="AUTHENTICATE" ><%=auth%></span>
                </td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Invoice" gstin="<%=name.getKey()%>" category="GENERATE IRN" ><%=gstr1%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Invoice" gstin="<%=name.getKey()%>" category="GENERATE EWB" ><%=gstr6%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Invoice" gstin="<%=name.getKey()%>" category="GET IRN" ><%=gstr2a%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Invoice" gstin="<%=name.getKey()%>" category="CANCEL IRN" ><%=gstr3b%></span></td>

                <td ><%=   auth
                        + gstr1
                        + gstr2a
                        + gstr3b + gstr6%></td>
            </tr>
            <tr class="more-info" id="<%=entry.getKey()%>e-Invoice<%=name.getKey()%>"  style="display: none">

            </tr>
            <%}
                }%>

        </table>
    </div>

    <div id="<%=entry.getKey()%>e-Way" class="hide_me" style="height: auto;">
        <table width="100%" id="eWay">
            <tr bgcolor="#E8EEF7" align="left">
                <th>GSTIN</th>
                <th>Authenticate</th>
                <th>Generate EWB</th>
                <th>Get EWB</th>
                <th>VEHICLE-UPDATE</th>
                <th>Cancel EWB</th>
                <th>Total</th>
            </tr>
            <% if (entry.getValue().containsKey("e-Way")) {

                    a = 0;

                    for (Map.Entry<String, List<LogDetail>> name : entry.getValue().get("e-Way").entrySet()) {
                        auth = 0;
                        gstr1 = 0;
                        gstr2a = 0;
                        gstr3b = 0;
                        gstr6 = 0;

                        a++;
                        for (LogDetail ld : name.getValue()) {
                            if (ld.getCategory().equals("AUTHENTICATE")) {
                                auth += ld.getTotCount();
                            } else if (ld.getCategory().equals("GENERATE E-WAY BILL")) {
                                gstr1 += ld.getTotCount();
                            } else if (ld.getCategory().equals("GET EWAYBILL")) {
                                gstr2a += ld.getTotCount();
                            } else if (ld.getCategory().equals("UPDATE EWAYBILL")) {
                                gstr3b += ld.getTotCount();
                            } else if (ld.getCategory().equals("CANCEL E-WAY BILL")) {
                                gstr6 += ld.getTotCount();
                            }

                        }
                        if ((a % 2) != 0) {
            %>
            <tr bgcolor="white" align="left">
                <%} else {%>
            <tr bgcolor="#E8EEF7" align="left">
                <%}%>
                <td ><%=name.getKey()%></td>

                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Way"  gstin="<%=name.getKey()%>" category="AUTHENTICATE" ><%=auth%></span>
                </td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Way" gstin="<%=name.getKey()%>" category="GENERATE E-WAY BILL" ><%=gstr1%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Way" gstin="<%=name.getKey()%>" category="GET E-WAY BILL" ><%=gstr2a%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Way" gstin="<%=name.getKey()%>" category="UPDATE EWAYBILL" ><%=gstr3b%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="e-Way" gstin="<%=name.getKey()%>" category="CANCEL E-WAY BILL	" ><%=gstr6%></span></td>

                <td ><%=   auth
                        + gstr1
                        + gstr2a
                        + gstr3b + gstr6%></td>
            </tr>
            <tr class="more-info" id="<%=entry.getKey()%>e-Invoice<%=name.getKey()%>"  style="display: none">

            </tr>
            <%}
                }%>

        </table>
        </div>

    <div id="<%=entry.getKey()%>GSTR" class="hide_me" style="height: auto;">

        <table width="100%" id="gstr">
            <tr bgcolor="#E8EEF7" align="left">
                <th>GSTIN</th>
                <th>Authenticate</th>
                <th>GSTR1</th>
                <th>GSTR2A</th>
                <th>GSTR3B</th>
                <th>GSTR6A</th>
                <th>GSTR6</th>
                <th>GSTR9</th>
                <th>Ledger</th>
                <th>Challan</th>
                <th>Status</th>
                <th>Total</th>
            </tr>

            <% if (entry.getValue().containsKey("GSTR")) {

                    a = 0;

                    for (Map.Entry<String, List<LogDetail>> name : entry.getValue().get("GSTR").entrySet()) {
                        auth = 0;
                        gstr1 = 0;
                        gstr2a = 0;
                        gstr3b = 0;
                        gstr6a = 0;
                        gstr6 = 0;
                        gstr9 = 0;
                        ledger = 0;
                        status = 0;
                        challan = 0;
                        gstintot = 0;
                        a++;
                        for (LogDetail ld : name.getValue()) {
                            if (ld.getCategory().equals("AUTHENTICATE")) {
                                auth += ld.getTotCount();
                            } else if (ld.getCategory().contains("GSTR1-")) {
                                gstr1 += ld.getTotCount();
                            } else if (ld.getCategory().contains("GSTR2A-")) {
                                gstr2a += ld.getTotCount();
                            } else if (ld.getCategory().contains("GSTR3B")) {
                                gstr3b += ld.getTotCount();
                            } else if (ld.getCategory().contains("GSTR6A-")) {
                                gstr6a += ld.getTotCount();
                            } else if (ld.getCategory().contains("GSTR6-")) {
                                gstr6 += ld.getTotCount();
                            } else if (ld.getCategory().contains("GSTR9-")) {
                                gstr9 += ld.getTotCount();
                            } else if (ld.getCategory().equals("GSTR-LEDGERS")) {
                                ledger += ld.getTotCount();
                            } else if (ld.getCategory().equals("GSTR-STATUS")) {
                                status += ld.getTotCount();
                            } else if (ld.getCategory().equals("CHALLAN")) {
                                challan += ld.getTotCount();
                            }

                        }
                        if ((a % 2) != 0) {
            %>
            <tr bgcolor="white" align="left">
                <%} else {%>
            <tr bgcolor="#E8EEF7" align="left">
                <%}%>
                <td ><%=name.getKey()%></td>

                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="auth" ><%=auth%></span>
                </td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="gstr1" ><%=gstr1%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="gstr2a" ><%=gstr2a%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="gstr3b" ><%=gstr3b%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="gstr6a" ><%=gstr6a%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="gstr6" ><%=gstr6%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="gstr9" ><%=gstr9%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="ledger" ><%=ledger%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="challan" ><%=challan%></span></td>
                <td ><span  class="showCount" project="<%=entry.getKey()%>" type="GSTR" gstin="<%=name.getKey()%>" category="status" ><%=status%></span></td>
                <td ><%=   auth
                        + gstr1
                        + gstr2a
                        + gstr3b
                        + gstr6a
                        + gstr6
                        + gstr9
                        + ledger + challan
                        + status%></td>
            </tr>
            <tr class="more-info" id="<%=entry.getKey()%>GSTR<%=name.getKey()%>"  style="display: none">

            </tr>
            <%}
                }%>

        </table></div>
        <%}%>
    <div id="dialog" title="Basic dialog">

    </div>
    <div id="dialoga" title="Basic dialog">

    </div>
    <script type="text/javascript">
        var date = new Date(); // 2012-03-31
        $(function () {
            $('.date-picker').datepicker({
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                dateFormat: 'MM yy',
                maxDate: date,
                showOn: "button",
                buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
                buttonImageOnly: true,
                onClose: function () {
                    var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                    $(this).datepicker('refresh');
                    document.testForm.action = "gstLogs.jsp?startDate=" + $('#startDate').val();
                    document.testForm.submit();
                },
                beforeShow: function () {
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
        $(".date-picker").focus(function () {
            $(".ui-datepicker-calendar").hide();
            $("#ui-datepicker-div").position({
                my: "center top",
                at: "center bottom",
                of: $(this)
            });
        });
        $(".date-picker").blur(function () {
            $(".ui-datepicker-calendar").hide();
        });

        $(document).ready(function () {
            $(document).on('click', '.showCount', function () {
                $(".Ajax-loder").show();
                var obj = $(this);
                var trid = obj.closest('tr').next('tr').attr('id'); // table row ID 
                var project = $.trim($(this).attr('project'));
                var type = $.trim($(this).attr('type'));
                var gstin = $.trim($(this).attr('gstin'));
                var category = $.trim($(this).attr('category'));
                var month = $("#startDate").val();
                var typegstin = project + type;
                $.ajax({
                    url: '<%=request.getContextPath()%>/admin/project/getAccessDetail.jsp',
                    data: {project: project, type: type, gstin: gstin, category: category, month: month, random: Math.random(1, 10)},
                    async: true,
                    type: 'GET',
                    cache: false,
                    success: function (data) {
                        $('#dialoga').html(data);
                        $("#dialoga").dialog("open");
                    }, complete: function () {
                        $('.ui-dialog-title').html(typegstin + " Detail");
                        $(".Ajax-loder").hide();
                    }
                });

            });

        });


        $(document).on('click', '.showActionCounta', function () {
            $(".Ajax-loder").show();
            var project = $.trim($(this).attr('project'));
            var type = $.trim($(this).attr('type'));
            var gstin = $.trim($(this).attr('gstin'));
            var category = $.trim($(this).attr('category'));
            var action = $.trim($(this).attr('action'));
            var month = $("#startDate").val();

            $.ajax({url: '<%=request.getContextPath()%>/admin/project/getActionwiseCount.jsp',
                data: {project: project, type: type, gstin: gstin, category: category, month: month, action: action, random: Math.random(1, 10)},
                async: true,
                type: 'GET',
                cache: false,

                success: function (data) {
                    $('#dialog').html(data);
                    $("#dialog").dialog("open");
                }, complete: function () {
                    $('.ui-dialog-title').html(action + " Detail");
                    $(".Ajax-loder").hide();
                }
            });

        });
        $(function () {
            $("#dialog,#dialoga").dialog({
                autoOpen: false,
                width: 1000,
                maxHeight: 500,
                show: {
                    effect: "blind",
                    duration: 1000
                },
                hide: {
                    effect: "blind",
                    duration: 1000
                }
            });
        });
        $(".Ajax-loder").hide();
    </script>
</body>
</html>
