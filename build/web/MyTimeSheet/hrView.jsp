<%-- 
    Document   : hrView
    Created on : Oct 30, 2009, 12:05:11 PM
    Author     : Administrator
--%>

<%@ page import="org.apache.log4j.*,com.eminent.timesheet.CreateTimeSheet"%>
<%@ page import="java.sql.*, dashboard.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="com.eminent.util.*"%>
<%@ page import="java.util.*, java.text.*, com.pack.*"%>

<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("HRView");
	


	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}
        String userId = request.getParameter("userId");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
       <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
       <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script language=javascript src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
       <script>
    function isNumber(str)  {
  		var pattern = "0123456789."
  		var i = 0;
  		do  {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j)) {
					pos = 1;
       				break;
      			}
    			i++;
  		}
  		while (pos==1 && i<str.length)
  			if (pos==0)
    		return false;
  		return true;
	}

    function Validate(){
        if(document.getElementById('workingdays').value==''){
            alert('Please enter the Total Working Days');
            document.getElementById('workingdays').focus();
            return false;
        }
        if(!isNumber(document.getElementById('workingdays').value)){
            alert('Please enter only Numerics in Total Working Days');
            document.getElementById('workingdays').focus();
            return false;
        }
        if(document.getElementById('workingdays').value>31){
            alert('The total working days cannot be greater than the calendar period days');
            document.getElementById('workingdays').focus();
            return false;
        }
        if(document.getElementById('workingdays').value<1){
            alert('The total working days cannot be lesser than the calendar period days');
            document.getElementById('workingdays').focus();
            return false;
        }
        if(document.getElementById('attendance').value==''){
            alert('Please enter the Attendance');
            document.getElementById('attendance').focus();
            return false;
        }
        if(!isNumber(document.getElementById('attendance').value)){
            alert('Please enter only Numerics in Attendance');
             document.getElementById('attendance').focus();
            return false;
        }
        if(document.getElementById('attendance').value>31){
            alert('The attendence cannot be greater than total working days');
            document.getElementById('attendance').focus();
            return false;
        }
        if((document.getElementById('attendance').value)*1>document.getElementById('workingdays').value){
            alert('The attendence cannot be greater than total working days');
            document.getElementById('attendance').focus();
            return false;
        }
         if(document.getElementById('feedback').value==''){
            alert('Please approve Attendance with Remarks');
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
        <form name="attendanceApproval" onSubmit="return Validate(this)" action="hrAttendenceApproval.jsp" method="post" onReset="return setFocus()">
        <table  align="center" bgcolor="#E8EEF7">
            <tr>
                <td><b>Name of the Employee</b></td>
                <td><%=GetProjectMembers.getUserName(userId)%></td>
            </tr>
            <tr>
                <td><b>Period</b></td>
                <td><%=request.getParameter("period")%></td>
            </tr>
            <tr>
                <td><b>Total Working Days</b></td>
                <td><input type="text" name="workingdays" id="workingdays" /></td>
            </tr>
             <tr>
                <td><b>Attendance</b></td>
                <td><input type="text" name="attendance" id="attendance" /></td>
            </tr>
             <tr>
            <td><b>Remarks</b></td><td><textarea id="feedback" name="feedback" rows="3" cols="25"></textarea></td>
            </tr
            <tr>
                <td align="right"><input id="submit" type="Submit" value="Submit"/></td><td align="left"><input id="reset" type="reset" value="Reset"/></td>
            </tr>
            <tr>
                <td align="right"><input id="timeSheetId" name="timeSheetId" type="hidden" value="<%=request.getParameter("timeSheetId")%>"/></td>
            </tr>
        </table>
        </form>
    </body>
</html>
