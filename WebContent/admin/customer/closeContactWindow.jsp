<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%



	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache");

	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("New Contact Creation");
	
	
%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</title>
<meta name="Generator" content="EditPlus">
<meta http-equiv="refresh" content="1; URL=http://www.eminentlabs.net/contactus.htm">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>


</head>




<body bgcolor="#FFFFFF">
<FORM name="theForm" METHOD=POST>
<table width="100%">
	<%@ page import="java.sql.*"%>

	<%@ page language="java"%>

	<%

   
    String bug = "yes";
    session.setAttribute("bug",bug);
String flag = request.getParameter("flag");
if(flag != null && flag.equalsIgnoreCase("true"))
    {
	%>
	<tr>
		<td align="center">
		<center><FONT SIZE="4" COLOR="#0000ff">Your Contact
		Information has been submitted successfully. Redirecting page...</center>
		</td>
	</tr>
	
	<%
	
}

      %>
</table>
<br>

</FORM>
</body>
</html>
