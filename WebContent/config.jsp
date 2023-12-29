<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8" session="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>

<!-- Start Of Java Script For Front End Validation -->

<SCRIPT language=JAVASCRIPT type=text/javascript>

<!--
	/** Java Script Function For Trimming A String To Get Only The Required String Input */
	
	function trim(str)  {
  		while (str.charAt(str.length - 1)==" ") 
   		str = str.substring(0, str.length - 1); 
  		while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  		return str; 
	} 
	function isNumber(str)  {
  		var pattern = "0123456789." 
  		var i = 0; 
  		do  {
    		var pos = 0; 
    		for (var j=0; j<pattern.length; j++) 
      			if (str.charAt(i)==pattern.charAt(j)) {
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
 
	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */
	
	function isPositiveInteger(str)  {
  		var pattern = "abcdefghijklmnopqrstuvwxyz.ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890" 
  		var i = 0; 
  		do  {
    		var pos = 0; 
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))  {
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
	/** Function To Validate The Input Form Data */
	function fun(theForm)  
	{
	
 		/** This Loop Checks Whether There Is Any Integer Present In The Project Name Field */
 		if ((theForm.domainname.value)=='')  
 		{
   			alert('Please enter the domain name '); 
   			document.theForm.domainname.value="";
   			theForm.domainname.focus();  
    		return false; 
  		}
 		else if (!isPositiveInteger(trim(theForm.domainname.value)))  
 		{
   			alert('Please enter the correct domain name '); 
			document.theForm.domainname.value="";
    		theForm.domainname.focus(); 
    		return false; 
  		} 

		else if ((theForm.mailserver.value)=='')  
		{
   			alert('Please enter the mail server name '); 
   			document.theForm.mailserver.value="";
   			theForm.mailserver.focus();  
    		return false; 
  		}
 		else if (!isPositiveInteger(trim(theForm.mailserver.value)))  
 		{
   			alert('Please enter the correct mail server name '); 
			document.theForm.mailserver.value="";
    		theForm.mailserver.focus(); 
    		return false; 
  		} 
  		else
  		{
  			alert('The configuration details are stored');
  			return true;  		
  		}
	}
	
	function setFocus()  
	{
		document.theForm.domainname.focus();
	}
	window.onload = setFocus;
//-->

</SCRIPT>

<!-- End Of Java Script Code -->

<body>
<%@ page import="org.apache.log4j.*"%>
<%
		
		Logger logger = Logger.getLogger("Config");
	
%>


<!-- Declaring The Form And Its Attributes -->

<FORM name="theForm" onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/domainConfig.jsp" method=post
	onReset="return setFocus()">


<div align="center">

<center><BR>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
	<TBODY height="100%">
		<TR>
			<TD width="39%"><img border="0"
				src="eminentech support files\Eminentlabs.png"></TD>
			<TD width="100%"><!--Start table for cell 2-->
			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="10%">
				<TBODY>
					<TR>
						<TD align=right>Software Development Life Cycle Management</TD>
					</TR>
					<TR>
						<TD>
						<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
							<TBODY bgColor="#C3D9FF">
								<TR>
									<TD bgColor=#000000 height=20 rowSpan=3 width=1><IMG
										alt="" border=0 height=20 src="images/dot_clear.gif" width=1></TD>
									<TD bgColor=#000000 height=1><IMG alt="" border=0 height=1
										src="images/dot_clear.gif" width=1></TD>
								</TR>
								<TR>
									<TD align=left height=18 vAlign=center width="100%">&nbsp;Welcome
									Customer</TD>
								</TR>
								<TR>
									<TD bgColor=#000000 height=1 width="100%"><IMG alt=""
										border=0 height=1 src="images/dot_clear.gif" width=1></TD>
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

<!-- Table To Display The Formatted String "Add New Project" -->

<table cellpadding="0" cellspacing="0" width="50%" height="5%">

	<tr border="2" bgcolor="#E8EEF7">

		<td bgcolor="#E8EEF7" border="1" align="left" width="50%"><font
			size="4" COLOR="#0000FF"><b> E-Tracker Configuration </b></font></td>

	</tr>

</table>
<br>
<table cellpadding="0" cellspacing="0" width="50%">

	<tr border="2" bgcolor="#E8EEF7">

		<td bgcolor="#E8EEF7" border="1" align="left" width="100%"><font
			size="4" COLOR="#0000FF"><b> Add Configuration Details </b></font></td>

	</tr>

</table>

<br>


<TABLE width="50%" bgColor=#E8EEF7>

	<TBODY>
		<tr>
			<td><strong>Domain Name </strong></td>
			<td><input type="text" name="domainname" maxlength="30"
				size="25"></td>
		</tr>
		<tr>

			<td><strong>Mail Server Host Name</strong></td>

			<td><input type="text" name="mailserver" maxlength="40"
				size="25"></td>


		</tr>

		<tr>
			<TD>&nbsp;</TD>
			<TD><INPUT type=submit value=Submit name=submit> <INPUT
				type=reset value=" Clear "></TD>
		</TR>


	</TBODY>

</TABLE>

</center>

</div>

</FORM>

<BR>

<%@ include file="/footer.jsp"%>
</body>

</html>