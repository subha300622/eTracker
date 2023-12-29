<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%

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
<LINK title="STYLE" href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type = "text/css" rel = "STYLESHEET">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>

<!-- Start Of Java Script For Front End Validation -->

<SCRIPT language=JAVASCRIPT type="text/javascript">

	/* Java Script Function For Trimming A String To Get Only The Required String Input */
	
	function trim(str)  {
  		while (str.charAt(str.length - 1)==" ") 
   		str = str.substring(0, str.length - 1); 
  		while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  		return str; 
	} 
	
 	
 /* Function To Set Focus On The Project Name Field In The Form */
 function check(theForm)
 {
  var x=document.theForm.teamname.value;
 
  if (x=='')
  {
        alert('Please enter the Team name '); 
   	document.theForm.teamname.value="";
   	theForm.teamname.focus();
  }
  
  else if (document.theForm.teamname.value.length > 20) 
  {
    alert('Size of the Team name should be less than 20 characters');
    document.theForm.teamname.value="";
    theForm.teamname.focus();      	
  }
  
  else if (x!='')
  {
   if (confirm("Do you want to Add One more Team?.."))
   {
     location = 'newTeam.jsp?teamname='+x
   } 
   else
   {
    location='viewproject.jsp'
   }
  }
  

 }
	
        
 function noenter() {
        if ((window.event && window.event.keyCode == 13) && (document.theForm.teamname.value)=='')  {
   			alert('Please enter the Team name '); 
   			document.theForm.teamname.value="";
   			theForm.teamname.focus(); 
                        }
	  return !(window.event && window.event.keyCode == 13); 
	  }
	function setFocus()  {
		document.theForm.teamname.focus();
	}
	window.onload = setFocus;


</SCRIPT>

<!-- End Of Java Script Code -->

<body>

<!-- Declaring The Form And Its Attributes -->

<FORM name=theForm onsubmit="return fun(this)" method=post
	onReset="return setFocus()"><!-- Table To Display Current User And The Links For User Profile, Mails, And Logout -->

<jsp:include page="/header.jsp" /> <br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<!-- Table To Display The Form Input Elements Project Name, Version, Project Manager, Customer  And The Submit, Reset Buttons-->
<table width="35%" bgColor=#eeeeee border="0" align="center">

	<tr border="2" bgcolor="#E8EEF7">

		<td border="1" align="center" width="100%"><font size="4"
			COLOR="#0000FF"><b> Add New Team</b> </font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>

	</tr>

</table>


<TABLE width="35%" bgcolor="#E8EEF7" border="0" align="center">
	
	<TBODY>

		<tr>

			<td width="35%"><strong>Team Name </strong></td>

			<td><input type="text" name="teamname" maxlength="20" size="20"
				onkeypress="return noenter()"> <strong class="style20"></strong>
			</td>
			
		</tr>


		<TR cols=2>
			<td align="right"><INPUT type=button value="Submit"
				name="submit" onClick='check(this.form)'></td>
			<td align="left"><INPUT type=reset value="Reset" name="reset"></td>
		</TR>


	</TBODY>

</TABLE>





</FORM>


</body>

</html>