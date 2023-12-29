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
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
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
		
		Logger logger = Logger.getLogger("New Resource");
		
		Connection  connection = null;
		
		String ip=request.getParameter("ip");
		String machinename=request.getParameter("machinename");
		String user=request.getParameter("user");
		String cpu=request.getParameter("cpu");
		String ram=request.getParameter("ram");
		String harddisk=request.getParameter("harddisk");
		String motherboard=request.getParameter("motherboard");
		String os=request.getParameter("os");
		String uniqueno=request.getParameter("uniqueno");
		String value=request.getParameter("value");
                String status=request.getParameter("status");
		
		
		PreparedStatement ps = null;
		Statement st = null;
		ResultSet rs = null;
		try  
		{
			connection = MakeConnection.getConnection();
			logger.debug("Connection:"+connection);
			if (connection!=null)
			{
					if (ip!=null && machinename!=null && user !=null)
					{

						
						
			        		//	int nextValue = rs.getInt("nextval");
								ps=connection.prepareStatement("insert into resources (ipaddress,machinename,assigneduser,cpudetails,ramdetails,harddisk,motherboard,OS,Unique_Asset_No,value,status) values(?,?,?,?,?,?,?,?,?,?,?)");
								ps.setString(1,StringUtil.fixSqlFieldValue(ip));
								ps.setString(2,StringUtil.fixSqlFieldValue(machinename));
								ps.setString(3,StringUtil.fixSqlFieldValue(user));
								ps.setString(4,StringUtil.fixSqlFieldValue(cpu));
								ps.setString(5,StringUtil.fixSqlFieldValue(ram));
								ps.setString(6,StringUtil.fixSqlFieldValue(harddisk));
								ps.setString(7,StringUtil.fixSqlFieldValue(motherboard));
								ps.setString(8,StringUtil.fixSqlFieldValue(os));
		                        ps.setString(9,StringUtil.fixSqlFieldValue(uniqueno));
								ps.setString(10,StringUtil.fixSqlFieldValue(value));
                                                                ps.setString(11,StringUtil.fixSqlFieldValue(status));
		     					
		     					
								ps.executeUpdate();
								connection.commit();
								logger.info("Successfully updated!!!");
							
						
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
<jsp:forward page="/admin/resource/viewResources.jsp">
	<jsp:param name="newresource" value="added" />
	<jsp:param name="machinename" value="<%= machinename %>" />
</jsp:forward>
</body>
</html>