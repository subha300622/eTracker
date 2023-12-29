<%--
    Document   : viewCreatedIssues
    Created on : Feb 3, 2012, 10:30:53 PM
    Author     : Tamilvelan
--%>
<%@page  import="java.util.Calendar,java.util.GregorianCalendar"%>
<%@page  import="org.apache.log4j.Logger"%>
<%@page  import="com.eminentlabs.appraisal.AppraisalIssues"%>
<%@page import="com.eminent.util.GetProjectMembers,com.eminent.util.IssueDetails" %>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil" %>
<%@page import="com.eminent.customer.CustomerUtil" %>
<%@page import="dashboard.CheckDate" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.ArrayList,java.util.HashMap,java.util.Collection,java.util.Iterator" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
        Logger logger           =   Logger.getLogger("");
        String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
        String period   =(String)session.getAttribute("period");
        logger.info("Period-->"+period);
        int userId      =   Integer.parseInt(request.getParameter("appUser"));
        String start   =   period.substring(0, period.indexOf('*'));
        String end     =   period.substring(period.indexOf('*')+1,period.length() );
        String startMonth  =   start.substring(0, start.indexOf('-'));
        String endMonth  =   end.substring(0, end.indexOf('-'));

        String startYear  =   start.substring(start.indexOf('-')+1, start.length());
        String endYear  =   end.substring(end.indexOf('-')+1, end.length());

        int stMonth     =   (Integer.parseInt(startMonth));
        if(stMonth<10){
            startMonth  =   "0"+stMonth;
        }

        int enMonth     =   (Integer.parseInt(endMonth));
        if(enMonth<10){
            endMonth  =   "0"+enMonth;
        }

        Calendar cal = new GregorianCalendar();
        cal.set(Calendar.YEAR,Integer.parseInt(endYear) );
        cal.set(Calendar.MONDAY,enMonth);
        int maxday=cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        String startDate    =   "01-"+monthName[stMonth]+"-"+startYear;
        String endDate      =   maxday+"-"+monthName[enMonth]+"-"+endYear;
        String issueDetails[][]     =   IssueDetails.displayIssues(userId, startDate, endDate, "Created");
        int rowcount                    =   issueDetails.length,age=0;
%>

       <table border="0" width="100%">
	<TR bgcolor="#C3D9FF" align="left">
		
		<td width="9%"><font><b>Issue No</b></font></td>
		<td width="3%" TITLE="Priority"><font><b>P</b></font></td>
		<td width="10%"><font><b>Project</b></font></td>
                <td width="7%"><font><b>Module</b></font></td>
		<td width="25%"><font><b>Subject</b></font></td>
		<td width="9%"><font><b>Status</b></font></td>
		<td width="8%"><font><b>Due Date</b></font></td>
		<td width="9%"><font><b>AssignedTo</b></font></td>
		<td width="7%"><font><b>Refer</b></font></td>
		<td width="5%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></td>
	</TR>
        <tr>
            <td colspan="10" style='font-size: 11px;font-weight: bold;'>This list shows <%=rowcount%> created issues </td>
        </tr>
	<%
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

        
	for(int i=0;i<rowcount;i++)
	{

				String iss 		= issueDetails[i][0];
                                String project1         = issueDetails[i][1];
				String type             = issueDetails[i][2];
                                String status           = issueDetails[i][3];
                                String sub		= issueDetails[i][4];
                                String desc             = issueDetails[i][5];
				String pri		= issueDetails[i][6];
				String sev		= issueDetails[i][7];
                                String createdBy	= issueDetails[i][8];
                                String createdOn        = issueDetails[i][9];
                                String assignedTo       = issueDetails[i][10];
                                String modifiedOn       = issueDetails[i][11];
                                String dueDateFormat    = issueDetails[i][12];
                                String rating           = issueDetails[i][13];
                                String feedback         = issueDetails[i][14];
                                String module           = issueDetails[i][15];
                                String fullModule       =   module;
                                if(module.length()>10){
                                    module  =   module.substring(0, 7)+"...";
                                }
                                if(sub.length()>42){
                                    sub  =   sub.substring(0, 40)+"...";
                                }
                                if(rating==null){
                                    rating  =   "NA";
                                }
                                int current = Integer.parseInt(assignedTo);
                                String p = "NA";
                                if(pri != null){
                                    p = pri.substring(0,2);
                                }

				assignedTo=GetName.getUserName(assignedTo);
				assignedTo=assignedTo.substring(0,assignedTo.indexOf(" ")+2);

				session.setAttribute("theissno",iss);

                                String dueDate  =   "NA";
                                if(dueDateFormat != null){
                                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                                }


                                String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
                                String create=sdf.format(dateConversion.parse(createdOn));

			String s1="S1- Fatal";
			String s2="S2- Critical";
			String s3="S3- Important";
			String s4="S4- Minor";


      //                                  age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
 //                           logger.info("Calculated time........"+i);
                                //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                            age =   CustomerUtil.getIssueAge(create, status, dateString1);
                if(( i % 2 ) != 0)
                {
%>
	<tr bgcolor="#E8EEF7" height="23" align="left">
		<%
                }
                else
                {
%>

	<tr bgcolor="white" height="23" align="left">
		<%
                }
%>


                
		<td width="9%" TITLE="<%= type %>"><a
        HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss %>
		</font></a></td>
                <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= p %> </font></td>
		<%

										if(project1.length()<15)
										{
										    %>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1 %></font></td>
		<%
										}
										else
										{
										    %>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0,15)+"..." %></font></td>
		<%
										}
									%>
                <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%=module%></font></td>
		<td id="<%=iss %>tab" onmouseover="xstooltip_show('<%=iss %>', '<%=iss %>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss %>');" ><div class="issuetooltip" id="<%=iss %>"><%= desc %></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub %></font></td>
		<%

                        String color="";

                        if(status.equalsIgnoreCase("Closed")){

                            if(rating.equalsIgnoreCase("Excellent")){
                                color   = "#336600";

                            }else if(rating.equalsIgnoreCase("Good")){
                                color   = "#33CC66";

                            }else if(rating.equalsIgnoreCase("Average")){
                                color   = "#CC9900";

                            }else if(rating.equalsIgnoreCase("Need Improvement")){
                                color   = "#CC0000";

                            }
                            if(feedback==null){
                                feedback="";
                            }
                        }

                %>

                <td width="9%" bgcolor="<%=color%>" title="<%=feedback%>"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= status %> </font></td>
		<%

                                                            if(  (status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)){

                                                            %>
		<td width="8%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate %></font>
		</td>
		<%
                                                            }else if((status.equalsIgnoreCase("Closed")&& (CheckDate.getClosedIssueFlag(dueDate,dateString1) == true))){

                                                                 %>
		<td width="8%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate %></font>
		</td>
		<%
                                                            }
                                                            else{
                                                            %>
		<td width="8%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate %></font>
		</td>
		<%
                                                            }
                                                            %>
                <td width="9%" title="Created By <%=GetName.getUserName(createdBy)%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
		</font></td>
                <%
                    int fileCount   =   IssueDetails.displayFiles(iss);
                if(fileCount>0){%>
                <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><A HREF="<%=request.getContextPath()%>/issueUpdateFile.jsp?issueid=<%=iss%>">ViewFiles(<%=fileCount%>)</A></font></td>
                <%}else{%>
		<td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000">No Files</font></td>
                <%}%>
		<td width="5%" align=center><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= age %></font>
		</td>
	</tr>

	<%
	}

 %>

    </table>
