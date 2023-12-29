<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,java.util.*,dashboard.*,com.eminent.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="com.pack.MyAuthenticator"%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <script type="text/javascript">
       
	function check()
	{
  		if (confirm("Do you want to upload a File"))
		{
				var attach='yes';
				location = '/eTracker/fileAttach.jsp?attach='+attach
		}
		else
		{
			var attach='no';
			location='/eTracker/fileAttach.jsp?attach='+attach
		}

	}

</script>
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
</head>

<%
		
		Logger logger = Logger.getLogger("newRequest");
		
		String logoutcheck=(String)session.getAttribute("Name");
		if(logoutcheck==null)
		{
			logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>

<%
		}
%>
<jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
<BODY onload="check()">
<%
	if(session.getAttribute("bug") == null){
%>
<%@ include file="../header.jsp"%>
<%
	}
%>

<div align="center">
<center><%@ page
	import="java.sql.*,java.util.Properties,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage"%>
<%@ page language="java"%> <%!
            String to = "";
            String operator=null,sms,mobile,Recipient;
            HashMap<String,String> pmanager=null;
            int roleid=0,currentuser=0;
%> <%

	session.setAttribute("forwardpage","/ResourceRequest/viewMyRequest.jsp");

	String project		= 	request.getParameter("project");
	String pname		=	project.substring(project.indexOf(":"),project.length());
	String projectid	=	project.substring(0,project.indexOf(":"));
	
	String team			= request.getParameter("team");
	String position     = request.getParameter("position");
	String skills		= request.getParameter("skill");
	
	String dueDate		= request.getParameter("duedate");
	String totalyears	= request.getParameter("totalyears");
    String totalmonths	= request.getParameter("totalmonths");
        
	String p1		= request.getParameter("p1");
	String p2		= request.getParameter("p2");
	String p3		= request.getParameter("p3");
	String p4		= request.getParameter("p4");
	String p5		= request.getParameter("p5");
	
	String s1		= request.getParameter("s1");
	String s2		= request.getParameter("s2");
	String s3		= request.getParameter("s3");
	String s4		= request.getParameter("s4");
	String s5		= request.getParameter("s5");
	
	String status	= "Unconfirmed";
	
   

	String projectDetails=ResourceRequest.getProjectDetails();
	int pid		=	Integer.parseInt(projectDetails.substring(0,projectDetails.indexOf(":")));
	int mid		=	Integer.parseInt(projectDetails.substring(projectDetails.indexOf(":")+1,projectDetails.lastIndexOf(":")));
	int manager=	Integer.parseInt(projectDetails.substring(projectDetails.lastIndexOf(":")+1,projectDetails.length()));

        // All request should be assigned to Gopal
        manager     =   212;

	logger.info("PID"+pid);
	logger.info("MID"+pid);
	logger.info("Manager"+manager);
	
	
        // declaring local variables
	int day, month, year;
	
	String requestidFormat = null;
	
	Statement st = null,statementDate = null,stForProject = null, stForType = null, st5 = null;
	ResultSet rs = null,fetchDate = null, rsForProject = null, rsForType = null, rs5 = null;
	Connection connection = null;
        
        int uid=0;
	String firstname=null;
	String lastname=null;
	currentuser=((Integer)session.getAttribute("uid")).intValue();
	
	  java.util.Date d = new java.util.Date();
      Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());
       

	try
	{
			connection =MakeConnection.getConnection();
                        
                        
                        //Generating Request Id using sequence
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			statementDate = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        	    	fetchDate = statementDate.executeQuery("select extract(day from sysdate) as day,extract(month from sysdate) as month,extract(year from sysdate) as year from dual");			
                    	rs = st.executeQuery("select requestid from resourcerequest where createdon like (select to_date(sysdate,'dd-mm-yyyy') from dual)");
			fetchDate.next();
			day = fetchDate.getInt("day");
			month = fetchDate.getInt("month");
			year = fetchDate.getInt("year");
			if(day<10)
				requestidFormat = "R0"+day;
			else
				requestidFormat = "R"+day;
			if(month<10)
				requestidFormat = requestidFormat+"0"+month+year;
			else
				requestidFormat = requestidFormat+month+year;
			if(rs.next())
			{
				Statement seqStatement = connection.createStatement();
				ResultSet seqResultSet = seqStatement.executeQuery("select requestid_seq.nextval as nextvalue from dual");
				
				seqResultSet.next();
				int nextValue = seqResultSet.getInt("nextvalue");
				if(nextValue<10)
				{
					requestidFormat = requestidFormat+"00"+nextValue;
				}
				else if(nextValue>=10 && nextValue <=99)
				{
					requestidFormat = requestidFormat+"0"+nextValue;
				}	
				else
				{
					requestidFormat = requestidFormat+nextValue;
				}
				logger.info("IssueID:\t"+requestidFormat);
				if(seqResultSet!=null)
					seqResultSet.close();
				
				if(seqStatement!=null)
					seqStatement.close();
			}
			else
			{
				Statement dropSeqeunceSt = connection.createStatement();
				boolean b = dropSeqeunceSt.execute("drop sequence requestid_seq");
				logger.info("Sequence has been dropped:"+b);
				ResultSet dropSequence = dropSeqeunceSt.executeQuery("create sequence requestid_seq start with 1 increment by 1 nocache nocycle");
				dropSequence = dropSeqeunceSt.executeQuery("select requestid_seq.nextval as nextvalue from dual");
				dropSequence.next();
				int nextValue = dropSequence.getInt("nextvalue");
				if(nextValue<10)
				{
					requestidFormat = requestidFormat+"00"+nextValue;
				}
				else if(nextValue>=10 && nextValue <=99)
				{
					requestidFormat = requestidFormat+"0"+nextValue;
				}
				else
				{
					requestidFormat = requestidFormat+nextValue;
				}
				logger.info("IssueID:\t"+requestidFormat);
				
				if(dropSequence!=null)
					dropSequence.close();
				
				if(dropSeqeunceSt!=null)
					dropSeqeunceSt.close();
			
			}
			   	
		
	
		
		st5 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs5 = st5.executeQuery("select userid,firstname,lastname from users where roleid=1");
		if(rs5.next()){
			firstname=rs5.getString("firstname");
			session.setAttribute("firstname",firstname);
			lastname=rs5.getString("lastname");
			session.setAttribute("lastname",lastname);
			uid = rs5.getInt("userid");
			session.setAttribute("userid_admin",new Integer(uid));
		}
		
                
        }catch(Exception e){
		logger.error("Exception:"+e);
		logger.error(e.getMessage());
         }finally{
			
			      try{
                                if(rsForProject != null){
                                    rsForProject.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(stForProject != null){
                                    stForProject.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(rsForType != null){
                                    rsForType.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                                try{
                                if(stForType != null){
                                    stForType.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                                
                               try{
                                if(rs != null){
                                    rs.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(st != null){
                                    st.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(fetchDate != null){
                                    fetchDate.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(statementDate != null){
                                    statementDate.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                                
                                try{
                                if(rs5 != null){
                                    rs5.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(st5 != null){
                                    st5.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                                
                                try{
                                if(connection != null){
                                    connection.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
            }
            
            Statement issuestatusSt = null ,fetchProjectManagerSt = null;
            PreparedStatement insertStatus_St = null, insertSeq = null, insertPhase_St = null, psComment = null;
            ResultSet issuestatus = null, fetchProjectManager = null;
            String tempFromCc = "";
          
         try{   
                    connection =MakeConnection.getConnection();
                    connection.setAutoCommit(false);
                    
                    if(dueDate != null){
                    dueDate = dueDate.trim();
                    }
                String storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
		int exp=Integer.parseInt(totalyears);
		int project_id=Integer.parseInt(projectid);
		
		session.setAttribute("theissu",requestidFormat);
                insertSeq = connection.prepareStatement("insert into resourcerequest(requestid,project,team,position,skillset,exp_years,responsibility_p1,responsibility_p2,responsibility_p3,responsibility_p4,responsibility_p5,responsibility_s1,responsibility_s2,responsibility_s3,responsibility_s4,responsibility_s5,createdon,modifiedon,assignedto,createdby,duedate,status,roleid,pid,moduleid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");//CHANGED
		insertSeq.setString(1,requestidFormat);
		
		insertSeq.setInt(2,project_id);
        insertSeq.setString(3,team);
		insertSeq.setString(4,position);
		insertSeq.setString(5,skills);
		
		insertSeq.setInt(6,exp);
//		insertSeq.setInt(7,Integer.parseInt(totalmonths));
		insertSeq.setString(7,p1);
		insertSeq.setString(8,p2);
		insertSeq.setString(9,p3);
		insertSeq.setString(10,p4);
		insertSeq.setString(11,p5);
		insertSeq.setString(12,s1);
		insertSeq.setString(13,s2);
		insertSeq.setString(14,s3);
		insertSeq.setString(15,s4);
		insertSeq.setString(16,s5);
		insertSeq.setTimestamp(17,ts);
		insertSeq.setTimestamp(18,ts);
		insertSeq.setInt(19,manager);
		insertSeq.setInt(20,currentuser);
		insertSeq.setDate(21,java.sql.Date.valueOf(storeDate));
		insertSeq.setString(22,status);
		insertSeq.setInt(23,roleid);
		insertSeq.setInt(24,pid);
		insertSeq.setInt(25,mid);
		insertSeq.executeUpdate();
		
		
 		
		
                
            psComment = connection.prepareStatement("insert into RR_COMMENTS(resourceid,commentedby,comment_date,comments,status,commentedto,duedate) values(?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                    
            pmanager=GetProjectMembers.getAdminDetail();
            String createdby=((Integer)session.getAttribute("uid")).toString();
            psComment.setString(1,requestidFormat);
			psComment.setString(2,createdby);
            psComment.setTimestamp(3,ts);
			psComment.setString(4,"Assigning to PM");
			psComment.setString(5,"Unconfirmed");
			psComment.setString(6,GetProjectManager.getManager("ERM","1.0"));
			psComment.setDate(7,java.sql.Date.valueOf(storeDate));
			psComment.executeUpdate();
                

                //Committing the database
                connection.commit();
                connection.setAutoCommit(true);
                
           }catch(Exception e){
                try{
                    if(connection != null){
                          connection.rollback();
                    }
                }catch(SQLException ex){
                          logger.error("Exception:"+ex);
                          logger.error(ex.getMessage());
                 }
                               
                    logger.error("Exception:"+e);
                    logger.error(e.getMessage());
         }finally{
			
			      try{
                                if(issuestatus != null){
                                    issuestatus.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(fetchProjectManager != null){
                                    fetchProjectManager.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(issuestatusSt != null){
                                    issuestatusSt.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                                try{
                                if(fetchProjectManagerSt != null){
                                    fetchProjectManagerSt.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                                
                               try{
                                if(insertStatus_St != null){
                                    insertStatus_St.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                               
                               try{
                                if(insertSeq != null){
                                    insertSeq.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                              
                                try{
                                if(psComment != null){
                                    psComment.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
                                
                                try{
                                if(connection != null){
                                    connection.close();
                                    }
                                    }catch(SQLException e){
                                    logger.error("Exception:"+e);
                                }
              }

		

                     	
		ArrayList<String> al = dashboard.Project.getDetails(s1+":"+s3);
                ArrayList<String> dateAndTime = CurrentDay.getDateTime();
                                               
		session.setAttribute("resourceId",requestidFormat);
		
                
		String from = tempFromCc;
						
		Session ses1=null;
		Statement statementEmail = null;
		ResultSet resultSetEmail = null;
		try  
		{
				connection =MakeConnection.getConnection();
                                statementEmail = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			
								
				
			
						from = (String)session.getAttribute("theName");
						to="admin@eminenlabs.net";
                                                //Edited By sowjanya
						MimeMessage msg= MakeConnection.getMailConnections();
                                                //Edit end by sowjanya
                                                                        
						msg.setFrom(new InternetAddress(to));
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
						msg.addRecipient(Message.RecipientType.CC, new InternetAddress(to));
						msg.setSubject("Resource Request Created:");
                                                                        
                        	           	String htmlContent 	=   		   "<b><font color=blue >Project Details</font></b><br>" +
                                                           "<table width=100% ><tr  bgcolor=#E8EEF7>"+
                 	                                          	"<td width = 18% ><b>Project</b></td>" +
	                   	                                      	"<td width = 32% >" + pname + "</td>" +
                                                              	"<td width = 18% ><b> Team </b> </td>" +
                                                              	"<td width = 32% >"+ team +"</td>" +
                          	                               "</tr>" + 
                                                           "<tr>"+
                                                           		"<td width   = 18% ><b> Position </b></td>" +
                             	        	                   	"<td width = 32% >" + position + "</td>" +
                                		    	           		"<td width = 18% ><b>Skill Set</b> </td>" +
                                                                "<td width = 32% >" + skills + "</td>" +
                                                           "</tr>" + 
                                                           "<tr  bgcolor=#E8EEF7>"+
                                                           		"<td width   = 18% ><b> Experience </b></td>" +
                                                           		"<td width = 32% >" + totalyears + "</td>" +
                                                                "<td width = 18% ><b>Due Date</b> </td>" +
                                                                "<td width = 32% >" + dueDate + "</td>" +
                                                         	"</tr>" +
                                                            "<tr><td width   = 18% colspan=2><b>Job Responsibilites</b> </td>" +
                                                            	"<td width  = 32% >" + p1 + "</td>" +
                                                               
                                                           	"</tr>" +
                                                            
                                                            "</table><br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;" ;
						msg.setContent(htmlContent,"text/html");
						Transport.send(msg);
					
				}catch(Exception s){
					logger.error("Exception in mail:"+s);
				}finally{
                                        try{
                                            if(resultSetEmail != null){
                                            resultSetEmail.close();
                                            }
                                        }catch(SQLException e){
                                            logger.error("Exception:"+e);
                                         }
                               
                                        try{
                                            if(statementEmail != null){
                                                statementEmail.close();
                                            }
                                        }catch(SQLException e){
                                            logger.error("Exception:"+e);
                                         }
                                         
                                         try{
                                            if(connection != null){
                                                connection.close();
                                            }
                                        }catch(SQLException e){
                                            logger.error("Exception:"+e);
                                         }
                                }
        
              //Sending SMS while creating issue
                try
              	{
                	
                		operator=pmanager.get("operator");
                		if(operator.equals("AIRTEL"))
                    	{
                           		
                            	Recipient=mobile+"@airtelkk.com";
                                //Edited by sowjanya
                              MimeMessage msg= MakeConnection.getMailConnections();   
                              //Edit end by sowjanya
								msg.setFrom(new InternetAddress(from));
                     	        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(Recipient));
                     	        
                    //          msg.addRecipient(Message.RecipientType.TO, new InternetAddress("+919980518397@airtelkk.com"));
                                msg.setSubject("Resource Request Created");
                                msg.setContent("Resource Request Created","text/html");
	 							Transport.send(msg);
        	          	}
       			}catch(Exception sms){
					logger.error("Exception in SMS:"+ sms);
					logger.error(sms.getMessage());
                         }
%> 
<BR>
<BR>
</center>
</div>
</BODY>
</HTML>