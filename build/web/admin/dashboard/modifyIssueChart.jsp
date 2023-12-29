<%@ page import="org.apache.log4j.*,com.eminent.util.IssueDetails"%>
<%@ page import="javax.mail.*"%>
<%@ page import="java.util.*, com.eminent.validation.StatusValidation"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="com.pack.MyAuthenticator"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page language="java"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<%

			//Configuring log4j properties
		
		
		
			Logger logger = Logger.getLogger("modifyIssueChart");
			
		
			String logoutcheck=(String)session.getAttribute("Name");
			if(logoutcheck==null)
			{
				logger.fatal("================Session expired===================");
				response.sendRedirect( request.getContextPath()+"/SessionExpired.jsp");
			}

	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<LINK title=STYLE
	href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<meta http-equiv="Content-Type" content="text/html ">
<script language="JavaScript">
	function check()
	{
  		if (confirm("Do you want to upload a File"))
		{
				var attach='yes';
				location = 'fileatt.jsp?attach='+attach
		} 
		else
		{
			var attach='no';
			location='fileatt.jsp?attach='+attach
		}
		
	}

	function printpost(post)
	{
		pp = window.open('profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}
</script>
</HEAD>

<BODY onload="check()">
<%@ include file="/header.jsp"%>
<br>
<br>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>

<%
	java.util.Date d = new java.util.Date();

	Calendar cal = Calendar.getInstance();
	cal.setTime(d);
	//Timestamp ts = new Timestamp(cal.getTimeInMillis());
	Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
	Connection connection = null;
	PreparedStatement ps = null;
	Statement stmt1 = null,statementEmail1 = null,statusUpdate=null;
	ResultSet rs1 = null,resultSetEmail1 = null;

	
	String theissu="";

	String fname = (String)session.getAttribute("fName");
	String lname = (String)session.getAttribute("lName");
	String Name  =  fname+" "+lname;
	connection=MakeConnection.getConnection();
	theissu=(String)session.getAttribute("theissu");
	
	
	String severity		= request.getParameter("severity");
	String priority		= request.getParameter("priority");
	String issueStatus 	= request.getParameter("issuestatus");
	String assignedto	= request.getParameter("assignedto");
	String comments		= request.getParameter("comments");
	String fix_version  = request.getParameter("fix_version");
	
	logger.info("SEVERITY:"+severity);
	logger.info("PRIORITY:"+priority);
	logger.info("ISSUESTATUS:"+issueStatus);
	logger.info("ASSIGNEDTO:"+assignedto);
	
	
	
	String issueid = (String)session.getAttribute("theissu");
	logger.info("ISSUEID:"+issueid);
	int x=0,y=0,z=0;

    //Checking the status to make sure that it's a valid
    issueStatus = StatusValidation.isStatusCorrect(issueStatus, issueid);

	if(comments!="")
	{
		try
		{
			ps = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments) values(?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ps.setString(1,issueid);
			ps.setString(2,fname+lname);
			ps.setTimestamp(3,ts);
			ps.setString(4,request.getParameter("comments"));
			x = ps.executeUpdate();
			logger.info("Inserted one row:\t"+x);
		}
		catch(Exception e)
		{
			logger.error("Exception:"+e);
		}
		finally
		{
			if(ps!=null)
				ps.close();
		}
	}
	 try{
                String crId =   request.getParameter("crid");
                String desc =   request.getParameter("criddescription");
                if(crId!=null){
                    IssueDetails.addCRID(issueid, crId, desc, new Timestamp((new java.util.Date()).getTime()), (Integer)session.getAttribute("uid"), issueStatus);
                }
            }
            catch(Exception ex){
                logger.error(ex.getMessage());
            }
	try
	{
		logger.info("DATE:"+new java.sql.Date(cal.getTimeInMillis()));
		ps = connection.prepareStatement("update issue set severity=?,priority=?,assignedto=?,modifiedon=?,fix_version=? where issueid=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ps.setString(1,severity);
		ps.setString(2,priority);
		ps.setString(3,assignedto);                
//		ps.setDate(4,new java.sql.Date(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DATE)));
		ps.setDate(4,new java.sql.Date(cal.getTimeInMillis()));
        ps.setString(5,fix_version);
		ps.setString(6,issueid);
		y = ps.executeUpdate();
		logger.debug("updating the issue:");
	}
	catch(Exception e)
	{
		logger.error("Exception:"+e);
	}
	finally
	{
		if(ps!=null)
			ps.close();
	}
	
	try
	{
		ps = connection.prepareStatement("update issuestatus set status=? where issueid=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ps.setString(1,issueStatus);
		ps.setString(2,issueid);
		z = ps.executeUpdate();
		logger.info("Updated one row:\t"+z);
	}
	catch(Exception e)
	{
		logger.error("Exception:"+e);
	}
	finally
	{
		if(ps!=null)
			ps.close();
	}
		
		
		
		if(x>0 || y>0 || z>0)
		{
			try{
				
				Statement username=connection.createStatement();
				ResultSet res=username.executeQuery("select email from users where userid="+assignedto);
				
				res.next();
				String to = res.getString(1);
				
				logger.info("Mail to"+to);
				
				String subject=request.getParameter("sub");
				String description=request.getParameter("des");
				String customer=request.getParameter("customer");
				String project=request.getParameter("project");
				String version=request.getParameter("version");
				String module=request.getParameter("module");
				String platform=request.getParameter("platform");
				String type=request.getParameter("type");
				
				
				String mail = (String)application.getAttribute("MailServerName");
				String host = mail;
			//	host = "mail.eminentlabs.net";
				String from =(String)session.getAttribute("theName");
				
				
                                
//				prop.put("mail.smtp.host",host);
//				Session ses1=Session.getDefaultInstance(prop,null);
                                //Edited by sowjanya
				      MimeMessage msg= MakeConnection.getMailConnections();
                                      //Edit end by sowjanya
				msg.setFrom(new InternetAddress(from,Name));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//				msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
				msg.setSubject("An eTracker Issue Updated...  Subject of The issue:  " +subject);
				msg.setText("A new eTracker issue has been assigned to you by "+fname+lname+" ("+from+").\n\nDetails are as follows:\n\tIssue Number : " +issueid+"\n\tProduct :  "+project+"\n\tCustomer : "+ customer+"\n\tVersion : "+ version+"\n\tType : "+ type+"\n\tPriority: "+priority+"\n\tSeverity: "+severity+"\n\tSubject :"+subject+"\n\tDescription: "+description+"\n\tModule :"+module+"\n\tPlatform :"+platform);
				Transport.send(msg);
				
			}
			catch(Exception exec)
			{
				logger.error("Exception:"+exec);
			}
                        finally{
                            if(connection!=null)
                                connection.close();
                        }
			%>
<jsp:forward page="/admin/dashboard/displayIssue.jsp">
	<jsp:param name="issuestatus" value="yes" />
</jsp:forward>
<%
			

		}

%>
</BODY>
</HTML>





