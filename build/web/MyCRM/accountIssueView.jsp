<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.eminent.util.*,org.apache.log4j.*,java.text.*" %>
<%


Logger logger = Logger.getLogger("Add New Contact");


	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-
//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<script language=javascript src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script language=javascript src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</title>
</head>
<SCRIPT language=JAVASCRIPT type="text/javascript">
function trim(str)  
{
    while (str.charAt(str.length - 1)==" ") 
	   	str = str.substring(0, str.length - 1); 
  	while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  	return str; 
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
   		alert('Please enter the AlphaNumerical only in the billingstreet '); 
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
        if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            alert ("Please Enter the Comments");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length>4000)
        {
            alert (" Comments exceeds 4000 character");
            CKEDITOR.instances.comments.focus();
    //        document.theForm.description.value == "";
            return false;
        }
//	if(theForm.comments.value.length<=0) 
//		{
//   		alert('Enter your comments'); 
//	    theForm.comments.focus(); 
//	    return false;
//	}
//
//	if(theForm.comments.value.length>4000) 
//		{
//    	alert('Comments Should not exceed 4000 Characters'); 
//	    theForm.comments.focus(); 
//	    return false;
//    }
  	
  monitorSubmit();
	}
	
	/** Function To Set Focus On The Project Name Field In The Form */
	
	function setFocus()  {
		document.theForm.accountname.focus();
	}
	window.onload = setFocus;
//-->
function editorTextCounter(field,cntfield,maxlimit)
    {
	if (field > maxlimit)
	{

                if (maxlimit==4000)
                    alert('Comments size is exceeding 4000 characters');
                else
                    alert('Comments size is exceeding 4000 characters');
	}
	else
		cntfield.value = maxlimit - field;
    }

function textCounter(field,cntfield,maxlimit) 
    {
		if (field.value.length > maxlimit) 
		{
			field.value = field.value.substring(0, maxlimit);
                    alert('Comments size is exceeding 4000 characters');
		}
		else
			cntfield.value = maxlimit - field.value.length;
	}
	
	
	
		
	    
  	
</SCRIPT>
<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#c3d9ff">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b> Edit Account</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<BR>
<FORM name="theForm" onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/MyCRM/crmAccountUpdate.jsp"
	method="post" onReset="return setFocus()"><%@ page
	import="java.sql.*,pack.eminent.encryption.*"%> <% 
int accountid=Integer.parseInt(request.getParameter("accountid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
try  {
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		rs = st.executeQuery("SELECT ACCOUNT_OWNER,ACCOUNTNAME,PARENTACCOUNT,PHONE,FAX,WEBSITE,TYPE,INDUSTRY,EMPLOYEES,ANNUALREVENUE,DESCRIPTION,BILLINGSTREET,BILLINGCITY,BILLINGSTATE,BILLINGZIP,BILLINGCOUNTRY,SHIPPINGSTREET,SHIPPINGCITY,SHIPPINGSTATE,SHIPPINGZIP,SHIPPINGCOUNTRY,ASSIGNEDTO,duedate,account_amount from account where accountid="+accountid);
		if(rs!=null)
		{
			while(rs.next())
			{
				String owner=rs.getString("ACCOUNT_OWNER");
				String accountname=rs.getString("ACCOUNTNAME");
				String parentaccount=rs.getString("PARENTACCOUNT");
				String phone=rs.getString("PHONE");
				String fax=rs.getString("FAX");
				String website=rs.getString("WEBSITE");
				String type=rs.getString("type");
				String industry=rs.getString("INDUSTRY");
               	String employees=rs.getString("EMPLOYEES");
				String annualrevenue=rs.getString("ANNUALREVENUE");
				String description=rs.getString("DESCRIPTION");
                String billingstreet=rs.getString("BILLINGSTREET");
                String billingcity=rs.getString("BILLINGCITY");
				String billingstate=rs.getString("BILLINGSTATE");
                String billingzip=rs.getString("BILLINGZIP");
                String billingcountry=rs.getString("BILLINGCOUNTRY");

                String shippingstreet=rs.getString("SHIPPINGSTREET");
                String shippingcity=rs.getString("SHIPPINGCITY");
				String shippingstate=rs.getString("SHIPPINGSTATE");
                String shippingzip=rs.getString("SHIPPINGZIP");
                String shippingcountry=rs.getString("SHIPPINGCOUNTRY");
                int assi=rs.getInt("assignedto");
                
                java.util.Date due=rs.getDate("duedate");
				
				SimpleDateFormat dfm =  new SimpleDateFormat("d-M-yyyy");
				String dueDate = "NA";
                if(due != null){
                    dueDate = dfm.format(due);
                }
                                
                int account_amount=rs.getInt("account_amount");
                
                if (accountname==null) accountname="";
				if (parentaccount==null) parentaccount="";
				if (phone==null) phone="";
				if (fax==null) fax="";
				if (website==null) website="";
				if (type==null) type="";
				if (industry==null)	industry="";
				if (employees==null)employees="";
				if (annualrevenue==null) annualrevenue="";
				if (description==null) description="";
				if (billingstreet==null) billingstreet="";
				if (billingcity==null) billingcity="";
				if (billingstate==null)	billingstate="";
				if (billingzip==null) billingzip="";
				if (billingcountry==null) billingcountry="";
				if (shippingstreet==null) shippingstreet="";
				if (shippingcity==null) shippingcity="";
				if (shippingstate==null)	shippingstate="";
				if (shippingzip==null) shippingzip="";
				if (shippingcountry==null) shippingcountry="";
                
                                

		%>

<table width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		
		<tr>
			<td width="15%"><strong>Account Name</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="accountname" maxlength="30" size=25 value="<%=accountname%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Parent Account </strong></td>
			<td width="25%"><input type="text" name="parentaccount" maxlength="30" size=25 value="<%=parentaccount%>"><strong class="style20"></strong></td>

			
		</tr>
		<tr>
			
			<td width="15%"><strong>Phone</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="phone" maxlength="30" size=25	value="<%=phone%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Fax</strong></td>
			<td width="25%"><input type="text" name="fax" maxlength="30" size=25 value="<%=fax%>"><strong class="style20"></strong></td>
		</tr>
		<tr>
			
			<td width="15%"><strong>website</strong><font size="10"	COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="website" maxlength="30" size=25 value="<%=website%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
				<td width="25%"><select name="assignedto" id="assignedto" size="1">
					<option value="--Select One--" selected>--Select One--</option>
			<% 

			
			HashMap al;
			
			String pro="CRM";
			String fix="1.0";
			al=GetProjectMembers.getBDMembers(pro,fix);
            if(al!=null){
			Collection set=al.keySet();
			Iterator iter = set.iterator();
			int assigned=0;
            int useridassi=0;

		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String nameofuser=(String)al.get(key);
		      logger.info("Userid"+key);
		      logger.info("Name"+nameofuser);
		      
		      
		     // String commentedby=GetProjectMembers.getUserName(rs.getString("commentedby"));
				nameofuser=nameofuser.substring(0,nameofuser.indexOf(" ")+2);
				
		      useridassi=Integer.parseInt(key);
		      if (useridassi==assi)
 				{
					assigned=useridassi;
%>
			<option value="<%=assigned%>" selected><%=nameofuser%></option>
			<%
			}
			else
			{
					assigned=useridassi;
%>
			<option value="<%=assigned%>"><%=nameofuser%></option>
<%
			}
		    }
            }
%>
		</select>
		</td>

		</tr>
		<tr>
			<td width="15%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="duedate" id="duedate" value="<%=dueDate%>" maxlength="10" size="12" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>
			<td width="15%"><strong>Account Owner</strong></td>
			<td width="25%"><input type="text" name="accountowner" maxlength="30" size=25 value="<%=GetProjectManager.getUserName(Integer.parseInt(owner))%>"	readonly="readonly"><strong class="style20"></strong></td>
		</tr>
<tr>
		
		<td width="10%"><strong>Account Amount</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td width="25%"><input type="text" name="accountamount" maxlength="30" value="<%=account_amount%>" size=25><strong class="style20"></strong></td>
		</tr>

		<tr bgcolor="C3D9FF">
			<td colspan=3><strong>Additional Information</strong></td>
			<td><input type="hidden" name="accountid" value="<%=accountid %>"></td>
		</tr>

		<tr>
			<td width="15%"><strong>Billing Street</strong></td>
			<td width="25%"><textarea name="billingstreet" wrap="physical" cols="20" rows="2"><%=billingstreet%></textarea></td>
			<td width="15%"><strong>Shipping Street</strong></td>
			<td width="25%"><textarea name="shippingstreet" wrap="physical" cols="20" rows="2"> <%=shippingstreet%></textarea></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing City</strong></td>
			<td width="25%"><input type="text" name="billingcity" maxlength="30" size=25 value="<%=billingcity%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping City</strong></td>
			<td width="25%"><input type="text" name="shippingcity" maxlength="30" size=25 value="<%=shippingcity%>"><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing State</strong></td>
			<td width="25%"><input type="text" name="billingstate" maxlength="30" size=25 value="<%=billingstate%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping State</strong></td>
			<td width="25%"><input type="text" name="shippingstate" maxlength="30" size=25 value="<%=shippingstate%>"><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing Zip</strong></td>
			<td width="25%"><input type="text" name="billingzip" maxlength="30" size=25 value="<%=billingzip%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping Zip</strong></td>
			<td width="25%"><input type="text" name="shippingzip" maxlength="30" size=25 value="<%=shippingzip%>"><strong class="style20"></strong></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing Country</strong></td>
			<td width="25%"><input type="text" name="billingcountry" maxlength="30" size=25 value="<%=billingcountry%>"><strong class="style20"></strong></td>
			<td width="15%"><strong>Shipping Country</strong></td>
			<td width="25%"><input type="text" name="shippingcountry" maxlength="30" size=25 value="<%=shippingcountry%>"><strong class="style20"></strong></td>
		</tr>

		<tr>
			<td width="15%"><strong>Type</strong></td>
			<%
		    String[] typeExist = { "--Select One--" , "SAP customer" , "SAP Partner"};
%>
			<td width="25%"><SELECT NAME="type" size="1">
				<%   
			for (int i = 0;i < typeExist.length ;i++ ){
				if (type.equals(typeExist[i]))
				{
%>
				<option value="<%= type %>" selected><%= type %></option>
				<%
				}
				else
				{
%>
				<option value="<%= typeExist[i] %>"><%= typeExist[i] %></option>
				<%
				}
          }
%>
			</SELECT><strong class="style20"></strong></td>
			<td width="15%"><strong>Industry</strong></td>
			<%
		    String[] industryExist = { "--None--" , "Agriculture" , "Apparel" , "Banking","BioTechnology","chemicals","communication","construction","consulting","Education","Electronics","Energy","Engineering","Entertainment","Entertainment","finance","food and beverage","government","healthcare","hospitality","Insurance","Machinery","Manufacturing","Media","Not for profit","other","Recreation","Retail","Shipping","Technology","Telecommunication","Transportation","Utilities"};
%>
			<td width="25%"><SELECT NAME="industry" size="1">
				<%
				for (int i = 0;i < industryExist.length ;i++ ){
				if (industry.equals(industryExist[i]))
				{
%>
				<option value="<%= industry %>" selected><%= industry %></option>
				<%
				}
				else
				{
%>
				<option value="<%=industryExist[i] %>"><%= industryExist[i] %></option>
				<%
				}
          	}
%>
			</SELECT></td>
			
		</tr>
		<tr>
			
			<td width="15%"><strong>Annual Revenue</strong></td>
			<%

		    String[] annualrevenueExist = { "--Select One--" , "$200K - $1 Million" , "$1 million - $10 million","$10 million - $100 million" , "$100 million - $1 billion","Above $1 billion"};
%>
			<td width="25%"><SELECT NAME="annualrevenue" size="1">
				<%   
			for (int i = 0;i < annualrevenueExist.length ;i++ ){
				if (annualrevenue.equals(annualrevenueExist[i]))
				{
%>
				<option value="<%= annualrevenue %>" selected><%= annualrevenue %></option>
				<%
				}
				else
				{
%>
				<option value="<%= annualrevenueExist[i] %>"><%= annualrevenueExist[i] %></option>
				<%
				}
          }
%>
			</SELECT></td>
			<td width="15%"><strong>Employees</strong></td>
			<%
		    String[] employeesExist = { "--Select One--" , "0 - 50 employees" , "51 - 200 employees","200 - 500 employees" , "500 - 2000 employees","2000+ employees"};
%>
			<td width="25%">
				<SELECT NAME="employees" size="1">
					<%   
				for (int i = 0;i < employeesExist.length ;i++ ){
					if (employees.equals(employeesExist[i]))
					{
	%>
					<option value="<%= employees %>" selected><%= employees %></option>
					<%
					}
					else
					{
	%>
					<option value="<%= employeesExist[i] %>"><%= employeesExist[i] %></option>
					<%
					}
	          }
	%>
				</SELECT>
		</td>
		</tr>
		
	
		<tr>
			<td width="100%" colspan=4><strong>Description</strong></td>
		</tr>
		<tr>
			<td width="100%" colspan=4> <%=description%></td>
		</tr>

	<tr height="21">
		<td width="100%" class="textdisplay" align="left" colspan=4>
		<p class="textdisplay"><b>Comments</b></p>
		</td>
	</tr>
	<tr height="21">
		<td width="15%"></td>
		<td width="70%" align="left" colspan=3><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <textarea
			rows="3" cols="58" name="comments" id="comments" maxlength="4000"
			onKeyDown="textCounter(document.theForm.comments,document.theForm.remLen1,4000)"
			onKeyUp="textCounter(document.theForm.comments,document.theForm.remLen1,4000)"></textarea></font>
			<input readonly type="text" name="remLen1" id="remLen1" size="3"
			maxlength="3" value="4000">characters left</td>
                                 <script type="text/javascript">
                                CKEDITOR.replace( 'comments',{toolbar:'Basic',height:100} );
                                var editor_data = CKEDITOR.instances.comments.getData();
                                CKEDITOR.instances["comments"].on("instanceReady", function()
                                {

                                                //set keyup event
                                                this.document.on("keyup", updateExpectedResult);
                                                 //and paste event
                                                this.document.on("paste", updateExpectedResult);

                                });
                                function updateExpectedResult()
                                {
                                        CKEDITOR.tools.setTimeout( function()
                                                    {
                                                        var desc    =   CKEDITOR.instances.comments.getData();
                                                         var leng    =   desc.length;
                                                       editorTextCounter(leng,document.getElementById('remLen1'),2000);

                                                    }, 0);
                                }
                        </script>
	</tr>
</table>
<table width="100%" border="0" bgcolor="#e8eef7" cellpadding="2"
	align="center">
	<tr align="center">
		<td></td>
		<td colspan="4" align="center">
			<INPUT type=submit id=submit value=Update 	name=submit>
			<INPUT type=reset id=reset value=Reset	name=reset>
		</td>
	</tr>
</table>
<%
                   session.setAttribute("name",accountname);
                   session.setAttribute("category","account");
                
                %> <iframe
	src="./commentHistory.jsp?accountId=<%= accountid %>" scrolling="auto"
	frameborder="2" height="45%" width="100%"></iframe> <br>
<br>
<br>


</FORM>

<%
			}
		}
	}
}catch(Exception ex)
		{
			logger.error(ex.getMessage());
		}finally
				{
                    if(rs!=null){
                        rs.close();
                    }
                    if(st!=null){
                        st.close();
                    }
					if (connection!=null)
					{
						connection.close();
					}
					if(connection.isClosed()){
		 				logger.info("Connection is Closed");
		 			}
		 			else{
		 				logger.info("Connection not Closed");	
		 			}
				} 
%>
<BR>
</body>
</html>