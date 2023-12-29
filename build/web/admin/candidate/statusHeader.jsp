<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<body>
<table width=100%>
	<TR height="9">
		<TD width="1%"><font><A
			HREF="searchStatus.jsp?status=Blank" TITLE="Registered">R </A></font></TD>
		<TD width="2%"><font><A
			HREF="searchStatus.jsp?status=RNS" TITLE="Registration Not Approved">
		RNA </A></font></TD>
		<TD width="2%"><font><A HREF="searchStatus.jsp?status=RW"
			TITLE="Registration Waitlisted"> RW </A></font></TD>
		<TD width="8%"><font><A HREF="searchStatus.jsp?status=RS"
			TITLE="Registration Approved"> RA </A></font></TD>

		<TD width="3%"><font><A
			HREF="searchStatus.jsp?status=ANS" TITLE="Online Test Not Approved">
		OTNA </A></font></TD>
		<TD width="3%"><font><A HREF="searchStatus.jsp?status=AW"
			TITLE="Oline Test Approval Waitlisted"> OTAW </A></font></TD>
		<TD width="8%"><font><A HREF="searchStatus.jsp?status=AS"
			TITLE="Online Test Approved"> OTA </A></font></TD>

		<TD width="3%"><font><A
			HREF="searchStatus.jsp?status=WNS" TITLE="Online Test Not Cleared">
		OTNC </A></font></TD>
		<TD width="3%"><font><A HREF="searchStatus.jsp?status=WW"
			TITLE="Online Test Cleared But Waitlisted"> OTCW </A></font></TD>
		<TD width="8%"><font><A HREF="searchStatus.jsp?status=WS"
			TITLE="Online Test Cleared"> OTC </A></font></TD>

		<TD width="3%"><font><A
			HREF="searchStatus.jsp?status=INS"
			TITLE="Competency Interview Not Scheduled"> CINSD </A></font></TD>
		<TD width="3%"><font><A HREF="searchStatus.jsp?status=IW"
			TITLE="Competency Interview Waitlisted"> CIWD</A></font></TD>
		<TD width="8%"><font><A HREF="searchStatus.jsp?status=IS"
			TITLE="Competency Interview Scheduled"> CISD </A></font></TD>

		<TD width="2%"><font><A
			HREF="searchStatus.jsp?status=ECN"
			TITLE="Competency Interview Not Selected"> CINS </A></font></TD>
		<TD width="2%"><font><A
			HREF="searchStatus.jsp?status=ECR"
			TITLE="Competency Interview Waitlisted"> CIW </A></font></TD>
		<TD width="2%"><font><A
			HREF="searchStatus.jsp?status=ECW"
			TITLE="Competency Interview Rescheduled"> CIR </A></font></TD>
		<TD width="8%"><font><A
			HREF="searchStatus.jsp?status=ECS"
			TITLE="Competency Interview Selected"> CIS </A></font></TD>

		<TD width="3%"><font><A
			HREF="searchStatus.jsp?status=MNS"
			TITLE="Client Interview Not Scheduled"> CNSD </A></font></TD>
		<TD width="2%"><font><A HREF="searchStatus.jsp?status=MW"
			TITLE="Client Interview Waitlisted"> CWD</A></font></TD>
		<TD width="8%"><font><A HREF="searchStatus.jsp?status=MS"
			TITLE="Client Interview Scheduled"> CSD </A></font></TD>

		<TD width="2%"><font><A
			HREF="searchStatus.jsp?status=CNS"
			TITLE="Client Interview Not Selected"> CNS </A></font></TD>
		<TD width="2%"><font><A HREF="searchStatus.jsp?status=CW"
			TITLE="Client Interview Waitlisted"> CW </A></font></TD>
		<TD width="1%"><font><A HREF="searchStatus.jsp?status=CR"
			TITLE="Client Interview Rescheduled"> CR </A></font></TD>
		<TD width="4%"><font><A HREF="searchStatus.jsp?status=CS"
			TITLE="Client Interview Selected"> CS </A></font></TD>
	</TR>
</TABLE>

</body>
</html>
