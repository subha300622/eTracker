<%-- 
    Document   : viewRequestDetails
    Created on : 19 Aug, 2011, 9:49:33 AM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"  pageEncoding="UTF-8"%>
<%@ page import="com.pack.*,java.util.*,org.apache.log4j.*,java.sql.*,pack.eminent.encryption.*,java.text.*,com.eminent.util.*,com.eminent.resource.*, com.pack.eminent.applicant.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
		

		Logger logger = Logger.getLogger("editRequest");
		
		String logoutcheck=(String)session.getAttribute("Name");
		if(logoutcheck==null)
		{
			logger.fatal("==============Session Expired===============");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		}

%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<script language="JavaScript">
function KillBrowser()
{
	opener.focus();
        self.close();
}
</script>
<meta http-equiv="Content-Type" content="text/html ">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
<script language=javascript	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script language=javascript	src="<%= request.getContextPath() %>/eminentech support files/validateResourceRequest.js"></script>
<script language="JavaScript">

    function createRequest(){
		var reqObj = null;
		try {
		   reqObj = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (err) {
		   try {
			reqObj = new ActiveXObject("Microsoft.XMLHTTP");
		   }
		   catch (err2) {
				try {
				   reqObj = new XMLHttpRequest();
				}
				catch (err3) {
				  reqObj = null;
				}
	   		}
		}
		return reqObj;
	}

    function validateLock() {
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null) {

            var lockArray = document.getElementsByName("lock");
            var index;

            for(i = 0;i < lockArray.length;i++) {
                if(lockArray[i].checked == true) {
                    index = i;
                }
            }

            var lock = lockArray[index].value;

            xmlhttp.open("GET","validateLock.jsp?apId="+lock+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = lockAlert;
            xmlhttp.send(null);
        }
	}


	function lockAlert() {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {

                var due = xmlhttp.responseText.split(",");
                var flag = due[1];

                if(flag != 'yes'){

                	var lockArray = document.getElementsByName("lock");
                    var index;

                    for(i = 0;i < lockArray.length;i++) {
                        if(lockArray[i].checked == true) {
                            index = i;
                        }
                    }
                    alert("This applicant has been locked by another member before you lock");

                    theForm.lock[index].checked = false;


                }

          	}
    	}
	}


    function textCounter(field,cntfield,maxlimit)
    {
		if (field.value.length > maxlimit)
		{
			field.value = field.value.substring(0, maxlimit);
                    alert('Comments size is exceeding 2000 characters');
		}
		else
			cntfield.value = maxlimit - field.value.length;
	}



</script>
</head>
<body>
<table align="center" width="100%" cellpadding="0" cellspacing="0">
	<tr>

            <td width="145" align="left"><a
			href="http://www.eminentlabs.com" target="_new"><img border="0"
			alt="Eminentlabs Software Pvt. Ltd."
			src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                        <td align="right">
                <img alt="Eminentlabs Software Pvt Ltd" src="<%= request.getContextPath() %>/eminentech support files/Eminentlabs_logo.gif">
            </td>
        </tr>
</table>
<form name="theForm" action="updateRequest.jsp" onsubmit="return validateUpdation(this)">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td  border="1" align="left"><font size="4"> <b> Edit Resource Requisition</b></font></td>
		

	</tr>

</table>
<jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
<%

	String requestid=request.getParameter("requestid");
	session.setAttribute("requestid",requestid);

        session.setAttribute("forwardpage","/ResourceRequest/viewMyRequest.jsp");

	Connection connection 		=	null, connection1=null;
	PreparedStatement 	ps		=	null;
	ResultSet rs				=	null, rs1=null;
	Statement st1				=	null;
	try{

	String project				=	null;
	String team					=	null;
	String position				=	null;
	String skillset				=	null;
	String responsibility_p1	=	null;
	String responsibility_p2	=	null;
	String responsibility_p3	=	null;
	String responsibility_p4	=	null;
	String responsibility_p5	=	null;
	String responsibility_s1	=	null;
	String responsibility_s2	=	null;
	String responsibility_s3	=	null;
	String responsibility_s4	=	null;
	String responsibility_s5	=	null;

	String createdon			=	null;
	String modifiedon			=	null;

	String createdby			=	null;
	String assignedto			=	null;

	String duedate				=	null;
	String exp_years			=	null;
	String exp_months			=	null;
	String status				=	null;
	java.sql.Date dueDateFormat =   null;
	java.sql.Date created		=   null;
	java.sql.Date modified		=   null;

	HashMap<String,String> hm	=	new HashMap<String,String>();


	String teams[]		=	{"XI","BASIS","ABAP","MDM","MM","PP","FI","BI","SD","EP","HR","NW ADMIN","ADMIN","CUSTOMER","DIRECTOR","SALES","INTERN"};

	String positions[]	=	{"HR","SE","SSE","PM","DBA"};

	String statusitems[]		=	{"Unconfirmed","Confirmed","Sourcing","In Process","Fulfilled","Rejected","Closed"};

	HashMap<String,String> Skillsets			=	new HashMap<String,String>();

	Skillsets.put("ABAP","ABAP");
	Skillsets.put("BS","BASIS");
	Skillsets.put("WD","WEBDYNPRO");
	Skillsets.put("SD","Sales and Distribution");
	Skillsets.put("MM","Material Management");
	Skillsets.put("FI","Finance");
	Skillsets.put("CO","Costing");
	Skillsets.put("HR","Human Resource");
	Skillsets.put("PP","Production Planning");
	Skillsets.put("PM","Plant Maintanance");
	Skillsets.put("XI","Exchange Infrastructure");
	Skillsets.put("MDM","Master Data Management");
	Skillsets.put("APO","Advance Plannet Optimizer");
	Skillsets.put("PS","Project Systems");
	Skillsets.put("FR","Fresher Aptitude");
	Skillsets.put("XIA","XI Administration");
	Skillsets.put("NWADMIN","Netweaver Administration");

	int skillsize=Skillsets.size();


	try{

		SimpleDateFormat sdf    = new SimpleDateFormat("d-M-yyyy");

		connection=MakeConnection.getConnection();
//		connection1=MakeConnection.getSAPConnection();


		if(connection!=null){

			rs=ResourceRequest.editRequest(connection,requestid);
			if(rs!=null){
				rs.next();

				project			=	rs.getString("project");
				team			=	rs.getString("team");
				position		=	rs.getString("position");
				skillset		=	rs.getString("skillset");

				exp_years		=	rs.getString("exp_years");
//				exp_months		=	rs.getString("exp_months");
				assignedto		=	rs.getString("assignedto");

				dueDateFormat   = 	rs.getDate("duedate");
				created			=	rs.getDate("createdon");
				modified		=	rs.getDate("modifiedon");

				responsibility_p1=  rs.getString("responsibility_p1");
				responsibility_p2=  rs.getString("responsibility_p2");
				responsibility_p3=  rs.getString("responsibility_p3");
				responsibility_p4=  rs.getString("responsibility_p4");
				responsibility_p5=  rs.getString("responsibility_p5");

				responsibility_s1=  rs.getString("responsibility_s1");
				responsibility_s2=  rs.getString("responsibility_s2");
				responsibility_s3=  rs.getString("responsibility_s3");
				responsibility_s4=  rs.getString("responsibility_s4");
				responsibility_s5=  rs.getString("responsibility_s5");

				if(responsibility_s1==null){
					responsibility_s1="NA";
				}
				if(responsibility_s2==null){
					responsibility_s2="NA";
				}
				if(responsibility_s3==null){
					responsibility_s3="NA";
				}
				if(responsibility_s4==null){
					responsibility_s4="NA";
				}
				if(responsibility_s5==null){
					responsibility_s5="NA";
				}

				createdby		 =	rs.getString("createdby");
				status			 =	rs.getString("status");



				duedate="NA";
				if(dueDateFormat!=null){
					duedate=sdf.format(dueDateFormat);
				}
				createdon="NA";
				if(dueDateFormat!=null){
					createdon=sdf.format(created);
				}
				modifiedon="NA";
				if(dueDateFormat!=null){
					modifiedon=sdf.format(modified);
				}

				hm=GetProjectMembers.getMembers("ERM","1.0",createdby,assignedto);

		}
	}
	}
	catch(Exception e){
		logger.error("Edit Exception"+e);
	}
%>


<table bgcolor="E8EEF7" cellpadding="2" width="100%">
<tr>
	<td><b>Position</b></td><td><%=position %></td>
	<td><b>Project</b></td><td><%=GetProjects.getProjectName(project) %></td>
	<td><b>Team</b></td><td> <%=team %></td>



</tr>
<tr>
	<td><b>Experience</b></td><td><%=exp_years%>Years</td>
 	<td><b>Expertise</b></td><td >	<%=skillset %></td>
<td><b>DueDate</b></td><td><%=duedate%></td>
</tr>
<tr>
	<td><b>Assignedto</b></td>
	<%
		Collection set=hm.keySet();
		Iterator iter = set.iterator();
		int assigned=0;

//		  int lockedResource = ResourceCheck.getResourceId(requestid);
                int lockedResource = 0;
          session.setAttribute("lockedResource", lockedResource);
          session.setAttribute("reqId", requestid);


	    while (iter.hasNext()) {

	     String key=(String)iter.next();
	      String nameofuser=(String)hm.get(key);
	      logger.info("Userid"+key);
	      logger.info("Name"+nameofuser);
	      int useridassi=Integer.parseInt(key);
			if (useridassi==Integer.parseInt(assignedto))
				{
				assigned=useridassi;
%>
<td><%=nameofuser%></td>
<%
		}
		

	    }

	%>


 	<td><b>Status</b></td><td ><%=status%>
	</td>
<td><b>Files Attached</b></td>
<td>
<%
        int fileCount   =   ResourceRequest.getAttachedFileCount(requestid);
        if(fileCount>0){
%>
        <A onclick="viewFileAttachForIssue('<%=requestid%>');" href="#"
>View Files</A>
<%
        }else{
%>
            <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font>
<%
        }
%>
</td>
</tr>
<tr>
<table bgcolor="E8EEF7" cellpadding="2" width="100%">
<tr>
    <td align="left" width="100%" colspan="8"><font size="4" COLOR="#0000FF"><b>Job Responsibilities </b></font></td>
	</tr>
	<tr >
		<td align="center" width="80%" colspan="4"><font size="4" COLOR="#0000FF"><b>Primary</b></font></td>

		<td align="center" width="20%" colspan="4"><font size="4" COLOR="#0000FF"><b>Secondary </b></font></td>

	</tr>
	<tr >
		<td align="left" width="80%" colspan="4"><font size="4" >1.<%=responsibility_p1 %></font></td>
		<td align="left" width="20%" colspan="4"><font size="4" >1.<%=responsibility_s1 %></font></td>

	</tr>
<tr>
		<td align="left" width="80%" colspan="4"><font size="4" >2.<%=responsibility_p2 %></font></td>
		<td align="left" width="20%" colspan="4"><font size="4" >2.<%=responsibility_s2 %></font></td>

	</tr>
<tr >
		<td align="left" width="80%" colspan="4"><font size="4" >3.<%=responsibility_p3 %></font></td>
		<td align="left" width="20%" colspan="4"><font size="4" >3.<%=responsibility_s3 %></font></td>

	</tr>
<tr>
		<td align="left" width="80%" colspan="4"><font size="4" >4.<%=responsibility_p4 %></font></td>
		<td align="left" width="20%" colspan="4"><font size="4" >4.<%=responsibility_s4 %></font></td>

	</tr>
<tr>
		<td align="left" width="80%" colspan="4"><font size="4" >5.<%=responsibility_p5 %></font></td>
		<td align="left" width="20%" colspan="4"><font size="4" >5.<%=responsibility_s5 %></font></td>


	</tr>
        </table>
</tr>
</table>




<%
	}catch(Exception e){
		logger.error("Exception while viewing request"+e);
	}
	finally{
		if(connection!=null){
			connection.close();
		}
		if(connection1!=null){
			connection1.close();
		}
		if(rs!=null){
			rs.close();
		}
		if(ps!=null){
			ps.close();
		}
		if(rs1!=null){
			rs1.close();
		}
		if(st1!=null){
			st1.close();
		}
	}

%>
<%
	Connection commentConnection = null;
	PreparedStatement st = null;
	ResultSet rsComments = null;
	GetName g=null;

	try
	{
		commentConnection=MakeConnection.getConnection();
		st = commentConnection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,status,commentedto,to_char(duedate,'dd-Mon-yyyy') as duedate from rr_comments where resourceid=? order by comment_date asc");
		st.setString(1,requestid);
		rsComments = st.executeQuery();

		if(rsComments.next())
		{
			%>
<table width="100%">
	<tr>
		<th align="center">Commented By</th>
		<th align="center">TimeStamp</th>
		<th align="center">Comments History</th>
		<th align="center">Status</th>
		<th align="center">Commented To</th>
		<th align="center">Due Date</th>
	</tr>
	<%
			do
			{
					String commentedby=GetProjectMembers.getUserName(rsComments.getString("commentedby"));
					commentedby=commentedby.substring(0,commentedby.indexOf(" ")+2);

					String commentedto=rsComments.getString("commentedto");
					if(!commentedto.equals("Nil")){
						commentedto=GetProjectMembers.getUserName(rsComments.getString("commentedto"));
						commentedto=commentedto.substring(0,commentedto.indexOf(" ")+2);
					}
					String duedate=rsComments.getString("duedate");
					if(duedate==null){
						duedate="NA";
					}

				%>
	<tr>
		<td align="left" width="12%"><%=commentedby%></td>
		<td align="left" width="9%"><%= rsComments.getString("commentdate") %><%=" "%><%= rsComments.getTime("comment_date") %></td>
		<td align="justify" width="46%"><%= rsComments.getString(4) %></td>
		<td align="left" width="9%"><%= rsComments.getString(5) %></td>
		<td align="left" width="12%"><%= commentedto %></td>
		<td align="left" width="12%"><%= duedate %></td>
	</tr>
	<tr>
		<td colspan="6" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
	</tr>
	<%
			}while(rsComments.next());
			%>
                        <tr align="center">
		<td colspan="6"><input type="button" name="print" value="Print"
			onclick="javascript:window.print()" /><input type="button"
			name="Close" value="Close" onclick="javascript:KillBrowser()" /></td>
	</tr>
</table>
<%

		}
		else
		{
			%>
<%= "Nothing to display"%>
<%
		}
	}
	catch(Exception e)
	{
        logger.error(e);
	}
	finally
	{
		if(rsComments!=null)
		{
			rsComments.close();
		}
		if(st!=null)
		{
			st.close();
		}
        if(commentConnection!=null)
		{
			commentConnection.close();
		}
	}

%>
</form>
<TABLE bgColor="#C3D9FF" border=0 width="100%">
	<tbody>
		<TR>
			<TD align=center noWrap vAlign=top width="50%" height="150%">
                <font face="Verdana" size="4" color="#666666">
                    KPI Tracker&#153;, ERPDS&#153;, EWE&#153;, eTracker&#153;, eOutsource&#153;, Rightshore&#153; are registered trademarks of Eminentlabs&#153; Software Private Limited
                </font>
			</TD>

		</TR>
	</TBODY>
</TABLE>
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
</body>
</html>