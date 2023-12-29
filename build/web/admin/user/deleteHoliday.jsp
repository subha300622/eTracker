<%-- 
    Document   : deleteHoliday
    Created on : Feb 13, 2014, 1:51:25 PM
    Author     : E0288
--%>

<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String holidayId=request.getParameter("hId");
String year=request.getParameter("year");
if(holidayId!=null){
    long hId=Long.valueOf(holidayId);
    HolidaysUtil.deleteHoliday(hId);
}

%>
<jsp:forward page="/admin/user/addHoliday.jsp">
    <jsp:param name="year" value="<%=year%>"></jsp:param>
</jsp:forward>