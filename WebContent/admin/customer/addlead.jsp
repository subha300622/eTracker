<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%
	String username=request.getParameter("username");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<title>Eminentlabs&#0153; Customer Relationship Management</title>
</head>
<SCRIPT>
function trim(str)  
{
    while (str.charAt(str.length - 1)==" ") 
	   	str = str.substring(0, str.length - 1); 
  	while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  	return str; 
} 

function isNumber(str)  
{
	var pattern = "0123456789+- ." 
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

function isPositiveInteger(str)  
{
	var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}/\!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890" 
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
	var pattern = "abcdefghijklmnopqrstuvwxyz,.:-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ" 
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
	/** This Loop Checks Whether There Is Any Integer Present In The Project Name Field */
        if (trim(theForm.firstname.value)=='')  
	{
		alert('Please enter the firstname '); 
		document.theForm.firstname.value="";
   		theForm.firstname.focus(); 
   		return false; 
	}
	if (!isPositiveInteger1(trim(theForm.firstname.value))  )  
	{
		alert('Please enter the Alphabetical Characters only in the Firstname '); 
		document.theForm.firstname.value="";
   		theForm.firstname.focus(); 
   		return false; 
	}
        
	if ((theForm.lastname.value)=='')  
	{
		alert('Please enter the last name'); 
		document.theForm.lastname.value="";
		theForm.lastname.focus();  
   		return false; 
	}
	if (!isPositiveInteger1(trim(theForm.lastname.value)))  
	{
		alert('Please enter the Alphabetical Characters only in the Lastname'); 
		document.theForm.lastname.value="";
		theForm.lastname.focus();  
   		return false; 
	}
	
	if (trim(theForm.email.value)=='')  
        {
   		alert('Please enter the email '); 
		document.theForm.email.value="";
                theForm.email.focus(); 
                return false; 
  	}
        if (!isPositiveInteger(trim(theForm.email.value)))  
        {
   		alert('Please enter the valid email '); 
		document.theForm.email.value="";
                theForm.email.focus(); 
                return false; 
  	}
      
        if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.email.value)))
 	{
		alert("Invalid E-mail Address! Please re-enter.")
		document.theForm.email.value="";
    		theForm.email.focus(); 
    		return (false);
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
   			alert('Size of the username should be more than 4 charactes ');
  			document.theForm.email.value="";
                        theForm.email.focus(); 
                        return false; 
  	}
        if ((theForm.company.value)=='')  
        {
   		alert('Please enter the company '); 
		document.theForm.company.value="";
                theForm.company.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.company.value)))  
        {
   		alert('Please enter the valid company '); 
		document.theForm.company.value="";
                theForm.company.focus(); 
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
	if (trim(theForm.title.value)=='')  
        {
   		alert('Please enter the title '); 
		document.theForm.title.value="";
                theForm.title.focus(); 
                return false; 
  	}
        if (!isPositiveInteger1(trim(theForm.title.value)))  
        {
   		alert('Please enter the Alphabets only in the title '); 
		document.theForm.title.value="";
                theForm.title.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.street.value)) && trim(theForm.street.value)!='')  
        {
   		alert('Please enter valid data in the street'); 
		document.theForm.street.value="";
                theForm.street.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.city.value)) && trim(theForm.city.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the city '); 
		document.theForm.city.value="";
                theForm.city.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.state.value)) && trim(theForm.state.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the state '); 
		document.theForm.state.value="";
                theForm.state.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.zip.value)) && trim(theForm.zip.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the zip '); 
		document.theForm.zip.value="";
                theForm.zip.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.country.value)) && trim(theForm.country.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the country '); 
		document.theForm.country.value="";
                theForm.country.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.website.value)) && trim(theForm.website.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the website '); 
		document.theForm.website.value="";
                theForm.website.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.noofemployees.value)) && trim(theForm.noofemployees.value)!='')  
        {
   		alert('Please enter the Numerical only in the noofemployees '); 
		document.theForm.noofemployees.value="";
                theForm.noofemployees.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.annualrevenue.value)) && trim(theForm.annualrevenue.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the annualrevenue '); 
		document.theForm.annualrevenue.value="";
                theForm.annualrevenue.focus(); 
                return false; 
  	}
        return true;
	}
	function setFocus()  {
		document.theForm.firstname.focus();
	}
	window.onload = setFocus;
</SCRIPT>
<body>
<FORM name=theForm
	action="http://www.eminentlabs.com/eTracker/admin/customer/newsaleslead.jsp"
	method=post onsubmit="return fun(this)" onReset="return setFocus()">
<div align="center">
<center><br>
<TABLE width="80%" border="0" align="center">
	<TBODY>
		<tr>
			<td align="right"><img src="images/Eminentlabs_logo.gif"
				alt="Eminentlabs Software Pvt Ltd"></td>
		</tr>
	</tbody>
</table>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>

		<tr bgcolor="C3D9FF">
			<td><strong>Please fill up this form, our executive
			will getback to you shortly</strong></td>
			<td align="right"><strong><font size="10"
				COLOR="#FF0000">**</font> = Required Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>First Name</strong><font size="10"
				COLOR="#FF0000">**</font></td>
			<td><input type="text" name="firstname" maxlength="30" size=25><strong
				class="style20"></strong></td>
			<td width="10%"><strong>Last Name<font size="10"
				COLOR="#FF0000">**</font></strong></td>
			<td><input type="text" name="lastname" maxlength="30" size=25><strong
				class="style20"></strong></td>

		</tr>
		<tr>

			<td width="10%"><strong>Phone</strong><font size="10"
				COLOR="#FF0000">**</font></td>
			<td><input type="text" name="phone" maxlength="30" size=25><strong
				class="style20"></strong></td>
			<td width="10%"><strong>Mobile</strong><font size="10"
				COLOR="#FF0000"></font></td>
			<td><input type="text" name="mobile" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
		<tr>
			<td width="10%"><strong>Company<font size="10"
				COLOR="#FF0000">**</font></strong></td>
			<td><input type="text" name="company" maxlength="30" size=25><strong
				class="style20"></strong></td>
			<td width="10%"><strong>Email</strong><font size="10"
				COLOR="#FF0000">**</font></td>
			<td><input type="text" name="email" maxlength="60" size=25><strong
				class="style20"></strong></td>
		</tr>
		<tr>
			<td width="10%"><strong>Title</strong><font size="10"
				COLOR="#FF0000">**</font></td>
			<td><input type="text" name="title" maxlength="30" size=25><strong
				class="style20"></strong></td>
			<td width="10%"><strong>Web Site</strong></td>
			<td><input type="text" name="website" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
	</tbody>
</table>
<br>

<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Address Information</strong></td>
		</tr>
	</tbody>
</table>

<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Street</strong></td>
			<td><textarea name="street" wrap="physical" cols="20" rows="2"></textarea></td>


			<td width="10%"><strong>City</strong></td>
			<td><input type="text" name="city" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
		<tr>
			<td width="10%"><strong>State</strong></td>
			<td><input type="text" name="state" maxlength="30" size=25><strong
				class="style20"></strong></td>

			<td width="10%"><strong>Zip</strong></td>
			<td><input type="text" name="zip" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
		<tr>
			<td width="10%"><strong>Country</strong></td>
			<td><input type="text" name="country" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
	</tbody>
</table>
<br>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">

	<TBODY>

		<tr bgcolor="C3D9FF">
			<td><strong>Additional Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">

	<TBODY>

		<tr>
			<td width="10%"><strong>No of employees</strong></td>
			<td><SELECT NAME="noofemployees" size="1">
				<OPTION value="--Select One--">--Select One--</option>
				<option value="0 - 50 employees">0 - 50 employees</option>
				<option value="51 - 200 employees" selected>51 - 200
				employees</option>
				<option value="200 - 500 employees">200 - 500 employees</option>
				<option value="500 - 2000 employees">500 - 2000 employees</option>
				<option value="2000 + employees">2000 + employees</option>
			</SELECT></td>
			<td width="10%"><strong>Lead Source</strong></td>
			<td align="left" width="35%"><SELECT NAME="leadsource" size="1">
				<OPTION value="--None--">--None--</option>
				<option value="Advertisement">Advertisement</option>
				<option value="Employee Referrel">Employee Referrel</option>
				<option value="External Referrel">External Referrel</option>
				<option value="partner">partner</option>
				<option value="public relataion">public relataion</option>
				<option value="seminar-internal">seminar-internal</option>
				<option value="seminar-partner">seminar-partner</option>
				<option value="Trade Show">Trade Show</option>
				<option value="web" selected>web</option>
				<option value="Word of mouth">Word of mouth</option>
				<option value="others">others</option>
			</SELECT></td>
		</tr>
		<tr>
			<td width="10%"><strong>Annual Revenue</strong></td>
			<td><SELECT NAME="annualrevenue" size="1">
				<OPTION value="--Select One--">--Select One--</option>
				<option value="$200K - $1 Million">$200K - $1 Million</option>
				<option value="$1 million - $10 million" selected>$1
				million - $10 million</option>
				<option value="$10 million - $100 million">$10 million -
				$100 million</option>
				<option value="$100 million - $1 billion">$100 million -
				$1 billion</option>
				<option value="Above $1 billion">Above $1 billion</option>
			</SELECT></td>
			<td width="10%"><strong>Industry</strong></td>
			<td align="left" width="35%"><SELECT NAME="industry" size="1">
				<OPTION value="--None--">--None--</option>
				<option value="Aerospace & Defense">Aerospace & Defense</option>
				<option value="Automotive">Automotive</option>
				<option value="Banking">Banking</option>
				<option value="Building Materials">Building Materials</option>
				<option value="chemicals">chemicals</option>
				<option value="Consumer Products">Consumer Products</option>
				<option value="Cross Industry">Cross Industry</option>
				<option value="Engineering, Contract & Operations">Engineering,
				Contract & Operations</option>
				<option value="Fabricated Metal Products">Fabricated Metal
				Products</option>
				<option value="Financial Service Provider">Financial
				Service Provider</option>
				<option value="Forest Products, Furniture & Textile">Forest
				Products, Furniture & Textile</option>
				<option value="Healthcare">Healthcare</option>
				<option value="High Tech & Electronics">High Tech &
				Electronics</option>
				<option value="Higher Education & Research">Higher
				Education & Research</option>
				<option value="Industrial Machinery  & Components">Industrial
				Machinery & Components</option>
				<option value="Insurance">Insurance</option>
				<option value="Lifescience">Lifescience</option>
				<option value="Logistics & Postal Services">Logistics &
				Postal Services</option>
				<option value="Media">Media</option>
				<option value="Nonclassifiable Establishments">Nonclassifiable
				Establishments</option>
				<option value="Oil & Gas">Oil & Gas</option>
				<option value="Passenger & Cargo Services">Passenger &
				Cargo Services</option>
				<option value="Primary Metal & Mining">Primary Metal &
				Mining</option>
				<option value="Professional Services" selected>Professional
				Services</option>
				<option value="Public Sector">Public Sector</option>
				<option value="Retail">Retail</option>
				<option value="Telecommunication">Telecommunication</option>
				<option value="Utilities & Waste">Utilities & Waste</option>
				<option value="Wholesale">Wholesale</option>
			</SELECT></td>
		</tr>
	</tbody>
</table>
<br>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Descriptive Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Description</strong></td>
			<td><textarea name="description" wrap="physical" cols="69"
				rows="2"></textarea></td>
		</tr>
	</tbody>
</table>
<TABLE width="80%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<TD>&nbsp;</TD>
			<TD align=right><INPUT type=submit value=Submit name=submit></TD>
			<TD><INPUT type=reset value=" Reset "></TD>
		</TR>
	</TBODY>
</TABLE>
</center>
</div>
</FORM>
</body>
</html>