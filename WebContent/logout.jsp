<%@ page import="org.apache.log4j.*,java.util.Enumeration,com.eminent.util.UserUtils"%>
<%@ page import="java.sql.Connection"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
<%@ include file="noScript.jsp" %>

</HEAD>
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"	marginwidth="0">
<% 	
	//Configuring log4j properties
	Logger logger = Logger.getLogger("Logout");
	//String name = (String)session.getAttribute("theName");
	if(session!=null) 
	{ 
		Enumeration names = session.getAttributeNames();
		int i=0;
		
		Connection connection = (Connection)session.getAttribute("dbconnection");
                String sessionAttribute =   "";
                if((String)session.getAttribute("theName")!=null){
                    int userId  =   (Integer)session.getAttribute("userid_curr");
                    logger.info("Logging out user id"+userId);
                }
		while(names.hasMoreElements())
		{
                        sessionAttribute    =   names.nextElement().toString();
                        logger.info(sessionAttribute+""+session.getAttribute(sessionAttribute));
			session.removeAttribute(sessionAttribute);
			++i;
		}
                
                
               
		session.invalidate();
		logger.info("Removed: "+i+" Session Attributes");
		logger.info("Session has been ended");
		
		if(connection!=null)
		{
			connection.close();
			connection = null;
			logger.info("DBConnection has been closed");
		}else{
                    logger.info("Connection is Null");
                }
	} 
			
		%>
<table border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
	<TBODY height="100%">
		<tr>
			<TD width="39%"><img border="0"
				src="eminentech support files\Eminentlabs.png" width="40%"
				height=85></TD>
			<TD width="100%"><!--Start table for cell 2-->
			<table border=0 cellPadding=0 cellSpacing=0 width="100%" height="10%">
				<TBODY>
				<tr>
					<TD align=right>Eminent Product Development Life Cycle Management</TD>
					</tr>

					<TR>
						<TD>

						<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
							<TBODY>
								<TR>
									<TD bgColor=#000000 height=20 rowSpan=3 width=1><IMG alt=""
										border=0 height=20
										src="eminentech support files/dot_clear.gif" width=1></TD>
									<TD bgColor=#000000 height=1><IMG alt="" border=0 height=1
										src="eminentech support files/dot_clear.gif" width=1></TD>
								<TR>
									<TD align=left bgColor=#cccccc height=18 vAlign=center
										width="100%">&nbsp;Welcome Customer</TD>
								</TR>
								<TR>
									<TD bgColor=#000000 height=1 width="100%"><IMG alt="" border=0
										height=1 src="eminentech support files/dot_clear.gif" width=1></TD>
								</TR>
							</TBODY>
						</TABLE>
						<!--End table for customer/buttons--></TD>
					</TR>
				</TBODY>
			</table>
			<!--End table for cell 2--></TD>
		</tr>
	</TBODY>
</table>
<TABLE align="center">
	

		<tr bgColor=#E8EEF7>
			<TD align="center"><B><FONT SIZE="4" COLOR="#33CC33"> You have been logged out successfully. </FONT></B></TD>
		</tr>
		<tr>
			<td colspan="2"><a href="login.jsp">Return to Home</a></td>
		</tr>
	
</TABLE>
	<jsp:forward page="login.jsp">
		<jsp:param name="logoutstatus" value="true"/>
	</jsp:forward>	
<P></P>
<P></P>
<TABLE bgColor=#eeeeee border=0 width="100%">
		<tbody>
			<TR>
				<TD align=left noWrap vAlign=top width="50%" height="150%">
					<DIV class=footer>Copyright ©2002 - 2006 Eminentlabs Software Pvt Ltd.&nbsp; All rights reserved.
				<BR>
				<%= new java.util.Date( ).toString( ) %></DIV>
				</TD>
				<TD>&nbsp;</TD>
				<TD align=right vAlign=top width="40%">
				<DIV class=footer>email: <A href="mailto:info@eminentlabs.com">info@eminentlabs.com</A>
				<BR>phone:91-80-25633840</DIV>
				</TD>
			</TR>
			</TBODY>
		</TABLE>

</BODY>
</HTML>
