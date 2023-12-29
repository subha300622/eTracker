<%-- 
    Document   : opportunities
    Created on : Feb 27, 2012, 4:54:15 PM
    Author     : Tamilvelan
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
        String userId       =   request.getParameter("userId");


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
		<td bgcolor="#E8EEF7" align="left"><font size="4" COLOR="#0000FF"> <b>  Opportunity Administration </b></font>
    </td>
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
			rs = st.executeQuery("SELECT OPPORTUNITYID,OPPORTUNITYNAME, ASSIGNEDTO, AMOUNT, CLOSE_DATE,STAGE,PROBABILITY from opportunity where OPPORTUNITYID IN (SELECT DISTINCT OPPORTUNITYID FROM OPPORTUNITY_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '"+start+"' AND '"+end+"' AND COMMENTEDBY='"+userId+"') OR (OPPORTUNITY_OWNER='"+userId+"' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '"+start+"' AND '"+end+"' ) ORDER BY CLOSE_DATE ASC ");
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			
			
%>


<TABLE width="100%" border="0">

	<tr>

		<%
			if(rowcount==0)
			{
%>
		<td>This list shows <%=rowcount%> opportunities worked in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>
		<%
			}
			else
			{
%>
		<td>This list shows <%=rowcount%> opportunities worked in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>
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
					while(rs.next())
					{
                                                i++;
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
		<td width="25%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="<%= request.getContextPath() %>/admin/customer/showOpportunity.jsp?opportunityid=<%=opportunityid%>"><%= StringUtil.encodeHtmlTag(opportunityname)%></A></font></td>
		<td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=GetProjectManager.getUserName(assignedto) %></font></td>
		<td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=dealvalue %></font></td>
		<td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=closedate%></font></td>
		<td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= stage %></font></td>


	</tr>
	<%
					}
				
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
