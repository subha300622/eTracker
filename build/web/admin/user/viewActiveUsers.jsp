<%-- 
    Document   : viewActiveUsers
    Created on : 30 Jul, 2010, 11:40:29 AM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.pack.SessionCounter,java.util.*"%>
<%@ page import="com.eminent.util.LoginDetails"%>
<%@ page import="com.eminent.util.UserUtils"%>
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
        HashMap userList    =   SessionCounter.getActiveUsersList();
        Collection set=userList.keySet();
        Iterator iter=set.iterator();

    int roleId  =   (Integer)session.getAttribute("Role");
    if(roleId==1){

%>
<%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr border="2">
		<td border="1" align="left"><font size="4" COLOR="#0000FF"><b>User
		Administration</b> -  <b>List of Active Users in eTracker&#153;</b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                <td border="1" align="right"><font size="4" COLOR="#0000FF"><b><a href="/eTracker/admin/dashboard/dailyUserActivity.jsp">User Activity</a></b> </font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td border="1" align="right"><font size="4" COLOR="#0000FF"><b>Active
		Sessions: <a href="/eTracker/admin/user/viewActiveUsers.jsp"><%=SessionCounter.getActiveUsers()%></a></b> </font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td border="1" align="right"></td>
	</tr>
</table>
<br>

<table align="left">

    <tr  bgColor="#C3D9FF">
        <td><b>User</b></td>
        <td><b>Company</b></td>
        <td><b>Logged On Time</b></td>
        <td><b>Browser Used</b></td>
        <td><b>IP Address</b></td>
    </tr>
    <%
            int i=0;
            String ipAddress    =   "NA";
            while (iter.hasNext()) {
                String color    =   "white";
             if(( i % 2 ) != 0)
             {
                color="#E8EEF7";
             }
              String key=(String)iter.next();
              String userId=(String)userList.get(key);
              logger.info("Active User Id"+userId);
              LoginDetails det  =   (LoginDetails)UserUtils.getLoginHistory(Integer.parseInt(userId),key);
              ipAddress =   det.getIpAddress();
              if(ipAddress==null){
				ipAddress	=	"NA";
             }
  %>
  <tr bgcolor="<%=color%>">
      <td align="left"><a href="<%= request.getContextPath() %>/admin/user/userLoginHistory.jsp?userId=<%=det.getUserId()%>"><%=det.getUserName()%></a></td>
      <td align="left"><%=det.getCompany()%></td>
      <td align="left"><%=det.getLoginTime()%></td>
      <td align="left"><%=UserUtils.getBrowser(det.getBrowser())%></td>
        <td align="left"><%=ipAddress%></td>
  </tr>
  
  <%
                i++;
            }
            }else{
%>
<BR>
                <table align="center">
                 <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
                </table>
<%
               
               }
%>
  
</table>
</body>
</html>