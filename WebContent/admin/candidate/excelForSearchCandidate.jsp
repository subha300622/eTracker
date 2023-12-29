<%-- 
    Document   : excelForSearchCandidate
    Created on : Jul 21, 2008, 1:01:10 PM
    Author     : Balaguru Ramasamy
--%>

<%@ page language="java" contentType="application/vnd.ms-excel"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%
	//Configuring log4j properties
	
	
	
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
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</head>
<body>
<%@ page import="java.sql.*"%>

<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left" colspan="2"><font size="4" COLOR="#0000FF"><b>Applicant
		Administration</b> </font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
	</tr>
</table>

<% 
        String search = request.getParameter("search");
	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
        int rowcount = 0;
	try
    {
		connection=MakeConnection.getSAPConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT apid,ANAM,LNAM,MPHN,cloc,refid,regdat,ug,pg,area,spey,spem,tote,totm,atta,rtime from yapn where upper(area) like upper('%"+search+"%"+"') or upper(lang) like upper('%"+search+"%"+"') or upper(erpp) like upper('%"+search+"%"+"') or upper(opsm) like upper('%"+search+"%"+"') or upper(dtbs) like upper('%"+search+"%"+"') or upper(tout) like upper('%"+search+"%"+"') or upper(ug) like upper('%"+search+"%"+"') or upper(pg) like upper('%"+search+"%"+"') order by anam ASC ");
			rs.last();
			rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			
					

			
			
%>
<table width="100%">
	<tr>
		<td colspan="2">Listing&nbsp;<b><%=rowcount%></b> applicants <%
			
%>
		
	</tr>
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="20">
		<TD width="5%"><font><b>Ap ID</b></font></TD>
		<TD width="20%"><font><b>Name</b></font></TD>
		<TD width="12%"><font><b>Mobile</b></font></TD>
		<TD width="10%"><font><b>Location</b></font></TD>
		<TD width="6%"><font><b>Ref ID</b></font></TD>
		<TD width="11%"><font><b>Education</b></font></TD>
		<TD width="9%"><font><b>Skills</b></font></TD>
		<TD width="8%"><font><b>Total Exp</b></font></TD>
		<TD width="8%"><font><b>SAP Exp</b></font></TD>

	</TR>

	<%
			int apid=9999;
			String fname="",lname="",ug="",pg="",email="",mobile="",area="",dob="",atta="";
			if(rs!=null)
			{ 
			    for(int i=1;i<=rowcount;i++)
				{
					if(rs.next())
					{
						apid=rs.getInt("apid");
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
                                                
                                                //String totExp = totExpYears+"Y"+"  "+totExpMonths+"M";
                                                
                                                int sapExpYears = rs.getInt("spey");
                                                int sapExpMonths = rs.getInt("spem");
                                                
                                                //String sapExp = sapExpYears+"Y"+"  "+sapExpMonths+"M";
                                                
                                                atta=rs.getString("atta");
                                                if (atta==null)
							atta="nil";
                                                
                                                String t = rs.getString("rtime");
                                                if(t.equalsIgnoreCase("000000")){
                                                    atta = apid+"_"+fname+"_"+rs.getString("regdat")+".doc";    
                                                }else{
                                                    atta = apid+"_"+fname+"_"+rs.getString("regdat")+"_"+t+".doc";
                                                }
						
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
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fullname) %></font></td>

		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(mobile) %></font></td>

		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>

		<td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= refId %></font></td>
		<%
                                                        String education=ug+pg;
                                                        if (education.equals(", ")) education="Nil";
                                                        
					    %>
		<td width="11%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(education) %></font></td>

		<td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= StringUtil.encodeHtmlTag(area) %></font></td>


		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= totExpYears %>Y&nbsp;&nbsp;<%= totExpMonths %>M</font></td>
		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= sapExpYears %>Y&nbsp;&nbsp;<%= sapExpMonths %>M</font></td>

	</tr>
	<% 
					}
                                        }
				}
			}	
			
		}catch(Exception e){
                        logger.error("Error while uploading to excel", e);
                }finally{
                    if(rs!=null)
			rs.close();
                    if(st!=null)
			st.close();
                    if(connection!=null)
			connection.close();
                        logger.debug("Closing JDBC Resources");
	}
%>
</table>
</body>
</html>
