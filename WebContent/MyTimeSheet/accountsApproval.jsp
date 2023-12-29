<%-- 
    Document   : accountsApproval
    Created on : Oct 30, 2009, 12:06:32 PM
    Author     : Administrator
--%>

<%@ page import="org.apache.log4j.*,com.eminent.timesheet.CreateTimeSheet"%>

<%@ page import="com.eminent.timesheet.Timesheet,com.eminent.util.GetProjectMembers"%>


<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("AccountsView");
	

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

            String accontsFeedback        =   request.getParameter("feedback");
            String timeSheetId            =   request.getParameter("timeSheetId");
            logger.info("TimeSheetID"+timeSheetId);
            CreateTimeSheet.AccountsApproval(timeSheetId,accontsFeedback, userId);

           
        %>
        <jsp:forward page="timeSheetList.jsp"/>
    </body>
</html>
