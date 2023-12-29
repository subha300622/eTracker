<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.pack.SessionCounter,java.util.*,com.eminent.util.*"%>
<%
	Logger logger = Logger.getLogger("ViewUser");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
             logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<%@ page import="com.pack.*,java.sql.*"%>
<jsp:useBean id="Team" class="com.eminent.util.TeamUtil" />
<%@ include file="/header.jsp"%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
</HEAD>
<body>
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr border="2">
		<td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Team
		Administration</b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
		<td border="1" align="right"></td>
		<td border="1" align="right"><font size="4" COLOR="#0000FF">
		</font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<table align="center">
<tr bgColor="#C3D9FF" >
		<td><font><b>Team Id</b></font></td>
		<td><font><b>Team Name</b></font></td>
</tr>
<%!
		Connection connection=null;
		ResultSet rs=null;
                Statement st=null;
		String teamName=null;
		String teamid=null;
%>
<%
		try{
			
			connection=MakeConnection.getConnection();
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("select * from team");
			
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			
			int i=0;
			while(rs.next()){
				teamName=	rs.getString("teamname");
				teamid	=	rs.getString("teamid");
			
				 if(( i % 2 ) != 0)                    
                {
%>
	<tr bgcolor="white" height="9">
		<%
                }
                else
                {
%>
	
	<tr bgcolor="#E8EEF7" height="9">
		<%
                }
%>
					<td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A href="editTeam"><%=teamid %></A> </font></td>
					<td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=teamName %></font></td>
</tr>
				<%
				i++;
			}
			
		}
		catch(Exception e){
			logger.error(e.getMessage());	
		}
		finally
		{
			if(rs!=null) {
				rs.close();
			}
                        if(st!=null) {
				st.close();
			}
			if(connection!=null) {
				connection.close();
			}
		}

%>
</table>
</body>
</html>