<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("eminentProfiles");
	
	
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
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}	
</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Eminent
		Profiles Administration</b> </font></td>
		<td align="right"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"><b>Export to
		<a
			href="<%=request.getContextPath()%>/admin/candidate/excelForEminentProfiles.jsp"
			target="_blank">Excel</a></b></font></td>
	</tr>
</table>

<% 

	Connection  connection = null;
	Statement st = null;
        PreparedStatement ps = null;
	ResultSet rs = null, rsClient = null;
	try
    {
		connection=MakeConnection.getSAPConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT apid,ANAM,spey,LNAM,MPHN,cloc,ug,pg,refid,area,spey,spem,tote,totm,atta from yapn where osta='OI' and csta='E' order by spey desc, spem desc, tote desc, totm desc ");
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			pageone=rowcount/15;
			pageremain=rowcount%15;
					
			if(pageremain>0)
			{
				totalpage=pageone+1;
			}
			else
			{
				totalpage=pageone;	
			}
			try
			{
				String requestpag=request.getParameter("manipulation");
				logger.debug("Requested Page:"+requestpag);
				if(requestpag!=null)
				{
					requestpage=Integer.parseInt(requestpag);
					if(requestpage==1)
					{
						presentpage=1;
						rs.beforeFirst();
						logger.debug("Requested page First"+presentpage);	
						issuenofrom=1;
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
							extra=issuenoto-rowcount;
							issuenoto=issuenoto-extra;
						}
					}
					if(requestpage==2)
					{
						presentpage=presentpage-1;
						if(presentpage<=0)
						{
							presentpage=1;
						}
						if(presentpage==1)
						{
							rs.beforeFirst();
							issuenofrom=1;
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						else
						{
						    issuenofrom=((presentpage-1)*15+1);
							rs.absolute(issuenofrom-1);	
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						logger.debug("Requested page Prev"+presentpage);					
					}
					if(requestpage==3)
					{
						presentpage=presentpage+1;
						if(presentpage>=totalpage)
						{
							presentpage=totalpage;
						}
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);	
						logger.debug("Requested page Next"+presentpage);		
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
					if(requestpage==4)
					{
						presentpage=totalpage;
						logger.debug("Requested page Last"+presentpage);
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);	
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
				}
				else
				{
					presentpage=1;
					issuenofrom=1;
					rs.beforeFirst();
					issuenoto=issuenofrom+14;
					if(issuenoto>rowcount)
					{
					    extra=issuenoto-rowcount;
					    issuenoto=issuenoto-extra;
					}
				}
		   }
		   catch(Exception e)
		   {
		   		logger.error("Exception:"+e);
		   }
			if(request.getParameter("newcontact")!=null)
			{
%>

<table width="100%" align=center border="0" bgcolor="E8EEF7">
	<tr>
		<td align=center><FONT SIZE="4" COLOR="#33CC33">New
		Contact has been added successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("email")%></FONT>
		</td>
	</tr>
</table>
<%
			}
%>
<TABLE width="100%" border="0">
	<tr>
		<%
			if(rowcount==0)
			{
%>
		<td>Displaying&nbsp;<%= "0"%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
		<%
			}
			else
			{
%>
		<td>Displaying&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
		<%
			}
%>
	</tr>
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
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
		<TD width="7%"><font><b>Resume</b></font></TD>
	</TR>

	<%
			int apid=9999;
			String fname="",lname="",lang="",ug="",pg="",email="",mobile="",area="",atta="";
                        ps = connection.prepareStatement("select clnt as client from zselp where apid=? and ssta = 'CS'");
                        
                        String client = null;
			if(rs!=null)
			{ 
			    for(int i=1;i<=15;i++)
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
			size="1" color="#000000"><A
			HREF="viewdetails.jsp?apid=<%=apid%>"><%= apid %></A></font></td>
		<%
                                                        String fullname=fname+" "+lname;
                                                        if((fullname.length())<25)
                                                        {
					    %>
		<td width="16%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fullname) %></font></td>
		<%
                                                        }
                                                        else
                                                        {
					    %>
		<td width="16%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= fullname.substring(0,25)+"..." %></font></td>
		<%
                                                        }
                                                        if((client.length())<20)
                                                        {
					    %>
		<td width="17%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(client) %></font></td>
		<%
                                                        }
                                                        else
                                                        {
					    %>
		<td width="17%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= client.substring(0,20)+"..." %></font></td>
		<%
                                                        }
				
							%>


		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(mobile) %></font></td>
		<%
                                                        if((email.length())<25)
                                                        {
					    %>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0,25)+"..." %></font></td>
		<%
                                                            }
                                                            %>
		<td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= refId %></font></td>
		<%
                                                        String education=ug+pg;
                                                        if (education.equals(", ")) education="Nil";
                                                        if((education.length())<8)
                                                        {
					    %>
		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= StringUtil.encodeHtmlTag(education) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= education.substring(0,8)+"..." %></font></td>
		<%
                                                            }
                                                            if((area.length())<10)
                                                            {
					    %>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= StringUtil.encodeHtmlTag(area) %></font></td>
		<%
                                                            }
                                                            else
                                                            {
					    %>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= lang.substring(0,10)+"..." %></font></td>
		<%
                                                            }
				%>
		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= totExpYears %>Y&nbsp;&nbsp;<%= totExpMonths %>M</font></td>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= sapExpYears %>Y&nbsp;&nbsp;<%= sapExpMonths %>M</font></td>
		<%
                                                            
                                                            if(atta.length()<9)
                                                            {
                                                            
					    %>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><a
			href="<%= request.getContextPath() %>/Eminentlabs/Profiles/<%=atta%>"
			target="_blank"><%=atta%></a></font></td>
		<%
                                                           }else
                                                           {
							%>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><a
			href="<%= request.getContextPath() %>/Eminentlabs/Profiles/<%=atta%>"
			target="_blank"><%=atta.substring(0,9)+"..."%></a></font></td>

		<%
                                                            }
                                                            %>

	</tr>
	<% 
					}
				}
			}	
			if(request.getParameter("manipulation")==null && (rowcount/16==0))
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation")==null)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=eminentProfiles.jsp?manipulation=3>Next</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("1"))
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=eminentProfiles.jsp?manipulation=3>Next</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}	
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=eminentProfiles.jsp?manipulation=1>First</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3") && issuenoto==rowcount)
			{
%>
	<table align=right>
		<tr>
			<td><a href=eminentProfiles.jsp?manipulation=1>First</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=eminentProfiles.jsp?manipulation=1>First</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=2>Prev</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=3>Next</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2") && issuenofrom == 1)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=eminentProfiles.jsp?manipulation=3>Next</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=eminentProfiles.jsp?manipulation=1>First</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=2>Prev</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=3>Next</a></td>
			<td><a href=eminentProfiles.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
		}
    } catch(Exception e) {
                        logger.error("Error while displaying Eminent profiles", e);
    } finally {
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