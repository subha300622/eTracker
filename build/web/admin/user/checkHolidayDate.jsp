<%-- 
    Document   : checkHolidayDate
    Created on : Feb 7, 2014, 12:58:39 PM
    Author     : E0288
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String holidayId=request.getParameter("holidayId");
String holidayDate=request.getParameter("holidayDate");
String branch=request.getParameter("branch");
String holidayName=request.getParameter("holidayName");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MMM-yyyy");
String hodate=com.pack.ChangeFormat.changeDateFormat(holidayDate);
Date hDate=sdf.parse(hodate);
Holidays holidays=HolidaysUtil.findUniqueHoliday(hDate,holidayName.toUpperCase(),Integer.parseInt(branch));
if(holidayId!=null){
if(holidays!=null){
    
    Long hId=Long.valueOf(holidayId);
    if(holidays.getHolidayId()!=hId){
        out.print("Yes");
    }else{
        out.print("No");
    }
    }else{
        out.print("No");
    }
}else{
    if(holidays!=null){
        out.print("Yes");
    }else{
    out.print("No");
    }
}
%>
