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
 function cancelUpdate(){
            location='profile.jsp';
        }
  function setFocus() {	document.theForm.password.focus(); }
window.onload = setFocus; 

function fun(theForm) {
 if ((theForm.password.value)=='') {
   alert('Please enter the password ');
  //win2=window.open("firstname.html","NewWindow","toolbar=no,directories=no,menubar=no,scrollbars=no,width=250,height=100, position=centre");
	document.theForm.password.value="";
    theForm.password.focus(); 
    return false; 
  } 
  return true;
  }


</SCRIPT>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">
<%@ page language="java"%>
<!--<table width="100%" valign="right" height="5%" border="0">

	<tr>
		<td border="0" align="left" width="800"><b>
			<font size="3" COLOR="#0000FF"> Welcome</font></b>
			<b><FONT SIZE="3" COLOR="#0000FF"><b>&nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%>
		</b></FONT></b>
			
		</td>

				
		
		<td width="6%" align="center" border="1">
			<font size="2" face="Verdana, Arial, Helvetica, sans-serif">
			<A HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A>
			</font>
		</td>
		
	</tr>
	
</table>-->
<%@ include file="../header.jsp"%>
<TABLE width="100%">

		<TR >
			<TD align="left"  bgcolor="#E8EEF7">
			<B>Your Profile:</B>
			</TD>
		</TR>

</TABLE>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<form action="<%=request.getContextPath() %>/UserProfile/userupdate.jsp"
	method="post" name="theForm" onSubmit='return fun(this)'>





<table width="50%" border="0" bgcolor="E8EEF7" cellpadding="2"
	align="center">

	<%
					if(request.getParameter("getpwd")!=null && request.getParameter("getpwd").equals("false"))
					{
						%>
	<tr align="center">
		<td colspan="2">
		<p class="textdisplay"><%= "Invalid password" %>
		</td>
	</tr>
	<%
					}
				%>
	<tr>
		<td><strong>Enter Your Password: </strong></td>
		<td><input type="password" name="password" maxlength="16" size=25>
		</td>
	</tr>
	
	<TR>
            <TD align="right"><INPUT type=submit value=Submit name=submit></TD>
                <TD><input type=button value=" Cancel " onclick="javascript:cancelUpdate();"></TD>
	</TR>
</table>

</form>
</BODY>
</HTML>
