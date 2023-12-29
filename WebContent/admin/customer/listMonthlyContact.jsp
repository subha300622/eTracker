<%-- 
    Document   : listMonthlyContact
    Created on : 27 May, 2010, 9:37:21 AM
    Author     : ADAL
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*,java.util.HashMap,java.util.ArrayList,java.util.Calendar,java.util.GregorianCalendar"%>
<%


	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache");
	//Configuring log4j properties



	Logger logger = Logger.getLogger("Listmonthlycontact");
	

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
<TITLE>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS
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
            location = 'listMonthlyContact.jsp?month='+month+'&year='+year;
        }else{
            alert("You can view Contacts from Aug 2008 to Current Month");
        }
    }


</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%!
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
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
<%@ include file="/header.jsp"%>

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
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Contact
		Administration</b> </font>
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
                        rs = st.executeQuery("SELECT contactid,FIRSTNAME,LASTNAME,ACCOUNTNAME,TITLE,PHONE,MOBILE,EMAIL,CREATEDON,DUEDATE,ASSIGNEDTO,CONTACT_OWNER,MODIFIEDON from CONTACT where to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"' order by DUEDATE ASC ");
                          


			rs.last();
			int rowcount=rs.getRow();
                        if(rowcount == 0){
                            %>


<table align="center" height="70%">
	<tr>
		<td align="left">
		<h3>No contacts are available</h3>
		</td>
	</tr>

</table>

<%
                        }else{
                        	%>

                       <%

			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			%>

<br>
<table>
    <tr><td>This list shows <%=rowcount%> contacts created in the month of <b><%=monthSelect.get(month)%> <%=year%></b></td></tr>
</table>
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="20%"><font><b>Name</b></font></TD>
		<TD width="13%"><font><b>Account</b></font></TD>
		<TD width="11%"><font><b>Phone</b></font></TD>
		<TD width="18%"><font><b>Email</b></font></TD>
		<TD width="12%"><font><b>Owner</b></font></TD>
		<TD width="8%"><font><b>Due Date</b></font></TD>
		<TD width="13%"><font><b>Assigned To</b></font></TD>
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>

	</TR>

	<%
			int contactid=9999,age=0;
			String fname="",lname="",title="",account="",email="",phone="",mobile=null,fullname="",createdon=null,duedate=null,assignedTo=null,owner=null;


			if(rs!=null)
			{
			    for(int i=1;i<=15;i++)
				{
					if(rs.next())
					{
						contactid=rs.getInt("contactid");
						fname=rs.getString("firstname");
						if (fname==null)
							fname="";
						lname=rs.getString("lastname");
						if (lname==null)
							lname="";
                                                fullname=fname+" "+lname;
						title=rs.getString("title");
						if (title==null)
							title="nil";
						account=rs.getString("accountname");
						if (account==null)
							account="nil";
						email=rs.getString("email");
						if (email==null)
							email="";
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

						mobile=rs.getString("mobile");


                        Date dueDateFormat	 = rs.getDate("duedate");

                        String dueDate = "NA";
                        if(dueDateFormat != null){

                            dueDate = sdf.format(dueDateFormat);
                        }

                        String typ		= rs.getString("assignedto");
                        assignedTo="NA";
                        if(typ!=null){
                        	assignedTo    = GetProjectManager.getUserName(Integer.parseInt(typ));
                        }

                        String own		= rs.getString("contact_owner");
                        owner="NA";
                        if(own!=null){
                        	owner    = GetProjectManager.getUserName(Integer.parseInt(own));
                        }

						Date modifiedOn = rs.getDate("modifiedon");

						String modified = "NA";
                        if(modifiedOn != null){

                        	modified = sdf.format(modifiedOn);
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
                                                if (fullname.length()<25)
                                                    {
%>
		<td width="20%" title="<%= StringUtil.encodeHtmlTag(title) %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="showContact.jsp?contactid=<%=contactid%>"><%= fullname %></A></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                        %>
		<td width="20%" title="<%= StringUtil.encodeHtmlTag(title) %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="showContact.jsp?contactid=<%=contactid%>"><%= fullname.substring(0,22)+"..."%></A></font></td>
		<%
                                                        }
                                                        %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(account) %></font></td>

		<td width="11%" title="Mobile No. <%=  mobile%>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= phone %></font></td>
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
		<%if (owner.length()<15)
                                                    {
 		%>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(owner) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= owner.substring(0,15)+"..." %></font></td>
		<%
                                                            }
                                                            %>
		<TD width="8%" title="Last Modified On <%= modified %>"><font><%=dueDate %></font></TD>
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