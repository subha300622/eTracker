<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%Logger logger = Logger.getLogger("newmodules");
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
<jsp:useBean id="getConnect" class="com.pack.AdminBean">
	<jsp:setProperty name="getConnect" property="*" />
</jsp:useBean>
<%
		Connection  connection = null;

try{
		Integer pids=(Integer)session.getAttribute("projectid");
		int pid=pids.intValue();
	//	System.out.println("Projecty Id"+pid);
		String mname = request.getParameter("mname");
                if( mname != null) {
                    mname = mname.trim();
                }
		//connection = getConnect.ConnectToDatabase(); 
		connection=MakeConnection.getConnection();
%>
<!-- Notifying JSP to use CreateNewProjectBean Class in the Package Named com.pack -->

<%
			if(connection != null)  
			{
				boolean state = getConnect.ModuleExist(connection,mname,pid);//Checks whether the Project already exists in the DB 
				if(state == true)  
				{
%>
<jsp:forward page="moduleexist.jsp" />
<%  			
				}
				else if(state == false) 
				{
					//If the Project is not in DB Get Input Values from Previous page
					
						getConnect.CreateNewModule(connection,mname,pid);
%>
<!-- The User Input Values to create a Project are passed to the CreateNewProjectBean Using Jsp Property tag -->

<jsp:getProperty name="getConnect" property="mname" />

<jsp:forward page="/admin/project/addmodules.jsp" />
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