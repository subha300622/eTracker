<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
</head>

<body>
<!-- Java Package Import Declarations -->
<%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="javax.mail.*,java.util.Calendar"%>
<%@ page import="com.pack.MyAuthenticator,javax.mail.Authenticator"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page
	import="javax.mail.internet.MimeMessage,java.util.Properties,javax.mail.Message,javax.mail.Session,javax.mail.Transport"%>




<!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->

<!--<jsp:useBean id="Register" class="com.pack.RegisterBean">
	<jsp:setProperty name="Register" property="*"/>
</jsp:useBean>
-->
<!-- Java Coding Starts Here -->

<% 	
	java.util.Date d = new java.util.Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(d);
	//Timestamp ts = new Timestamp(cal.getTimeInMillis());
	Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
	
		//Configuring log4j properties
	
		
		Logger logger = Logger.getLogger("Contact Creation in Admin Module");
		
		Connection  connection = null;

		String leadowner="sales";
		String firstname=request.getParameter("firstname");
		String lastname=request.getParameter("lastname");
		String company=request.getParameter("company");
		String title=request.getParameter("title");
		String leadstatus="open";
		String phone=request.getParameter("phone");
		String mobile=request.getParameter("mobile");
		String email=request.getParameter("email");
		String rating="warm";
		
		String street=request.getParameter("street");
		String city=request.getParameter("city");
		String state=request.getParameter("state");
		String zip=request.getParameter("zip");
		String country=request.getParameter("country");
		String website=request.getParameter("website");
		String leadpotential=request.getParameter("leadpotential");
		String noofemployees=request.getParameter("noofemployees");
		String leadsource=request.getParameter("leadsource");
		String annualrevenue=request.getParameter("annualrevenue");
		String industry=request.getParameter("industry");
        String description=request.getParameter("description");
		
        PreparedStatement ps = null;
		Statement st = null;
		ResultSet rs = null;
		try  
		{
			connection = MakeConnection.getConnection();
			logger.debug("Connection:"+connection);
			if (connection!=null)
			{
					if (lastname!=null && company !=null)
					{

						st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = st.executeQuery("select leadid_seq.nextval from dual");
						if(rs!=null)  
						{
							if(rs.next())  
							{
								int role=0;
			        			int nextValue = rs.getInt("nextval");
								ps=connection.prepareStatement("insert into lead (lead_owner,firstname,lastname,company,title,leadstatus,phone,email,rating,street,city,state,zip,country,website,noofemployees,annualrevenue,leadsource,industry,description,leadid,roleid,mobile,leadpotential,createdon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
								ps.setString(1,StringUtil.fixSqlFieldValue(leadowner));
								ps.setString(2,StringUtil.fixSqlFieldValue(firstname));
								ps.setString(3,StringUtil.fixSqlFieldValue(lastname));
								ps.setString(4,StringUtil.fixSqlFieldValue(company));
								ps.setString(5,StringUtil.fixSqlFieldValue(title));
								ps.setString(6,StringUtil.fixSqlFieldValue(leadstatus));
								ps.setString(7,StringUtil.fixSqlFieldValue(phone));
		                        ps.setString(8,StringUtil.fixSqlFieldValue(email));
								ps.setString(9,StringUtil.fixSqlFieldValue(rating));
		     					ps.setString(10,StringUtil.fixSqlFieldValue(street));
		                        ps.setString(11,StringUtil.fixSqlFieldValue(city));
		                        ps.setString(12,StringUtil.fixSqlFieldValue(state));
		                        ps.setString(13,StringUtil.fixSqlFieldValue(zip));
		                        ps.setString(14,StringUtil.fixSqlFieldValue(country));
		                        ps.setString(15,StringUtil.fixSqlFieldValue(website));
		                        ps.setString(16,StringUtil.fixSqlFieldValue(noofemployees));
		                        ps.setString(17,StringUtil.fixSqlFieldValue(annualrevenue));
		                        ps.setString(18,StringUtil.fixSqlFieldValue(leadsource));
		                        ps.setString(19,StringUtil.fixSqlFieldValue(industry));						
		                        ps.setString(20,StringUtil.fixSqlFieldValue(description));
		                        ps.setInt(21,nextValue);
		                        ps.setInt(22,role);
		                        ps.setString(23,mobile);
		                        ps.setString(24,leadpotential);
		                        ps.setTimestamp(25,ts);
								int x=ps.executeUpdate();
								connection.commit();
								logger.info("Successfully updated!!!"+x);
							}
						}
					}
			}
					
		}
		catch(SQLException Ex)  
		{
				logger.error("Exception While Creating new sales lead:"+Ex);
		}
		finally
		{
			if(ps!=null)
				ps.close();
			if(connection!=null)
			connection.close();
		}
		
		/* Sending SMS while Lead is registered
        
         */
         try{
                   
                        String subject="Eminentlabs Customer Relationship Management";
                        String Recipient=email;
                        String content="<table width='100%'><tr><font color=blue >Dear Sir,</font></tr><br><tr><b><font color=blue >Thanks for registring with our Eminentlabs&#153; Customer Relationship Management!!! Our normal business hours are Monday through Friday, 8am to 5pm and you can expect a response within 48 hours. Thanks again for your inquiry and feel free to contact us if you have any further questions!</font></b></tr><br><tr><font color=blue >Pavithra Morey</tr><tr><font color=blue >Business Development</tr><tr> <font color=blue >Eminentlabs Software Pvt Ltd</tr><tr> <font color=blue >sales@eminentlabs.net</tr></table>";
                           MimeMessage msg= MakeConnection.getMailConnections();   
						msg.setFrom(new InternetAddress("admin@eminentlabs.net"));
                        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(Recipient));
               //          msg.addRecipient(Message.RecipientType.TO, new InternetAddress("+919980518397@airtelkk.com"));
                        msg.setSubject(subject);
                        msg.setContent(content,"text/html");
						Transport.send(msg);
                        logger.info("The SMS has been sent");
                   
         }
         catch(Exception ex)  
{
//	System.err.println("Error while sending an SMS:"+sms);
             logger.error(ex.getMessage());
}  
	
		%>
<jsp:forward page="closeWindow.jsp">
	<jsp:param name="flag" value="true" />
</jsp:forward>
<!-- End of Java Coding -->

</body>

</html>