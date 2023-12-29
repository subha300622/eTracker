<%-- 
    Document   : addHoliday
    Created on : Feb 7, 2014, 11:31:34 AM
    Author     : E0288
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"/>
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript">
            function trim(str) {
                while (str.charAt(str.length - 1) == " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) == " ")
                    str = str.substring(1, str.length);
                return str;
            }
            var  xmlhttp = createRequest();
            function isDate(str)
            {
                var pattern = "0123456789-";
                var i = 0;
                do
                {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) === pattern.charAt(j))
                        {
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
            var ssss;
            function checkhdate() {
                var holidayName = document.getElementById("holidayName").value;
                var holidayDate = document.getElementById("holidayDate").value;
                var branch = document.getElementById("branch").value;
                if (xmlhttp !== null) {

                    xmlhttp.open("GET", "/eTracker/admin/user/checkHolidayDate.jsp?holidayDate=" + holidayDate + "&holidayName=" + holidayName+"&branch=" + branch, false);

                    xmlhttp.onreadystatechange = function() {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                 ssss=xmlhttp.responseText;
                            
                            }
                        }
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
                
            }
            var editss;
            function checkedithdate() {
                var holidayName = document.getElementById("eholidayName").value;
                var holidayDate = document.getElementById("eholidayDate").value;
                var holidayId=document.getElementById("eholidayId").value;
                var branch=document.getElementById("branch").value;
                if (xmlhttp !== null) {

                    xmlhttp.open("GET", "/eTracker/admin/user/checkHolidayDate.jsp?holidayDate=" + holidayDate+"&holidayName="+holidayName+"&holidayId="+holidayId+ "&branch=" + branch, false);

                    xmlhttp.onreadystatechange = function() {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                 editss=xmlhttp.responseText;
                            
                            }
                        }
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
                
            }
            function  fun(theForm) {
                var holidayName = document.getElementById("holidayName").value;
                var holidayDate = document.getElementById("holidayDate").value;
                var branch = document.getElementById("branch").value;
                 if (trim(branch) === "") {
                    alert('Please select branch');
                    theForm.branch.value = "";
                    document.getElementById("branch").focus();
                    return false;
                }
                if (trim(holidayName) === "") {
                    alert('Please enter Holiday Name');
                    theForm.holidayName.value = "";
                    document.getElementById("holidayName").focus();
                    return false;
                }
                if (trim(theForm.holidayDate.value) === "") {
                    alert('Please enter the Holiday Date');
                    theForm.holidayDate.value = '';
                    theForm.holidayDate.focus();
                }
                if (!isDate(trim(holidayDate)))
                {
                    alert('Please enter the valid Holiday Date');
                    theForm.holidayDate.value = "";
                    theForm.holidayDate.focus();
                    return false;
                }
                checkhdate();
                if (ssss === 'Yes') {
                    alert(holidayDate + ' already holiday available');
                    $('#holidayDate').val('');
                    theForm.holidayDate.focus();
                    return false;
                }
                monitorSubmit();
            }
            function  editfun(theForm){
                var holidayName=document.getElementById("eholidayName").value;
                var holidayDate=document.getElementById("eholidayDate").value;
                var branch = document.getElementById("branch").value;
                 if (trim(branch) === "") {
                    alert('Please select branch');
                    theForm.branch.value = "";
                    document.getElementById("branch").focus();
                    return false;
                }
                if(trim(holidayName)===""){
                    alert('Please enter Holiday Name');
                    theForm.eholidayName.value="";
                    document.getElementById("eholidayName").focus();
                    return false;
                }
                if(trim(holidayDate)===""){
                    alert('Please enter the Holiday Date');
                    theForm.eholidayDate.value='';
                    theForm.eholidayDate.focus();
                    return false;
                }
                if (!isDate(trim(holidayDate)))
                {
                    alert('Please enter the valid Holiday Date');
                    theForm.eholidayDate.value = "";
                    theForm.eholidayDate.focus();
                    return false;
                }
                    checkedithdate();
                    if (editss === 'Yes') {
                    alert(holidayDate + ' already holiday available');
                    $('#eholidayDate').val('');
                    theForm.eholidayDate.focus();
                    return false;
                }
                monitorSubmit();
            }
            function call()
            {
                var x = document.getElementById("year").value;
                yearForm.action = '/eTracker/admin/user/addHoliday.jsp?year=' + x;
                yearForm.submit();
            }
        </script>
    </head>
    <%@ include file="/header.jsp"%> <br>
        <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
<%mwd.getAllBranchMap();%>
    <body>
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            SimpleDateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat formatter = new SimpleDateFormat("EEEEEE");
            String holidayName=request.getParameter("holidayName"); 
            String holidayDate=request.getParameter("holidayDate"); 
        String branch = request.getParameter("branch");
            Calendar cu = new GregorianCalendar();
            Calendar c = new GregorianCalendar();
            Date date = c.getTime();
            if(holidayName!=null){
            String hoDate=com.pack.ChangeFormat.changeDateFormat(holidayDate);
            Date hDate=sdf.parse(hoDate);
            cu.setTime(hDate);
            Holidays holiday = new Holidays(holidayName, hDate, date, date, Integer.parseInt(branch));
            HolidaysUtil.addHoliday(holiday);
            }
            Holidays editHoliday=new Holidays();
            String holidayId=request.getParameter("holidayId"); 
            if(holidayId!=null){
               long hid=Long.valueOf(holidayId);
                editHoliday= HolidaysUtil.findByHolidayId(hid);
            }
            
            
            int year = cu.get(Calendar.YEAR);
            if(request.getParameter("year")!=null){
                year=Integer.valueOf(request.getParameter("year"));
            }
            String start = "01-Jan-" + year;
            String end = "31-Dec-" + year;
            Date startDate = sdf.parse(start);
            Date endDate = sdf.parse(end);
            List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidays(startDate, endDate);
                int assignedto = (Integer) session.getAttribute("userid_curr");
                int branchId = (Integer) session.getAttribute("branch");


                String leaveDetails[][] = LeaveUtil.waitingForApproval(assignedto);

                int noOfRequests = leaveDetails.length;
        %>
        <TABLE width="100%">

            <TR >
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>Holidays :</B>
                </TD>
            </TR>

        </TABLE>
        <br/>
        <table style="width: 100%;">
                <tr>
                    <td>
                        <a href="<%=request.getContextPath()%>/UserProfile/employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/UserProfile/holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/UserProfile/leaveRequest.jsp"> Leave Management</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <%
                            
                            if (noOfRequests > 0) {
                        %>
                        <a href="editLeaveRequest.jsp"> Approve Leave</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <%                }if(assignedto==104){%>
                            <a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp">Leave  Request For User </a>&nbsp;&nbsp;&nbsp;&nbsp;
                       <% }if (assignedto == 1189 || assignedto==104) {%>
                        <a href="<%=request.getContextPath()%>/leave/leaveView.jsp">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                      <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <% }
                %>

                           
                    </td></tr></table>
        <TABLE width="100%">

            <TR >
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>Add Holidays :</B>
                </TD>
            </TR>

        </TABLE>
        <br/>
        <% if(editHoliday.getHolidayId()==0l){%>
        <form name="theForm" id="theForm" method="post" action="addHoliday.jsp" onsubmit="return fun(this);">
            <table style="background-color: #E8EEF7;">
               
                <tr>
      <td><b>Location</b></td><td><select id="branch" name="branch">
                        <%if (!mwd.getBranchMap().isEmpty()) {
                                for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}
                            }%>                                                
                    </select>
                </td>                    <td><b>Holiday Name</b></td><td><input type="text" name="holidayName" id="holidayName" maxlength="50"></td>
                    <td><b>Holiday Date</b></td><td><input type="text" name="holidayDate" id="holidayDate" readonly="" ><a href="javascript:NewCal('holidayDate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date" ></a><td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4" align="center"><input type="submit" name="Submit" id="submit" value="Submit">
                     <input type="Reset" name="Reset" id="reset" value="Reset">
                    </td>
                </tr>
               
            </table>
            
        </form>
            <%}else{%>
                    <form name="edittheForm" id="edittheForm" method="post" action="updateHoliday.jsp" onsubmit="return editfun(this);">
            <table style="background-color: #E8EEF7;">
               
                <tr>  <td><b>Location</b></td><td><select id="branch" name="branch">
                        <%if (!mwd.getBranchMap().isEmpty()) {
                                for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                                <option value="<%=entry.getKey()%>" <%if(entry.getKey()==editHoliday.getBranchId()){%> selected=""
                                <%}%> ><%=entry.getValue()%></option>
                        <%}
                            }%>                                                
                    </select>
                </td>
                    <td><b>Holiday Name</b></td><td><input type="text" name="eholidayName" id="eholidayName" maxlength="50" value="<%=editHoliday.getHolidayName()%>"></td>
                    <td><b>Holiday Date</b></td><td><input type="text" name="eholidayDate" id="eholidayDate" readonly="" value="<%=sdfs.format(editHoliday.getHolidayDate())%>" ><a href="javascript:NewCal('eholidayDate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date" ></a><td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4" align="center">
                        <input type="hidden" name="eholidayId" id="eholidayId" value="<%=editHoliday.getHolidayId()%>">
                        <input type="submit" name="Submit" id="submit" value="Update">
                        <input type="Reset" name="Reset" id="reset" value="Reset">
                    </td>
                </tr>
               
            </table>
            
        </form>
                <%}%>

        <br/><br/>
        <form name="yearForm" id="yearForm" method="post" >
        <TABLE width="100%">

            <TR >
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>List of Eminent Holidays for  :</B>
                    <%
                        Calendar cal = new GregorianCalendar();
                        int currentYear  = cal.get(Calendar.YEAR);
                        ArrayList<Integer> selectYears=new ArrayList<Integer>();
                        int startYear = 2008;

                        while(startYear<=currentYear+1){
                            selectYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='year' id='year' onchange="javascript:call();">
                        <%
                        for(int k=0,selected=2008;k<selectYears.size();k++,selected++){
                                    if(selected==year){
                                     %>
                                     <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>
                </TD>
            </TR>

        </TABLE>
        </form>
        <br/>
        <br/>

        <table style="width: 60%;" >
            <tr style="background-color: #C3D9FF;font-weight: bold;height: 21px;">
                <td>SI.No</td>
                <td>Holiday Date</td>
                <td>Day</td>
                <td>Holiday Name</td>
                <td>Location</td>
            </tr>
            <%
                int i = 0;
                for (Holidays holidays : holidaysList) {

                    if (i % 2 == 0) {%>
            <tr style="height: 21px;">  
                <%} else {%>
            <tr style="background-color: #E8EEF7;height: 21px;">
                <%}
                    i++;
                %>
                <td><%=i%></td>
                <td><a href="addHoliday.jsp?holidayId=<%=holidays.getHolidayId()%>" style="cursor: pointer;"><%=sdf.format(holidays.getHolidayDate())%></a></td>
                <td><%=formatter.format(holidays.getHolidayDate())%> </td>
                <td><%=holidays.getHolidayName()%> <a href="deleteHoliday.jsp?hId=<%=holidays.getHolidayId()%>&year=<%=year%>" style="color: white;" ><img  src="<%=request.getContextPath()%>/images/remove.gif" style="position: relative;cursor:pointer;margin-left:10px;"></a></td>
                <td><%=mwd.getBranchMap().get(holidays.getBranchId()) %> </td>
                <%}
                %>

            </tr>

        </table>
    </body>
</html>
