<%-- 
    Document   : leads
    Created on : Feb 27, 2012, 4:53:53 PM
    Author     : Tamilvelan
--%>
<%@ page import="java.util.*,org.apache.log4j.*,pack.eminent.encryption.*,java.util.Calendar,java.text.*,com.eminent.util.*"%>
<%
        response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache");
	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("listMonthlyLead");
	

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
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
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>

<%@ include file="/header.jsp"%>


<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Lead
		Administration</b> </font>
</td>
	</tr>
</table>


<%





	Connection  connection = null;
	Statement st=null;
	PreparedStatement pt=null;
	ResultSet rs=null;


	String rating=request.getParameter("rating");

	logger.info("Rating"+rating);
	try
    {
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);

		if(connection != null)
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                        rs = st.executeQuery("SELECT LEADID,TITLE,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,MOBILE,EMAIL,LEADSTATUS,RATING,DUEDATE,ASSIGNEDTO,CREATEDON,MODIFIEDON,LEAD_OWNER from lead where LEADID IN (SELECT DISTINCT LEADID FROM LEAD_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '"+start+"' AND '"+end+"' AND COMMENTEDBY='"+userId+"') OR (LEAD_OWNER='"+userId+"' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '"+start+"' AND '"+end+"' ) ORDER BY UPPER(FIRSTNAME) ASC");

			rs.last();
			int rowcount=rs.getRow();
                        if(rowcount == 0){
                            %>

<table align="center" height="70%">

	<tr>
		<td>
		<h3>No leads are available</h3>
		</td>
	</tr>
</table>

<%
                        }else{
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
			
%>


<TABLE width="100%" border="0">
	<tr>


		<%
			if(rowcount==0)
			{
%>

		<%
			}
			else
			{
%>
		<td>This list shows <%=rowcount%> leads worked in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>


	</tr>

</TABLE>
<br>

<table width=100%>
	<TR bgColor="#C3D9FF" height="9">


		<TD width="18%"><font><b>Lead Name</b></font></TD>
		<TD width="13%"><font><b>Company</b></font></TD>
		<TD width="12%"><font><b>Phone</b></font></TD>
		<TD width="13%"><font><b>Email</b></font></TD>
		<TD width="12%"><font><b>Lead Status</b></font></TD>
		<TD width="9%"><font><b>Due Date</b></font></TD>
		<TD width="13%"><font><b>Assigned To</b></font></TD>
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>

	</TR>

	<%
			String firstname=null,lastname=null,company=null,state=null,email=null,leadstatus=null,phone=null,duedate=null,assignedTo=null,createdon=null,owner=null,mobile=null,title=null,rate=null;
			int leadid=9999,age=0;
			if(rs!=null)
			{
					while(rs.next())
					{
                                            i++;
						leadid=rs.getInt("leadid");
						title=rs.getString("TITLE");

						firstname=rs.getString("firstname");

						lastname=rs.getString("lastname");

						company=rs.getString("company");

						state=rs.getString("state");

						email=rs.getString("email");

						leadstatus=rs.getString("leadstatus");

						phone=rs.getString("phone");

						mobile=rs.getString("mobile");


						SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

						java.util.Date createdOn=rs.getDate("createdon");

						if(createdOn!=null){
							createdon=sdf.format(createdOn);
							age=GetAge.getContactAge(connection,createdon);
							createdon=((Integer)age).toString();
						}else{
							createdon="NA";
						}
						java.util.Date dueDateFormat	 = rs.getDate("duedate");

                        String dueDate = "NA";
                        if(dueDateFormat != null){

                            dueDate = sdf.format(dueDateFormat);
                        }

                        String typ		= rs.getString("assignedto");
                        assignedTo="NA";
                        if(typ!=null){
                        	assignedTo    = GetProjectManager.getUserName(Integer.parseInt(typ));
                        }

                        String own		= rs.getString("lead_owner");
                        owner="NA";
                        if(own!=null){
                        	owner    = GetProjectManager.getUserName(Integer.parseInt(own));
                        }

						java.util.Date modifiedOn = rs.getDate("modifiedon");

						String modified = "NA";
                        if(modifiedOn != null){

                        	modified = sdf.format(modifiedOn);
                        }


						rate=rs.getString("rating");




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


                        String name=firstname+" "+lastname;
                        if(name.length()<26)
                        {
                        %>
		<td width="18%" title="<%=  title%>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
			HREF="<%= request.getContextPath() %>/admin/customer/showLead.jsp?leadid=<%=leadid%>"><%= StringUtil.encodeHtmlTag(name)%></A></font></td>
		<%
                        }
                        else
                        {
                        %>
		<td width="18%" title="<%=  title%>"><A HREF="<%= request.getContextPath() %>/admin/customer/showLead.jsp?leadid=<%=leadid%>"><%=name.substring(0,25)+"..." %></A></td>

		<%
                        }
                        if(company.length()<20)
                        {
                        %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(company)%></font></td>
		<%
                        }
                        else
                        {
                        %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=company.substring(0,20)+"..." %></font></td>

		<%
                        }


                        %>

		<td width="12%" title="Mobile No. <%=  mobile%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(phone) %></font></td>
		<%if (email.length()<20)
		  {
		 %>
		<td width="18%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>
		<%
		  }else
          {
          %>
		<td width="18%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0,20)+"..." %></font></td>
		<%
          }
        %>


		<td width="12%" title="Rating : <%= rate %>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(leadstatus) %></font></td>

		<TD width="9%" title="Last Modified On <%= modified %>"><font><%=dueDate %></font></TD>
		<TD width="13%"><font><%=assignedTo %></font></TD>
		<td width="5%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=createdon%></font></td>





	</tr>
	<%
					}
				
			}


			
			



			
			}
                        }
		}
    }
	catch(Exception e)
	{
	//		System.err.println(e.getMessage());
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