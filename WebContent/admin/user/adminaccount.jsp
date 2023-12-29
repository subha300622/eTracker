<%@ page import="org.apache.log4j.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM, ERM and EPTS Solution </TITLE>
<META http-equiv=Content-Type content="text/htmlcharset=windows-1252">


<!-- FILE:  stdHeader.cfm :-->
<META http-equiv=Expires content=-1>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<SCRIPT language=JAVASCRIPT type=text/javascript>

<!--

function trim(str) {
  while (str.charAt(str.length - 1)==" ") 
    str = str.substring(0, str.length - 1); 
  while (str.charAt(0)==" ") 
    str = str.substring(1, str.length); 
  return str; 
} 

function isPositiveInteger(str) {
  var pattern = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'" 
  var i = 0; 
  do {
    var pos = 0; 
    for (var j=0; j<pattern.length; j++) 
      if (str.charAt(i)==pattern.charAt(j)) {
pos = 1; 
        break; 
      } 
    i++; 
  } while (pos==1 && i<str.length) 
  if (pos==0) 
    return false; 
  return true; 
}
function isPositiveInteger1(str) {
  var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ@" 
  var i = 0; 
  do {
    var pos = 0; 
    for (var j=0; j<pattern.length; j++) 
      if (str.charAt(i)==pattern.charAt(j)) {
pos = 1; 
        break; 
      } 
    i++; 
  } while (pos==1 && i<str.length) 
  if (pos==0) 
    return false; 
  return true; 
}
	function isPositiveInteger2(str)  {
  		var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()-_+=|[];',./{}:<>?" 
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
function isPositiveInteger3(str) {
  var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.-'&" 
  var i = 0; 
  do {
    var pos = 0; 
    for (var j=0; j<pattern.length; j++) 
      if (str.charAt(i)==pattern.charAt(j)) {
pos = 1; 
        break; 
      } 
    i++; 
  } while (pos==1 && i<str.length) 
  if (pos==0) 
    return false; 
  return true; 
}


	function isNumber(str)  {
  		var pattern = "0123456789" 
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
 
  	var digits = "0123456789";
	var phoneNumberDelimiters = "()- ";
	var validWorldPhoneChars = phoneNumberDelimiters + "+";
	var minDigitsInIPhoneNumber = 10;

	function isInteger(s)
	{   
		var i;
	    for (i = 0; i < s.length; i++)
	    {   
       		var c = s.charAt(i);
	        if (((c < "0") || (c > "9"))) return false;
   		}
	    return true;
	}

	function stripCharsInBag(s, bag)
	{   
		var i;
	    var returnString = "";
	    for (i = 0; i < s.length; i++)
	    {   
       		var c = s.charAt(i);
	        if (bag.indexOf(c) == -1) returnString += c;
   		}
	    return returnString;
	}

	function checkInternationalPhone(strPhone)
	{
		s=stripCharsInBag(strPhone,validWorldPhoneChars);
		return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
	}
	function fun(theForm)  {
	
		/** This Loop Checks Whether There Is Any Input Data Present In The First Name Info Field */
		
		if ((theForm.firstName.value)=='')  {
   			alert('Please enter the Firstname ');
  			document.theForm.firstName.value="";
    		theForm.firstName.focus(); 
    		return false; 
  		} 

  		
  		/** This Loop Checks Whether There Is Any Integer Present In The First Name Field */
  		
  		if (!isPositiveInteger(trim(theForm.firstName.value)))  {
   			alert('Please enter the Alphabetical only in the FirstName ');
			document.theForm.firstName.value="";
   			theForm.firstName.focus(); 
    		return false; 
  		}
  		 
  		/** This Loop Checks Whether There Is Any Input Data Present In The Last Name Field */
  		
  		if ((theForm.lastName.value)=='')  {
   			alert('Please enter the Lastname '); 
   			document.theForm.lastName.value="";
    		theForm.lastName.focus();  
    		return false; 
  		}

  	  		
  		/** This Loop Checks Whether There Is Any Integer Present In The Last Name Field */
  		
  		if (!isPositiveInteger(trim(theForm.lastName.value)))  {
    		alert('Please enter a Alphabetical only in the "LastName" box'); 
			document.theForm.lastName.value="";
    		theForm.lastName.focus(); 
    		return false; 
  		} 
  		
  		/** This Loop Checks Whether There Is Any Input Data Present In The Email Address Field */
  		
  		if ((theForm.userEmail.value)=='')  {
    		alert('Please enter the Email Address'); 
			document.theForm.userEmail.value="";
    		theForm.userEmail.focus(); 
    		return false; 
  		}
 
 		if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.userEmail.value)))
 		{
			alert("Invalid E-mail Address! Please re-enter.")
			document.theForm.userEmail.value="";
    		theForm.userEmail.focus(); 
    		return (false);
		}
 		var mail=theForm.userEmail.value;
		var user=mail.indexOf('@');
    	var len=mail.length;
	    var id=mail.substring(user+1,len);
    	var domain=theForm.validateDomain.value;
    	var len1=domain.length;
		var id1=mail.substring(0,user-1);
    	/** This Loop Checks Whether The User Entered The Corporate Email Address Using The Domain Name */

		if( !( (user>=0) && (id==domain)))  {
	  		alert('Enter the Corporate Email Address');
	 		document.theForm.userEmail.value="";
   			theForm.userEmail.focus(); 
     		return false;
     	}
  		if ((len-len1)<5)  {
   			alert('Size of the username should be more than 4 charactes ');
  			document.theForm.userEmail.value="";
    		theForm.userEmail.focus(); 
    		return false; 
  		} 
    	
    	
     	
	  	/** This Loop Checks Whether There Is Any Integer Present In The Email Address Field */
	  	
	  	if (!isPositiveInteger1(trim(theForm.userEmail.value)))  {
    		alert('Please enter a Alphabetical only in the "Email" box'); 
			document.theForm.userEmail.value="";
    		theForm.userEmail.focus(); 
    		return false; 
  		} 
  		/** This Loop Checks Whether There Is Any Input Data Present In The Pssword Field */
  		
  		if ((theForm.password.value)=='')  {
    		alert('Please enter the Password '); 
			document.theForm.password.value="";
			document.theForm.Confirmpass.value="";
    		theForm.password.focus(); 
    		return false; 
  		} 
  		if ((theForm.password.value.length)<6)  {
   			alert('Size of the password should be more than 6 charactes ');
  			document.theForm.password.value="";
			document.theForm.Confirmpass.value="";
    		theForm.password.focus(); 
    		return false; 
  		} 
  		if ((theForm.password.value.length)>15)  {
   			alert('Size of the password should not be more than 15 charactes ');
  			document.theForm.password.value="";
			document.theForm.Confirmpass.value="";
    		theForm.password.focus(); 
    		return false; 
  		} 
	   if (!isPositiveInteger2(trim(theForm.password.value)))  {
    		alert('Please enter the valid character only in the "password" box'); 
			document.theForm.password.value="";
			document.theForm.Confirmpass.value="";
    		theForm.password.focus(); 
    		return false; 
  		} 
  		/** This Loop Checks Whether There Is Any Input Data Present In The Confirm Password Field */
  		
  		if ((theForm.Confirmpass.value)=='')  {
    		alert('Please enter the password again '); 
			document.theForm.Confirmpass.value="";
    		theForm.Confirmpass.focus(); 
    		return false; 
  		}
  		var pass1=theForm.password.value;
  		var pass2=theForm.Confirmpass.value;
  
  		/** This Loop Checks The Password And Confirm Password Matches Or Not */
  		
  		if (!(pass1==pass2))  {
  			alert('The password and confirm password does not Match');
  			document.theForm.password.value="";
  			document.theForm.Confirmpass.value="";
  			theForm.password.focus();
  			return false;
  		}
  		/** This Loop Checks Whether There Is Any Input Data Present In The Company Field */
  		
  		if ((theForm.company.value)=='')  {
    		alert('Please enter the Company Name '); 
	   		theForm.company.focus(); 
    		return false; 
  		}
  		
   		/** This Loop Checks Whether There Is Any Integer Present In The Company Field */
   		
   		if (!isPositiveInteger3(trim(theForm.company.value)))  {
   			alert('Please enter Valid Characters only in the "Company" box'); 
			document.theForm.company.value="";
   			theForm.company.focus(); 
    		return false; 
  		} 
  		/** This Loop Checks Whether There Is Any Input Data Present In The Phone Field */
	  	
  		if ( document.theForm.secret.selectedIndex == 0 )
    {
        alert ( "Please select the Question." );
		return false;
    }
    if (document.getElementById("secret").value=="[Select a Question]")
    {
        alert ( "Please select the Question." );
		return false;
    }

	if ((theForm.answer.value==null)||(theForm.answer.value==""))
		{
			alert("Please Enter your Answer");
			theForm.answer.focus();
			return false;
		}
  	
 
  		
  
  		
  		/** This Loop Checks Whether There Is Any Input Data Present In The Phone Field */
		if ((theForm.phone.value)=='')  {
    		alert('Please enter the Phone Number '); 
			theForm.phone.focus(); 
    		return false; 
  		}
  		
		if ((theForm.phone.value==null)||(theForm.phone.value==""))
		{
			alert("Please Enter your Counter code in Phone Number");
			theForm.phone.focus();
			return false;
		}
		 if (!isNumber(trim(theForm.phone.value))) 
		 {
    		alert('Please enter number only in the "phone" box'); 
			document.theForm.phone.value="";
    		theForm.phone.focus(); 
    		return false; 
  		} 
			if ((theForm.phone1.value==null)||(theForm.phone1.value==""))
		{
			alert("Please Enter your Area code in Phone Number");
			theForm.phone1.focus();
			return false;
		}
		if (!isNumber(trim(theForm.phone1.value))) 
		{
    		alert('Please enter number only in the "phone" box'); 
			document.theForm.phone1.value="";
    		theForm.phone1.focus(); 
    		return false; 
  		} 
		if ((theForm.phone2.value==null)||(theForm.phone2.value==""))
		{
			alert("Please Enter your Phone Number");
			theForm.phone2.focus();
			return false;
		}
		if (!isNumber(trim(theForm.phone2.value))) 
		{
    		alert('Please enter number only in the "phone" box'); 
			document.theForm.phone2.value="";
    		theForm.phone2.focus(); 
    		return false; 
  		} 
		

  		if ((theForm.phone2.value.length)<6)  {
   			alert('Size of the phone should be more than 10 charactes ');
  			document.theForm.phone2.value="";
    		theForm.phone2.focus(); 
    		return false; 
  		} 
  		if ((theForm.phone2.value.length)>10)  {
   			alert('Size of the phone should not be more than 12 charactes ');
  			document.theForm.phone2.value="";
    		theForm.phone2.focus(); 
    		return false; 
  		} 
 

 		
  		
  		/** This Loop Checks Whether There Is Any Input Data Present In The Mobile Field */
  		if (!isNumber(trim(theForm.mobile.value)))  {
    		alert('Please enter number only in the "mobile" box'); 
			document.theForm.mobile.value="";
    		theForm.mobile.focus(); 
    		return false; 
  		} 
  		var ph=theForm.phone.value;
  		var mo=theForm.mobile.value;
  		var ch01="0000000000";
  		var ch02="00000000000";
  		var ch03="000000000000";
  		var ch11="1111111111";
  		var ch12="11111111111";  		
  		var ch13="111111111111";
  		if (ph==ch01 ||ph==ch02 || ph==ch03 || ph==ch11 ||ph==ch12 || ph==ch13)
  		{
  			alert('Please enter valid phone number only in the "phone" box'); 
			document.theForm.phone.value="";
    		theForm.phone.focus(); 
    		return false; 
  		
  		}
  		if (mo==ch01 ||mo==ch02 || mo==ch03 || mo==ch11 ||mo==ch12 || mo==ch13)
  		{
  			alert('Please enter valid phone number only in the "phone" box'); 
			document.theForm.mobile.value="";
    		theForm.mobile.focus(); 
    		return false; 
  		
  		}
  		
  		if ((theForm.mobile.value)=='')  {
    		alert('Please enter the Country code in Mobile Number '); 
			theForm.mobile.focus(); 
   			return false; 
  		}
  		if ((theForm.mobile1.value)=='')  {
    		alert('Please enter the Mobile Number '); 
			theForm.mobile1.focus(); 
   			return false; 
  		}
  		if (!isNumber(trim(theForm.mobile1.value)))  {
    		alert('Please enter number only in the "mobile" box'); 
			document.theForm.mobile1.value="";
    		theForm.mobile1.focus(); 
    		return false; 
  		} 
  		
  		if ((theForm.mobile1.value.length)<10)  {
   			alert('Size of the mobile should be more than 10 charactes ');
  			document.theForm.mobile1.value="";
    		theForm.mobile1.focus(); 
    		return false; 
  		} 
  		if ((theForm.mobile1.value.length)>12)  {
   			alert('Size of the mobile should not be more than 12 charactes ');
  			document.theForm.mobile1.value="";
    		theForm.mobile1.focus(); 
    		return false; 
  		} 

		if ((theForm.mobile.value==null)||(theForm.mobile.value==""))
		{
			alert("Please Enter your mobile Number")
			theForm.mobile.focus()
			return false
		}
 	
    return true;
    
	}
function setFocus() {	document.theForm.firstName.focus(); }
window.onload = setFocus;
//-->

</SCRIPT>


</HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">
<%@ page language="java"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>

<!--Start main table cell 1-->

<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
	<TBODY height="100%">
		<TR>
			<TD width="39%"><img border="0"
				src="<%= request.getContextPath() %>/eminentech support files/Eminentlabs.png"
				></TD>
			<TD width="100%"><!--Start table for cell 2-->
			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="10%">
				<TBODY>

					<TR>
						<TD align=right>Global Customer Solutions Management</TD>
					</TR>

					<TR>
						<TD>

						<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%"
							bgColor="#C3D9FF">
							<TBODY bgcolor="#C3D9FF">
								<TR>
									<TD bgColor=#000000 height=20 rowSpan=3 width=1><IMG
										alt="" border=0 height=20
										src="<%= request.getContextPath() %>/eminentech support files/dot_clear.gif"
										width=1></TD>
									<TD bgColor=#000000 height=1><IMG alt="" border=0 height=1
										src="<%= request.getContextPath() %>/eminentech support files/dot_clear.gif"
										width=1></TD>
								<TR>
									<TD align=left height=18 vAlign=center width="100%">&nbsp;Welcome
									Customer</TD>
								</TR>
								<TR>
									<TD bgColor=#000000 height=1 width="100%"><IMG alt=""
										border=0 height=1
										src="<%= request.getContextPath() %>/eminentech support files/dot_clear.gif"
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
<BR>
<%
%>
<FORM name=theForm onsubmit="return fun(this)"
	action="<%= request.getContextPath() %>/admin/user/adminaccountsetdb.jsp"
	method=post onReset="return setFocus()">
<TABLE width="70%" bgColor=#eeeeee border="0" align="center">
	<FONT color=red>For security reasons, access to eTracker&#153; is
	limited to Eminentlabs&#153; customers, employees and partners.</FONT>
	The form below allows us to verify your identity and provide access to eTracker&#153;

</table>
<TABLE align="center" width="70%">
	<TBODY>
		<TR>
			<TD bgColor=#E8EEF7>

			<H3>Administrator Account Setup</H3>

			<TABLE cellSpacing=1 cellPadding=1 width="100%" border=0
				align="center">
				<TBODY>
					<tr>
						<td width="20%"><strong>First Name </strong></td>
						<td><input type="text" name="firstName" maxlength="25"
							size=25> <strong class="style20"></strong></td>
					</tr>
					<tr>
						<td><strong>Last Name </strong></td>
						<td><input type="text" name="lastName" maxlength="25" size=25>
						<span class="style13"></span></td>
					</tr>
					<tr>
						<td><strong>E mail</strong></td>
						<td><input type="text" name="userEmail" maxlength="60"
							size=25></td>
					</tr>
					
					<tr>
						<td><strong>Password</strong></td>
						<td><input type="password" name="password" maxlength="20"
							size=25></td>
					</tr>
					<tr>
						<td><strong>Confirm Password</strong></td>
						<td><input type="password" name="Confirmpass" maxlength="20"
							size=25></td>
					</tr>

					<tr>
						<td width="20"><strong>Company</strong></td>
						<td><input type="text" name="company" maxlength="30" size=25></td>
					</tr>
					<tr>
						<td width="20%"><strong>Security question</strong></td>
						<td align="left" width="560"><select name="secret" id="pwq">
							<option value="">[Select a Question]</option>

							<option value="What is your fathers middle name?">What
							is your father's middle name?</option>
							<option value="What was the name of your first school?">What
							was the name of your first school?</option>
							<option value="Who was your childhood hero?">Who was
							your childhood hero?</option>
							<option value="What is your favorite pastime?">What is
							your favorite pastime?</option>
							<option value="What is your all-time favorite sports team?">What
							is your all-time favorite sports team?</option>
							<option value="What was your high school mascot?">What
							was your high school mascot?</option>
							<option value="What make was your first car or bike?">What
							make was your first car or bike?</option>
							<option value="Where did you first meet your spouse?">Where
							did you first meet your spouse?</option>
							<option value="What is your pets name?">What is your
							pet's name?</option>
						</select></td>
					</tr>
					<tr>
						<td width="20"><strong>Answer</strong></td>
						<td><input type="text" name="answer" maxlength="20" size=25></td>
					</tr>

					<tr>
						<td><strong>Phone</strong></td>
						<td><input type="text" name="phone" maxlength="4" size=5>

						<input type="text" name="phone1" maxlength="5" size=5> <input
							type="text" name="phone2" maxlength="10" size=15><b>(Country-STD-Phone
						No.)</b></td>
					</tr>

					<tr>
						<td><strong>Mobile</strong></td>
						<td><input type="text" name="mobile" maxlength="4" size=5>
						<input type="text" name="mobile1" maxlength="10" size=15><b>(Country-Mobile
						No.)</b></td>
					</tr>
					<tr>
			<td><strong>Mobile Operator</strong></td>
			<td><select name="operator" id="operator">
				<option value="">[Select a Operator]</option>
				<option value="AIRTEL">AIRTEL</option>
				<option value="VODAFONE">VODAFONE</option>
				<option value="BSNL">BSNL</option>
				<option value="SPICE">SPICE</option>
				<option value="OTHERS">OTHERS</option>
				<!--                  <option value="AIRCEL">AIRCEL</option>
                                                <option value="RELIENCE">RELIENCE</option>
                                                <option value="TATA INDICOM">TATA INDICOM</option>
                                   -->
			</select></td>
		</tr>
		
		<tr></tr>


					<tr>
						<td>&nbsp;</td>
						<td><label></label> <label></label></td>
						
						
					</tr>

					<tr>
						<TD><input type="hidden" name="team" value="ADMIN"></TD>
						<TD><INPUT type=submit value=Submit name=submit> <INPUT
							type=reset value=" Clear "></TD>
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
<BR>

<%@ include file="/footer.jsp"%>


</BODY>
</HTML>
