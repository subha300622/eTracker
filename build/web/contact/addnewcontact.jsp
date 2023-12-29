
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*"%>
<%
           response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

	

	Logger logger = Logger.getLogger("Add New Contact");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>

<script type="text/javascript"	src="<%= request.getContextPath() %>/eminentech support files/dbpicker.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<script language=JAVASCRIPT type="text/javascript">
function trim(str)  
{
        while (str.charAt(str.length - 1)==" ")
   	str = str.substring(0, str.length - 1);
  	while (str.charAt(0)==" ")
    	str = str.substring(1, str.length);
  	return str;
}
function isDate(str)
{
	var pattern = "1234567890-"
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

function isNumber(str)
{
	var pattern = "0123456789."
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

	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

function isPositiveInteger(str)
{
	var pattern = "abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890"
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
function isCompany(str)
{
	var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
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
function isPositiveInteger1(str)
{
	var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ";
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



	/** Function To Validate The Input Form Data */
function fun(theForm)
{

    if (trim(theForm.title.value)=='')
        {
   		alert('Please enter the Title ');
		document.theForm.title.value="";
                theForm.title.focus();
                return false;
  	}
	if (!isPositiveInteger1(trim(theForm.title.value)))
        {
   		alert('Please enter the Alphabets only in the Title ');
		document.theForm.title.value="";
                theForm.title.focus();
                return false;
  	}
	if (trim(theForm.firstname.value)=='' )
	{
		alert('Please enter the First Name ');
		document.theForm.firstname.value="";
   		theForm.firstname.focus();
   		return false;
	}
	if (!isPositiveInteger1(trim(theForm.firstname.value)))
	{
		alert('Please enter the Alphabet Characters only in the First Name ');
		document.theForm.firstname.value="";
   		theForm.firstname.focus();
   		return false;
	}
        if ((theForm.lastname.value)=='')
	{
		alert('Please enter the Last Name');
		document.theForm.lastname.value="";
		theForm.lastname.focus();
   		return false;
	}
	if (!isPositiveInteger1(trim(theForm.lastname.value)))
	{
		alert('Please enter the Last Name with Alphabets only');
		document.theForm.lastname.value="";
		theForm.lastname.focus();
   		return false;
	}
	if (trim(theForm.phone.value)=='')
	{
		alert('Please enter the Phone ');
		document.theForm.phone.value="";
   		theForm.phone.focus();
   		return false;
	}
	if (!isNumber(trim(theForm.phone.value)))
	{
		alert('Please enter the Numerical Characters only in the Phone ');
		document.theForm.phone.value="";
   		theForm.phone.focus();
   		return false;
	}



	if (trim(theForm.email.value)=='')
        {
   		alert('Please enter the valid Email ');
		document.theForm.email.value="";
                theForm.email.focus();
                return false;
  	}
        if (!isPositiveInteger(trim(theForm.email.value)))
        {
   		alert('Please enter the AlphaNumerical only in the Email ');
		document.theForm.email.value="";
                theForm.email.focus();
                return false;
  	}
        var mail=theForm.email.value;
	var user=mail.indexOf('@');
    	var len=mail.length;
	var id=mail.substring(user+1,len);
	var id1=mail.substring(0,user-1);

	if( !( (user>=0)))  {
	  		alert('Enter the valid Email Address');
	 		document.theForm.email.value="";
   			theForm.email.focus();
                        return false;
        }

        if (len<5)  {
   			alert('Size of the Email should be more than 4 charactes ');
  			document.theForm.email.value="";
                        theForm.email.focus();
                        return false;
  	}
        if (trim(theForm.company.value)=='')
        {
   		alert('Please enter the Company ');
		document.theForm.company.value="";
                theForm.company.focus();
                return false;
  	}
	if (!isCompany(trim(theForm.company.value)))
        {
   		alert('Please enter the AlphaNumerical only in the Company ');
		document.theForm.company.value="";
                theForm.company.focus();
                return false;
  	}
	if (trim(theForm.mobile.value)=='')
	{
		alert('Please enter Mobile ');
		document.theForm.mobile.value="";
   		theForm.mobile.focus();
   		return false;
	}
  	if (!isNumber(trim(theForm.mobile.value)))
	{
		alert('Please enter the Numerical Characters only in the Mobile ');
		document.theForm.mobile.value="";
   		theForm.mobile.focus();
   		return false;
	}
        if(!(theForm.personalemail.value=='')){
            if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.personalemail.value)))
            {
                    alert("Invalid Personal E-mail Address! Please re-enter.")
                    document.theForm.personalemail.value="";
                    theForm.personalemail.focus();
                    return (false);
            }
        }
	if (!isPositiveInteger(trim(theForm.reportsto.value)) && trim(theForm.reportsto.value)!='')
        {
   		alert('Please enter the AlphaNumerical only in the Reports To ');
		document.theForm.reportsto.value="";
                theForm.reportsto.focus();
                return false;
  	}
      if (!(/^[0-9a-zA-Z\_,/]+$/.test(theForm.mailingstreet.value)) && trim(theForm.mailingstreet.value) != '') {
            alert("Special characters are not allowed in street! Please re-enter.")
            document.theForm.mailingstreet.value = "";
            theForm.mailingstreet.focus();
            return (false);
        }
        
           if (!isPositiveInteger(trim(theForm.mailingarea.value)) && trim(theForm.mailingarea.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Area/Location ');
		document.theForm.mailingarea.value="";
        theForm.mailingarea.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingcity.value)) && trim(theForm.mailingcity.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the City ');
		document.theForm.mailingcity.value="";
        theForm.mailingcity.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingstate.value)) && trim(theForm.mailingstate.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the State ');
		document.theForm.mailingstate.value="";
        theForm.mailingstate.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingzip.value)) && trim(theForm.mailingzip.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Zip ');
		document.theForm.zip.value="";
        theForm.zip.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingcountry.value)) && trim(theForm.mailingcountry.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Country ');
		document.theForm.mailingcountry.value="";
        theForm.mailingcountry.focus();
        return false;
  	}

	if (!isNumber(trim(theForm.fax.value)) && trim(theForm.fax.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Fax ');
		document.theForm.fax.value="";
   		theForm.fax.focus();
   		return false;
	}
	if (!isNumber(trim(theForm.homephone.value)) && trim(theForm.homephone.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Home Phone ');
		document.theForm.homephone.value="";
   		theForm.homephone.focus();
   		return false;
	}
	if (!isNumber(trim(theForm.otherphone.value)) && trim(theForm.otherphone.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Other Phone ');
		document.theForm.otherphone.value="";
   		theForm.otherphone.focus();
   		return false;
	}

	if (!isPositiveInteger(trim(theForm.assistant.value)) && trim(theForm.assistant.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Assistant ');
		document.theForm.assistant.value="";
        theForm.assistant.focus();
        return false;
  	}
	if (!isNumber(trim(theForm.asstphone.value)) && trim(theForm.asstphone.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Asst.Phone ');
		document.theForm.asstphone.value="";
   		theForm.asstphone.focus();
   		return false;
	}

     var str   = document.theForm.birthdate.value;
        var first = str.indexOf("-");
        var last  = str.lastIndexOf("-");
        var year         = str.substring(last+1,last+5);
        var month        = str.substring(first+1,last);
        var date         = str.substring(0,first);
        var form_date    = new Date(year,month-1,date);

        var current_date = new Date();

    if (!(theForm.birthdate.value)=='')
        {

   			if(form_date.getFullYear() > (current_date.getFullYear()-18))
            {
                window.alert("Enter the valid Date of Birth");
                theForm.birthdate.focus();
                document.theForm.birthdate.value="";
                return false;
            }

  		}

	if (!isPositiveInteger(trim(theForm.department.value)) && trim(theForm.department.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Department ');
		document.theForm.department.value="";
        theForm.department.focus();
        return false;
  	}

        monitorSubmit();
    return true;
	}

	/** Function To Set Focus On The Project Name Field In The Form */

	function setFocus()  {
		document.theForm.firstname.focus();
	}
	window.onload = setFocus;


</script>
</head>
<body>
<FORM name=theForm
	action="newcontact.jsp"
	method=post onsubmit="return fun(this)" onReset="return setFocus()">
<%@ include file="/header.jsp"%>
<div align="center">
<center>
<table  width="100%">
	<tr bgcolor="C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>
		Add New Contact</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>

<TABLE width="100%" bgColor=#E8EEF7  align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td colspan=2><strong>Contact Information</strong></td>
			<td ><input type="hidden" name="owner" maxlength="30" size=20 value="<%=session.getAttribute("uid")%>"
				 readonly=true></td>
			<td align="right" colspan=3><strong><font size="10"
				COLOR="#FF0000">*</font> = Required Information</strong></td>
		</tr>

		<tr>
			<td width="10%"><strong>Title<font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="title" maxlength="30" size=14
				><strong class="style20"></strong></td>
			<td width="10%"><strong>First Name<font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="firstname" maxlength="30" size=25
				><strong class="style20"></strong></td>
			<td width="12%"><strong>Last Name <font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="23%"><input type="text" name="lastname" maxlength="30" size=20
				><strong class="style20"></strong></td>
		</tr>

		<tr>


			<td width="10%"><strong>Phone<font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="phone" maxlength="15" size=14
				><strong class="style20"></strong></td>
			<td width="10%"><strong>Official Email<font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="email" maxlength="60" size=25
				><strong class="style20"></strong></td>

			<td width="10%"><strong>Company<font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="23%"><input type="text" name="company" maxlength="60" size=20
				><strong class="style20"></strong></td>




		</tr>
		<tr>
			<td width="10%"><strong>Mobile<font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="mobile" maxlength="15" size=14
				><strong class="style20"></strong></td>
                        <td width="10%"><strong>Personal Email</strong></td>
			<td width="25%"><input type="text" name="personalemail" maxlength="60" size=25
				><strong class="style20"></strong></td>
			<td width="12%"><strong>Reports to</strong></td>
			<td width="23%"><input type="text" name="reportsto" maxlength="30" size=25
				><strong class="style20"></strong></td>
		</tr>



		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF">
			<td colspan=6><strong >Address Information</strong></td>
			<td><input type="hidden" name="contactid"
				></td>
		</tr>

		<tr>
			<td width="10%"><strong>Street</strong></td>
			<td width="21%"> <textarea name="mailingstreet" wrap="physical" cols="13"
				rows="2"></textarea></td>
                                
                                <td width="10%"><strong>Area/Location</strong></td>
			<td width="21%"> <textarea name="mailingarea" wrap="physical" cols="13" maxlength="100"
				rows="2"></textarea></td>


			<td width="10%"><strong>City</strong></td>
			<td width="23%"><input type="text" name="mailingcity" maxlength="30" size=25
				><strong class="style20"></strong></td>


			

		</tr>
		<tr>
                    <td width="12%"><strong>State</strong></td>
			<td width="23%"><input type="text" name="mailingstate" maxlength="30"
				size=20 ><strong class="style20"></strong></td>
			<td width="10%"><strong>Zip</strong></td>
			<td width="21%"><input type="text" name="mailingzip" maxlength="30" size=14
				><strong class="style20"></strong></td>

			<td width="10%"><strong>Country</strong></td>
			<td width="23%"><input type="text" name="mailingcountry" maxlength="30"
				size=25 ><strong class="style20"></strong></td>


		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>

		<tr bgcolor="C3D9FF">
			<td colspan=6><strong>Additional Information</strong></td>
		</tr>


		<tr>
			<td width="10%"><strong>Fax</strong></td>
			<td width="21%"><input type="text" name="fax" maxlength="30" size=14
				><strong class="style20"></strong></td>
			<td width="10%"><strong>Home Phone</strong></td>
			<td width="23%"><input type="text" name="homephone" maxlength="30" size=25
				><strong class="style20"></strong></td>
			<td width="12%"><strong>Other Phone</strong></td>
			<td width="23%"><input type="text" name="otherphone" maxlength="30" size=20
				><strong class="style20"></strong></td>

		</tr>

		<tr>

			<td width="10%"><strong>Department</strong></td>
			<td width="21%"><input type="text" name="department" maxlength="30" size=14
				><strong class="style20"></strong></td>

			<td width="10%"><strong>Assistant</strong></td>
			<td width="23%"><input type="text" name="assistant" maxlength="30" size=25
				><strong class="style20"></strong></td>

			<td width="12%"><strong>Asst. Phone</strong></td>
			<td width="23%"><input type="text" name="asstphone" maxlength="30" size=20
				><strong class="style20"></strong></td>
		</tr>
<tr>
			<td width="10%"><strong>Birthdate</strong></td>
			<td width="21%"><input type="text" name="birthdate" id="birthdate" maxlength="30" size=14
				readonly="true"> <strong
				class="style20"></strong><a
				href="javascript:NewCal('birthdate','ddmmyyyy')"> <img
				src="images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a></td>
			<td width="10%"><strong>Lead Source</strong></td>

			<td align="left" width="23%">
			<SELECT NAME="leadsource" size="1">

				<OPTION value="--None--" selected>--None--</option>
				<option value="Advertisement">Advertisement</option>
				<option value="External Referrel">External Referrel</option>
                <option value="Employee Referrel">Employee Referrel</option>
				<option value="Partner">Partner</option>
				<option value="Public Relataion">Public Relataion</option>
				<option value="Seminar-Internal">Seminar-Internal</option>
				<option value="Seminar-Partner">Seminar-Partner</option>
			</SELECT></td>



		</tr>
	</tbody>
</table>
<br>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Descriptive Information</strong></td>
		</tr>
	</tbody>
</table>
<table width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Description</strong></td>
			<td><textarea name="description" wrap="physical" cols="69"
				rows="2"></textarea></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<TD>&nbsp;</TD>
			<TD align=right><INPUT type=submit value=Submit name=submit id=submit></TD>
			<TD><INPUT type=reset id=reset value=" Reset "></TD>
		</tr>
	</TBODY>
</TABLE>
</center>
</div>
</FORM>
<BR>
</body>
</html>