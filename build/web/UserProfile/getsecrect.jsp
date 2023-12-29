<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
<META http-equiv=Expires content=-1>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<LINK title=STYLE href="../eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</HEAD>
<SCRIPT LANGUAGE="JavaScript">

function fun(theForm)
{
	if ((theForm.answer.value)=='')  {
   			alert('Please enter your answer for your secret Question ');
  			document.theForm.answer.value="";
    		theForm.answer.focus(); 
    		return false; 
  		} 
		return true;
}
  function setFocus() {	document.theForm.answer.focus(); }
window.onload = setFocus; 

//-->
</SCRIPT>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">
<form action="validate.jsp" method="post" name="theForm"
	onsubmit='return fun(this)'>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
	<TBODY height="100%">
		<TR>
			<TD width="39%"><img border="0"
				src="../eminentech support files/Eminentlabs.png"></TD>
			<TD width="100%"><!--Start table for cell 2-->
			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="10%">
				<TBODY>
					<TR>
						<TD align=right>Global Customer Solutions Management</TD>
					</TR>

					<TR>
						<TD>

						<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
							<TBODY>
								<TR>
									<TD bgColor=#000000 height=20 rowSpan=3 width=1><IMG
										alt="" border=0 height=20
										src="eminentech support files/dot_clear.gif" width=1></TD>
									<TD bgColor=#000000 height=1><IMG alt="" border=0 height=1
										src="eminentech support files/dot_clear.gif" width=1></TD>
								<TR>
									<TD align=left bgColor=#C3D9FF height=18 vAlign=center
										width="100%">&nbsp;Welcome Customer</TD>
								</TR>
								<TR>
									<TD bgColor=#000000 height=1 width="100%"><IMG alt=""
										border=0 height=1 src="eminentech support files/dot_clear.gif"
										width=1></TD>
								</TR>
							</TBODY>
						</TABLE>
						<!--End table for customer/buttons--></TD>
					</TR>
				</TBODY>
			</TABLE>
			<!--End table for cell 2--></TD>
		</TR>
	</TBODY>
</TABLE>
<br>
<br>
<TABLE align="center">
	<TBODY>

		<TR>
			<TD colSpan=2><B>Please provide the following options to
			change your password</B></TD>
		</TR>

		<%
        	   		if(request.getParameter("answerStatus")!=null && request.getParameter("answerStatus").equals("false"))
        	   		{
        	   		    %>
		<font color="red" face="Tahoma" size="2"><%= "Incorrect Secret Answer"%></font>
		<%
        	   		}
          		   	%>


		<%
						if(request.getParameter("question")!=null)
						{
							%>
		<TR>
			<TD>Secret Question</TD>
			<TD><%= request.getParameter("question") %></TD>
		</TR>
		<%
						}
						
					%>


		<TR>
			<TD>YOUR ANSWER
			<TD><INPUT type="password" size=25 name="answer"></TD>
			<TD><INPUT type="hidden" size=25 name="question"
				value="<%= request.getParameter("question") %>"></TD>
		</TR>
		<TR>
			<TD align=right colSpan=2><INPUT type=submit size=25
				value=Submit></TD>
		</TR>
	</TBODY>

</TABLE>

</form>
</BODY>

</html>
