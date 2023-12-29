<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
</head>
<body>
<!-- Java Package Import Declarations -->
<%@ page
	import="java.sql.*,pack.eminent.encryption.*,com.pack.*,org.apache.log4j.*,java.util.Calendar"%>
<% 	
java.util.Date d = new java.util.Date();

Calendar cal = Calendar.getInstance();
cal.setTime(d);
//Timestamp ts = new Timestamp(cal.getTimeInMillis());
Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
		
		Logger logger = Logger.getLogger("NewOpportunity");
		
		Connection  connection = null;
		
		String opportunityowner=((Integer)session.getAttribute("uid")).toString();
		String opportunityname=request.getParameter("opportunityname");
	
		String type=request.getParameter("type");
		String closedate=request.getParameter("closedate");
		String stage=request.getParameter("stage");
		String probability=request.getParameter("probability");
		String amount=request.getParameter("amount");
		logger.info("Amount before"+amount);
		if(amount==""){
			amount="100";
		}
		logger.info("Amount after"+amount);
		String leadsource=request.getParameter("leadsource");
		String nextstep=request.getParameter("nextstep");
		String description=request.getParameter("description");
		
		String assignedto=request.getParameter("assignedto");
		
		 String storeDate = com.pack.ChangeFormat.getDateFormat(closedate);
		
		PreparedStatement ps = null;
		Statement st = null;
		ResultSet rs = null;
		int roleid=2;
		try  
		{
			connection = MakeConnection.getConnection();
			logger.debug("Connection:"+connection);
			if (connection!=null)
			{
					if (closedate!=null && opportunityname!=null )
					{

						st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = st.executeQuery("select opportunityid_seq.nextval from dual");
						if(rs!=null)  
						{
							if(rs.next())  
							{
			        			int nextValue = rs.getInt("nextval");
								ps=connection.prepareStatement("insert into opportunity (opportunity_owner,opportunityname,type,close_date,stage,probability, amount,leadsource,nextstep,description,opportunityid,createdon,modifiedon,assignedto,roleid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
								ps.setString(1,StringUtil.fixSqlFieldValue(opportunityowner));
								ps.setString(2,StringUtil.fixSqlFieldValue(opportunityname));
								ps.setString(3,StringUtil.fixSqlFieldValue(type));
								ps.setDate(4,java.sql.Date.valueOf(storeDate));
								ps.setString(5,StringUtil.fixSqlFieldValue(stage));
								ps.setString(6,StringUtil.fixSqlFieldValue(probability));
								ps.setString(7,StringUtil.fixSqlFieldValue(amount));
		                        ps.setString(8,StringUtil.fixSqlFieldValue(leadsource));
								ps.setString(9,StringUtil.fixSqlFieldValue(nextstep));
		     					ps.setString(10,StringUtil.fixSqlFieldValue(description));
		     					ps.setInt(11,nextValue);
		     					ps.setTimestamp(12,ts);
		     					ps.setTimestamp(13,ts);
		     					ps.setInt(14,Integer.parseInt(assignedto));
		     					ps.setInt(15,roleid);
								ps.executeUpdate();
								connection.commit();
								logger.info("Successfully updated!!!");
							}
						}
					}
			}
					
		}
		catch(SQLException ex)  
		{
				logger.error(ex.getMessage());
		}
		finally
		{
			if(ps!=null)
				ps.close();
			if(connection!=null)
				connection.close();
		}
%>
<jsp:forward page="/admin/customer/viewOpportunity.jsp">
	<jsp:param name="newopportunity" value="true" />
	<jsp:param name="opportunityname" value="<%= opportunityname %>" />
</jsp:forward>
</body>
</html>