<%-- 
    Document   : viewLoggedUsers
    Created on : Jan 27, 2012, 9:22:21 PM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.UserUtils,java.util.*"%>
<%@ page import="com.eminent.util.LoginDetails"%>
<%
	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("ViewActiveUsers");
	

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
             logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>

</head>
<body>
<%
        String month    =   request.getParameter("month");
        logger.info("Month"+month);
        List userList    =   UserUtils.getLoggedInUsersDetails(month);
       
        Iterator iter=userList.iterator();
        String browser  =   "NA";
        
%>
<%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr border="2">
		<td border="1" align="left"><font size="4" COLOR="#0000FF"><b>List of Logged In Users in eTracker&#153; on <%=month%>
		</b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                <td border="1" align="right"><font size="4" COLOR="#0000FF"><b><a href="/eTracker/admin/dashboard/dailyUserActivity.jsp">User Activity</a></b> </font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td border="1" align="right"><font size="4" COLOR="#0000FF"><b>Active
		Sessions: <a href="/eTracker/admin/user/viewActiveUsers.jsp"><%=SessionCounter.getActiveUsers()%></a></b> </font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td border="1" align="right"><font size="4" COLOR="#0000FF">
		</font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<br>


<table align="left">
<!--    <tr>
        <td align="left"><a>Previous Day</a></td>
        <td align="right" colspan="5"><a>Next Day</a></td>
    </tr>-->
    <tr bgColor="#C3D9FF">
        <td><b>User</b></td>
        <td><b>Company</b></td>
        <td><b>Last Logged On</b></td>
        <td><b>Last Logged Out</b></td>
        <td><b>Browser Used</b></td>
        <td><b>IP Address</b></td>
    </tr>
    
    <%
            int i=0;
            String logoutTime	=	"NA";
            String ipAddress    =   "NA";
            while (iter.hasNext()) {
                String color    =   "white";
             if(( i % 2 ) != 0)
             {
                color="#E8EEF7";
             }
             
              LoginDetails logDetails=(LoginDetails)iter.next();
			  if(logDetails.getLogoutTime()!=null){
				logoutTime	=	logDetails.getLogoutTime();
			  }else{
                                logoutTime      =   "NA";
                          }
              browser   =  UserUtils.getBrowser(logDetails.getBrowser());
              ipAddress =   logDetails.getIpAddress();
              if(ipAddress==null){
				ipAddress	=	"NA";
             }
              
  %>
  <tr bgcolor="<%=color%>">
      <td align="left"><a href="<%= request.getContextPath() %>/admin/user/userLoginHistory.jsp?userId=<%=logDetails.getUserId()%>"><%=logDetails.getUserName()%></a></td>
      <td align="left"><%=logDetails.getCompany()%></td>
      <td align="left"><%=logDetails.getLoginTime()%></td>
      <td align="left"><%=logoutTime%></td>
      <td align="left"><%=browser%></td>
       <td align="left"><%=ipAddress%></td>
  </tr>
  <%
                i++;
            }
    %>
</table>
</body>
</html>
