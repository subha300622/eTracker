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
		if (change_pwd.currentpwd.value=='')  
		{
    		alert('Please Enter Your Current Password'); 
			document.change_pwd.currentpwd.value="";
    		change_pwd.currentpwd.focus(); 
    		return false; 
  		}
  		if ((change_pwd.currentpwd.value.length)<6)  
  		{
   			alert('Password Should be minimum 6 Characters!!!...');
  			document.change_pwd.currentpwd.value="";
    		change_pwd.currentpwd.focus(); 
    		return false; 
  		} 
  		if ((change_pwd.currentpwd.value.length)>15)  
  		{
   			alert('Password Should not Exceed 15 Characters!!!...');
  			document.change_pwd.currentpwd.value="";
    		change_pwd.currentpwd.focus(); 
    		return false; 
  		} 
  		
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
		document.change_pwd.currentpwd.focus();
	}
	
	window.onload = setFocus;

//-->
</SCRIPT>
<%@ page import="org.apache.log4j.*"%>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">


<%
			//Configuring log4j properties
			
		
			
			Logger logger = Logger.getLogger("changepwd");
			
			
			String logoutcheck=(String)session.getAttribute("Name");
			if(logoutcheck==null)
			{
				logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

			}

	%>



<form name=change_pwd onsubmit="return fun(this)"
	action="change_pwd.jsp" method="post" onReset="return setFocus()">
<%@ include file="../header.jsp"%> <br>

<TABLE border=0 cellPadding=0 cellSpacing=0 width="50%" height="1%"
	bgcolor="C3D9FF" align="center">
	<TBODY height="100%">
		<TR>
			<TD align="center"><FONT SIZE="" COLOR="#330000"></FONT><B>Change
			Password</B></td>
		</TR>
	</TBODY>
</TABLE>
<br>
<br>
<table width="50%" border="0" bgcolor="#E8EEF7" cellpadding="0"
	align="center">
	<tr>
		<td width="40%"><strong>Current Password</strong></td>
		<td><input type="password" name="currentpwd" maxlength="15"
			size="25"><strong class="style20"></strong></td>
	</tr>

	<tr>
		<td width="40%"><strong>New Password</strong></td>
		<td><input type="password" name="newpwd" maxlength="15" size="25""><strong
			class="style20"></strong></td>
	</tr>

	<tr>
		<td width="40%"><strong>Confirm Password</strong></td>
		<td><input type="password" name="confirmpwd" maxlength="15"
			size="25"><strong class="style20"></strong></td>
	</tr>
</table>
<table width="50%" border="0" bgcolor="E8EEF7" cellpadding="0"
	align="center">
	<tr align="center">
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td align="right"><input type="submit" value="Submit"
			name="submit">
		<td align="left"><input type="reset" name="reset" value="Reset""></td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;</td>
	</tr>
</table>

<br>
<br>

</form>
</BODY>
</HTML>

