<%@ page language="java" contentType="text/html"  pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.*,java.util.*" %>
<%
//	session.setAttribute("forwardpage","/MyAssignment/UpdateIssue.jsp");
//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("Create Request");
	
	
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
<%@ include file="../header.jsp"%>
<jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" /> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
<LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<script language=javascript	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script language=javascript	src="<%= request.getContextPath() %>/eminentech support files/validateResourceRequest.js"></script>
<script>
<%
	int project =ResourceRequest.checkProject();

%>
</script>
</head>
<body >
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Create Resource Request </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
	</tr>
</table>
<%

if(project>0){

%>
<form name=theForm action="newRequest.jsp" onsubmit="return fun(this)" method=post>
<table width="100%" border="0" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
	<tr>
		<td align="left"><b>Position</b></td>
		<td>
                    <SELECT id="position" NAME="position" size="1">
				<option value="--Select One--" selected>--Select One--</option>
                                <option value="Accountant">Accountant</option>
                                <option value="Architect">Architect</option>
                                <option value="Associate Consultant">Associate Consultant</option>
                                <option value="Business Analyst">Business Analyst</option>
                                <option value="Business Process Expert">Business Process Expert</option>
                                <option value="Consultant">Consultant</option>
                                <option value="Delivery Manager">Delivery Manager</option>
                                <option value="Developer">Developer</option>
                                <option value="Intern">Intern</option>
                                <option value="Lead Consultant">Lead Consultant</option>
                                <option value="Lead Developer">Lead Developer</option>
                                <option value="Program Manager">Program Manager</option>
                                <option value="Project Manager">Project Manager</option>
                                <option value="Quality Manager">Quality Manager</option>
                                <option value="Quality Manager">Quality Manager</option>
                                <option value="Senior Consultant">Test Engineer</option>
                                <option value="Senior Developer">Senior Developer</option>
                                <option value="Trainee">Trainee</option>
                                 
		    </SELECT>
                </td>
		<td align=left><b>Project</b></td>
		<td>
		<select id="project" name="project" size="1">
		<option value="--Select One--" selected>--Select One--</option>
			<% 
			String userid=((Integer)session.getAttribute("uid")).toString();
			
			HashMap<String,String> al;
			al=GetProjects.getProjects(userid);
			Collection set=al.keySet();
			Iterator iter = set.iterator();
		

		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String pname=(String)al.get(key);
//		      logger.info("Userid"+key);
//		      logger.info("Name"+nameofuser);
		   
		
%>
			<option value="<%=key%>:<%=pname%>"><%=pname%></option>
			<%
		
			

		    }
			
%>
		</select>
		</td>

		<td align="left"><b>Team</b></td><td><SELECT id="team" NAME="team" size="1">
				<option value="--Select One--" selected>--Select One--</option>
				
                                <option value="ABAP">ABAP</option>
                                <option value="ADMIN">ADMIN</option>
				<option value="BASIS">BASIS</option>
                                <option value="BI">BI</option>
                                <option value="CUSTOMER">CUSTOMER</option>
				<option value="DIRECTOR">DIRECTOR</option>
				<option value="EP">EP</option>
                                <option value="FI">FI</option>
                                <option value="HR">HR</option>
                                <option value="INTERN">INTERN</option>
				<option value="MDM">MDM</option>
				<option value="MM">MM</option>
                                <option value="NW ADMIN">NW ADMIN</option>
				<option value="PP">PP</option>
				<option value="SALES">SALES</option>
				<option value="SD">SD</option>
                                <option value="XI">XI</option>
			</SELECT></td>

		

		
	</tr>

	<tr >
		<td align="left"><b>Experience</b></td>
	 	<td>
			<SELECT id=totalyears NAME="totalyears" size="1">
			<OPTION value="--None--" selected>--None--</OPTION>
            <OPTION value="0" >Fresher</OPTION>
			<OPTION value="1" >1</OPTION>
			<OPTION value="2" >2</OPTION>
			<OPTION value="3" >3</OPTION>
			<OPTION value="4" >4</OPTION>
			<OPTION value="5" >5</OPTION>
			<OPTION value="6" >6</OPTION>
			<OPTION value="7" >7</OPTION>
			<OPTION value="8" >8</OPTION>
			<OPTION value="9" >9</OPTION>
			<OPTION value="10" >10</OPTION>
			<OPTION value="10+" >10+</OPTION>
			</SELECT>
		</td>
		<td align="left"><b>Expertise</b></td><td><SELECT id=skill NAME="skill" size="1">
                        <OPTION value="--None--" selected>--None--</OPTION>
			<option value="ABAP" >ABAP</option>
                        <option value="APO">Advance Planner Optimizer</option>
			<option value="BS">BASIS</option>
                        <option value="CO">Costing</option>
                        <option value="XI" >Exchange Infrastructure</option>
                        <option value="FI">Finance</option>
			<option value="FR">Freshers Aptitude</option>
                        <option value="HR">Human Resource</option>
			<option value="MDM">Master Data Management</option>
                        <option value="MM">Materials Managaement</option>
			<option value="NWADMIN">Netweaver Administration</option>
                        <option value="PM">Plant Maintanenece</option>
                        <option value="PP">Production Planning</option>
			<option value="PS">Project Systems</option>
                        <option value="SD">Sales and Distribution</option>
			<option value="WD">WEBDYNPRO</option>
			<option value="XIA">XI Administration</option>
			
			
                    </SELECT></td>
		<td align="left"><b>Due Date</b></td>
		<td><input type="text" name="duedate" id="duedate" maxlength="10" size="14"
			readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img
			src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
			width="16" height="16" alt="Pick a date"></a></td>

	</tr>
	<tr>
		<td align="left" width="100%" colspan="6"><font size="4" COLOR="#0000FF"><b>Job Responsibilities </b></font></td>
	</tr>
	<tr >
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><b>Primary</b></font></td>
		
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><b>Secondary </b></font></td>

	</tr>
	<tr >
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=p1 cols="30" rows="3" maxlenght=200></textarea></font></td>
		
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=s1 cols="30" rows="3" maxlenght=200></textarea></font></td>

	</tr>
<tr>
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=p2 cols="30" rows="3" maxlenght=200></textarea></font></td>
		
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=s2 cols="30" rows="3" maxlenght=200></textarea></font></td>

	</tr>
<tr >
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=p3 cols="30" rows="3" maxlenght=200></textarea></font></td>
		
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=s3 cols="30" rows="3" maxlenght=200></textarea></font></td>

	</tr>
<tr>
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=p4 cols="30" rows="3" maxlenght=200></textarea></font></td>
		
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=s4 cols="30" rows="3" maxlenght=200></textarea></font></td>

	</tr>
<tr>
		<td align="center" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><textarea name=p5 cols="30" rows="3" maxlenght=200></textarea></font></td>
		
		<td align="center" width="100%" colspan="3" ><font size="4" COLOR="#0000FF"><textarea name=s5 cols="30" rows="3" maxlenght=200></textarea></font></td>

	
	</tr>
<tr>
		<td align="right" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><input type="submit" value="Create"></font></td>
		
		<td align="left" width="100%" colspan="3"><font size="4" COLOR="#0000FF"><input type="reset" value="Reset" style="width:50"></font></td>

	
	</tr>
</table>
</form>
<%
}
else{
	%>
			<table align="center" height="70%">
	
				<tr>
					<td>
					<h3>No ERM projects available to create your request</h3>
					</td>
				</tr>
			</table>

<%
}
%>
</body>
</html>