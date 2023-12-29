<%-- 
    Document   : uploadTscExcel
    Created on : Apr 10, 2014, 11:56:55 AM
    Author     : E0288
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<%@ page import="org.apache.log4j.*"%>
      <%
	//Configuring log4j properties
	Logger logger = Logger.getLogger("uploadTscExcel");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}
        
        
        
      String tsid   =   request.getParameter("tsId");
      if(tsid!=null){
       session.setAttribute("uploadtsid",tsid);
      }

%>
<SCRIPT LANGUAGE="JavaScript">

<!--
function validate()
{
var extensions = new Array("xls","xlsx");

/*
// Alternative way to create the array

var extensions = new Array();

extensions[1] = "jpg";
extensions[0] = "jpeg";
extensions[2] = "gif";
extensions[3] = "png";
extensions[4] = "bmp";
*/

var image_file = document.form.image_file.value;

var image_length = document.form.image_file.value.length;

var pos = image_file.lastIndexOf('.') + 1;

var ext = image_file.substring(pos, image_length);

var final_ext = ext.toLowerCase();

for (i = 0; i < extensions.length; i++)
{
    if(extensions[i] == final_ext)
    {
        document.getElementById('submit').value = 'Processing';
        document.getElementById('submit').disabled = true;
        document.getElementById('progressbar').style.visibility = 'visible';
        return true;
    }
}

alert("You must upload a file with one of the following extensions: "+ extensions.join(', ') +".");
return false;
}
 //-->

 </SCRIPT>

 </HEAD>

<BODY>
      <%@ include file="header.jsp"%>
      <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgColor="#C3D9FF">
		<td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
			size="4" COLOR="#0000FF"><b>Upload BPM Excel </b></font></td>
	</tr>
    </table>
<center>

<form name="form" action="uploadTscDetails.jsp" enctype="multipart/form-data" method="post" onSubmit="return validate();">

<!--<h2>Validate image on upload</h2>

<br/>

	Upload an image: <INPUT type="file" name="image_file"> <input type="submit" name="submit" value="Submit">-->
<br/>
<br/>
<table>
	<table width="100%" align=center border="0" bgcolor="#E8EFF7">
		<tr align="center">
			<td><BR>
			<FONT SIZE="4" COLOR="#33CC33"><b> Enter the Filename to upload</b></FONT><BR>
			</td>
		</tr>
		<tr>
			<td align="center"> <b>Attach:</b>
                            <input type="file" id="image_file" name="image_file" /></td>
		</tr>
		<tr>
			<td align=center><FONT SIZE="4" COLOR="#330000"><b>File type should be *.xls/*xlsx and It's size should be less than 12MB(aprox.)</b></FONT></td>
		</tr>
		<tr>
			<td align="center"><input type="submit" id="submit" name="Submit" value="Upload File" /></td>
		</tr>
                <tr>
			<td align="center"><img id="progressbar" style='visibility: hidden;' src='/eTracker/images/file-progress.gif'/></td>
		</tr>
	</table>
</table>
</form>

</center>

</BODY>

</HTML>
