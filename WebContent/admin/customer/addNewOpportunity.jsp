<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="com.eminent.util.*,org.apache.log4j.*,java.util.*"%>
<%
	


	Logger logger = Logger.getLogger("Add New Opportunity");
	
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
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</title>
</head>
<script language=javascript
	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<SCRIPT language=JAVASCRIPT type="text/javascript">
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
 	}
 	while (pos==1 && i<str.length) 
 	if (pos==0) 
    		return false; 
 	return true; 
} 
 
	
function isPositiveInteger(str)  
{
	var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+\ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890/" 
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
	
        if ((theForm.opportunityname.value)=='')  
	{
		alert('Please enter the Opportunity Name '); 
		document.theForm.opportunityname.value="";
		theForm.opportunityname.focus();  
    		return false; 
	}
	if (!isPositiveInteger(trim(theForm.opportunityname.value)))  
	{
		alert('Please enter the valid Opportunity Name '); 
		document.theForm.opportunityname.value="";
		theForm.opportunityname.focus();  
    		return false; 
	}
  	if ( document.getElementById('stage').value == '--None--' )
        {
                	alert ( "Please select Stage." );
                        document.getElementById('stage').focus();
			return false;
        }

        if ((theForm.probability.value)=='')  
	{
		alert('Please enter the Probability '); 
		document.theForm.probability.value="";
   		theForm.probability.focus(); 
                return false; 
	}
	if (!isNumber(trim(theForm.probability.value)))  
	{
		alert('Please enter the Numerical only in the Probability '); 
		document.theForm.probability.value="";
   		theForm.probability.focus(); 
                return false; 
	}
	if (!isNumber(trim(theForm.amount.value))&& (theForm.amount.value)!='')  
	{
		alert('Please enter the Numerical only in the amount '); 
		document.theForm.amount.value="";
   		theForm.amount.focus(); 
   		return false; 
	}
	 if (document.getElementById('assignedto').value == '--Select One--') 
        {
	        alert("Please choose a Assigned to Name");
	        document.getElementById('assignedto').focus();
	        return false;
        }
	if ((theForm.closedate.value)=='')  
	{
		alert('Please enter the Closing Date '); 
		document.theForm.closedate.value="";
		theForm.closedate.focus();  
    		return false; 
	}
        if (!isPositiveInteger(trim(theForm.closedate.value)))  
	{
		alert('Please enter the Closing Date '); 
		document.theForm.closedate.value="";
		theForm.closedate.focus();  
    		return false; 
	}
	if (!isPositiveInteger(trim(theForm.nextstep.value)) && (theForm.nextstep.value)!='')  
	{
		alert('Please enter the nextstep '); 
		document.theForm.nextstep.value="";
		theForm.nextstep.focus();  
   		return false; 
	}
        return true;
}
function setFocus()  {
		document.theForm.closedate.focus();
}
window.onload = setFocus;
//-->

</SCRIPT>
<body>
<FORM name=theForm onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/admin/customer/newOpportunity.jsp"
	method=post onReset="return setFocus()"><%@ include
	file="/header.jsp"%>
<div align="center">
<center>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>
		Add New Opportunity</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<br>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr bgcolor="C3D9FF">
			<td><strong>Opportunity Information</strong></td>
			<td align="right"><strong><font size="10"
				COLOR="#FF0000">*</font> = Required Information</strong></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="20%"><b>Opportunity Name</b><font size="10"	COLOR="#FF0000">*</font></td>
			<td><input type="text" name="opportunityname" maxlength="30" size=25><strong class="style20"></strong></td>
			<td width="20%"><b>Stage</b><font size="10" COLOR="#FF0000">*</font></td>
			<td align="left" width="35%"><SELECT NAME="stage" size="1">
				<option value="Prospecting">Prospecting</option>
				<option value="Qualification">Qualification</option>
				<option value="Needs Analysis">Needs Analysis</option>
				<option value="Value Proposition">Value Proposition</option>
				<option value="Id. Decision makers">Id. Decision makers</option>
				<option value="Perception Analysis">Perception Analysis</option>
				<option value="Proposal/Price Quote">Proposal/Price Quote</option>
				<option value="Negotiation/Review">Negotiation/Review</option>
				<option value="Closed Won">Closed Won</option>
				<option value="Closed Lost">Closed Lost</option>
			</SELECT></td>
			

		</tr>
		<tr>
			
			
		</tr>
		<tr>
			
			<td width="20%"><strong>Probability(%)</strong></td>
			<td><input type="text" name="probability" maxlength="30" size=25	value="10"></td>
			<td width="20%"><strong>Amount</strong></td>
			<td><input type="text" name="amount" maxlength="30" size=25><strong
				class="style20"></strong></td>
		</tr>
		<tr>
			<td width="20%"><strong>Type </strong></td>
			<td align="left" width="35%"><SELECT NAME="type" size="1">
				<OPTION value="--None--" selected>--None--</option>
				<option value="Existing Business">Existing Business</option>
				<option value="New Business">New Business</option>
			</SELECT></td>
			<td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%">
					<select name="assignedto" size="1">
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
		<td width="20%"><strong>Closing Date</strong><font size="10"
				COLOR="#FF0000">**</font></td>
			<td><input type="text" name="closedate" id="closedate"
				readonly="true" maxlength="30" size=15><a
				href="javascript:NewCal('closedate','ddmmyyyy')"> <img
				src="images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a></td>
		</tr>

		<tr bgcolor="C3D9FF">
			<td colspan="4"><strong>Additional Information</strong></td>
		</tr>

		<tr>
			<td width="20%"><strong>Lead Source</strong></td>
			<td align="left" width="35%" colspan=3><SELECT NAME="leadsource" size="1">
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
		<tr>
			<td width="20%"><strong>Next Step</strong></td>
			<td colspan="3"><input type="text" name="nextstep" maxlength="30" size=25><strong
				class="style20"></strong></td>
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
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="20%"><strong>Description</strong></td>
			<td><textarea name="description" wrap="physical" cols="69"
				rows="3"></textarea></td>
		</tr>
	</tbody>
</table>
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
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
<BR>
</body>
</html>