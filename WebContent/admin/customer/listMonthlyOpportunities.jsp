<%-- 
    Document   : listMonthlyOpportunities
    Created on : 22 Jun, 2010, 3:24:01 PM
    Author     : ADAL
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*,java.text.*,java.util.*"%>
<%
	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("listMonthlyOpportunity");
	

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
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</TITLE>
<script type="text/javascript">

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
            location = 'listMonthlyOpportunities.jsp?month='+month+'&year='+year;
        }else{
            alert("You can view Opportunities from Aug 2008 to Current Month");
        }
    }


</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%!
		String start,end;
		int i,year,month;

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
<%!
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%
String selectYear = request.getParameter("year");
        String selectMonth = request.getParameter("month");

         //calculating start and end date of this month
                                Calendar cal = new GregorianCalendar();
                                int currentYear  = cal.get(Calendar.YEAR);
                                int currentMonth = cal.get(Calendar.MONTH);
                                int currentDay   = cal.get(Calendar.DAY_OF_MONTH);

        //        logger.info("Selected Year"+selectYear);
        //        logger.info("Selected Month"+selectMonth);
                 year=0;
                 month=0;
                int maxday=30;
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
         //       logger.info("Year"+year);
         //       logger.info("Month"+monthSelect.get(month));

         //       logger.info("MAX DAY of MOnth"+maxday);
                start="1"+"-"+monthSelect.get(month)+"-"+year;
                end=maxday+"-"+monthSelect.get(month)+"-"+year;



%>
<%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%">
	<tr  bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" align="left"><font size="4" COLOR="#0000FF"> <b>  Opportunity Asministration </b></font>
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
                    <input type="button" id="button" value="Submit" onclick="monthSelection()"></td>
		</tr>
</table>


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
			rs = st.executeQuery("SELECT OPPORTUNITYID,OPPORTUNITYNAME, ASSIGNEDTO, AMOUNT, CLOSE_DATE,STAGE,PROBABILITY from opportunity where to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"' order by CLOSE_DATE ASC ");
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
%>


<TABLE width="100%" border="0">
    
	<tr>

		<%
			if(rowcount==0)
			{
%>
		<td>This list shows <%=rowcount%> opportunities created in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>
		<%
			}
			else
			{
%>
		<td>This list shows <%=rowcount%> opportunities created in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>
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
						java.util.Date dateFormat=rs.getDate("close_date");

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
							dealvalue=((Long)((Long.parseLong(amount)*Integer.parseInt(probability))/100)).toString();
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
		<td width="25%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="showOpportunity.jsp?opportunityid=<%=opportunityid%>"><%= StringUtil.encodeHtmlTag(opportunityname)%></A></font></td>
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
			<td><a href=viewOpportunity.jsp?manipulation=3>Next</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewOpportunity.jsp?manipulation=3>Next</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewOpportunity.jsp?manipulation=1>First</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=viewOpportunity.jsp?manipulation=1>First</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=viewOpportunity.jsp?manipulation=1>First</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=3>Next</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewOpportunity.jsp?manipulation=3>Next</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewOpportunity.jsp?manipulation=1>First</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=3>Next</a></td>
			<td><a href=viewOpportunity.jsp?manipulation=4>Last</a></td>
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
