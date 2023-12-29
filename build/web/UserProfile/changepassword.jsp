<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</HEAD>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<SCRIPT LANGUAGE="JavaScript">
	function fun(change_pwd)  
	{
		
  		if (change_pwd.newpwd.value=='')  
		{
    		alert('Please Enter Your New Password'); 
			document.change_pwd.newpwd.value="";
    		change_pwd.newpwd.focus(); 
    		return false; 
  		}
  		if ((change_pwd.newpwd.value.length)<6)  
  		{
   			alert('New Password Should be minimum 6 Characters!!!...');
  			document.change_pwd.newpwd.value="";
    		change_pwd.newpwd.focus(); 
    		return false; 
  		} 
  		if ((change_pwd.newpwd.value.length)>15)  
  		{
   			alert('New Password Should not Exceed 15 Characters!!!...');
  			document.change_pwd.newpwd.value="";
    		change_pwd.newpwd.focus(); 
    		return false; 
  		}
  		if (change_pwd.confirmpwd.value=='')  
		{
    		alert('Please Enter Your Confirm Password'); 
			document.change_pwd.confirmpwd.value="";
    		change_pwd.confirmpwd.focus(); 
    		return false; 
  		}
  		if ((change_pwd.confirmpwd.value.length)<6)  
  		{
   			alert('Confirm Password Should be minimum 6 Characters!!!...');
  			document.change_pwd.confirmpwd.value="";
    		change_pwd.confirmpwd.focus(); 
    		return false; 
  		} 
  		if ((change_pwd.confirmpwd.value.length)>15)  
  		{
   			alert('Confirm Password Should not Exceed 15 Characters!!!...');
  			document.change_pwd.confirmpwd.value="";
    		change_pwd.confirmpwd.focus(); 
    		return false; 
  		}
		var newpwd_change = change_pwd.newpwd.value;
  		var confirmpwd_change = change_pwd.confirmpwd.value;
  
  		  		
  		if (!(newpwd_change==confirmpwd_change))
  		{
  			alert('New Password & Confirm Password does not match!!!!...');
  			document.change_pwd.newpwd.value="";
  			document.change_pwd.confirmpwd.value="";
  			change_pwd.newpwd.focus();
  			return false;
  		}
		return true;
	}
	function setFocus()  
	{
		document.change_pwd.newpwd.focus();
	}
	
	window.onload = setFocus;

//-->
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
										src="../eminentech support files/dot_clear.gif" width=1></TD>
									<TD bgColor=#000000 height=1><IMG alt="" border=0 height=1
										src="..eminentech support files/dot_clear.gif" width=1></TD>
								<TR>
									<TD align=left bgColor=#C3D9FF height=18 vAlign=center
										width="100%">&nbsp;Welcome Customer</TD>
								</TR>
								<TR>
									<TD bgColor=#000000 height=1 width="100%"><IMG alt=""
										border=0 height=1
										src="../eminentech support files/dot_clear.gif" width=1></TD>
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
<form name=change_pwd onsubmit='return fun(this)' action="resetpwd.jsp"
	method="post" onReset='return setFocus()'>
<table bgColor=#C3D9FF align="center" width="50%">
	<TR>
		<TD align="center"><B>Change Password</B></td>
	</TR>
</TABLE>
<br>
<br>

<TABLE bgcolor=#E8EEF7 align="center" width="50%">
	<TBODY>

		<tr>
			<td width="40%"><strong>New Password</strong></td>
			<td><input type="password" name="newpwd" maxlength="12"
				size="25"><strong class="style20"></strong></td>
		</tr>

		<tr>
			<td width="40%"><strong>Confirm Password</strong></td>
			<td><input type="password" name="confirmpwd" maxlength="12"
				size="25"><strong class="style20"></strong></td>
		</tr>
		<tr>
		</tr>

		<TR>
			<TD>&nbsp;</TD>
			<TD><INPUT type=submit value=Submit name=submit> <INPUT
				type=reset value=" Reset "></TD>
		</TR>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;</td>
		</tr>
</table>
<br>
<br>


</form>
</BODY>
</HTML>
