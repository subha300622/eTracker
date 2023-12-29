<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html;">
 <meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>
<body>
<% if(session == null || session.getAttribute("userid_curr") == null){
}else{
        session.invalidate();

}%>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<table border="0" align="center">
	<tr>
		<td>


		<TABLE border="0" cellPadding=0 cellSpacing=0 height="20%">
			<TR>
				<TD valign="top">

				<h1><font color="RED" size="15">
			</TR>
			<tr>
				<td>
				<p class="errordisplay">Your Session has been expired!</p>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><a
					href="<%=request.getContextPath()%>/login.jsp" target=_parent>
				<p class="textdisplay">Relogin</p>
				</a></td>
			</tr>
		</TABLE>

		</td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>



</body>
</html>
