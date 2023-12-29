<%-- 
    Document   : excelForEminentProfiles
    Created on : Jul 21, 2008, 12:10:00 PM
    Author     : Balaguru Ramasamy
--%>


<%@ page language="java" contentType="application/vnd.ms-excel"%>
<%@ page
	import="org.apache.log4j.*,pack.eminent.encryption.*, java.sql.*"%>
<%@ page import="com.pack.*"%>
<%
	//Configuring log4j properties
	
	
	Logger logger = Logger.getLogger("excelForEminentProfiles");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</head>
<body>
<%@ page import="java.sql.*"%>

<% 

	Connection  connection = null;
	Statement st=null;
	PreparedStatement ps = null;
	ResultSet rs = null, rsClient = null;
        int rowcount = 0;
	try{
		connection=MakeConnection.getSAPConnection();
		
	
		if(connection != null){
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT apid,ANAM,spey,LNAM,MPHN,cloc,ug,pg,refid,area,spey,spem,tote,totm,atta from yapn where osta='OI' and csta='E' order by spey desc, spem desc, tote desc, totm desc ");
			rs.last();
			rowcount=rs.getRow();
			rs.beforeFirst();
			
		   }
          
			
%>
<TABLE width="100%" border="0">
	<tr>
		<%
			
%>
		<td colspan="2">Displaying&nbsp;<b><%=rowcount%></b> Eminent
		Profiles</td>
		<%
			
%>
	</tr>
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="20">
		<TD width="5%"><font><b>Ap ID</b></font></TD>
		<TD width="16%"><font><b>Name</b></font></TD>
		<TD width="17%"><font><b>Client</b></font></TD>
		<TD width="10%"><font><b>Mobile</b></font></TD>
		<TD width="10%"><font><b>Location</b></font></TD>
		<TD width="6%"><font><b>Ref ID</b></font></TD>
		<TD width="9%"><font><b>Education</b></font></TD>
		<TD width="5%"><font><b>Skills</b></font></TD>
		<TD width="8%"><font><b>Total Exp</b></font></TD>
		<TD width="7%"><font><b>SAP Exp</b></font></TD>

	</TR>

	<%
			int apid=9999;
			String fname="",lname="",lang="",ug="",pg="",email="",mobile="",area="",atta="";
                        ps = connection.prepareStatement("select clnt as client from zselp where apid=? and ssta = 'CS'");
                        
                        String client = null;
			if(rs!=null)
			{ 
			    for(int i=1;i<=rowcount;i++)
				{
					if(rs.next())
					{
						apid=rs.getInt("apid");
                                                ps.setInt(1,apid);
                                                rsClient = ps.executeQuery();
                                                if(rsClient != null){
                                                    if(rsClient.next()){
                                                        client = rsClient.getString("client");
                                                    }else{
                                                        client = "NA";
                                                    }
                                                }
						fname=rs.getString("anam");
						if (fname==null)
							fname="";
						lname=rs.getString("lnam");
						if (lname==null)
							lname="";
						mobile=rs.getString("mphn");
						if (mobile==null)
							mobile="nil";
                                                String refId = rs.getString("refid");
						ug=rs.getString("ug");
						if (ug==null)
							ug="";
                                                if (ug!=null)
							ug+=", ";
                                                pg=rs.getString("pg");
						if (pg==null)
							pg="";
						email=rs.getString("cloc");
						if (email==null)
							email="";
						area=rs.getString("area");
						if (area==null)
							area="nil";
                                                
                                                        
                                                int totExpYears = rs.getInt("tote");
                                                int totExpMonths = rs.getInt("totm");
                                                
                                                //String totExp = totExpYears+"Y  "+totExpMonths+"M";
                                                
                                                int sapExpYears = rs.getInt("spey");
                                                int sapExpMonths = rs.getInt("spem");
                                                
                                                //String sapExp = sapExpYears+"Y  "+sapExpMonths+"M";
                                                
						
                                                atta=rs.getString("spey");
                                                atta = fname+ "_" +atta+ "+_" +area+".PDF";
						if (atta==null)
							atta="nil";
						if(( i % 2 ) != 0)                    
                                                {
%>
	<tr bgcolor="white" height="21">
		<%
						}
                                                else
                                                {
%>
	
	<tr bgcolor="#E8EEF7" height="21">
		<%
						}
%>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="blue"><%= apid %></font></td>
		<%
                                                        String fullname=fname+" "+lname;
                                                       %>
		<td width="16%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fullname) %></font></td>


		<td width="17%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(client) %></font></td>



		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(mobile) %></font></td>

		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>

		<td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= refId %></font></td>
		<%
                                                        String education=ug+pg;
                                                        if (education.equals(", ")) education="Nil";
                                                        
					    %>
		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= StringUtil.encodeHtmlTag(education) %></font></td>


		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= StringUtil.encodeHtmlTag(area) %></font></td>



		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= totExpYears %>Y&nbsp;&nbsp;<%= totExpMonths %>M</font></td>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= sapExpYears %>Y&nbsp;&nbsp;<%= sapExpMonths %>M</font></td>

	</tr>
	<% 
					}
				}
                            }
			
	}catch(Exception e){
            logger.error("Error while uploading to excel", e);
	}	
	finally{
		if(rs!=null)
			rs.close();
		if(st!=null)
			st.close();
                if(ps!=null)
			ps.close();
		if(rsClient!=null)
			rsClient.close();
                if(connection!=null)
			connection.close();
		logger.debug("Closing JDBC Resources");
	}
%>
</table>
</body>
</html>