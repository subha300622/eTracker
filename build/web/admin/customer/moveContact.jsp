<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.text.*,com.pack.*,java.util.*,org.apache.log4j.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>
<LINK title=STYLE	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"	type="text/css" rel=STYLESHEET>
</head>
<%

		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma","no-cache");
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("moveContact");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table  width="100%">
	<tr  bgcolor="#c3d9ff">
		<td  align="left" ><font size="4"
			COLOR="#0000FF"><b> Contact Administration</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		
	</tr>
</table>
<BR>
<%
		logger.info("Moving");
		String contact=request.getParameter("contactid");
		logger.info("Contact id"+contact);
		Connection connection = null;
		PreparedStatement ps=null;
		PreparedStatement ps1=null;
		Statement st=null;
		ResultSet rs=null;
		Statement stInsert=null;
		ResultSet rsInsert=null;
		
		int potential=1;
		int leadrole=2;
		String leadstatus="Open";
		String company=null;
		String industry=null;
		String website=null;
		String annualrevenue=null;
		String noofemployees=null;
		String rating=null;
		int assi=100;
		String storeDate=null;
		
		java.util.Date d = new java.util.Date();

		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		//Timestamp ts = new Timestamp(cal.getTimeInMillis());
		Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
		
		
		try{
			connection=MakeConnection.getConnection();
			
			if(connection!=null){
				st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				
				rs = st.executeQuery("Select EMAIL,FIRSTNAME,LASTNAME,ACCOUNTNAME, contact_owner, TITLE,PHONE,MOBILE,REPORTSTO,MAILINGSTREET,MAILINGCITY,MAILINGSTATE,MAILINGZIP,MAILINGCOUNTRY,OTHERSTREET,OTHERCITY,OTHERSTATE,OTHERZIP,OTHERCOUNTRY,FAX,HOMEPHONE,OTHERPHONE,ASSISTANT,ASSTPHONE,LEADSOURCE,BIRTHDATE,DEPARTMENT,DESCRIPTION,assignedto,company,duedate,rating,modifiedon,INTERESTED  from contact where contactid='"+contact+"'");
				if(rs!=null)
				{
					while(rs.next())
					{
						logger.info("Inside data retrival");
						String firstname=rs.getString("FIRSTNAME");
						String lastname=rs.getString("LASTNAME");
		                String contactOwner=rs.getString("CONTACT_OWNER");
						String accountname=rs.getString("ACCOUNTNAME");
						String title=rs.getString("TITLE");
						String phone=rs.getString("PHONE");
						String mobile=rs.getString("MOBILE");
						String reportsto=rs.getString("REPORTSTO");
						 company=rs.getString("company");
						String email=rs.getString("EMAIL");
						String street=rs.getString("MAILINGSTREET");
						String city=rs.getString("MAILINGCITY");
		                String state=rs.getString("MAILINGSTATE");
						String zip=rs.getString("MAILINGZIP");
						String country=rs.getString("MAILINGCOUNTRY");
		                String otherstreet=rs.getString("OTHERSTREET");
		                String othercity=rs.getString("OTHERCITY");
						String otherstate=rs.getString("OTHERSTATE");
		                String otherzip=rs.getString("OTHERZIP");
		                String othercountry=rs.getString("OTHERCOUNTRY");
						String fax=rs.getString("FAX");
						String homephone=rs.getString("HOMEPHONE");
						String otherphone=rs.getString("OTHERPHONE");
						String assistant=rs.getString("ASSISTANT");
						String asstphone=rs.getString("ASSTPHONE");
						String leadsource=rs.getString("LEADSOURCE");
						String birthdate=rs.getString("BIRTHDATE");
						String department=rs.getString("DEPARTMENT");
						String description=rs.getString("DESCRIPTION");
						
						
						
						
									
						rating=rs.getString("rating");
						
						assi=rs.getInt("assignedto");
						
						java.util.Date due=rs.getDate("duedate");
						
						SimpleDateFormat dfm =  new SimpleDateFormat("d-M-yyyy");
						String dueDate = "NA";
		                if(due != null){
		                    dueDate = dfm.format(due);
		                }
		                
		                storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
		                
		                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
		                
		                java.sql.Date modifiedOn = rs.getDate("modifiedon");
						
						String modified = "NA";
		                if(modifiedOn != null){
		                	modified = sdf.format(modifiedOn);
		                }
						
		                String product=rs.getString("INTERESTED");
		              
		                
		                
		                if (lastname!=null && company !=null)
						{

							stInsert = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rsInsert = stInsert.executeQuery("select leadid_seq.nextval from dual");
							if(rsInsert!=null)  
							{
								if(rsInsert.next())  
								{
									logger.info("creation of lead ");
				        			int nextValue = rsInsert.getInt("nextval");
//									ps=connection.prepareStatement("insert into lead (lead_owner,firstname,lastname,company,title,leadstatus,phone,email,rating,street,city,state,zip,country,website,noofemployees,annualrevenue,leadsource,industry,description,leadid,roleid,mobile,leadpotential,createdon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
									ps=connection.prepareStatement("insert into lead (lead_owner,title,firstname,lastname,phone,email,company,mobile,leadstatus,assignedto,rating,website,leadpotential,duedate,interested,street,city,state,zip,country,annualrevenue,noofemployees,industry,leadsource,description,leadid,roleid,createdon,modifiedon,contact_reference) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
									
									ps.setString(1,StringUtil.fixSqlFieldValue(contactOwner));
									
									ps.setString(2,StringUtil.fixSqlFieldValue(title));
									ps.setString(3,StringUtil.fixSqlFieldValue(firstname));
									ps.setString(4,StringUtil.fixSqlFieldValue(lastname));
									
									ps.setString(5,StringUtil.fixSqlFieldValue(phone));
			                        ps.setString(6,StringUtil.fixSqlFieldValue(email));
									ps.setString(7,StringUtil.fixSqlFieldValue(company));
									
									ps.setString(8,mobile);
									ps.setString(9,StringUtil.fixSqlFieldValue(leadstatus));
									ps.setInt(10, assi);
									
									ps.setString(11,StringUtil.fixSqlFieldValue(rating));
									ps.setString(12,StringUtil.fixSqlFieldValue(website));
									ps.setInt(13,potential);
									
									ps.setDate(14,java.sql.Date.valueOf(storeDate));
									ps.setString(15,StringUtil.fixSqlFieldValue(product));
									
			     					ps.setString(16,StringUtil.fixSqlFieldValue(street));
			                        ps.setString(17,StringUtil.fixSqlFieldValue(city));
			                        ps.setString(18,StringUtil.fixSqlFieldValue(state));
			                        
			                        ps.setString(19,StringUtil.fixSqlFieldValue(zip));
			                        ps.setString(20,StringUtil.fixSqlFieldValue(country));
			                       
			                        ps.setString(21,StringUtil.fixSqlFieldValue(annualrevenue));
			                        ps.setString(22,StringUtil.fixSqlFieldValue(noofemployees));
			                        
			                        ps.setString(23,StringUtil.fixSqlFieldValue(industry));	
			                        ps.setString(24,StringUtil.fixSqlFieldValue(leadsource));
			                   					
			                        ps.setString(25,StringUtil.fixSqlFieldValue(description));
			                        
			                        ps.setInt(26,nextValue);
			                        ps.setInt(27,leadrole);
			                       
			                       
			                        ps.setTimestamp(28,ts);
			                        ps.setTimestamp(29,ts);
			                        ps.setInt(30,Integer.parseInt(contact));
			                        
									int x=ps.executeUpdate();
									logger.info("moving contact to lead"+x);
								}
							}
						}
		                int roleidUpdate=3;
		                ps1 = connection.prepareStatement("update contact set roleid=? where contactid=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		                ps1.setInt(1,roleidUpdate);
		                ps1.setString(2,contact);
		                
		               int y= ps1.executeUpdate();
		               logger.info("Contact update "+y);

		                                

			}

				}
				int x=0;
		        
				Integer user = (Integer)session.getAttribute("uid");
			        String userId = String.valueOf(user); 
			                
			        String comments = request.getParameter("comments");
				if(comments.length()>0)
				{
					try
					{
							ps = connection.prepareStatement("insert into contact_comments(contactid,commentedby,comment_date,comments,rating,duedate,commentedto) values(?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							ps.setInt(1,Integer.parseInt(contact));
							ps.setString(2,userId);
							ps.setTimestamp(3,ts);
							ps.setString(4,comments);
							ps.setString(5,rating);
							ps.setDate(6,java.sql.Date.valueOf(storeDate));
							ps.setInt(7,assi);
							
							x = ps.executeUpdate();
							logger.info("Inserted one row:\t"+x);
					}
					catch(Exception e)
					{
						logger.error("Exception in Comments:"+e);
						logger.error(e.getMessage());
					}
					
					finally
					{
						if(ps!=null)
							ps.close();
						logger.debug("Comments are not empty");
					}
				}
			}
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(connection!=null){
				connection.close();
			}
			if(ps!=null){
				ps.close();
			}
			if(ps1!=null){
				ps1.close();
			}
			if(st!=null){
				st.close();
			}
			if(rs!=null){
				rs.close();
			}
			if(stInsert!=null){
				stInsert.close();
			}
			if(rsInsert!=null){
				rsInsert.close();
			}
		}

%>
<jsp:forward page="viewcontact.jsp">
	<jsp:param name="flag" value="yes"/>
	<jsp:param name="contact" value="<%=company %>"/>
</jsp:forward>

</tr>
</table>
</body>
</html>