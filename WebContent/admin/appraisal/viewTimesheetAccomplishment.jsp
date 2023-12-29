<%-- 
    Document   : viewTimesheetAccomplishment
    Created on : Feb 3, 2012, 10:09:12 PM
    Author     : Tamilvelan
--%>
<%@page  import="com.eminentlabs.appraisal.AppraisalIssues"%>
<%@page  import="java.util.Calendar,java.util.GregorianCalendar"%>
<%@page  import="org.apache.log4j.Logger"%>
<%@page  import="java.text.SimpleDateFormat"%>
<%@page  import="java.util.Calendar,java.util.GregorianCalendar"%>
<%@page  import="java.util.Date" %>
<%@page  import="com.eminentlabs.appraisal.AppraisalIssues"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<table>
    <tr bgcolor="" style="font-weight: bold;">
        <td width="5%" align="center">Date</td>
                <td width="5%" align="center">Attendance</td>
                <td width="20%" align="center">Accomplishment</td>
                <td width="20%" align="center">Learnings</td>
                <td width="20%" align="center">Plan</td>
                <td width="10%" align="center">Hardship</td>
                <td width="10%" align="center">Suggestion</td>
                 <td width="5%" align="center">Approval</td>
            </tr>
<%
        Logger logger           =   Logger.getLogger("");
        
         String period   =(String)session.getAttribute("period");
        logger.info("Period-->"+period);
        String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
        String start   =   period.substring(0, period.indexOf('*'));
        String end     =   period.substring(period.indexOf('*')+1,period.length() );
        String startMonth  =   start.substring(0, start.indexOf('-'));
        String endMonth  =   end.substring(0, end.indexOf('-'));

        String startYear  =   start.substring(start.indexOf('-')+1, start.length());
        String endYear  =   end.substring(end.indexOf('-')+1, end.length());

        int stMonth     =   (Integer.parseInt(startMonth));
        if(stMonth<10){
            startMonth  =   "0"+stMonth;
        }

        int enMonth     =   (Integer.parseInt(endMonth));
        if(enMonth<10){
            endMonth  =   "0"+enMonth;
        }

        Calendar cal = new GregorianCalendar();
        cal.set(Calendar.YEAR,Integer.parseInt(endYear) );
        cal.set(Calendar.MONDAY,enMonth);
        int maxday=cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        String startDate    =   "01-"+(stMonth+1)+"-"+startYear;
        String endDate      =   maxday+"-"+(enMonth+1)+"-"+endYear;
        SimpleDateFormat sdfInput =   new SimpleDateFormat (  "dd-MM-yyyy"  ) ;
        SimpleDateFormat sdfOutput =  new SimpleDateFormat  (  "dd-MMM-yy"  ) ;
        int userId      =   Integer.parseInt(request.getParameter("appUser"));
        String[][] timesheetDetails     =   AppraisalIssues.displayTimesheet("Achievement",sdfOutput.format(sdfInput.parse(startDate)),sdfOutput.format(sdfInput.parse(endDate)),userId );
        int totalRecords    =   timesheetDetails.length;
        String color    ="white";
        SimpleDateFormat formatter ;
        Date dateUtil ;
        Calendar calendar=Calendar.getInstance();
        formatter = new SimpleDateFormat("dd-MMM-yy");
        int mon=0,yr=0;
        for(int i=0;i<totalRecords;i++){
            String accomplishment   =   timesheetDetails[i][0];
            String learnings    =   timesheetDetails[i][1];
            String plan         =   timesheetDetails[i][2];
            String hardship     =   timesheetDetails[i][3];
            String suggestion   =   timesheetDetails[i][4];
            String date         =   timesheetDetails[i][5];
            String approval     =   timesheetDetails[i][6];
            String attendance   =   timesheetDetails[i][7];
            if(( i % 2 ) != 0)
                {
                    color   ="E8EEF7";
    
                }
                else
                {
                    color   ="E8EEF7";

                }
            if(learnings==null){
                learnings ="NA";
            }
            if(suggestion==null){
                suggestion ="NA";
            }
            if(plan==null){
                plan ="NA";
            }
            if(hardship==null){
                hardship ="NA";
            }
            if(approval==null){
                approval ="NA";
            }else{
                approval    =   approval+"%";
            }

            dateUtil = (Date)formatter.parse(date);
            logger.info("Parsed Date"+dateUtil);
            calendar.setTime(dateUtil);
            calendar.add(Calendar.MONTH,-1);
            mon =   calendar.get(Calendar.MONTH);
            yr  =   calendar.get(Calendar.YEAR);
            logger.info("Parsed Month"+mon);
            logger.info("Parsed Year"+yr);
            %>
            <tr bgcolor="<%=color%>">
                <td ><a href="<%= request.getContextPath() %>/admin/appraisal/viewTimesheetDetails.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>" target='_blank'><%=date%></a></td>
                <td bgcolor="white" align="center"><%=attendance%>%</td>
                <td ><%=accomplishment%></td>
                <td bgcolor="white"><%=learnings%></td>
                <td ><%=plan%></td>
                <td bgcolor="white"><%=hardship%></td>
                <td ><%=suggestion%></td>
                <td bgcolor="white" align="center"><%=approval%></td>
            </tr>
            <%
        }
%>
</table>


