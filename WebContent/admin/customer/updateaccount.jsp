<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8" import="java.util.*,org.apache.log4j.*,com.eminent.util.*"%>
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
        Logger logger = Logger.getLogger("updateaccount");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
</head>
<body>
<table width="100%" bgcolor="#EEEEEE" valign="right" height="5%"
	border="0">
	<tr>
		<td align="left" width="800"><b><font size="3"
			COLOR="#0000FF"> Current User: </font></b> <FONT SIZE="3" COLOR="#0000FF">
		&nbsp; <b> &nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%></b></FONT></td>
		<td width="6%" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <a
			href="<%=request.getContextPath() %>/profile.jsp">Profile</a></font></td>
		<td width="6%" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <A
			HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A></font></td>
		<%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*,javax.mail.*,javax.mail.internet.*"%>
<%!

       String recipientMobile,recipientOperator,from,subject,host;
%>
		<%
		
		java.util.Date d = new java.util.Date();

		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		//Timestamp ts = new Timestamp(cal.getTimeInMillis());
		Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
		
		Connection connection = null;
        PreparedStatement ps=null;
        int accountid=9999;
        String accountname="";
		String parentaccount="";
		String type="";
		String industry="";
		String employees="";
                String phone="";
                String fax="";
                String website="";
                String annualrevenue = "";
                
		String billingstreet="";
		String shippingstreet="";
		String billingcity="";
		String billingstate="";
		String billingcountry="";
		String billingzip="";
		String shippingcity="";
		String shippingstate="";
		String shippingcountry="";
		String shippingzip="";

		accountid=Integer.parseInt(request.getParameter("accountid"));
		accountname=request.getParameter("accountname");
		parentaccount=request.getParameter("parentaccount");
		phone=request.getParameter("phone");
		fax=request.getParameter("fax");
		website=request.getParameter("website");
		type=request.getParameter("type");
		industry=request.getParameter("industry");
		employees=request.getParameter("employees");
                type=request.getParameter("type");
                annualrevenue=request.getParameter("annualrevenue");
		String description=request.getParameter("description");
                if(description == null){
                    description = "Nil";
                }
		billingstreet=request.getParameter("billingstreet");
		billingzip=request.getParameter("billingzip");
		billingstate=request.getParameter("billingstate");
		billingcity=request.getParameter("billingcity");
		billingcountry=request.getParameter("billingcountry");
		shippingstreet=request.getParameter("shippingstreet");
		shippingzip=request.getParameter("shippingzip");
		shippingstate=request.getParameter("shippingstate");
		shippingcity=request.getParameter("shippingcity");
		shippingcountry=request.getParameter("shippingcountry");
		
		String assignedto=request.getParameter("assignedto");
		
		String duedate=request.getParameter("duedate");
		String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);

		String account_amount=request.getParameter("accountamount");
		
		try{
			connection=MakeConnection.getConnection();
			if(connection != null)  {
				ps = connection.prepareStatement("update account set parentaccount=?, phone=?, fax=?, website=?, type=?, industry=?, employees=?, annualrevenue=?, description=?, billingstreet=?, shippingstreet=?, billingcity=?, shippingcity=?,billingzip=?, shippingzip=?, billingstate=?, shippingstate=?, billingcountry=?, shippingcountry=?, accountname=?,assignedto=?,duedate=?,modifiedon=?,account_amount=? where accountid=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ps.setString(1,StringUtil.fixSqlFieldValue(parentaccount));
				ps.setString(2,StringUtil.fixSqlFieldValue(phone));
				ps.setString(3,StringUtil.fixSqlFieldValue(fax));
				ps.setString(4,StringUtil.fixSqlFieldValue(website));
				ps.setString(5,StringUtil.fixSqlFieldValue(type));
				ps.setString(6,StringUtil.fixSqlFieldValue(industry));
				ps.setString(7,StringUtil.fixSqlFieldValue(employees));
				ps.setString(8,StringUtil.fixSqlFieldValue(annualrevenue));
				ps.setString(9,StringUtil.fixSqlFieldValue(description));
				ps.setString(10,StringUtil.fixSqlFieldValue(billingstreet));
				ps.setString(11,StringUtil.fixSqlFieldValue(shippingstreet));
				ps.setString(12,StringUtil.fixSqlFieldValue(billingcity));
				ps.setString(13,StringUtil.fixSqlFieldValue(shippingcity));
				ps.setString(14,StringUtil.fixSqlFieldValue(billingzip));
				ps.setString(15,StringUtil.fixSqlFieldValue(shippingzip));
				ps.setString(16,StringUtil.fixSqlFieldValue(billingstate));
				ps.setString(17,StringUtil.fixSqlFieldValue(shippingstate));
				ps.setString(18,StringUtil.fixSqlFieldValue(billingcountry));
				ps.setString(19,StringUtil.fixSqlFieldValue(shippingcountry));
				ps.setString(20,StringUtil.fixSqlFieldValue(accountname));
				ps.setInt(21,Integer.parseInt(assignedto));
                ps.setDate(22,java.sql.Date.valueOf(storeDate));
                ps.setTimestamp(23,ts);
                ps.setInt(24,Integer.parseInt(account_amount));
				ps.setInt(25,accountid);
				ps.executeUpdate();
				connection.commit();
                                
                                
        int x=0;
        
	Integer user = (Integer)session.getAttribute("uid");
        String userId = String.valueOf(user); 
      


	    
        String comments = request.getParameter("comments");
	if(comments.length()>0)
	{
		try
		{
				ps = connection.prepareStatement("insert into account_comments(accountid,commentedby,commentedto,duedate,comment_date,comments) values(?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ps.setInt(1,accountid);
				ps.setString(2,userId);
				ps.setString(3,assignedto);
				ps.setDate(4,java.sql.Date.valueOf(storeDate));
				ps.setTimestamp(5,ts);
				ps.setString(6,comments);
				x = ps.executeUpdate();
				logger.info("Inserted one row:\t"+x);
		}
		catch(Exception e)
		{
			logger.error("Exception in Comments:"+e);
		}
		
		finally
		{
			if(ps!=null)
				ps.close();
			logger.debug("Comments are not empty");
		}
	}	
	Session ses1=null;
    ResultSet res=null;
    Statement username=null;
	  try{
	  			
	  			 username=connection.createStatement();
	  			 res=username.executeQuery("select email,mobile,mobileoperator from users where userid="+assignedto);
	  			
	  			res.next();
	  			String to                 = res.getString(1);
	  			 recipientMobile    = res.getString(2);
	               recipientOperator = res.getString(3);
	                          
	                             /* Eliminating hyphen in mobile no*/
	                               recipientMobile=recipientMobile.replaceAll("-","");
	  			
	  			logger.info("Mail to"+to);
	                          logger.info("Mail to Mobile "+recipientMobile);
	  			logger.info("Mail to Mobile Operator"+recipientOperator);
	                          
	  			
	                       
	  			
	  			
//	  			String mail = (String)application.getAttribute("MailServerName");
	  			
	                       //   host = "mail.eminentlabs.net";
	  			 from =(String)session.getAttribute("theName");
	  			
	  			 ArrayList<String> al       = dashboard.Project.getDetails("CRM"+":"+"1.0");
	                           ArrayList<String> dateTime = dashboard.CurrentDay.getDateTime();                        
	                                                  
	                                                  String createdOn    = (String)session.getAttribute("createdOn");
	                                                  String foundVersion = (String)session.getAttribute("foundVersion");
	                                                  String fixVersion   = (String)session.getAttribute("fixVersion");
	                                                  
	  			
                                                          
	  				String fnme=(String)session.getAttribute("fName");
	  				String lname=(String)session.getAttribute("lName");
                    String Name =   fnme+lname;

	  				MimeMessage msg= MakeConnection.getMailConnections();
	  				msg.setFrom(new InternetAddress(from,Name));
	  				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//	  				msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
	  				msg.setSubject("eTracker CRM Account has been Updated :  "  +accountname);
	  				String htmlContent =    "<b><font color=blue >Project Details</font></b><table width=100% >" +
	                  "<tr bgcolor=#E8EEF7 ><td width = 18% ><b>Project</b></td>" +
	                  "<td width = 32% >CRM</td>" +
	                  "<td width = 18% ><b> Customer </b> </td>" +
	                  "<td width = 32% >Eminentlabs Software Pvt Ltd</td>" +
	              "</tr>" + 
	              "<tr><td width   = 18% ><b> Version </b></td>" +
	                    "<td width = 32% >1.0</td>" +
	                    "<td width = 18% ><b>Manager</b> </td>" +
	                    "<td width = 32% >" + GetProjectManager.getUserName(Integer.parseInt(al.get(0))) + "</td> " +
	              "</tr>" + 
	              "<tr  bgcolor=#E8EEF7><td width   = 18% ><b> Status </b></td>" +
	                    "<td width = 32% >" + al.get(4) + "</td>" +
	                    "<td width = 18% ><b>Phase</b> </td>" +
	                    "<td width = 32% >" + al.get(1) + "</td> " +
	              "</tr>" + 
	              "<tr><td width   = 18% ><b>Start Date</b> </td>" +
	                   "<td width  = 32% >" + al.get(2) + "</td>" +
	                   "<td width  = 18% ><b>End Date</b> </td>" +
	                    "<td width = 32% >" + al.get(3) + "</td>" +
	               "</tr></table><br><font color=blue><b>Updated CRM Account details</b></font><table width=100% >"+
	                  "<tr bgcolor=#E8EEF7><td width = 18%  ><b>Name</b></td>" +
	                  "<td width = 32% >" +accountname+" </td>" +
	                  "<td width = 18% ><b>Website </b> </td>" +
	                  "<td width = 32% >"+ website +"</td>" +
	              "</tr>" +
	             
	              "<tr  >"+
	              
	                 
	                  "<td width = 18% ><b>Updated On </b> </td>" +
	                  "<td width = 32% >"+ dateTime.get(0) +"</td>" +
	                  "<td width  = 18% ><b>Updated Time</b> </td>" +
	                    "<td width  = 32%  >" +dateTime.get(1) + "</td>" +
	              "</tr>" +
	              
	             

	               "<tr bgcolor=#E8EEF7>"+
	              		
	               "<td width  = 18% ><b>Due Date</b> </td>" +
		              "<td width = 32% >" +storeDate+ "</td>" +
	                
	  			  "<td width  = 18% ><b>Sender</b> </td>" +
	                    "<td width  = 32%  >" + session.getAttribute("fName")+ session.getAttribute("lName") + "</td>" +
	                  
	                "</tr>"+
	           
	                "<tr><td width  = 18%  ><b>Comments</b> </td>" +
	                    "<td width  = 82% colspan=3 >"+comments+"</td>" +
	                "</tr>"+
	                "</table><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;" ;
	                                  				msg.setContent(htmlContent,"text/html");
	  			Transport.send(msg);
	  			
	  		}
	  		catch(Exception exec)
	  		{
	  			logger.error("Exception in Sending Mail:"+exec);
	  		}
             finally
            {
            if (res!=null)
				res.close();
            if (username!=null)
				username.close();
             }
	                  /*
	                         Sending SMS while Updating issue
	                                  
	                  */
	                   try{
	                            if(recipientOperator.equals("AIRTEL"))
	                            {
	                                     subject="eTracker CRM Account has been Updated. SUBJECT:"+accountname;
	                                     String Recipient=recipientMobile+"@airtelkk.com";
	                                        
	                                   MimeMessage msg= MakeConnection.getMailConnections();                                      
	  				  msg.setFrom(new InternetAddress(from));
	                                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(Recipient));

	                                    msg.setSubject("CRM Account Updated :" +subject);
	                                    msg.setContent(subject,"text/html");
	  				  Transport.send(msg);
	                                    logger.info("The SMS has been sent");
	                            }
	                    }
	                    catch(Exception sms)  
	                    {
                     logger.error("Error while sending an SMS:"+sms);
	                    }  
	%>
		<jsp:forward page="/admin/customer/viewaccount.jsp" />
		<%
			}
		}
		catch(Exception e)  {
			out.println("DONE EXCEPTION" +e);
	    }finally
		{
			if (ps!=null)
				ps.close();
			if (connection!=null)
				connection.close();
		} 
	%>
	</tr>
</table>
<br>
</body>
</html>