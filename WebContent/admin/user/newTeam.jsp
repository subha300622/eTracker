<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%Logger logger = Logger.getLogger("newTeam");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</head>
<body>
<!-- Java Package Import Declarations -->
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->
<jsp:useBean id="getConnect" class="com.eminent.util.TeamUtil">
	<jsp:setProperty name="getConnect" property="*" />
</jsp:useBean>
<%
		Connection  connection = null;

try{
		
		String teamname = request.getParameter("teamname");
                if( teamname != null) {
                	teamname = teamname.trim();
                }
		//connection = getConnect.ConnectToDatabase(); 
		connection=MakeConnection.getConnection();
%>
<!-- Notifying JSP to use CreateNewProjectBean Class in the Package Named com.pack -->

<%
			if(connection != null)  
			{
				boolean state = getConnect.TeamExist(connection,teamname);//Checks whether the Project already exists in the DB 
				if(state == true)  
				{
%>
<jsp:forward page="moduleexist.jsp" />
<%  			
				}
				else if(state == false) 
				{
					//If the Project is not in DB Get Input Values from Previous page
					
						getConnect.CreateNewTeam(connection,teamname);
%>
<!-- The User Input Values to create a Project are passed to the CreateNewProjectBean Using Jsp Property tag -->



<jsp:forward page="/admin/project/addTeam.jsp" />
<%
				}
			}
}catch(Exception e)
{
	logger.error(e.getMessage());
}finally
				{
					if (connection!=null)
					{
						connection.close();
					}
				}
%>
</body>
</html>