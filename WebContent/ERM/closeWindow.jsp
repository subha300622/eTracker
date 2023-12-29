<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache");
%>
<html>
<head>
<title>eOutsource &trade;- Eminent Product Development Life Cycle Management</title>
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
</head>
<%@ include file="../noScript.jsp" %>
<body bgcolor="#FFFFFF" >
<FORM name="theForm"  METHOD=POST>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<table width="80%" align=center border="0">
<%
    String bug = "yes";
    session.setAttribute("bug",bug);
    String flag = request.getParameter("flag");
    if(flag != null && flag.equalsIgnoreCase("true"))
    {
%>
        <tr>
        <td align="center"><center><FONT SIZE="9" COLOR="#000000">Thank You. Your information has been saved successfully.
		<br>
		Your application Id is <%= (String)session.getAttribute("apid") %></center>
		
		<br>
		Feel free to send your suggestion and feedbacks to E-mail: <a href="mailto:hr@eminentlabs.net"><font color="#006699">hr@eminentlabs.net</center></td></tr>
          <tr>  <td colspan="2" align="center"> <input type="button" name="Close" value="Close" onclick="window.close()"></td>
        </tr>
<%
}
%> 
	</table>
	<br>
</FORM>		
</body>
</html>