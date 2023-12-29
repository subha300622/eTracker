<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.eminent.util.*" %>
<%
	
	
	Logger logger = Logger.getLogger("Add CRM New Contact");
	

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
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS
Solution</title>
</head>
<script language=javascript	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
<SCRIPT  type="text/javascript">
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
function isAccount(str)  
{
	var pattern = "1234567890" 
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
	var pattern = "+- 0123456789." 
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
 	}while (pos==1 && i<str.length) 
 	if (pos==0) 
    	return false; 
 	return true; 
} 
 
/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */
	
function isPositiveInteger(str)  
{
	var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}/!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890" 
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
	if ((theForm.accountname.value)=='')  
	{
		alert('Please enter the Account name '); 
		document.theForm.accountname.value="";
		theForm.accountname.focus();  
   		return false; 
	}
        if (!isPositiveInteger(trim(theForm.accountname.value)))  
	{
		alert('Please enter the Valid Account name '); 
		document.theForm.accountname.value="";
		theForm.accountname.focus();  
   		return false; 
	}
        if (!isPositiveInteger(trim(theForm.parentaccount.value)) && trim(theForm.parentaccount.value)!='')  
        {
       		alert('Please enter the AlphaNumerical only in the parentaccount '); 
    		document.theForm.parentaccount.value="";
            theForm.parentaccount.focus(); 
            return false; 
      	} 
	if (trim(theForm.phone.value)=='' )  
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
	if (!isNumber(trim(theForm.fax.value)) && trim(theForm.fax.value)!='')  
	{
		alert('Please enter the Numerical Characters only in the Fax '); 
		document.theForm.fax.value="";
   		theForm.fax.focus(); 
   		return false; 
	}
	
        if (trim(theForm.website.value)=='')  
    {
   		alert('Please enter the website '); 
		document.theForm.website.value="";
        theForm.website.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.website.value)))  
        {
   		alert('Please enter the AlphaNumerical only in the website '); 
		document.theForm.website.value="";
                theForm.website.focus(); 
                return false; 
  	}
	if (document.getElementById('assignedto').value == '--Select One--') 
    {
        alert("Please choose a Assigned to Name");
        document.getElementById('assignedto').focus();
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
	if (!isPositiveInteger(trim(theForm.type.value)) && trim(theForm.type.value)!='')  
        {
   		alert('Please enter the AlphaNumerical only in the type '); 
		document.theForm.type.value="";
                theForm.type.focus(); 
                return false; 
  	}
	if (!isPositiveInteger(trim(theForm.employees.value)) && trim(theForm.employees.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the employees '); 
		document.theForm.employees.value="";
        theForm.employees.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.industry.value)) && trim(theForm.industry.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the industry '); 
		document.theForm.industry.value="";
        theForm.industry.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.annualrevenue.value)) && trim(theForm.annualrevenue.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the annualrevenue '); 
		document.theForm.annualrevenue.value="";
        theForm.annualrevenue.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.billingstreet.value)) && trim(theForm.shippingstreet.value)!='')  
    {
   		alert('Please enter valid data in the street '); 
		document.theForm.billingstreet.value="";
        theForm.billingstreet.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.shippingstreet.value)) && trim(theForm.shippingstreet.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the shippingstreet '); 
		document.theForm.shippingstreet.value="";
        theForm.shippingstreet.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.billingcity.value)) && trim(theForm.billingcity.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the billingcity '); 
		document.theForm.billingcity.value="";
        theForm.billingcity.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.shippingcity.value)) && trim(theForm.shippingcity.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the shippingcity '); 
		document.theForm.shippingcity.value="";
        theForm.shippingcity.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.billingstate.value)) && trim(theForm.billingstate.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the billingstate '); 
		document.theForm.billingstate.value="";
        theForm.billingstate.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.shippingstate.value)) && trim(theForm.shippingstate.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the shippingstate '); 
		document.theForm.shippingstate.value="";
        theForm.shippingstate.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.billingzip.value)) && trim(theForm.billingzip.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the billingzip '); 
		document.theForm.billingzip.value="";
        theForm.billingzip.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.shippingzip.value)) && trim(theForm.shippingzip.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the shippingzip '); 
		document.theForm.shippingzip.value="";
        theForm.shippingzip.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.billingcountry.value)) && trim(theForm.billingcountry.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the billingcountry '); 
		document.theForm.billingcountry.value="";
        theForm.billingcountry.focus(); 
        return false; 
  	}
	if (!isPositiveInteger(trim(theForm.shippingcountry.value)) && trim(theForm.shippingcountry.value)!='')  
    {
   		alert('Please enter the AlphaNumerical only in the shippingcountry '); 
		document.theForm.shippingcountry.value="";
        theForm.shippingcountry.focus(); 
        return false; 
  	}
	if (trim(document.theForm.accountamount.value)== "")
    {
        alert ("Please Enter the Account Amount ");
        document.theForm.accountamount.focus();
        return false;
    }
    if (!isAccount(trim(theForm.accountamount.value)))  
    {
        alert('Please enter the valid Account Amount'); 
	document.theForm.accountamount.value="";
        theForm.accountamount.focus(); 
        return false; 
    }
  return true;
	}
	
	/** Function To Set Focus On The Project Name Field In The Form */
	
	function setFocus()  {
		document.theForm.accountname.focus();
	}
	window.onload = setFocus;
//-->
</SCRIPT>
<body>
<FORM name=theForm
	action="<%=request.getContextPath() %>/admin/customer/newaccount.jsp"
	method=post onsubmit="return fun(this)" onReset="return setFocus()">
<%@ include file="/header.jsp"%>
<div align="center">
<center>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>
		Add New Account</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<br>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Account Information</strong></td>
			<td><input type="hidden" name="accountowner" value="<%=session.getAttribute("uid")%>"></td>
			<td align="right"><strong><font size="10" COLOR="#FF0000">*</font> = Required Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Account Name</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="accountname" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="10%"><strong>Parent Account </strong></td>
			<td width="25%"><input type="text" name="parentaccount" maxlength="30"	size=25><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Phone</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="phone" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="10%"><strong>Fax</strong></td>
			<td width="25%"><input type="text" name="fax" maxlength="30" size=25><strong class="style20"></strong></td>
		</tr>
		<tr>
			
			<td width="10%"><strong>website</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="website" maxlength="30" size=25><strong class="style20"></strong></td>
		
			<td width="10%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="25%">
                            <select name="assignedto" id="assignedto" size="1">
                        
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
		      logger.info("Userid-->"+key);
		      logger.info("Name-->"+nameofuser);
		      
		      nameofuser=nameofuser.substring(0,nameofuser.indexOf(" ")+2);
		      
		      useridassi=Integer.parseInt(key);
				
					assigned=useridassi;
%>
			
			<option value="<%=assigned%>" ><%=nameofuser%></option>
			<%
			
		    }
%>
		</select></td>
		</tr>
		<tr>
		<td width="10%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
		<td width="25%"><input type="text" name="duedate" id="duedate" maxlength="10" size="14" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>
		<td width="10%"><strong>Account Amount</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="accountamount" maxlength="30" size=25><strong class="style20"></strong></td>
		</tr>

		<tr bgcolor="C3D9FF">
			<td colspan=4><strong>Additional Information</strong></td>
		</tr>

		<tr>
			<td width="15%"><strong>Billing Street</strong></td>
			<td width="25%"><textarea name="billingstreet" wrap="physical" cols="20" rows="2"></textarea></td>
			<td width="15%"><strong>Shipping Street</strong></td>
			<td width="25%"><textarea name="shippingstreet" wrap="physical" cols="20" rows="2"></textarea></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing City</strong></td>
			<td width="25%"><input type="text" name="billingcity" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping City</strong></td>
			<td width="25%"><input type="text" name="shippingcity" maxlength="30" size=25><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing State</strong></td>
			<td width="25%"><input type="text" name="billingstate" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping State</strong></td>
			<td width="25%"><input type="text" name="shippingstate" maxlength="30" size=25><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing Zip</strong></td>
			<td width="25%"><input type="text" name="billingzip" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping Zip</strong></td>
			<td width="25%"><input type="text" name="shippingzip" maxlength="30" size=25><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing Country</strong></td>
			<td width="25%"><input type="text" name="billingcountry" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping Country</strong></td>
			<td width="25%"><input type="text" name="shippingcountry" maxlength="30" size=25><strong class="style20"></strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="15%"><strong>Type</strong></td>
			<td width="25%"><SELECT NAME="type" size="1">
				<OPTION value="--Select One--" selected>--Select One--</option>
				<option value="SAP customer">SAP customer</option>
				<option value="SAP Partner">SAP Partner</option>
			</SELECT></td>
			<td width="15%"><strong>Industry</strong></td>
			<td width="25%"><SELECT NAME="industry" size="1">
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
				<option value="Professional Services">Professional Services</option>
				<option value="Public Sector">Public Sector</option>
				<option value="Retail">Retail</option>
				<option value="Telecommunication">Telecommunication</option>
				<option value="Utilities & Waste">Utilities & Waste</option>
				<option value="Wholesale">Wholesale</option>
			</SELECT></td>
			
		</tr>
		<tr>
			
			<td width="15%"><strong>Annual Revenue</strong></td>
			<td width="25%"><SELECT NAME="annualrevenue" size="1">
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
			<td width="15%"><strong>Employees</strong></td>
			<td width="25%"><SELECT NAME="employees" size="1">
				<OPTION value="--Select One--" selected>--Select One--</option>
				<option value="0 - 50 employees">0 - 50 employees</option>
				<option value="51 - 200 employees">51 - 200 employees</option>
				<option value="200 - 500 employees">200 - 500 employees</option>
				<option value="500 - 2000 employees">500 - 2000 employees</option>
				<option value="2000 + employees">2000 + employees</option>
			</SELECT></td>
		</tr>

		<tr>
			<td width="15%"><strong>Description</strong></td>
			<td colspan=3><textarea name="description" wrap="physical" cols="69"
				rows="2"></textarea></td>
		</tr>
	

<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<TD>&nbsp;</TD>
			<TD align=right><INPUT type=submit value=Submit name=submit></TD>
			<TD><INPUT type="reset" name="reset" id="reset" value=" Reset "></TD>
		</TR>
	</TBODY>
</TABLE>
</center>
</div>
</FORM>
<BR>
</body>
</html>