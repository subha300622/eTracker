<%-- 
    Document   : listMonthlyAccount
    Created on : 22 Jun, 2010, 3:24:17 PM
    Author     : ADAL
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,org.apache.log4j.*,pack.eminent.encryption.*,java.text.*,com.eminent.util.*,java.util.Calendar,java.util.GregorianCalendar"%>
<%
	//Configuring log4j properties

	
	Logger logger = Logger.getLogger("ViewUser");
	


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
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
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
            location = 'listMonthlyAccount.jsp?month='+month+'&year='+year;
        }else{
            alert("You can view Account from Aug 2008 to Current Month");
        }
    }


</script>
</head>
<body>
<jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" />
<%@ page import="java.sql.*,java.util.HashMap"%>
<%!
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
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
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b> Account Administration </b></font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT>
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
			rs = st.executeQuery("SELECT ACCOUNTID,ACCOUNTNAME,BILLINGSTATE,PHONE,TYPE,DUEDATE,ACCOUNT_AMOUNT,ASSIGNEDTO,CREATEDON,OPPORTUNITY_REFERENCE from account where to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"' order by DUEDATE ASC ");
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
		<td>This list shows <%=rowcount%> accounts created in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>
		<%
			}
			else
			{
%>
		<td>This list shows <%=rowcount%> accounts created in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td>
		<%
			}
%>
	</tr>
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="20%"><font><b>Account Name</b></font></TD>
		<TD width="10%"><font><b>Billing State</b></font></TD>
		<TD width="12%"><font><b>Phone</b></font></TD>
		<TD width="10%"><font><b>Type</b></font></TD>
		<TD width="10%"><font><b>Deal Value</b></font></TD>
		<TD width="13%"><font><b>Account Value</b></font></TD>
		<TD width="12%"><font><b>Assigned To</b></font></TD>
		<TD width="8%"><font><b>Due Date</b></font></TD>
		<TD width="5%"><font><b>Age</b></font></TD>

	</TR>

	<%
			String accountname=null,billingstate=null,type=null,phone=null,duedate=null,account_amount=null,createdon=null,opportunity_reference=null,dealValue=null;
			int accountid=9999,assignedto=0,age=0;
			if(rs!=null)
			{
			    for(int i=1;i<=15;i++)
				{
					if(rs.next())
					{
						accountid=rs.getInt("accountid");
						accountname=rs.getString("accountname");
						if (accountname==null)
							accountname="";
						billingstate=rs.getString("billingstate");
						if (billingstate==null)
							billingstate="nil";
						type=rs.getString("type");
						if (type==null || type.equals("--Select One--"))
							type="nil";
						phone=rs.getString("phone");
						if (phone==null)
							phone="nil";

						SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
						Date createdOn=rs.getDate("createdon");
						if(createdOn!=null){
							createdon=sdf.format(createdOn);
							age=GetAge.getContactAge(connection,createdon);
							createdon=((Integer)age).toString();
						}else{
							createdon="NA";
						}
						 Date dueDateFormat	 = rs.getDate("duedate");

	                        String dueDate = "NA";
	                        if(dueDateFormat != null){

	                            dueDate = sdf.format(dueDateFormat);
	                        }


						String amount = "NA";
						account_amount=rs.getString("account_amount");

						if(amount!=null){
							amount=account_amount;
						}

						assignedto=rs.getInt("assignedto");

						opportunity_reference=rs.getString("opportunity_reference");

						if(opportunity_reference!=null){
							dealValue=CRMIssue.getOpportunityValue(connection,Integer.parseInt(opportunity_reference));
						}
						else{
							dealValue="NA";
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
		<td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="showAccount.jsp?accountid=<%=accountid%>"><%= StringUtil.encodeHtmlTag(accountname)%></A></font></td>
		<td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(billingstate) %></font></td>
		<td width="12%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(phone) %></font></td>
		<td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(type) %></font></td>
		<td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=dealValue %></font></td>
		<td width="13%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= amount%></font></td>
		<td width="12%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= GetProjectManager.getUserName(assignedto) %></font></td>
		<td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate %></font></td>
		<td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= createdon %></font></td>

	</tr>
	<%
					}
				}
			}
			
		}
    }
	catch(Exception e)
	{
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