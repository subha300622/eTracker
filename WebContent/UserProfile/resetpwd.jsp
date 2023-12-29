<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page errorPage="changepwderror.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.pack.PasswordRetrival"%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>
<body>
<% 
Logger logger = Logger.getLogger("resetpwd");
	String mail=(String)session.getAttribute("forgot_email");
	
	//mail = mail+"@"+application.getAttribute("Domain");
	PasswordRetrival pr = new PasswordRetrival();

	try
	{
		int x = pr.changePassword(mail,request.getParameter("newpwd"));
		
		if(x>0)
		{
			%>
<jsp:forward page="resetpwdsucces.jsp" />
<%		
		}
		else
		{
			response.sendRedirect("./changepwderror.jsp");
		}
		
	}
	catch(Exception e)
	{
		logger.error(e.getMessage());
	}
%>
</body>
</html>