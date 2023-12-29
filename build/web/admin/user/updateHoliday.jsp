<%-- 
    Document   : updateHoliday
    Created on : Feb 10, 2014, 10:19:49 AM
    Author     : E0288
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String holidayId=request.getParameter("eholidayId");
String holidayDate=request.getParameter("eholidayDate");
String holidayName=request.getParameter("eholidayName");
String branch=request.getParameter("branch");
SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
Calendar c = new GregorianCalendar();
Date date = c.getTime();
String hoDate=com.pack.ChangeFormat.changeDateFormat(holidayDate);
Date hDate=sdf.parse(hoDate);
long hId=Long.valueOf(holidayId);
Holidays holidays=HolidaysUtil.findByHolidayId(hId);
holidays.setHolidayName(holidayName);
holidays.setHolidayDate(hDate);
holidays.setModifiedon(date);
holidays.setBranchId(Integer.parseInt(branch));
HolidaysUtil.updateHoliday(holidays);
%>
<jsp:forward page="/admin/user/addHoliday.jsp"></jsp:forward>