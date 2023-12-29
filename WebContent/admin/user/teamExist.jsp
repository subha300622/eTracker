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
<SCRIPT language=JAVASCRIPT type=text/javascript>

<!--
function printpost(post)
{
	pp = window.open('/etracker/profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
	pp.focus();
}</script>

<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">

<P>
<table width="100%" bgcolor="#EEEEEE" valign="right" height="5%"
	border="0">

	<tr>


		<td border="0" align="left" width="800"><b><font size="3"
			COLOR="#0000FF"> Current User: </font></b><FONT SIZE="3" COLOR="#0000FF">
		&nbsp;<b>&nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%>
		</b></FONT></td>


		<td width="6%" border="1" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"><a
			href="javascript:printpost(44078)">Profile</a></font></td>
		<td width="6%" align="center" border="1"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"><A
			HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A></font></td>


	</tr>
</table>
<br>
<br>
-->
<jsp:include page="/header.jsp" />
<TABLE bgColor=#E8EEF7 align="center">
	<TBODY>

		<TR>
			<TD align="center"><B><FONT SIZE="5" COLOR="#FF0000">
			This Team Already Exist.Please enter another Team </FONT></B></TD>
		</tr>
		<tr>
			<td colspan="2">
			<div align="Left">Return to eTracker Add Team Page<a href="<%=request.getContextPath() %>/admin/project/addTeam.jsp">Click
			Here </a></div>
			</td>
		</tr>
	</TBODY>
</TABLE>
<P></P>
<P></P>
</BODY>
</HTML>
