<%-- 
    Document   : userLoginHistory
    Created on : Aug 29, 2012, 8:27:17 PM
    Author     : Tamilvelan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.UserUtils,com.pack.SessionCounter,com.eminent.util.GetProjectManager"%>
<%@ page import="com.eminent.util.LoginDetails"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
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
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    </head>
    <body>
       <%
        String user    =   request.getParameter("userId");
        logger.info("Month"+user);
        List userList    =   UserUtils.getUserLoginHistory(Integer.parseInt(user));
       
        Iterator iter=userList.iterator();
        String browser  =   "NA";
        
%>
<%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr border="2">
		<td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Logged In details of <%=GetProjectManager.getUserFullName(Integer.parseInt(user))%> in eTracker&#153;
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
    <tr bgColor="#C3D9FF">

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

