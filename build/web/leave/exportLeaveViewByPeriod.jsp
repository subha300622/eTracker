<%-- 
    Document   : exportLeaveViewByPeriod
    Created on : 9 Feb, 2016, 2:24:05 PM
    Author     : admin
--%>

<%@page import="com.eminent.leaveUtil.LeaveBalanceReportBean"%>
<%@page import="java.util.List"%>
<%@ page language="java"  contentType="application/vnd.ms-excel;" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, org.apache.log4j.*"%>
<%@ page import="com.eminent.util.*, dashboard.CheckDate"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave view</title>
        <style>
            .leaveViewTable  th {
                background: #A0BFF3;
                text-align: center;
                color: black;
                font-size: 12px;
                box-shadow: 0px 0px 2px 1px #FFF;
                border: 1px solid #B5CAF9;
                border-collapse: collapse;
            }
            .leaveViewTable  tr td{
                height: 23px;

                box-shadow: 0px 0px 2px 1px #FFF;
                font-size: 13px;
                border: 1px solid #B5CAF9;
                border-collapse: collapse;
            }
            .leaveViewTable {
                border: 1px solid black;
                border-collapse: collapse;
            }


            .tdalingment{
                text-align: left;
            }
            .periodclass{
                background: #d6e0f5;
            }
            .availabeTD{
                background: #ffff99; 
            }
            .negativeLeave{
                background: red;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="lrc" class="com.eminent.leaveUtil.LeaveBalancePeriod"></jsp:useBean>
        <%
            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {
        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\"");
            //Configuring log4j properties

            String requestPage = null;
            String fromdate = request.getParameter("fromDate");
            String todate = request.getParameter("toDate");
            requestPage = request.getParameter("export");
            if (requestPage.equals("LeaveView")) {
                lrc.exportExcel(fromdate, todate);
            }
        %>

        <%  List<LeaveBalanceReportBean> ListLeaveBalanceReportBeans = lrc.getListLeaveBalanceReportBeans();
            if (ListLeaveBalanceReportBeans.size() > 0) {%>
        <table style="width: 100%;" class="leaveViewTable" >
            <thead>
                <tr>
                    <th rowspan="2">S/N</th>
                    <th rowspan="2">Emp No</th>
                    <th rowspan="2">Employee Name</th>
                    <th rowspan="2">Division</th>
                    <th colspan="7"><%=lrc.getStartMonth()%> - <%=lrc.getEndMonth()%></th>

                    <th colspan="4">Available</th>
                    <th colspan="4">Availed</th>
                    <th colspan="4">Balance</th>
                    <th rowspan="2">Total Leave Taken</th>
                </tr>
                <tr>
                    <th>P</th>
                    <th>O</th>
                    <th>Un</th>
                    <th>SL</th>
                    <th>CL</th>
                    <th>PL</th>
                    <th>Abs</th>


                    <th>SL</th>
                    <th>CL</th>
                    <th>PL</th>
                    <th>Abs</th>


                    <th>SL</th>
                    <th>CL</th>
                    <th>PL</th>
                    <th>Abs</th>


                    <th>SL</th>
                    <th>CL</th>
                    <th>PL</th>
                    <th>Abs</th>

                </tr>
            </thead>

            <%
                int count = 1;
                for (LeaveBalanceReportBean leaveBalanceReportBean : ListLeaveBalanceReportBeans) {
            %>
            <tr >
                <td ><%=count%></td>
                <td ><%=leaveBalanceReportBean.getEmpNo()%></td>
                <td style="text-align: left"><%=leaveBalanceReportBean.getEmpName()%></td>
                <td style="width: 116px;text-align: left"><%=leaveBalanceReportBean.getTeam()%><%=(leaveBalanceReportBean.getEmpDivision())%></td>


                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodPresent()%></td>
                <td class="periodclass"><%=leaveBalanceReportBean.getPeriodOther()%></td>
                <%if (leaveBalanceReportBean.getPeriodUnInitmeted() > 0.0f) {%>
                <td class="periodclass negativeLeave" style=" background: red;"><%=leaveBalanceReportBean.getPeriodUnInitmeted()%></td>
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
                <td class="periodclass negativeLeave" style=" background: red;"><%=leaveBalanceReportBean.getAvailedAbsent()%></td>
                <%} else {%>
                <td class="periodclass"><%=leaveBalanceReportBean.getAvailedAbsent()%></td>
                <%}%>




                <% if (Float.parseFloat(leaveBalanceReportBean.getBalanceSickLeave()) < 0.0f) {%>
                <td class="availabeTD negativeLeave" style=" background: red;" ><%=leaveBalanceReportBean.getBalanceSickLeave()%></td>
                <% } else {%>
                <td class="availabeTD" ><%=leaveBalanceReportBean.getBalanceSickLeave()%></td>
                <%}
                    if (Float.parseFloat(leaveBalanceReportBean.getBalanceCasualLeave()) < 0.0f) {%>
                <td class="availabeTD negativeLeave" style=" background: red;"><%=leaveBalanceReportBean.getBalanceCasualLeave()%></td>
                <%} else {%>
                <td class="availabeTD"><%=leaveBalanceReportBean.getBalanceCasualLeave()%></td>
                <%}
                    if (Float.parseFloat(leaveBalanceReportBean.getBalancePrivilegeLeave()) < 0.0f) {%>
                <td class="availabeTD negativeLeave" style=" background: red;"><%=leaveBalanceReportBean.getBalancePrivilegeLeave()%></td>
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



    </body>
</html>
