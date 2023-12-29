<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*,org.apache.log4j.*"%>
<%
	
	Logger logger = Logger.getLogger("Add New Lead");

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"	type=text/css rel=STYLESHEET>
<title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>
<script language=javascript	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
<script>
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
	var pattern = "0123456789.+- " 
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
	var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890" 
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
	var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789" 
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
function fun(theForm){
	
	if (trim(theForm.title.value)=='')  
    {
		alert('Please enter the Title '); 
		document.theForm.title.value="";
        theForm.title.focus(); 
        return false; 
	}
	if (!isPositiveInteger1(trim(theForm.title.value)))  
    {
		alert('Please enter the AlphaNumerical only in the Title '); 
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
		alert('Please enter the AlphaNumerical Characters only in the First Name '); 
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
		alert('Please enter the Last Name with AlphaNumerical only'); 
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
       
	if (!isPositiveInteger(trim(theForm.company.value)))  
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
   	if (document.getElementById('leadstatus').value == '--Select One--') 
    {
        alert("Please choose a Lead Status");
        document.getElementById('leadstatus').focus();
        return false;
    }
   	if (document.getElementById('assignedto').value == '--Select One--') 
    {
        alert("Please choose a Assigned to Name");
        document.getElementById('assignedto').focus();
        return false;
    }
   	if (document.getElementById('rating').value == '--Select One--') 
    {
        alert("Please choose a Rating");
        document.getElementById('rating').focus();
        return false;
    }
   	if (!isPositiveInteger(trim(theForm.website.value)) && trim(theForm.website.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the Website '); 
		document.theForm.website.value="";
        theForm.website.focus(); 
        return false; 
  	}
   	if (trim(theForm.leadpotential.value)=='')  
 	{
 		alert('Please enter Lead Potential '); 
 		document.theForm.leadpotential.value="";
    		theForm.leadpotential.focus(); 
    		return false; 
 	}
	if (!isNumber(trim(theForm.leadpotential.value)))  
    {
   		alert('Please enter the Numerical only in the Lead Potential '); 
		document.theForm.leadpotential.value="";
        theForm.leadpotential.focus(); 
        return false; 
  	}
	if (trim(document.theForm.duedate.value)== "")
    {
        alert ("Please Enter the Due Date ");
        document.theForm.duedate.focus();
        return false;
    }
    if (!isDate(trim(theForm.duedate.value)))  
    {
        alert('Please enter the valid Due Date'); 
	document.theForm.duedate.value="";
        theForm.duedate.focus(); 
        return false; 
    }
    var str   = document.theForm.duedate.value;
    var first = str.indexOf("-");
    var last  = str.lastIndexOf("-");
    var year         = str.substring(last+1,last+5);
    var month        = str.substring(first+1,last);
    var date         = str.substring(0,first);
    var form_date    = new Date(year,month-1,date);
    var current_date = new Date();
    
    var current_year  = current_date.getYear();
    var current_month = current_date.getMonth();
    var current_date  = current_date.getDate();
    var today = new Date(current_year,current_month,current_date);
                
    if(form_date < today){
        alert('Due Date cannot be less than Today'); 
	document.theForm.duedate.value="";
        theForm.duedate.focus(); 
        return false; 
    }
    monitorSubmit();
}
function setFocus()  {
	document.theForm.firstname.focus();
}
window.onload = setFocus;
</script>
</head>
<body scroll="no">
<%@ include file="/header.jsp"%>
<FORM name=theForm
	action="<%=request.getContextPath() %>/admin/customer/newlead.jsp"
	method=post onsubmit="return fun(this)" onReset="return setFocus()">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>
		Add New Lead</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<br>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Lead Information</strong></td>
			<td><input type="hidden" name="leadowner" value="<%=session.getAttribute("uid")%>"></td>
			<td align="right"><strong><font size="10"
				COLOR="#FF0000">*</font> = Required Information</strong></td>
		</tr>
	</tbody>
</table>

<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Title<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="title" maxlength="30" size=14><strong class="style20"></strong></td>
			<td width="10%"><strong>First Name<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="firstname" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="12%"><strong>Last Name <font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%"><input type="text" name="lastname" maxlength="30" size=20><strong class="style20"></strong></td>
		</tr>
		<tr>
				
			<td width="10%"><strong>Phone<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="phone" maxlength="15" size=14><strong class="style20"></strong></td>
			<td width="10%"><strong>Email<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="email" maxlength="60" size=25><strong class="style20"></strong></td>
			<td width="12%"><strong>Company<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%"><input type="text" name="company" maxlength="30" size=20><strong class="style20"></strong></td>
		</tr>

		<tr>
			<td width="10%"><strong>Mobile<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="mobile" maxlength="15" size=14><strong class="style20"></strong></td>
			<td width="10%"><strong>Lead Status<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td align="left" width="25%">
                            <SELECT NAME="leadstatus" id="leadstatus" size="1">
					<OPTION value="Open" selected>Open</option>
					<option value="Contacted">Contacted</option>
					<option value="Qualified">Qualified</option>
					<option value="UnQualified">UnQualified</option>
				</SELECT>
			</td>
			<td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%">
                            <select name="assignedto" id="assignedto" size="1">
					<option value="--Select One--" selected>--Select One--</option>
			<% 

			
			HashMap al;
			
			String pro="CRM";
			String fix="1.0";
			al=GetProjectMembers.getBDMembers(pro,fix);
			Collection set=al.keySet();
			Iterator iter = set.iterator();
			int assigned=0;
            int useridassi=0;

		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String nameofuser=(String)al.get(key);
		      logger.info("Userid"+key);
		      logger.info("Name"+nameofuser);
		      
		      nameofuser=nameofuser.substring(0,nameofuser.indexOf(" ")+2);
		      
		      useridassi=Integer.parseInt(key);
				
					assigned=useridassi;
%>
			
			<option value="<%=assigned%>" selected><%=nameofuser%></option>
			<%
			
		    }
%>
		</select></td>
		</tr>

		<tr>
			<td width="10%"><strong>Rating</strong></td>
                        <td><SELECT NAME="rating" id="rating" size="1">

				<option value="Hot" selected>Hot</option>
				<option value="Warm">Warm</option>
				<option value="Cold">Cold</option>
			</SELECT></td>
			<td width="10%"><strong>Web Site</strong></td>
			<td><input type="text" name="website" maxlength="60" size=25><strong
				class="style20"></strong></td>
			<td width="10%"><strong>Lead Potential</strong><font size="10"	COLOR="#FF0000">*</font></td>
			<td><input type="text" name="leadpotential" maxlength="30"
				size=20><strong class="style20"></strong></td>

		</tr>
		<tr>
			<td width="10%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="duedate" id="duedate" maxlength="10" size="12" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>
			<td width="10%"><strong>Interested In<font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%">
				<select name="product" size="1">
				<option value="eTracker">eTracker</option>
				<option value="eOutSource">eOutSource</option>
				<option value="ERPDS">ERPDS</option>
				</select>
			</td>
		</tr>

	</tbody>
</table>
<br>

<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Address Information</strong></td>
		</tr>
	</tbody>
</table>

<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Street</strong></td>
			<td width="21%"><textarea name="street" wrap="physical" cols="13" rows="2"></textarea></td>


			<td width="10%"><strong>City</strong></td>
			<td width="25%"><input type="text" name="city" maxlength="30" size=25><strong class="style20"></strong></td>
		
			<td width="12%"><strong>State</strong></td>
			<td width="23%"><input type="text" name="state" maxlength="30" size=20><strong
				class="style20"></strong></td>
		</tr>
		<tr>
			<td width="10%"><strong>Zip</strong></td>
			<td width="21%"><input type="text" name="zip" maxlength="30" size=14><strong
				class="style20"></strong></td>
	
			<td width="10%"><strong>Country</strong></td>
			<td width="25%"><input type="text" name="country" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
	</tbody>
</table>
<br>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">

	<TBODY>

		<tr bgcolor="C3D9FF">
			<td><strong>Additional Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">

	<TBODY>

		<tr>
			<td width="10%"><strong>Revenue</strong></td>
			<td colspan="2" width="31%"><SELECT NAME="annualrevenue" size="1">
				<OPTION value="--Select One--" selected>--Select One--</option>
				<option value="$200K - $1 Million">$200K - $1 Million</option>
				<option value="$1 million - $10 million">$1 million - $10
				million</option>
				<option value="$10 million - $100 million">$10 million -
				$100 million</option>
				<option value="$100 million - $1 billion">$100 million -
				$1 billion</option>
				<option value="Above $1 billion">Above $1 billion</option>
			</SELECT></td>
			<td width="24%"></td>

			<td width="12%"><strong>Employees</strong></td>
			<td width="25%"><SELECT NAME="noofemployees" size="1">
				<OPTION value="--Select One--" selected>--Select One--</option>
				<option value="0 - 50 employees">0 - 50 employees</option>
				<option value="51 - 200 employees">51 - 200 employees</option>
				<option value="200 - 500 employees">200 - 500 employees</option>
				<option value="500 - 2000 employees">500 - 2000 employees</option>
				<option value="2000 + employees">2000 + employees</option>
			</SELECT></td>
			
		
			
		</tr>
		<tr>
			<td width="10%"><strong>Industry</strong></td>
			<td align="left" colspan="2" width="31%"><SELECT NAME="industry" size="1">
				<OPTION value="--None--" selected>--None--</option>
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
				<option value="Forest Products, Furniture & Textile">Forest Products, Furniture & Textile</option>
				<option value="Healthcare">Healthcare</option>
				<option value="High Tech & Electronics">High Tech &	Electronics</option>
				<option value="Higher Education & Research">Higher Education & Research</option>
				<option value="Industrial Machinery  & Components">Industrial Machinery & Components</option>
				<option value="Insurance">Insurance</option>
				<option value="Lifescience">Lifescience</option>
				<option value="Logistics & Postal Services">Logistics & Postal Services</option>
				<option value="Media">Media</option>
				<option value="Nonclassifiable Establishments">Nonclassifiable Establishments</option>
				<option value="Oil & Gas">Oil & Gas</option>
				<option value="Passenger & Cargo Services">Passenger & Cargo Services</option>
				<option value="Primary Metal & Mining">Primary Metal & Mining</option>
				<option value="Professional Services">Professional Services</option>
				<option value="Public Sector">Public Sector</option>
				<option value="Retail">Retail</option>
				<option value="Telecommunication">Telecommunication</option>
				<option value="Utilities & Waste">Utilities & Waste</option>
				<option value="Wholesale">Wholesale</option>
			</SELECT></td>
			<td width="24%"></td>
			<td width="12%"><strong>Lead Source</strong></td>
			<td align="left" ><SELECT NAME="leadsource" size="1">
				<OPTION value="--None--" selected>--None--</option>
				<option value="Advertisement">Advertisement</option>
				<option value="Employee Referrel">Employee Referrel</option>
				<option value="External Referrel">External Referrel</option>
				<option value="Partner">Partner</option>
				<option value="Public Relataion">Public Relataion</option>
				<option value="Seminar-Internal">Seminar-Internal</option>
				<option value="Seminar-Partner">Seminar-Partner</option>
				<option value="Trade Show">Trade Show</option>
				<option value="Web">Web</option>
				<option value="Word of mouth">Word of mouth</option>
				<option value="Others">Others</option>
			</SELECT></td>

		</tr>
	</tbody>
</table>
<br>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF" >
			<td><strong>Descriptive Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Description</strong></td>
			<td><textarea name="description" wrap="physical" cols="75"
				rows="2"></textarea></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<TD>&nbsp;</TD>
			<TD align=right><INPUT type="submit" value="Submit" name="submit" id="submit"></TD>
			<TD><INPUT type="reset" name="reset" id="reset" value=" Reset "></TD>
		</TR>
	</TBODY>
</TABLE>
</form>
</body>
</html>