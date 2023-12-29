<%-- 
    Document   : LeaveViewByPeriod
    Created on : 5 Feb, 2016, 9:53:58 AM
    Author     : admin
--%>

<%@page import="com.eminent.leaveUtil.LeaveBalanceReportBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="com.eminent.leaveUtil.Leave"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@  taglib  prefix="c"   uri="http://java.sun.com/jstl/core"  %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=18" type="text/css" rel="STYLESHEET"/>
    <link href='<%=request.getContextPath()%>/css/fullcalendar.css?test=7' rel='stylesheet' />
    <link href='<%=request.getContextPath()%>/css/fullcalendar.print.css' rel='stylesheet' media='print' />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src='<%=request.getContextPath()%>/javaScript/moment.min.js'></script>
    <script src='<%=request.getContextPath()%>/javaScript/fullcalendar.min.js'></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css?test=3">
    <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>


    <title>Leave Request</title>
    <style type="text/css">

        .ui-datepicker-calendar {
            display: none;
        }
        .error2{
            color: red;
            font-size:14px;
        }

    </style>

</head>
<body>
    <%@ include file="../header.jsp"%>
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <jsp:useBean id="lrc" class="com.eminent.leaveUtil.LeaveBalancePeriod">
        <jsp:setProperty name="lrc" property="*"/>
    </jsp:useBean>
    <% int assignedto = (Integer) session.getAttribute("userid_curr");
        String mail = (String) session.getAttribute("theName");
        int roleId = (Integer) session.getAttribute("Role");
        smmc.getLocationNBranch(assignedto);
    %>
    <%lrc.getAll(request);%>
    <!-- edit by mukesh-->
    <div style="height: 21px;background-color: #C3D9FE;font-weight: bold;padding: 1px;margin-top: 12px;"><span>Leave Request</span>
        <span style="margin-left: 85%; text-align: center;"> 
            <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Export to: <a href="<%=request.getContextPath()%>/leave/exportLeaveViewByPeriod.jsp?export=LeaveView&fromDate=<%=lrc.getStartMonth()%>&toDate=<%=lrc.getEndMonth()%>" target="_blank">Excel</a></font></span></div>
    <!-- edit by mukesh-->
    <table style="width: 100%;">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/UserProfile/employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProfile/holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProfile/leaveRequest.jsp"> Leave Management</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%      if (assignedto == 104 || assignedto == 103 || mail.equals("accounts@eminentlabs.net")) {%>
                <a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp">Leave  Request For User </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <% }
                    if (assignedto == 112 || assignedto == 103 || assignedto == 104 || roleId == 4 || mail.equals("accounts@eminentlabs.net") || (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto)) {%>
                <a href="<%=request.getContextPath()%>/leave/leaveView.jsp" >Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp" style="font-weight: bold;">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <% }%>
            </td>
        </tr></table>

    <div class="leaveForm">
        <form class="theForm" method="get" action="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp" onsubmit="disableSubmit()">

            <div> 
                <label > From Month </label><input type="text" name="fromDate" id="fromDate" maxlength="11" class="datepicker" value="<%=((lrc.getStartMonth() == null) ? "" : lrc.getStartMonth())%>"  readonly=""> 
            </div >

            <div  > 
                <label> To Month</label> <input type="text" name="toDate" class="datepicker2" id="toDate" maxlength="11" value="<%=((lrc.getEndMonth() == null) ? "" : lrc.getEndMonth())%>" readonly="">
            </div>
            <div style="width: 38%"><input type="submit" name="submit" id="submit" value="Submit"/> </div>
        </form>
    </div>
    <%  List<LeaveBalanceReportBean> ListLeaveBalanceReportBeans = lrc.getListLeaveBalanceReportBeans();
            if (ListLeaveBalanceReportBeans.size() > 0) {%>
    <div class="tablecontent" style="width: 100%;">
        <table style="width: 100%;" class="leaveViewTable tablesorter" id="userTableSort">
            <thead>
                <tr>
                    <th rowspan="2"  class="filter-false" >S/N</th>
                    <th rowspan="2" class="filter-match">Emp No</th>
                    <th rowspan="2" class="filter-select filter-match">Employee Name</th>
                    <th rowspan="2" class="filter-match">Division</th>
                    <th colspan="7"  class="filter-false" ><%=lrc.getStartMonth()%> - <%=lrc.getEndMonth()%></th>

                    <th colspan="4"  class="filter-false" >Available</th>
                    <th colspan="4"  class="filter-false" >Availed</th>
                    <th colspan="4"  class="filter-false" >Balance</th>
                    <th rowspan="2"  class="filter-false" >Total Leave Taken</th>
                </tr>
                <tr>
                    <th class=" filter-false"><div class="tooltip">P <span class="tooltiptext tooltippresnt">Present/ClientMeeting/Permission/Intimated </span></div></th>
                    <th class=" filter-false" ><div class="tooltip">O <span class="tooltiptext" >Medical Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">U<span class="tooltiptext">Un intimated</span></div></th>
                    <th class=" filter-false"><div class="tooltip">SL <span class="tooltiptext">Sick Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">CL <span class="tooltiptext">Casual Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">PL <span class="tooltiptext">Privilege Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">Abs <span class="tooltiptext">Absent</span></div></th>


                    <th class=" filter-false" ><div class="tooltip">SL <span class="tooltiptext">Sick Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">CL <span  class="tooltiptext">Casual Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">PL <span  class="tooltiptext">Privilege Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">Abs <span  class="tooltiptext">Absent</span></div></th>



                    <th class=" filter-false" ><div class="tooltip">SL <span class="tooltiptext">Sick Leave</span></div></th>
                    <th  class=" filter-false"><div class="tooltip">CL <span class="tooltiptext">Casual Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">PL <span class="tooltiptext">Privilege Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">Abs <span class="tooltiptext">Absent</span></div></th>



                    <th class=" filter-false"><div class="tooltip">SL <span class="tooltiptext">Sick Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">CL <span class="tooltiptext">Casual Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">PL <span class="tooltiptext">Privilege Leave</span></div></th>
                    <th class=" filter-false"><div class="tooltip">Abs <span class="tooltiptext">Absent</span></div></th>

                </tr>
            </thead>

            <%
                int count = 1;
                for (LeaveBalanceReportBean leaveBalanceReportBean : ListLeaveBalanceReportBeans) {
            %>
            <tr >
                <td ><%=count%></td>
                <td ><%=leaveBalanceReportBean.getEmpNo()%></td>
                <td style="text-align: left;color:blue;cursor: pointer;" class="useratt" userid='<%=leaveBalanceReportBean.getUserId()%>'><%=leaveBalanceReportBean.getEmpName()%></td>
                <td style="width: 116px;text-align: left;"><%=leaveBalanceReportBean.getTeam()%><%=(leaveBalanceReportBean.getEmpDivision())%></td>


                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodPresent()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodOther()%></td>

                <%if (leaveBalanceReportBean.getPeriodUnInitmeted() > 0.0f) {%>
                <td class="periodclass negativeLeave"><%=leaveBalanceReportBean.getPeriodUnInitmeted()%></td>
                <%} else {%>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodUnInitmeted()%></td>
                <%}%>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodSickLeave()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodCasualLeave()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodPrivilegeLeave()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodAbsent()%></td>


                <td class="availabeTD"><%=leaveBalanceReportBean.getAvailableSickLeave()%></td>
                <td class="availabeTD"><%=leaveBalanceReportBean.getAvailableCasualLeave()%></td>
                <td class="availabeTD"><%=leaveBalanceReportBean.getAvailablePrivilegeLeave()%></td>
                <td class="availabeTD"><%=leaveBalanceReportBean.getAvailableAbsent()%></td>


                <td class="periodclass"><%=leaveBalanceReportBean.getAvailedSickLeave()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getAvailedCasualLeave()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getAvailedPrivilegeLeave()%></td>
                <%if (leaveBalanceReportBean.getAvailedAbsent() > 0.0f) {%>
                <td class="periodclass negativeLeave"><%=leaveBalanceReportBean.getAvailedAbsent()%></td>
                <%} else {%>
                <td class="periodclass"><%=leaveBalanceReportBean.getAvailedAbsent()%></td>
                <%}%>




                <% if (Float.parseFloat(leaveBalanceReportBean.getBalanceSickLeave()) < 0.0f) {%>
                <td class="availabeTD negativeLeave" ><%=leaveBalanceReportBean.getBalanceSickLeave()%></td>
                <% } else {%>
                <td class="availabeTD" ><%=leaveBalanceReportBean.getBalanceSickLeave()%></td>
                <%}
                        if (Float.parseFloat(leaveBalanceReportBean.getBalanceCasualLeave()) < 0.0f) {%>
                <td class="availabeTD negativeLeave"><%=leaveBalanceReportBean.getBalanceCasualLeave()%></td>
                <%} else {%>
                <td class="availabeTD"><%=leaveBalanceReportBean.getBalanceCasualLeave()%></td>
                <%}
                        if (Float.parseFloat(leaveBalanceReportBean.getBalancePrivilegeLeave()) < 0.0f) {%>
                <td class="availabeTD negativeLeave"><%=leaveBalanceReportBean.getBalancePrivilegeLeave()%></td>
                <%} else {%>
                <td class="availabeTD"><%=leaveBalanceReportBean.getBalancePrivilegeLeave()%></td>
                <%}%>

                <td class="availabeTD"><%=leaveBalanceReportBean.getBalanceAbsent()%></td>


                <td><%=leaveBalanceReportBean.getTotalLeaveTaken()%></td>
            </tr>
            <% count++;
                }
            %>
        </table>
        <%}%>
    </div>
    <div id="dialog" >
        <div id='usercalendar'></div>
    </div>



    <script type="text/javascript">
        $(document).ready(function () {
            $('#usercalendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                },
                editable: false,
                eventLimit: true, // allow "more" link when too many events
                events: '<%=request.getContextPath()%>/UserProfile/userAttJson.jsp?month=07&year=2016&rand=' + Math.random(1, 10),
                eventMouseover: function (calEvent, jsEvent) {
                    var tooltip = '<div class="tooltipevent" style="width:100px;height:90px;background:#FFF;position:absolute;z-index:10001;padding:10px;border :1px solid #CCC;border-radius:10px;">' + calEvent.title + '</div>';
                    $("body").append(tooltip);
                    $(this).mouseover(function (e) {
                        $(this).css('z-index', 10000);
                        $('.tooltipevent').fadeIn('500');
                        $('.tooltipevent').fadeTo('10', 1.9);
                    }).mousemove(function (e) {
                        $('.tooltipevent').css('top', e.pageY + 10);
                        $('.tooltipevent').css('left', e.pageX + 20);
                    });
                },
                eventMouseout: function (calEvent, jsEvent) {
                    $(this).css('z-index', 8);
                    $('.tooltipevent').remove();
                },
                eventRender: function (event, element) {
                    element.find('span.fc-title').html(element.find('span.fc-title').text());
                },
            });
        });
        $("#fromDate,#toDate").datepicker({
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            showOn: "button",
            buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
            buttonImageOnly: true,
            dateFormat: 'MM yy',
            onClose: function (dateText, inst) {
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year, month, 1));
                var defultdate = $.datepicker.formatDate('MM yy', new Date(year, month, 1));
                $("#toDate").val(defultdate);
            },
            beforeShow: function (input, inst) {
                if ((datestr = $(this).val()).length > 0) {
                    year = datestr.substring(datestr.length - 4, datestr.length);
                    month = jQuery.inArray(datestr.substring(0, datestr.length - 5), $(this).datepicker('option', 'monthNames'));
                    $(this).datepicker('option', 'defaultDate', new Date(year, month, 1));
                    $(this).datepicker('setDate', new Date(year, month, 1));
                }
                var other = this.id == "fromDate" ? "#toDate" : "#fromDate";
                var option = this.id == "fromDate" ? "minDate" : "minDate";
                if ((selectedDate = $(other).val()).length > 0) {
                    var byear = selectedDate.substring(selectedDate.length - 4, selectedDate.length);
                    var bmonth = jQuery.inArray(selectedDate.substring(0, selectedDate.length - 5), $(this).datepicker('option', 'monthNames'));
                    $("#toDate").datepicker("option", option, new Date(byear, bmonth, 1));
                    //  $("#toDate").datepicker("setDate", new Date(byear, bmonth, 1));
                }
            }
        });
        $(document).on("click", "input[type='text'] ", function () {
            $(this).parent().children("img").click();
        });
        $(document).on('focus', "#fromDate ,.datepicker2,#submit", function () {
            $(".error2").remove();
        });
        $('#submit').click(function () {
            $(".theForm span.error2").remove();
            var count = 0;
            var fromDate = $("#fromDate").val();
            var todate = $('.datepicker2').val();
            var spitfrom = fromDate.split(" ");
            var splitTo = todate.split(" ");
            var fyear = parseInt(spitfrom[1]);
            var tyear = parseInt(splitTo[1]);
            var fmonth = new Date(Date.parse(spitfrom[0] + "1," + spitfrom[1])).getMonth();
            var tmon = new Date(Date.parse(splitTo[0] + "1," + splitTo[1])).getMonth();
            if (fromDate == "") {
                $("<span class='error2' style='margin-left:10px;'>from month can not be empty </span>").insertAfter("#submit");
                count = 1;
            } else if (todate == "") {
                $("<span class='error2' style='margin-left:10px;'>to month can not be empty </span>").insertAfter("#submit");
                count = 1;
            } else if (new Date(Date.parse(splitTo[0] + "1," + splitTo[1])) < new Date(Date.parse(spitfrom[0] + "1," + spitfrom[1]))) {
                $('.datepicker2').val('');
                $("<span class='error2' style='margin-left:10px;'>to month can not less than from month </span>").insertAfter("#submit");
                count = 1;
            } else {
                fmonth = parseInt(fmonth);
                tmon = parseInt(tmon);
                fyear = parseInt(fyear);
                tyear = parseInt(tyear);
                if (fmonth > 2 && fyear == tyear) {
                } else if ((fmonth < 3 && tmon > 2) && (fyear == tyear)) {
                    $('.datepicker2').val('');
                    $("<span class='error2' style='margin-left:10px;'>Please select single financial year period. </span>").insertAfter("#submit");
                    count = 1;
                } else if (fyear != tyear) {
                    if (fmonth > 2 && fyear < tyear) {
                        if (tmon < 3 && (fyear + 1) == tyear) {
                        } else {
                            $('.datepicker2').val('');
                            $("<span class='error2' style='margin-left:10px;'>Please select single financial year period. </span>").insertAfter("#submit");
                            count = 1;
                        }
                    } else if ((fmonth < 3 && tmon < 3) && (fyear != tyear)) {
                        $('.datepicker2').val('');
                        $("<span class='error2' style='margin-left:10px;'>Please select single financial year period.</span>").insertAfter("#submit");
                        count = 1;
                    } else if ((fmonth > 2 && tmon > 2) && (fyear != tyear)) {
                        $('.datepicker2').val('');
                        $("<span class='error2' style='margin-left:10px;'>Please select single financial year period.</span>").insertAfter("#submit");
                        count = 1;
                    } else if ((fmonth < 3 && tmon > 2) && (fyear != tyear)) {
                        $('.datepicker2').val('');
                        $("<span class='error2' style='margin-left:10px;'>Please select single financial year period.</span>").insertAfter("#submit");
                        count = 1;
                    }
                }
            }
            if (count == 1) {
                return false;
            } else {
                count = 0;
                return true;
            }

        });
        $('#submit').button();
        $(document).ready(function ()
        {
            $("#userTableSort").tablesorter({
                widgets: ['zebra'],
                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                // change the multi sort key from the default shift to alt button 
                sortMultiSortKey: 'altKey',
                headers: {
                    1: {// <-- replace 1with the zero-based index of your column
                        sorter: 'ddMMMyy'
                    }
                }
            });
        });


        $(document).on('click', '.useratt', function () {
            $("#dialog").dialog("open");
            var title = $(this).html();
            $('#usercalendar').html("");
            var monthYear = $("#toDate").val();
            var monthYear = monthYear.split(" ");
            var monthNumber = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"].indexOf(monthYear[0].toLowerCase());

            var userId = $(this).attr('userid');

            $.ajax({
                url: '<%=request.getContextPath()%>/UserProfile/requestedAttendance.jsp?month=' + monthNumber + '&year=' + monthYear[1] + '&userId=' + userId + '&rand=' + Math.random(1, 10),
                type: 'POST',
                async: false,
                success: function (response, statusTxt, calslback) {
                    $('#dialog').html(response);
                    $('.ui-dialog-title').html(title);
                }
            });
        });



        $(function () {
            $("#dialog").dialog({
                autoOpen: false,
                width: 900,
                height: 700,
                //my: "center",
                //at: "top",
                //  of: window,
                position: ['center' + 50, 50],
                show: {
                    effect: "blind",
                    duration: 1000
                },
                hide: {
                    effect: "blind",
                    duration: 1000
                }
            });
            $("#dialog").dialog("widget").animate({
                left: "140px",
                top: "20px"
            }, 1500);
        });

        $(".Ajax-loder").hide();
    </script>

</body>
</html>
