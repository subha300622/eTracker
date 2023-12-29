<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*, dashboard.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="com.eminent.util.*"%>
<%@ page import="java.util.*, java.text.*, com.pack.*"%>

<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties
	Logger logger = Logger.getLogger("UsersWorkedIssues");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script>
    function monthSelection(){

        var date=1;
        var startMonth=7;
        var startYear =2008;

        var startRange = new Date(startYear,startMonth,date);

        var month   =   document.getElementById("month").value;
        var year    =   document.getElementById("year").value;
        var selectedValue= new Date(year,month,date);
        var current_date = new Date();
        if(selectedValue>=startRange &&selectedValue<=current_date ){
            document.getElementById('button').value = 'Processing';
            document.getElementById('button').disabled = true;
            location = "<%= request.getContextPath() %>/admin/user/UsersWorkedIssues.jsp?month="+month+"&year="+year;
        }else{
            alert("You can view TimeSheet from Aug 2008 to Current Month");
        }
    }
</script>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
</HEAD>

<BODY>

<%!
		Connection  connection;
		Statement state,state1;
		PreparedStatement psforissuedetails;
		ResultSet result;
		ResultSet rs;
		String start,end;
		int i;
		private static HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();
	    
	    static{
	    
	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");	
	    
	}
	%>

<jsp:useBean id="RightsSetup" scope="page"
	class="com.pack.RightsSetupBean" />
<jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>



<%@ include file="/header.jsp"%>




<jsp:useBean id="MyIssue" class="com.pack.UpdateIssueBean"></jsp:useBean>

<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
	int userid_curri,age;
	HashMap hm;
	String workeduserid;
%>

<%

	
	//Statement stmt=null;
	PreparedStatement pt=null,pt1=null,pt2=null,ps = null;
	ResultSet rs1=null,rs2=null,rs3=null;
	try
	{
	
		
		
		connection=MakeConnection.getConnection();
		
		if(hm==null)
		{
                        logger.info("Calling users");
			hm	= MyIssue.showUsers(connection);
		}
	
		logger.debug("SIZE:"+hm.size());

		if(request.getParameter("userId")==null){
			workeduserid =(String)session.getAttribute("WorkedIssueUser");
		}
		else{
			workeduserid=request.getParameter("userId");
			session.setAttribute("WorkedIssueUser",workeduserid);
		}
		logger.info("worked User:"+workeduserid);
	
	
	
	//calculating start and end date of this month
		Calendar cal = new GregorianCalendar();
                         
        int year = cal.get(Calendar.YEAR);             
        int month = cal.get(Calendar.MONTH);         
        int maxday=cal.getActualMaximum(cal.DAY_OF_MONTH);
        
        logger.info("Year"+year);
        logger.info("Month"+monthSelect.get(month));
       
        logger.info("MAX DAY of MOnth"+maxday);
       
        logger.info("Start Date"+start);
        logger.info("End Date"+end);

        int currentYear  = cal.get(Calendar.YEAR);

        String selectYear = request.getParameter("year");
        String selectMonth = request.getParameter("month");
      
       
        if(selectYear==null || selectYear.equals("")){
                 year = currentYear;
                 month = cal.get(Calendar.MONTH);
                 maxday=cal.get(Calendar.DAY_OF_MONTH);
        }else{
            year =Integer.parseInt(selectYear);
            month=Integer.parseInt(selectMonth);

             Calendar cale=Calendar.getInstance();
             cale.set(year, month, 1);
             maxday = cale.getActualMaximum(Calendar.DATE);
        }
        start="1"+"-"+monthSelect.get(month)+"-"+year;
        end=maxday+"-"+monthSelect.get(month)+"-"+year;

        String selectedStartDate = "01-"+(month+1)+"-"+year+" 00:00:00";
        String selectedEndDate = maxday+"-"+(month+1)+"-"+year+" 23:59:59";

        logger.info("Selected Start Date"+selectedStartDate);
        logger.info("Selected End Date"+selectedEndDate);
	
	String query="select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(comment_date, 'DD-Mon-YY') between '"+start+"' and '"+end+"' and commentedto='"+workeduserid+"'and commentedby='"+workeduserid+"' order by modifiedon desc";
	ps = connection.prepareStatement( query,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs= ps.executeQuery();
	rs.last();
	
	rowcount=rs.getRow();
	rs.beforeFirst();

	pageone=rowcount/150;
	pageremain=rowcount%150;
			
			if(pageremain>0)
			{
				totalpage=pageone+1;
			}
			else
			{
				totalpage=pageone;	
			}
			logger.debug("Total no of pages"+totalpage);
			try
			{
				String requestpag=request.getParameter("manipulation");
				logger.debug("Requested page"+requestpag);
				if(requestpag!=null)
				{
					requestpage=Integer.parseInt(requestpag);
					if(requestpage==1)
					{
						presentpage=1;
						issuenofrom=1;
						issuenoto=issuenofrom+149;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
						rs.beforeFirst();
						logger.debug("Requested page First"+presentpage);					
					}
					if(requestpage==2)
					{
						presentpage=presentpage-1;
						if(presentpage<=0)
						{
							presentpage=1;
						}
						if(presentpage==1)
						{
							rs.beforeFirst();
							issuenofrom=1;
							issuenoto=issuenofrom+149;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						else
						{
						    issuenofrom=((presentpage-1)*150+1);
							rs.absolute(issuenofrom-1);	
							issuenoto=issuenofrom+149;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}						
						}
						logger.debug("Requested page Prev"+presentpage);					
					}
					if(requestpage==3)
					{
						presentpage=presentpage+1;
						if(presentpage>=totalpage)
						{
							presentpage=totalpage;
						}
						issuenofrom=((presentpage-1)*150+1);
						rs.absolute(issuenofrom-1);	
						logger.debug("Requested page Next"+presentpage);		
						issuenoto=issuenofrom+149;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}				
					}
					if(requestpage==4)
					{
					
						presentpage=totalpage;
						logger.debug("Requested page Last"+presentpage);			
						issuenofrom=((presentpage-1)*150+1);
						rs.absolute(issuenofrom-1);	
						issuenoto=issuenofrom+149;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
				}
				else
				{
					logger.info("In the else part");
                    presentpage=1;
					if(rowcount>0)
                    {
                           issuenofrom=1;
                    }
                    else
                    {
                        issuenofrom=0;
                     }
					
					issuenoto=issuenofrom+149;
					if(issuenoto>rowcount)
					{
					    extra=issuenoto-rowcount;
					    issuenoto=issuenoto-extra;
					}
				}
			}
			 catch(Exception e)
			 {
				 logger.error(e.getMessage());
			}

		
%>

<div align="center">
<center>

<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b> Issues Worked by <%=GetName.getUserName(workeduserid)%> in the month of  </b></font>
                        <select name="month" id="month">
                         <%

                            for(int k=0;k<monthSelect.size();k++){
                                    if(k==month){
                                     %>
                                     <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                     <%
                                    }

                                }
%>

                    </select>

                    <%
                        ArrayList<Integer> selectYears=new ArrayList<Integer>();
                        int startYear = 2008;

                        while(startYear<=currentYear){
                            selectYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='year' id='year' >
                        <%
                        for(int k=0,selected=2008;k<selectYears.size();k++,selected++){
                                    if(selected==year){
                                     %>
                                     <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>
                    <input type="button" id="button" value="Submit" onclick="monthSelection()">
                </td>

	</tr>
</table>
<br>
<br>

<table width="100%">
	<tr height="10">
		<td align="left" width="100%">This list shows <b> <%=rowcount %>
		</b>issues are worked by <%=GetName.getUserName(workeduserid)%> in the month of <b><%=monthSelect.get(month)%> <%=year%></b>.</td>
		<td align="left" width="100%">Issues</td>
		<TD align="right" width="25"><%=issuenofrom%></td>
		<TD align="right" width="25">-</td>
		<TD align="right" width="25"><%=issuenoto%></td>


		<TD align="right" width="25">Severity</td>
		<TD align="right" width="25" bgcolor="#FF0000">S1</TD>
		<TD align="right" width="25" bgcolor="#FF9900">S2</TD>
		<TD align="right" width="25" bgcolor="#FFFF00">S3</TD>
		<TD align="right" width="25" bgcolor="#33FF33">S4</TD>
	</tr>
</table>
<br>
<TABLE width="100%" height="23">
	<TR bgcolor="#C3D9FF">
		<TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
		<TD width="11%"><font><b>Issue No</b></font></TD>
		<TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
		<TD width="13%"><font><b>Project</b></font></TD>
		<TD width="29%"><font><b>Subject</b></font></TD>
		<TD width="9%"><font><b>Status</b></font></TD>
		<TD width="9%"><font><b>Due Date</b></font></TD>
		<TD width="13%"><font><b>CreatedBy</b></font></TD>
		<TD width="7%"><font><b>Refer</b></font></TD>
		<TD width="5%" TITLE="In Hours" ALIGN="CENTER"><font><b>Time</b></font></TD>
	</TR>

	<%	
	
	
	if(rs!=null)
	{
	for(i=1;i<=150;i++)
	{
		if(rs.next())
		{
			
		String issuedetailsquery="select issueid, pname as project, type, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date from issue i, project p where issueid='"+rs.getString("issueid")+"' and i.pid = p.pid";
		psforissuedetails= connection.prepareStatement( issuedetailsquery,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs1=psforissuedetails.executeQuery();
	if(rs1!=null)
	{
	   
			if(rs1.next())
			{
				String iss 		= rs1.getString("issueid");
				String type             = rs1.getString("type");
                                String project1         = rs1.getString("project");
                                String sub		= rs1.getString("subject");
                                String desc             = rs1.getString("description");
				String sev		= rs1.getString("severity");
				String pri		= rs1.getString("priority");
                                String p = "NA";
                                if(pri != null){
                                    p = pri.substring(0,2);
                                }
				String createdBy			= rs1.getString("createdby");
				createdBy=GetName.getUserName(createdBy);
				createdBy=createdBy.substring(0,createdBy.indexOf(" ")+2);
				int current = rs1.getInt("assignedto");

				//int ass1		= rs1.getInt("assignedto");
				java.util.Date createdon  = rs1.getDate("createdon");
				
				session.setAttribute("theissno",iss);
                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
				java.util.Date dueDateFormat	 = rs1.getDate("due_date");
                            
                                String dueDate = "NA";
                                if(dueDateFormat != null){
                                    dueDate = sdf.format(dueDateFormat);
                                }
				java.util.Date   modifiedon1 = rs1.getDate("modifiedon");
				
                                String dateString1 = sdf.format(modifiedon1);
                                String create=sdf.format(createdon);
			

//				String createdBy = (String)hm.get(typ);

//				logger.info(hm);
//				logger.debug("CreatedBy:"+createdBy);
				//String assignedto1 = (String)hm.get(ass1);
			

			
			
			
			String s1="S1- Fatal";
			String s2="S2- Critical";
			String s3="S3- Important";
			String s4="S4- Minor";
			
                        String theissno=(String)session.getAttribute("theissno");
			String sql1="select status from issuestatus where issueid='"+theissno+"' ";
			pt1=connection.prepareStatement(sql1,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs2=pt1.executeQuery();
			if(rs2!=null)
			{
		  		while(rs2.next())
				{
					String sta=rs2.getString("status");
	//				age=GetAge.getIssueAge(connection,create,sta,dateString1);
                                        age=WorkedTime.getHoldingTime(theissno, workeduserid, selectedStartDate, selectedEndDate);
                if(( i % 2 ) != 0)                    
                {
%>
	<tr bgcolor="white" height="23">
		<%
                }
                else
                {
%>
	
	<tr bgcolor="#E8EEF7" height="23">
		<%
                }
%>


		<% if(sev.equals(s1)){%>
		<td width="1%" bgcolor="#FF0000"></td>
		<%}else if(sev.equals(s2)){%>
		<td width="1%" bgcolor="#FF9900"></td>
		<%}else if(sev.equals(s3)){%>
		<td width="1%" bgcolor="#FFFF00"></td>
		<%}else if(sev.equals(s4)){%>
		<td width="1%" bgcolor="#00FF40"><br>
		</td>
		<%} %>
		<td width="11%" TITLE="<%= type %>"><A
        HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss %>
		</font></A></td>
		<td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= p %> </font></td>
		<%
									
										if(project1.length()<15)
										{
										    %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1 %></font></td>
		<%
										}
										else
										{
										    %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0,15)+"..." %></font></td>
		<%
										}
									%>

		<%
									
										if(sub.length()<42)
										{
										    %>
		<td width="29%" TITLE="<%= StringUtil.escapeHtmlTag(desc) %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub %></font></td>
		<%
										}
										else
										{
										    %>
		<td width="29%" TITLE="<%= StringUtil.escapeHtmlTag(desc) %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub.substring(0,42)+"..." %></font></td>
		<%
										}
									%>

		<td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= sta %> </font></td>
		<%
                                                            if( (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)){

                                                            %>
		<td width="9%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate %></font>
		</td>
		<%
                                                            }else{
                                                            %>
		<td width="9%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate %></font>
		</td>
		<%
                                                            }
                                                            %>
		<td width="13%"  title="Assigned To <%= (String)hm.get(current) %>"
><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=createdBy%>
		</font></td>
		<%
							
							int count1=1;
							String sql2="select fileid,filename from fileattach where issueid='"+theissno+"' ";
							pt2=connection.prepareStatement(sql2,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
							rs3=pt2.executeQuery();
							if(rs3 != null)
							{
					 			if(rs3.next())
								 {
					        		
									count1++;
%>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"> <A
			onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles</A></font></td>
		<%								}
							}
							if(rs3!=null)
							{
								rs3.close();
							}
							if(pt2!=null)
							{
								pt2.close();
							}
							if (count1==1)
							{
%>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000">No Files</font></td>
		<%
							}
							%>
		<td width="5%" align=center><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age %></font>
		</td>
	</tr>
	<%
					}
					}
			if(rs2!=null)
			{
				rs2.close();
			}
			if(pt1!=null)
			{
				pt1.close();
			}
		}
	
	if(rs1!=null)
	{
		rs1.close();
	}
	if(pt!=null)
	{
		pt.close();
	}
		}
	}
	}
	}
}
	catch(Exception e)
	{
		logger.error("Exception:"+e);
	}
	finally
	{
//		state.close();
//		state1.close();
//		pt.close();
//		pt1.close();
//		pt2.close();
//		rs1.close();
//		rs2.close();
//		rs3.close();
//		result1.close();
//		result.close();
                if(connection!=null)
                  {
                        connection.close();
  //                      logger.info("Connection Close in My Assignment");
                  }
	}
	
	
%>
</table>
<%

	if(request.getParameter("manipulation")==null && (rowcount/16==0))
	{
		%> <%
	}

	else if(request.getParameter("manipulation")==null)
	{
	    %>
<table align=right>
	<tr>
<!--
		<td>First</td>
		<td>Prev</td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=3>Next</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=4>Last</a></td>
-->
	</tr>
</table>
<%
		
	}
	else if(request.getParameter("manipulation").equals("4"))
	{
	    %>
<table align=right>
	<tr>
<!--
		<td><a href=UsersWorkedIssues.jsp?manipulation=1>First</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=2>Prev</a></td>
		<td>Next</td>
		<td>Last</td>
-->
	</tr>
</table>
<%
	}
	else if(request.getParameter("manipulation").equals("1"))
	{
	    %>
<table align=right>
	<tr>
 <!--
		<td>First</td>
		<td>Prev</td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=3>Next</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=4>Last</a></td>
-->
	</tr>
</table>
<%
	}

	else if(request.getParameter("manipulation").equals("3") && issuenoto==rowcount)
	{
	    %>
<table align=right>
	<tr>
<!--
		<td><a href=UsersWorkedIssues.jsp?manipulation=1>First</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=2>Prev</a></td>
		<td>Next</td>
		<td>Last</td>
-->
	</tr>
</table>
<%
		
	}
	else if(request.getParameter("manipulation").equals("3"))
	{
	    %>
<table align=right>
	<tr>
<!--		<td><a href=UsersWorkedIssues.jsp?manipulation=1>First</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=2>Prev</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=3>Next</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=4>Last</a></td>
-->
	</tr>
</table>
<%
		
	}
	else if(request.getParameter("manipulation").equals("2") && issuenofrom == 1)
	{
	    %>
<table align=right>
	<tr>
		<td>First</td>
		<td>Prev</td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=3>Next</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=4>Last</a></td>
	</tr>
</table>
<%
		
	}
	else if(request.getParameter("manipulation").equals("2"))
	{
	    %>
<table align=right>
	<tr>
		<td><a href=UsersWorkedIssues.jsp?manipulation=1>First</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=2>Prev</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=3>Next</a></td>
		<td><a href=UsersWorkedIssues.jsp?manipulation=4>Last</a></td>
	</tr>
</table>
<%
		
	}



%>
</center>
</div>
<div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Attached Files</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div id="IssuePopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

            </div>
        </div>
    </div>

</BODY>
</HTML>

