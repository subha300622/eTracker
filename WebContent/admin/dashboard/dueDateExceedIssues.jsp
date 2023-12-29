<%-- 
    Document   : dueDateExceedIssues
    Created on : 27 Jun, 2010, 9:36:50 AM
    Author     : Tamilvelan
--%>


<%@ page import="org.apache.log4j.Logger,com.eminent.timesheet.CreateTimeSheet"%>
<%@ page import="java.sql.*, dashboard.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="com.eminent.util.*"%>
<%@ page import="java.util.*, java.text.*, com.pack.*"%>

<%

	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties

	

	Logger logger = Logger.getLogger("dueDateExceedIssues");
	

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

<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
                <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script><script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/tooltip.js"></script>
</HEAD>

<BODY>

<jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>



<%@ include file="/header.jsp"%>






<%
        int age;
        try {
                String projectId = request.getParameter("pid");
                if (projectId == null) {
                    projectId = (String) session.getAttribute("pid");
                } else {
                    session.setAttribute("pid", projectId);
                }
                HashMap<Integer, String> member = GetProjectMembers.showUsersSName();

                String issueDetails[][] = IssueDetails.dueDateExceededIssues(projectId);
                int rowcount = issueDetails.length;
%>

<div align="center">
<center>
    <br>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b> Due Date Exceeded Issues </b></font><FONT
			SIZE="3" COLOR="#0000FF"> </FONT>
                   


	</tr>
</table>
    <br>

<table width="100%">
	<tr height="10">
            <td align="left" width="100%">This list shows <b><%=GetProjects.getProjectName(projectId).replace(":"," v")%></b> due date exceeded issues. Total due date exceeded issues are <b> <%=rowcount%>.
		</b></td>
		<TD align="right" width="25">Severity</td>
		<TD align="right" width="25" bgcolor="#FF0000">S1</TD>
		<TD align="right" width="25" bgcolor="#FF9900">S2</TD>
		<TD align="right" width="25" bgcolor="#FFFF00">S3</TD>
		<TD align="right" width="25" bgcolor="#33FF33">S4</TD>
	</tr>
</table>
<br>
<table width="100%" height="23">
	<TR bgcolor="#C3D9FF">
		<TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
		<TD width="10%"><font><b>Issue No</b></font></TD>
		<TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
		<TD width="12%"><font><b>Project</b></font></TD>
                <TD width="7%"><font><b>Module</b></font></TD>
		<TD width="29%"><font><b>Subject</b></font></TD>
		<TD width="9%"><font><b>Status</b></font></TD>
		<TD width="9%"><font><b>Due Date</b></font></TD>
		<TD width="10%"><font><b>AssignedTo</b></font></TD>
		<TD width="7%"><font><b>Refer</b></font></TD>
                <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

	</TR>

	<%
                        String totalissuenos = "";
                            for (int i = 1; i < rowcount; i++) {


                                totalissuenos = totalissuenos + "'" + issueDetails[i][0].trim() + "',";

                            }
                            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                            if (totalissuenos.contains(",")) {
                                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                            }
                            for (int i = 0; i < rowcount; i++) {

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
                                    module  = module.substring(0, 10)+"...";
                                }
                                if(sub.length()>42){
                                    sub =sub.substring(0,42)+"...";
                                }
                                int currentass =0;
                                if(assignedTo!=null){
                                 currentass = Integer.parseInt(assignedTo);
                                }
                                String p = "NA";
                                if(pri != null){
                                    p = pri.substring(0,2);
                                }

				assignedTo=member.get(currentass);
				if(createdBy!=null){
                                    createdBy=member.get(Integer.parseInt(createdBy));
                                }

				session.setAttribute("theissno",iss);
                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
				SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

                                String dueDate  =   "NA";
                                if(dueDateFormat != null){
                                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                                }


                                String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
			String s1="S1- Fatal";
			String s2="S2- Critical";
			String s3="S3- Important";
			String s4="S4- Minor";
                        logger.info("Processing data........"+i);

                        //                age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
   //                         logger.info("Calculated time........"+i);
                                //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                                    age=0;           
                                    if(issueDetails[i][16]!=null){
                                        age = Integer.valueOf(issueDetails[i][16]);
                                    }
                                    
                                    int lastAsigneeAge =1;
                                    if(lastAsigneeAgeList.containsKey(iss)){
                                            lastAsigneeAge=lastAsigneeAgeList.get(iss);
                                    }
                                    if (lastAsigneeAge == 1) {
                                        lastAsigneeAge = age;
                                    }
                                    if (lastAsigneeAge == 0) {
                                        lastAsigneeAge = lastAsigneeAge + 1;
                                    }
                if(( i % 2 ) != 0)
                {
%>
	<tr bgcolor="#E8EEF7" height="23">
		<%
                }
                else
                {
%>

	<tr bgcolor="white" height="23">
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
		<td width="10%" TITLE="<%= type %>"><A
        HREF="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=iss%>"> <font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss %>
		</font></A></td>
                <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= p %> </font></td>
		<%

										if(project1.length()<15)
										{
										    %>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1 %></font></td>
		<%
										}
										else
										{
										    %>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0,15)+"..." %></font></td>
		<%
										}
									%>
                <td title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>
                <td id="<%=iss %>tab" onmouseover="xstooltip_show('<%=iss %>', '<%=iss %>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss %>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc %></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub %></font></td>

		<td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><%= status %> </font></td>
		<%

                                                            if(  (status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)){

                                                            %>
		<td width="9%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate %></font>
		</td>
		<%
                                                            }else if((status.equalsIgnoreCase("Closed")&& (CheckDate.getClosedIssueFlag(dueDate,dateString1) == true))){
                                                                 %>
		<td width="9%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate %></font>
		</td>
		<%
                                                            }
                                                            else{
                                                            %>
		<td width="9%" title="Last Modified On <%= dateString1 %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate %></font>
		</td>
		<%
                                                            }
                                                            %>
		<td width="10%" title="Created By <%= createdBy %>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
		</font></td>
               <%
                    int fileCount = 0;
                            if (fileCountList.containsKey(iss)) {
                                    fileCount = fileCountList.get(iss);
                                }
                if(fileCount>0){%>
                <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#"
>ViewFiles(<%=fileCount%>)</A></font></td>
                <%}else{%>
		<td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif"
			size="1" color="#000000">No Files</font></td>
                <%}
                        

                %>
                <td title="<%=lastAsigneeAge%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font></td>
	</tr>
<%
}


}
	catch(Exception e)
	{
		logger.error("Exception:"+e);
                logger.error(e.getMessage());
	}
       



%>
</table>

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
