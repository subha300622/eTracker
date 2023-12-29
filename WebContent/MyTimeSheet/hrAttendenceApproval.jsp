<%-- 
    Document   : hrAttendenceApproval
    Created on : Oct 30, 2009, 12:05:34 PM
    Author     : Administrator
--%>


<%@page import="org.apache.log4j.*,com.eminent.timesheet.CreateTimeSheet" %>
<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties

	
	Logger logger = Logger.getLogger("Attendace Approval");
	

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            int userId             =   (Integer)session.getAttribute("uid");
            String workingdays     =   request.getParameter("workingdays");
            String attendance      =   request.getParameter("attendance");
            String feedback        =   request.getParameter("feedback");
            String timeSheetId     =   request.getParameter("timeSheetId");
          
            CreateTimeSheet.AttendanceApproval(timeSheetId, Float.parseFloat(workingdays),feedback, Float.parseFloat(attendance), userId);

            logger.info("TimeSheetID"+timeSheetId);
        %>
        <jsp:forward page="timeSheetList.jsp"/>
    </body>
</html>

