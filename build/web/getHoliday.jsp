<%-- 
    Document   : getHoliday
    Created on : Feb 10, 2014, 5:34:49 PM
    Author     : E0288
--%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%int user;
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");
    String userid = request.getParameter("userId");
    String fromDateString = com.pack.ChangeFormat.changeDateFormat(fromDate);
    String toDateString = com.pack.ChangeFormat.changeDateFormat(toDate);
    Date from = sdf.parse(fromDateString);
    Date to = sdf.parse(toDateString);
    if (userid == null) {
        user = (Integer) session.getAttribute("userid_curr");
    } else {
        user = Integer.parseInt(userid);
    }
    int branch=GetProjectMembers.getBranchId(user);
    List<Holidays> holidaysList = HolidaysUtil.findByHolidayDateByBranch(from, to, branch);
    int i = 0;
    if (!holidaysList.isEmpty()) {
        for (Holidays holiday : holidaysList) {
            if (holiday.getBranchId()==branch) {
                if (i == 0) {
                    if (from.compareTo(holiday.getHolidayDate()) == 0) {

                        out.print(fromDate);
                    } else if (to.compareTo(holiday.getHolidayDate()) == 0) {
                        out.print(toDate);
                    }
                    i++;
                }
            }
        }
    }

%>
