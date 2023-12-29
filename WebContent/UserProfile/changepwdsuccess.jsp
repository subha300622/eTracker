<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</HEAD>

<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>


<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">

<%@ include file="../header.jsp"%>
<br>
<br>
<br>
<TABLE bgColor=#E8EEF7 align="center">

	<TBODY>

		<TR>
			<TD align="center"><B><FONT SIZE="4" COLOR="#0000ff">
			Your Password has been changed Successfully!!!...</FONT></B> <% if(session!=null) { 
				
				session.removeAttribute("Name");
				session.removeAttribute("theName");
				session.removeAttribute("fName");
				session.removeAttribute("lName");
				session.removeAttribute("uid");
				session.removeAttribute("Currentpwd");
				session.removeAttribute("user_email");
				session.removeAttribute("userid_curr");
				session.invalidate(); 
				} %>
			</TD>
		</TR>
		<tr>
			<td align="center"><a href="../login.jsp" target="_parent">Return
			to Login</a></td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
	</TBODY>
</TABLE>
<P></P>
<P></P>
</BODY>
</HTML>
