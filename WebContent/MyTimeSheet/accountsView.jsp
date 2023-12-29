<%-- 
    Document   : accountsView
    Created on : Oct 30, 2009, 12:06:14 PM
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
        String userId       =  request.getParameter("userId");
        String timeSheetId  =  request.getParameter("timeSheetId");

        Timesheet timesheet =   CreateTimeSheet.GetTimeSheetDetails(timeSheetId);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
       <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
       <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script language=javascript src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
        <script language="javascript">
      function Validate(){

         if(document.getElementById('feedback').value==''){
            alert('Please approve Account with Narration');
             document.getElementById('feedback').focus();
            return false;
        }
         monitorSubmit();
      return true;
    }
      </script>
    </head>
    <%@ include file="/header.jsp"%>
    <body>
     <table cellpadding="0" cellspacing="0" width="100%">
         <tr border="2" bgcolor="#E8EEF7">
              <td><b>Attendance Update</b></td>
          </tr>
      </table>
        <br>
        <br>
        <br>
        <br>
        <form name="accountsApproval" onSubmit="return Validate(this)" action="accountsApproval.jsp" method="post" onReset="return setFocus()">
        <table  align="center" bgcolor="#E8EEF7">
            <tr>
                <td><b>Name of the Employee</b></td>
                <td><%=GetProjectMembers.getUserName(userId)%></td>
            </tr>
            <tr>
                <td><b>Approval Percentage</b></td>
                <td><%=timesheet.getApprovalpercentage()%><%=" "%>%</td>
            </tr>
            <tr>
                <td><b>Total Working Days</b></td>
                <td><%=timesheet.getWorkingdays()%></td>
            </tr>
             <tr>
                <td><b>Attendance</b></td>
                <td><%=timesheet.getAttendance()%></td>
            </tr>
             <tr>
            <td><b>Narration</b></td><td><textarea id="feedback" name="feedback" rows="3" cols="25"></textarea></td>
            </tr
            <tr>
                <td align="right"><input id="submit" type="Submit" value="Submit"/></td><td align="left"><input id="reset" type="reset" value="Reset"/></td>
            </tr>
            <tr>
                <td align="right"><input id="timeSheetId" name="timeSheetId" type="hidden" value="<%=timeSheetId%>"/></td>
            </tr>
        </table>
        </form>
    </body>
</html>
