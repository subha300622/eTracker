<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*,java.text.*"%>
<%
	//Configuring log4j properties

	
	Logger logger = Logger.getLogger("lostOpportunities");


	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
 	response.setHeader("Pragma","no-cache");

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}
     function check(searchOpportuntiy)  {
    if ((searchOpportuntiy.opportunityName.value==null)||(searchOpportuntiy.opportunityName.value==""))
		{
			alert("Please Enter Opportunity Name ")
			searchOpportuntiy.opportunityName.focus()
			return false
		}
                monitorSubmit();
                }
</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%!
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
<form name="searchOpportuntiy" onsubmit="return check(this);"
	action="searchOpportunity.jsp">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b>  Opportunity Asministration </b></font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td align="right"><b>Enter Opportunity Name:</b></td>
		<td align="left"><input type="text" name="opportunityName" maxlength="40"
			size="15"></td>
		<td><input type="submit" id="submit" name="submit" value="Search"></td>
		<td><input type="reset" name="reset" id="reset" value="Reset"></td>
		<td width="25%" border="1" align="right"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
</table>
</form>
<%
	if(request.getParameter("flag")!=null && request.getParameter("flag").equalsIgnoreCase("yes"))
	{
		%>

<table width="100%" align=center border="0" bgcolor="#F9F9F9">
	<tr>
		<td align=center>

		<FONT SIZE="4" COLOR="#33CC33">You have been Successfully
		Moved a Opportunity to Account : </FONT><FONT SIZE="4" COLOR="#0000FF"> <%=request.getParameter("opportunity")%> </FONT></td>
	</tr>
</table>
<%
	}
%>
<%

	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
	try
    {
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);

		if(connection != null)
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT OPPORTUNITYID,OPPORTUNITYNAME, ASSIGNEDTO, AMOUNT, CLOSE_DATE,STAGE,PROBABILITY from opportunity where roleid=2  and upper(stage)=upper('Closed Lost') order by CLOSE_DATE ASC ");
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			pageone=rowcount/15;
			pageremain=rowcount%15;

			if(pageremain>0)
			{
				totalpage=pageone+1;
			}
			else
			{
				totalpage=pageone;
			}
			try
			{
				String requestpag=request.getParameter("manipulation");
				logger.debug("Requested Page:"+requestpag);
				if(requestpag!=null)
				{
					requestpage=Integer.parseInt(requestpag);
					if(requestpage==1)
					{
						presentpage=1;
						rs.beforeFirst();
						logger.debug("Requested page First"+presentpage);
						issuenofrom=1;
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
							extra=issuenoto-rowcount;
							issuenoto=issuenoto-extra;
						}
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
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						else
						{
						    issuenofrom=((presentpage-1)*15+1);
							rs.absolute(issuenofrom-1);
							issuenoto=issuenofrom+14;
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
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);
						logger.debug("Requested page Next"+presentpage);
						issuenoto=issuenofrom+14;
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
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
				}
				else
				{
					presentpage=1;
					issuenofrom=1;
					rs.beforeFirst();
					issuenoto=issuenofrom+14;
					if(issuenoto>rowcount)
					{
					    extra=issuenoto-rowcount;
					    issuenoto=issuenoto-extra;
					}
				}
		   }
		   catch(Exception e)
		   {
		   		logger.error("Exception:"+e);
		   }
			if(request.getParameter("newopportunity")!=null)
			{
%>

<table width="100%" align=center border="0" bgcolor="E8EEF7">
	<tr>
		<td align=center><FONT SIZE="4" COLOR="#33CC33">
		Opportunity has been updated successfully!: </FONT> <FONT SIZE="4"
			COLOR="#0000FF"><%= request.getParameter("opportunityname")%></FONT>
		</td>
	</tr>
</table>
<%
			}
%>
<TABLE width="100%" border="0">
     <tr>
        <td><a	href="<%=request.getContextPath() %>/admin/customer/viewOpportunity.jsp">View Opportunities</a>&nbsp;&nbsp;&nbsp;&nbsp; 
         <b><a href="javascript:void(0)">View Lost Opportunities</a></b>
         </td>
    </tr>
	<tr>

		<%
			if(rowcount==0)
			{
%>
		<td>This list shows &nbsp;<%= "0"%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<%=rowcount%>&nbsp; <b>Lost Opportunities</b> </td>
		<%
			}
			else
			{
%>
		<td>This list shows&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<%=rowcount%>&nbsp; <b>Lost Opportunities</b> </td>
		<%
			}
%>
	</tr>
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="25%"><font><b>Opportunity Name</b></font></TD>
		<TD width="20%"><font><b>Assigned To</b></font></TD>
		<TD width="15%"><font><b>Deal Value</b></font></TD>
		<TD width="15%"><font><b>CloseDate</b></font></TD>
		<TD width="15%"><font><b>Stage</b></font></TD>

	</TR>

	<%
			String opportunityname=null,amount=null,closedate=null,stage=null,probability=null,dealvalue=null;
			int opportunityid=9999,assignedto=0;
			if(rs!=null)
			{
			    for(int i=1;i<=15;i++)
				{
					if(rs.next())
					{
						opportunityid=rs.getInt("opportunityid");
						opportunityname=rs.getString("opportunityname");
						if (opportunityname==null)
								opportunityname="NA";
						assignedto=rs.getInt("ASSIGNEDTO");

						amount=rs.getString("amount");


						probability=rs.getString("PROBABILITY");
						Date dateFormat=rs.getDate("close_date");

						SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");





						if (dateFormat!=null){
								closedate=sdf.format(dateFormat);

							}else{
								closedate="NA";

							}

						stage=rs.getString("stage");
						if (stage==null)
								stage="NA";
						if(probability!=null&&amount!=null ){
							dealvalue=((Integer)((Integer.parseInt(amount)*Integer.parseInt(probability))/100)).toString();
						}else{
							dealvalue="NA";
						}
						if(( i % 2 ) != 0)
		                {
%>
	<tr bgcolor="white" height="21">
		<%
						}
		                else
				        {
%>

	<tr bgcolor="#E8EEF7" height="21">
		<%
						}
%>
		<td width="25%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="viewLostOpportunities.jsp?opportunityid=<%=opportunityid%>"><%= StringUtil.encodeHtmlTag(opportunityname)%></A></font></td>
		<td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=GetProjectManager.getUserName(assignedto) %></font></td>
		<td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=dealvalue %></font></td>
		<td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=closedate%></font></td>
		<td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= stage %></font></td>


	</tr>
	<%
					}
				}
			}
			if(request.getParameter("manipulation")==null && (rowcount/16==0))
			{
%>
	<table align=right>
		<tr>

		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation")==null)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=lostOpportunities.jsp?manipulation=3>Next</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("1"))
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=lostOpportunities.jsp?manipulation=3>Next</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=lostOpportunities.jsp?manipulation=1>First</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3") && issuenoto==rowcount)
			{
%>
	<table align=right>
		<tr>
			<td><a href=lostOpportunities.jsp?manipulation=1>First</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=lostOpportunities.jsp?manipulation=1>First</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=2>Prev</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=3>Next</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=4>Last</a></td>
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
			<td><a href=lostOpportunities.jsp?manipulation=3>Next</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=lostOpportunities.jsp?manipulation=1>First</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=2>Prev</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=3>Next</a></td>
			<td><a href=lostOpportunities.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
		}
    }
	catch(Exception e)
	{
			logger.error(e.getMessage());
			logger.error(e.getMessage());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(st!=null)
			st.close();
        if(connection!=null)
			connection.close();
		logger.debug("Closing JDBC Resources");
	}
%>
</table>
</body>
</html>