<%-- 
    Document   : excelForViewCandidate
    Created on : Jul 21, 2008, 12:43:28 PM
    Author     : Balaguru Ramasamy
--%>
<%@ page language="java"
	contentType="application/vnd.ms-excel;  "
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("viewcandidate");
	
	
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
<%@ include file="statusHeader.jsp"%>

<% 

	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
        int rowcount = 0;
	try{
		connection=MakeConnection.getSAPConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null){
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT apid,ANAM,LNAM,MPHN,cloc,refid,regdat,ug,pg,area,spey,spem,tote,totm,atta,rtime from yapn order by spey desc, spem desc, tote desc, totm desc ");
			rs.last();
			rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			
		   }
		   
			
%>


<TABLE width="100%" border="0">
	<tr>
		<td colspan="2">Displaying&nbsp;<b><%=rowcount%></b> candidates</td>
	</tr>
</TABLE>
<br>

<table width=100%>
	<TR bgColor="#C3D9FF" height="20">
		<TD width="5%"><font><b>Ap ID</b></font></TD>
		<TD width="16%"><font><b>Name</b></font></TD>
		<TD width="17%"><font><b>Employer</b></font></TD>
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
%>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="blue"><%= apid %></font></td>
		<%
                                                        String fullname=fname+" "+lname;
                                                        
					    %>
		<td width="16%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fullname) %></font></td>

		<td width="17%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(employer) %></font></td>


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
		<td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
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
        logger.error("Error while to excel ", e);
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
