<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,org.apache.log4j.*,java.sql.*,com.eminent.resource.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="pack.eminent.encryption.MakeConnection"%><html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <script language="JavaScript">
            function check()
            {
                
                if (confirm("Do you want to upload a File"))
                {
                    var attach = 'yes';
                    location = '/eTracker/fileAttach.jsp?attach=' + attach
                }
                else
                {
                    var attach = 'no';
                    location = '/eTracker/fileAttach.jsp?attach=' + attach
                }

            }
            function printpost(post)
            {
                pp = window.open('UserProfile/profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                pp.focus();
            }
        </script>
    </head>
    <body onload="check()">
        <%
                        //Configuring log4j properties
		
		
                        Logger logger = Logger.getLogger("Update Request");
		
                        Connection connection = null;
                        PreparedStatement ps = null,ps1=null;


                        java.util.Date d = new java.util.Date();
		
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(d);
                        //Timestamp ts = new Timestamp(cal.getTimeInMillis());
                        Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());

        //		String project		= 	request.getParameter("project");
        //		String pname		=	project.substring(project.indexOf(":"),project.length());
        //		String projectid	=	project.substring(0,project.indexOf(":"));
		
        //		String team			= request.getParameter("team");
        //		String position     = request.getParameter("position");
        //		String skills		= request.getParameter("skill");
		
		
        //		String totalyears	= request.getParameter("totalyears");
        //		String totalmonths	= request.getParameter("totalmonths");
		    
        //		String p1		= request.getParameter("p1");
        //		String p2		= request.getParameter("p2");
        //		String p3		= request.getParameter("p3");
        //		String p4		= request.getParameter("p4");
        //		String p5		= request.getParameter("p5");
		
        //		String s1		= request.getParameter("s1");
        //		String s2		= request.getParameter("s2");
        //		String s3		= request.getParameter("s3");
        //		String s4		= request.getParameter("s4");
        //		String s5		= request.getParameter("s5");
		
                        String dueDate		= request.getParameter("duedate");
                        String assi=request.getParameter("assignedto");
                        String status	= request.getParameter("status");
                        String requestid=(String)session.getAttribute("requestid");
                        session.setAttribute("resourceId",requestid);
                        String comments=request.getParameter("comments");
		
                        String uid=((Integer)session.getAttribute("uid")).toString();
		
                        logger.info("Due Date"+dueDate);
                        logger.info("Assignedto"+assi);
                        logger.info("Status"+status);
                        logger.info("requestid"+requestid);
                        logger.info("Time Stamp"+ts);
		
		
		
		
		
                          if(dueDate != null){
                      dueDate = dueDate.trim();
                      }
                  String storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
                  logger.info("Store date"+storeDate);
                 connection=MakeConnection.getConnection();
		
                        try
                        {
                                if(connection!=null){
                                                logger.info("DATE:"+new java.sql.Date(cal.getTimeInMillis()));
                                                ps = connection.prepareStatement("update resourcerequest set duedate=?,assignedto=?,modifiedon=?,status=? where requestid=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                                                ps.setDate(1,java.sql.Date.valueOf(storeDate));
                                                ps.setInt(2,Integer.parseInt(assi));
                                                ps.setTimestamp(3,ts);                
                                                ps.setString(4,status);
			        
                                                ps.setString(5,requestid);
                                                ps.executeUpdate();
                                                logger.debug("updating the issue:");
                                }
                                if(comments.length()>0)
                                {
                                        try
                                        {
                                                        ps1 = connection.prepareStatement("insert into rr_comments(resourceid,commentedby,comment_date,comments,status,commentedto,duedate) values(?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                                                        ps1.setString(1,requestid);
                                                        ps1.setString(2,uid);
                                                        ps1.setTimestamp(3,ts);
                                                        ps1.setString(4,comments);
                                                        ps1.setString(5,status);
                                                        ps1.setString(6,assi);
                                                        ps1.setDate(7,java.sql.Date.valueOf(storeDate));
                                                        ps1.executeUpdate();
						
                                        }
                                        catch(Exception e)
                                        {
                                                logger.error("Exception in Comments:"+e);
                                        }
				
				
                                }	
			
                                String lockId =  request.getParameter("lock");
                                int lock = 0;
                                if(lockId != null) {
                                    lock = Integer.parseInt(lockId);
                        
                         
                                int userId = (Integer)session.getAttribute("userid_curr");
                                int lockedResource = (Integer)session.getAttribute("lockedResource");
                                String reqId = (String)session.getAttribute("reqId");
                                if (lock != lockedResource) {
                                    ResourceCheck.lockResource(reqId, lock, lockedResource, userId, status);
                                } else if ( status.equalsIgnoreCase("Fulfilled")) {
                            
                                    ResourceCheck.doUpdateSelected(reqId, lock, userId);
                                }
                                }
		            
			
                        }
                        catch(Exception e)
                        {
                                logger.error("Exception in issue update:"+e);
                                logger.error(e.getMessage());
                        }
                        finally
                        {
                            if(ps!=null)
                                   ps.close();
                            if(ps1!=null)
                                        ps1.close();
                                if(connection!=null)
                                        connection.close();
			
                        }

        %>
    </body>
</html>