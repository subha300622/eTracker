<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type"
	content="multipart/form-data;>
<LINK title=STYLE	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
<script language=javascript
        src="<%= request.getContextPath() %>/javaScript/checkSubmit.js">
</script>
<script>
    function validateUpload() {
        if(document.getElementById("file1").value == '') {
            alert('Please select the file');
            filesForm.file1.focus();
            return false;
        }
        disableSubmit();
    }
</script>
</head>
<body bgcolor="#E8EEF7">

<br>
<%
String actionURL="upload.jsp?no1="+request.getParameter("no1");
String attach=request.getParameter("attach");
if (attach.equals("yes"))
{
%>
<FORM name="filesForm" action=<%=actionURL%> method="post" onSubmit='return validateUpload()'
	enctype="multipart/form-data">
<table>
	<table width="100%" align=center border="0" bgcolor="#E8EEF7">
		<tr align="center">
			<td><BR>
			<FONT SIZE="4" COLOR="#33CC33"><b> Enter the Filename to
			upload</b></FONT><BR>
			</td>
		</tr>
		<tr>
			<td align="center"><input type="hidden" name="no1"
				value="<%=session.getAttribute("issueid")%>"> <b>Attach:</b><input
				type="file" id="file1" name="file1" onkeypress="this.blur();" onPaste="return false"/></td>
		</tr>
		<tr>
			<td align=center><FONT SIZE="4" COLOR="#330000"><b>File
			type should be .txt, .doc, .gif, image files( .jpg, .bmp,...).It's
			size should be less than 12MB(aprox.)</b></FONT></td>
		</tr>
		<tr>
			<td align="center"><input type="submit" id="submit" name="Submit"
				value="Upload File" /></td>
		</tr>
	</table>
</table>
</FORM>
<%
}
else
{
	
	if(session.getAttribute("bug") != null){
            
            session.removeAttribute("bug");
            
%>
<jsp:forward page="closeWindow.jsp">
	<jsp:param name="flag" value="true" />
</jsp:forward>

<%
            
            
        }
		
%>


<%
	
}
%>
</body>
</html>
