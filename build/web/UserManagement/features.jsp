<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8" import="java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html">
<STYLE>
BODY {
	BACKGROUND: white;
	COLOR: #333333;
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 11px
}

A:link {
	COLOR: #cc0000
}

A:visited {
	COLOR: #330099
}

A:hover {
	COLOR: #ff3300
}

H2 {
	COLOR: #666666;
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 15px;
	FONT-WEIGHT: bold
}

H3 {
	COLOR: #333333;
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 13px;
	FONT-WEIGHT: bold
}

H4 {
	COLOR: #666666;
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 11px;
	FONT-WEIGHT: bold
}

TH {
	BACKGROUND: #000099;
	COLOR: white;
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 11px;
	FONT-WEIGHT: bold;
	TEXT-ALIGN: center
}

TABLE {
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 11px
}

TD {
	FONT-FAMILY: Arial, Helvetica;
	FONT-SIZE: 11px
}
</STYLE>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>
<body>
<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%" height="1%">
	<TBODY height="100%">
		<BR>
		<BR>
		<TR>
			<TD width="3%"></TD>
			<TD width="16%"><img border="0"
				src="<%= request.getContextPath()%>/eminentech support files\Eminentlabs.png"></TD>
			<TD width="70%"><!--Start table for cell 2-->
			<TABLE border=0 cellPadding=0 cellSpacing=0 width="95%" height="10%">
				<TR>
					<TD align=right>Eminent Product Development Life Cycle
					Management</TD>
				</TR>
				<TR>
					<TD>
					<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
						<TR>
							<TD align=left border=0 bgColor=#C3D9FF height=23 vAlign=center
								width="100%">&nbsp;<b>Welcome Customer</b></TD>
						</TR>
					</TABLE>
					<!--End table for customer/buttons--></TD>
				</TR>
			</TABLE>
			<!--End table for cell 2--></TD>
		</TR>
	</TBODY>
</TABLE>
<BR>
<BR>
<BR>
<font size="3" color="#336699" face="Garamond">
<TABLE>
	<TR>
		<TD WIDTH="12%"></TD>
		<TD>
		<h3>FEATURES AND BENEFITS</h3>
		<UL>
			<li>eTracker&#153; is a complete CRM, ERM, APM and Performance
			Tracking System</li>
			<li>eTracker&#153; brings in visibility in the system aiding in
			quick decesion making</li>

			<li>eTracker&#153; allows employees to track, manage and follow
			the defined processes to continuously improve productivity and reduce
			company-operating costs</li>

			<li>eTracker&#153; provides an effective communication link to
			be forged between people working in different departments across
			geographical locations</li>

		</UL>
		<h3>FEATURES AND BENEFITS</h3>
		<ul>
			<li>Information to help ensure the quality, security, and
			performance of your Distributed Software Development</li>
			<li>Information about software maintenance, functional
			enhancements and updates, and technical support</li>
			<li>Information that helps you realize the full value of your
			Enterprise and optimize the performance of your resources</li>
			<li>Improves productivity and deliver a better customer
			experience</li>
			<li>Easy integration with any of your existing website or
			portals</li>
		</ul>

		</TD>
	</TR>
</TABLE>
</font>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<TABLE border=0 width="96%">
	<TR>
		<TD width="2%"></TD>
		<TD bgColor="#C3D9FF" align=center noWrap vAlign=top width="100%"
			height=20><font face="Verdana" size="1" color="#666666">
		<%
        Calendar c=Calendar.getInstance();
        c.setTime(new Date());
        %> Copyright ©2002 -<%=c.get(Calendar.YEAR)%> Eminentlabs
		Software Private Limited&nbsp; All rights reserved. </font></TD>
	</TR>
</TABLE>

</body>
</html>
