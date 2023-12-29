<%@ page session="false"%>
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

<%@ include file="../noScript.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
function trim(str)  {
  		while (str.charAt(str.length - 1)==" ") 
    	str = str.substring(0, str.length - 1); 
  		while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  		return str; 
	} 
function isEmailValid(str)  
{
	var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.@_-" 
	var i = 0; 
	do  
        {
    		var pos = 0; 
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))  
                        {
				pos = 1; 
        			break; 
      			} 
    			i++; 
  	}
  	while (pos==1 && i<str.length) 
  	if (pos==0) 
    		return false; 
  	return true; 
} 
function fun(theForm)
{
	if ((theForm.email.value)=='')  {
   			alert('Please enter your E-Mail ID');
  			document.theForm.email.value="";
    		theForm.email.focus(); 
    		return false; 
  		} 
  		if(!isEmailValid(trim(theForm.email.value))){
  		alert('Please Enter Valid Email ID');
   		document.theForm.email.value="";
  		theForm.email.focus(); 
   		return false;
  	}
		return true;
}
//	<!--  		function setFocus()
//  		{
//  			document.theForm.email.focus(); 
//  		}
//		window.onload = setFocus; 
//
//	//-->
</SCRIPT>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">


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
<P>Please enter your email address (example:
object_world@yourcompany.com) inorder to reset your password
<FORM action="resetpassword.jsp" method=post name="theForm"
	onsubmit='return fun(this)'>
<TABLE bgColor=#E8EEF7>
	<TBODY>
		<TR>
			<TD>
			<TABLE>
				<TBODY>
					<TR>
						<TD colSpan=2><B>Retrieve Password</B></TD>
					</TR>


					<%
        		   		if(request.getParameter("status")!=null && request.getParameter("status").equals("false"))
        		   		{
        		   		    %>
					<font color="red" face="Tahoma" size="2"><%= "No such user exists!"%></font>
					<%
        		   		}
        		   	%>


					<%
        		   		if(request.getParameter("mailid")!=null)
        		   		{
        		   			%>
					<TR>
						<TD>Email Address:</TD>
						<TD><INPUT type="text" size=25 name="email"
							value="<%= request.getParameter("mailid") %>"><font
							face="Tahoma" size="4" COLOR="brown"></font></TD>
					</TR>
					<TR>

						<%
        		   		}
        		   		else
        		   		{
        		   			%>
					
					<TR>
						<TD>Email Address:</TD>
						<TD><INPUT type="text" size=25 name="email"><font
							face="Tahoma" size="4" COLOR="brown"></font></TD>
					</TR>
					<%
        		   		}
        		   	%>

					<TR>
						<TD align=right colSpan=2><INPUT type=submit size=25
							value=Submit></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
</FORM>
<!-- FILE:  stdFooter.cfm :-->
<P></P>
<P></P>

</BODY>
</HTML>
