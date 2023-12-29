<%@ page import="java.sql.*, org.apache.log4j.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="com.pack.PasswordRetrival"%>
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
<META http-equiv=Expires content=-1>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<LINK title=STYLE href="../eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
	marginwidth="0">
<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
	<TBODY height="100%">
		<TR>
			<TD width="39%"><img border="0"
				src="../eminentech support files\Eminentlabs.png"></TD>
			<TD width="100%"><!--Start table for cell 2-->
			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="10%">
				<TBODY>
					<TR>
						<TD align=right>Global Customer Solutions Management</TD>
					</TR>
					<TR>
						<TD>

						<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
							<TBODY>
								<TR>
									<TD bgColor=#000000 height=20 rowSpan=3 width=1><IMG
										alt="" border=0 height=20
										src="eminentech support files/dot_clear.gif" width=1></TD>
									<TD bgColor=#000000 height=1><IMG alt="" border=0 height=1
										src="eminentech support files/dot_clear.gif" width=1></TD>
								<TR>
									<TD align=left bgColor=#C3D9FF height=18 vAlign=center
										width="100%">&nbsp;Welcome Customer</TD>
								</TR>
								<TR>
									<TD bgColor=#000000 height=1 width="100%"><IMG alt=""
										border=0 height=1 src="eminentech support files/dot_clear.gif"
										width=1></TD>
								</TR>
							</TBODY>
						</TABLE>
						<!--End table for customer/buttons--></TD>
					</TR>
				</TBODY>
			</TABLE>
			<!--End table for cell 2--></TD>
		</TR>
	</TBODY>
</TABLE>

<%!
		Connection con;
		Statement ps;
		ResultSet rs;
		ArrayList al;

%>

<% 
	
		//Configuring log4j properties

			

			Logger logger = Logger.getLogger("resetpassword");
			

		try  
		{
			String email = request.getParameter("email").trim();
			
//			String email1 = email+"@"+application.getAttribute("Domain");
			
			PasswordRetrival pr = new PasswordRetrival();
			al = pr.getSecret(email);
			
			//logger.debug("itsmine"+al.get(0));
			if(al.get(0).equals("false"))
			{
				//logger.debug("forwarding back");
				%>

<jsp:forward page="forgotpassword.jsp">
	<jsp:param name="status" value="false" />
	<jsp:param name="mailid" value="<%= email %>" />
</jsp:forward>
<%
			}
			else
			{
				//logger.debug("Forwarding to getSecret");
				session.setAttribute("answer",al.get(1));
				session.setAttribute("forgot_email",request.getParameter("email"));
				%>
<jsp:forward page="getsecrect.jsp">
	<jsp:param name="question" value="<%= al.get(0) %>" />
</jsp:forward>
<%

			}
					
		}
		catch(Exception e)
		{
			logger.error("Exception:"+e);
		}
		finally
		{
			
			if(ps!=null)
				ps.close();
			if(rs!=null)
				rs.close();
			if(con!=null)
				con.close();			
		}
		%>
<br>
<br>

</BODY>

</html>