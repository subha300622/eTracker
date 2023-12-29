<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
<META http-equiv=Expires content=-1>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</HEAD>



<jsp:include page="/header.jsp" />
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">

	<tr border="2">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b>Project Administration</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>

<TABLE bgColor=#E8EEF7 align="center">
	<TBODY>

		<tr>
			<TD align="center"><B><FONT SIZE="5" COLOR="#FF0000">
			This Module Already Exist.Please enter another Module </FONT></B></TD>
		</tr>
		<tr>
			<td colspan="2">
			<div align="Left">Return to eTracker&#153; Project Module Edit page
			<a href="<%=request.getContextPath() %>/admin/project/addmodules.jsp">Click
			Here </a></div>
			</td>
		</tr>
	</TBODY>
</TABLE>
<P></P>
<P></P>
</BODY>
</HTML>
