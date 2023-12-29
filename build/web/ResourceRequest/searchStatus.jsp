<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page
	import="org.apache.log4j.*,com.pack.eminent.applicant.*,pack.eminent.encryption.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("searchStatus");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<%@ page import="com.pack.*, com.eminent.resource.ResourceCheck"%>
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
        
    function check(searchCandidate)  {  
    if ((searchCandidate.candidateName.value==null)||(searchCandidate.candidateName.value==""))
		{
			alert("Please Enter String to Search ")
			searchCandidate.candidateName.focus()
			return false
		}
                return true
                }
                
        /** Function To Set Focus On The First Name Field In The Form */
	
	function setFocus()  {
		document.searchCandidate.candidateName.focus();
	}
	
	window.onload = setFocus;
</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>



<%@ include file="/admin/candidate/statusHeader.jsp"%>

<% 

	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
	try
    {
		connection=MakeConnection.getSAPConnection();
		logger.debug("Connection has been created:"+connection);
                String status = request.getParameter("status");
				String replace = status;
				if(replace.equalsIgnoreCase("CS")){
					replace = status+"' and csta='"+"  ";
				}
                
                String reqId = "R20112008002";
                String skill  = "FI";
                int lockedResource = ResourceCheck.getResourceId(reqId);
                session.setAttribute("lockedResource", lockedResource);
                session.setAttribute("reqId", reqId);
                
		if(connection != null)  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                        
                            rs = st.executeQuery("SELECT apid,ANAM,LNAM,MPHN,cloc,refid,regdat,ug,pg,area,spey,spem,tote,totm,atta,rtime from yapn  where osta = '"+ status +"' and (sel_status is null or sel_status != 'S') and (area = '"+ skill +"' or lang = '"+ skill +"') and (reqid is null or reqid = '"+ reqId +"') and apid not in(select distinct apid from yrr_history where reqid='"+ reqId +"') order by spey desc, spem desc, tote desc, totm desc ");
                           
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			
%>


<TABLE width="100%" border="0">
	<tr>
		<%
			if(rowcount==0)
			{
%>
		<table align="center" height="70%">
			<tr>
				<td>
				<h3>No applicants are available matching this requirement.</h3>
				</td>
			</tr>
		</table>
		<%
			}
			else
			{
%>
		
<br>
<form name="listForm" action="<%= request.getContextPath() %>/ResourceRequest/lockResource.jsp">
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
                <TD width="5%"><font><b>Select</b></font></TD>
		<TD width="5%"><font><b>Ap ID</b></font></TD>
		<TD width="16%"><font><b>Name</b></font></TD>
		<TD width="17%"><font><b>Employer</b></font></TD>
		<TD width="10%"><font><b>Mobile</b></font></TD>
		<TD width="10%"><font><b>Location</b></font></TD>
		<TD width="6%"><font><b>Ref ID</b></font></TD>
		<TD width="9%"><font><b>Education</b></font></TD>
		<TD width="5%"><font><b>Skills</b></font></TD>
		<TD width="6%"><font><b>Total Exp</b></font></TD>
		<TD width="6%"><font><b>SAP Exp</b></font></TD>
		<TD width="5%"><font><b>Resume</b></font></TD>
	</TR>

	<%
			int apid=9999;
			String fname="",lname="",ug="",pg="",email="",mobile="",area="",dob="",atta="";
                        PreparedStatement ps = connection.prepareStatement("select pemp from yapn_emp_exp where apid=? and cnt=1");
                        ResultSet rsEmp = null;
                        String employer = null;
			if(rs!=null)
			{ 
			    for(int i=1;i<=rowcount;i++)
				{
					if(rs.next())
					{
						apid=rs.getInt("apid");
                                                
                                                ps.setInt(1,apid);
                                                rsEmp = ps.executeQuery();
                                                if(rsEmp != null){
                                                    if(rsEmp.next()){
                                                        employer = rsEmp.getString("pemp");
                                                    }else{
                                                        employer = "NA";
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
                                                        
                                                String t = rs.getString("rtime");  
                                                
                                                
                                                int totExpYears = rs.getInt("tote");
                                                int totExpMonths = rs.getInt("totm");
                                                
                                                //String totExp = totExpYears+"Y"+"  "+totExpMonths+"M";
                                                
                                                int sapExpYears = rs.getInt("spey");
                                                int sapExpMonths = rs.getInt("spem");
                                                
                                                //String sapExp = sapExpYears+"Y"+"  "+sapExpMonths+"M";
                                                
                                                
                                                
                                               
                                                    atta=rs.getString("atta");
                                                    if(t.equalsIgnoreCase("000000")){
                                                    atta = apid+"_"+fname+"_"+rs.getString("regdat")+".doc";    
                                                }else{
                                                    atta = apid+"_"+fname+"_"+rs.getString("regdat")+"_"+t+".doc";
                                                }
                                                
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
                                                    
                         if(lockedResource == apid) {
                %>
                    <td width="5%"><input type="radio" checked name="lock" value="<%= apid %>"> </td>
                <%
                } else {
                %>
                    <td width="5%"><input type="radio" name="lock" value="<%= apid %>"> </td>
                <%
                                                        
                }
                %>
                <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><A
			HREF="<%= request.getContextPath() %>/admin/candidate/viewdetails.jsp?apid=<%=apid%>"><%= apid %></A></font></td>
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
                                                        if((employer.length())<20)
                                                        {
					    %>
		<td width="17%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(employer) %></font></td>
		<%
                                                        }
                                                        else
                                                        {
					    %>
		<td width="17%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= employer.substring(0,20)+"..." %></font></td>
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
                                                        if((education.length())<10)
                                                        {
					    %>
		<td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= StringUtil.encodeHtmlTag(education) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= education.substring(0,10)+"..." %></font></td>
		<%
                                                            }
                                                            if((area.length())<13)
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
			size="1" color="#000000"><%= area.substring(0,13)+"..." %></font></td>
		<%
                                                            }
				%>
		<td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= totExpYears %>Y&nbsp;&nbsp;<%= totExpMonths %>M</font></td>
		<td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= sapExpYears %>Y&nbsp;&nbsp;<%= sapExpMonths %>M</font></td>
		<%
                                                            
                                                            if(atta.length()<8)
                                                            {
                                                            
					    %>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><a
			href="<%= request.getContextPath() %>/Eminentlabs/Resumes/<%=atta%>"
			target="_blank"><%=atta%></a></font></td>
		<%
                                                           }else
                                                           {
							%>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><a
			href="<%= request.getContextPath() %>/Eminentlabs/Resumes/<%=atta%>"
			target="_blank"><%=atta.substring(0,8)+"..."%></a></font></td>

		<%
                                                            }
                                                            
                                                            %>

	</tr>
	<% 
					}
				}
			}
                        
			
			
                        }
		}
    }
	catch(Exception e){
                        logger.error("Error while displaying ROH", e);
	}	
	finally{
		if(rs != null)
			rs.close();
		if(st != null)
			st.close();
                if(connection != null)
			connection.close();
		logger.debug("Closing JDBC Resources");
	}
%>
</table>
<table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="2"
	align="center">
	<tr align="center">
		<TD>&nbsp;</TD>
		<TD><INPUT type=submit value=Update name=submit>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
			type=reset value=" Reset "></TD>
	</tr>
</table>
</form>
</body>
</html>