<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8" import="java.util.*,org.apache.log4j.*,javax.mail.*,javax.mail.internet.*,com.eminent.util.*"%>
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
        Logger logger = Logger.getLogger("updateopportunity");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</TITLE>
</head>
<body>
<table width="100%" bgcolor="#EEEEEE" height="5%" border="0">
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
		<%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*"%>
<%!

       String recipientMobile,recipientOperator,from,subject,host;
%>
		<%
		Connection connection = null;
        PreparedStatement ps=null,ps1=null;
        Statement stInsert=null;
        ResultSet rsInsert=null;
                
        String assignedto=request.getParameter("assignedto");
        String type="";
        String closedate="";
        String amount="";
        String stage="";
        String probability="";
        String leadsource = "";
        String nextstep="";
        String opportunityname="";
        int opportunityid=9999;
        String movetoaccount=null,owner=null;
        int leadrole=2;
        int accountamount=100;
        String meetingDate = null;
        String meetingTime = null;
        
        opportunityid=Integer.parseInt(request.getParameter("opportunityid"));
        opportunityname=request.getParameter("opportunityname");
        
        movetoaccount=request.getParameter("movetoaccount");
        owner=request.getParameter("owner");
		
		type=request.getParameter("type");
		amount=request.getParameter("amount");
		closedate=request.getParameter("closedate");
        stage=request.getParameter("stage");
        probability=request.getParameter("probability");
        leadsource = request.getParameter("leadsource");
        nextstep=request.getParameter("nextstep");
		String description=request.getParameter("description");
                if(description == null){
                    description = "Nil";
                }
                meetingTime = request.getParameter("meetingtime");
                meetingDate = request.getParameter("meetingdate");
                String metDate = com.pack.ChangeFormat.getDateFormat(meetingDate);
		try{
			
			 String storeDate = com.pack.ChangeFormat.getDateFormat(closedate);
			 
			connection=MakeConnection.getConnection();
			if(connection != null)  {
				ps = connection.prepareStatement("update opportunity set assignedto=?,type=?,close_date=?,stage=?,probability=?,amount=?,leadsource=?,nextstep=?, description=?,opportunityname=?,meeting_time=?,meeting_date=? where opportunityid=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ps.setInt(1,Integer.parseInt(assignedto));
				ps.setString(2,StringUtil.fixSqlFieldValue(type));
				ps.setDate(3,java.sql.Date.valueOf(storeDate));
				ps.setString(4,StringUtil.fixSqlFieldValue(stage));
				ps.setString(5,StringUtil.fixSqlFieldValue(probability));
				ps.setString(6,StringUtil.fixSqlFieldValue(amount));
				ps.setString(7,StringUtil.fixSqlFieldValue(leadsource));
				ps.setString(8,StringUtil.fixSqlFieldValue(nextstep));
				ps.setString(9,StringUtil.fixSqlFieldValue(description));
				ps.setString(10,StringUtil.fixSqlFieldValue(opportunityname));
                                ps.setString(11, StringUtil.fixSqlFieldValue(meetingTime));
                                ps.setDate(12, java.sql.Date.valueOf(metDate)); 
				ps.setInt(13,opportunityid);
				ps.executeUpdate();
				connection.commit();
                                
        int x=0;
        
	Integer user = (Integer)session.getAttribute("uid");
        String userId = String.valueOf(user); 
        java.util.Date d = new java.util.Date();


	Calendar cal = Calendar.getInstance();
	cal.setTime(d);
        Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
        
       
        
        String comments = request.getParameter("comments");
	if(comments.length()>0)
	{
		try
		{
				ps = connection.prepareStatement("insert into opportunity_comments(opportunityid,commentedby,comment_date,comments,stage,commentedto,duedate) values(?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ps.setInt(1,opportunityid);
				ps.setString(2,userId);
				ps.setTimestamp(3,ts);
				ps.setString(4,comments);
                ps.setString(5,StringUtil.fixSqlFieldValue(stage));
                ps.setInt(6,Integer.parseInt(assignedto));
                ps.setDate(7,java.sql.Date.valueOf(storeDate));
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
	if(movetoaccount!=null){
		stInsert = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rsInsert = stInsert.executeQuery("select accountid_seq.nextval from dual");
		if(rsInsert!=null)  
		{
			if(rsInsert.next())  
			{
				logger.info("creation of Account ");
				int nextValue = rsInsert.getInt("nextval");
				ps=connection.prepareStatement("insert into account(ACCOUNT_OWNER,ACCOUNTNAME,ASSIGNEDTO,ACCOUNTID,CREATEDON,MODIFIEDON,opportunity_reference,roleid,account_amount) values(?,?,?,?,?,?,?,?,?)");
				ps.setString(1,StringUtil.fixSqlFieldValue(owner));
				ps.setString(2,StringUtil.fixSqlFieldValue(opportunityname));
				ps.setInt(3,Integer.parseInt(assignedto));
				ps.setInt(4,nextValue);
                                ps.setTimestamp(5,ts);
                                ps.setTimestamp(6,ts);
                                ps.setInt(7,opportunityid);
                                ps.setInt(8,leadrole);
                                ps.setInt(9,accountamount);
				ps.executeUpdate();
				
			}
		}
		int roleidUpdate=3;
        ps1 = connection.prepareStatement("update opportunity set roleid=? where opportunityid=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        ps1.setInt(1,roleidUpdate);
        ps1.setInt(2,opportunityid);
        
       int y= ps1.executeUpdate();
       logger.info("lead update "+y);
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
	  			 host = "smtp.gmail.com";
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

	  				subject = "eTracker CRM Opportunity has been Updated :  "  +opportunityname;
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
	               "</tr></table><br><font color=blue><b>Updated CRM Opportunity details</b></font><table width=100% >"+
	                  "<tr bgcolor=#E8EEF7><td width = 18%  ><b>Name</b></td>" +
	                  "<td width = 32% >" +opportunityname+" </td>" +
	                  "<td width = 18% ><b>Stage </b> </td>" +
	                  "<td width = 32% >"+ stage +"</td>" +
	              "</tr>" +
	             
	              "<tr  >"+
	              
	                 
	                  "<td width = 18% ><b>Updated On </b> </td>" +
	                  "<td width = 32% >"+ dateTime.get(0) +"</td>" +
	                  "<td width  = 18% ><b>Updated Time</b> </td>" +
	                    "<td width  = 32%  >" +dateTime.get(1) + "</td>" +
	              "</tr>" +
	              
	             

	               "<tr bgcolor=#E8EEF7>"+
	              		
	               "<td width  = 18% ><b>Close Date</b> </td>" +
		              "<td width = 32% >" +closedate+ "</td>" +
	                
	  			  "<td width  = 18% ><b>Sender</b> </td>" +
	                    "<td width  = 32%  >" + session.getAttribute("fName")+ session.getAttribute("lName") + "</td>" +
	                  
	                "</tr>"+
	           
	                "<tr bgcolor=#E8EEF7><td width  = 18%  ><b>Comments</b> </td>" +
	                    "<td width  = 82% colspan=3 >"+comments+"</td>" +
	                "</tr>";
	                String endLine="</table><br>Thanks,";
                String signature="<br>eTracker&trade;<br>";
                String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak =  "<br>";

                String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

				htmlContent =htmlContent+endLine+signature+emi+lineBreak+htmlTableEnd;
                    SendMail.CRMContacts(htmlContent,subject,Name,assignedto,al.get(0),userId);
	  			
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
	               
		String pag=(String)session.getAttribute("forwardpage");
	logger.info("page to forward"+pag);
	String link=pag;
	
	%>
		<jsp:forward page="<%=link %>" >
			
					<jsp:param name="newopportunity" value="Updated"/>
		</jsp:forward>
		<%
			}
		}
		catch(Exception e)  {
			logger.error(e.getMessage());
	    }finally
		{
			if (ps!=null)
				ps.close();
			if(ps1!=null){
				ps1.close();
			}
			if(stInsert!=null){
				stInsert.close();
			}
			if(rsInsert!=null){
				rsInsert.close();
			}
			if (connection!=null)
				connection.close();
			if(connection.isClosed()){
 				logger.info("Connection is Closed");
 			}
 			else{
 				logger.info("Connection not Closed");	
 			}
		} 
	%>
	</tr>
</table>
<br>
</body>
</html>