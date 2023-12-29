<!doctype html public "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.eminent.util.GetProjectMembers"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%

	//Configuring log4j properties

	Logger logger = Logger.getLogger("View Applicant");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}

%>

<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
    <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript">
        function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
	}
        function editorTextCounter(field,cntfield,maxlimit)
    {
	if (field > maxlimit)
	{

                if (maxlimit==2000)
                    alert('Comments size is exceeding 2000 characters');
                else
                    alert('Comments size is exceeding 2000 characters');
	}
	else
		cntfield.value = maxlimit - field;
    }
    function fun()
    {
        if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            alert ("Please Enter the Comments");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length>2000)
        {
            alert (" Comments exceeds 2000 character");
            CKEDITOR.instances.comments.focus();
    //        document.theForm.description.value == "";
            return false;
        }
        disableSubmit();
    }
</script>
</HEAD>
<BODY>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page import="com.pack.*"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page language="java"%>
<%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td align="left""><font size="4" COLOR="#0000FF"><b>
		Applicant Details </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>

	</tr>
</table>

<br>


<% 
	String apid=(String)request.getParameter("apid");
	logger.debug("apid:"+apid);
%>
<table align="center" width="100%" bgcolor="C3D9FF">
	<tr>
            <td><font size="4" COLOR="#0000FF"><b>Applicant Id</b> <b><%= apid %></b></font></td>
	</tr>
</table>
  <%!
        Connection connection = null;
        Statement stmt=null;
	PreparedStatement ps=null, psEmp = null;
	ResultSet resultset=null,result=null, rsEmp = null;
	String firstname,lastname;
%> <%
        int userId  =  (Integer) session.getAttribute("userid_curr");
       try{
		connection=MakeConnection.getConnection();
		if(connection!=null)
		{
			ps = connection.prepareStatement("SELECT FIRSTNAME,LASTNAME,PHONE,MOBILE,EMAIL,CURRENT_LOCATION,REFERENCE_EMPID,UG,UG_BRANCH,UG_INSTITUTE,UG_YEAR,UG_PERCENTAGE,PG,PG_BRANCH,PG_INSTITUTE,PG_YEAR,PG_PERCENTAGE,SAP_EXP_YR,SAP_EXP_MON,CORE_COMPETENCE,TOTAL_EXP_YR ,TOTAL_EXP_MON,AREA_OF_EXPERTISE,LANGUAGES,ERP_PACKAGES,OS,DB,TOOLS,DESIRED_JOB_TYPE,DESIRED_POSITION,DESIRED_LOCATION,REFERENCE_NAME,REFERENCE_DESIGNATION,REFERENCE_ORG,REFERENCE_ID,APPLICANT_STATUS,WATER,RTI,RTE,HABITS,SOCIAL,APJBOOK from ERM_APPLICANT WHERE APPLICANT_ID=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        		ps.setString(1,apid);
                	resultset = ps.executeQuery();
			while(resultset.next())
			{
				String ANAM		= resultset.getString("FIRSTNAME");
                                int APJBOOK		= resultset.getInt("APJBOOK");
				String LNAM		= resultset.getString("LASTNAME");
				String LPHN		= resultset.getString("PHONE");
                                if (LPHN==null)
                                    LPHN="";
                                String MPHN		= resultset.getString("MOBILE");
				String MAIL		= resultset.getString("EMAIL");
				String CLOC		= resultset.getString("CURRENT_LOCATION");
                                if (CLOC==null)
                                    CLOC="";
				String REFID		= resultset.getString("REFERENCE_EMPID");
                                if (REFID==null)
                                    REFID="";
				String UG		= resultset.getString("UG");
                                if (UG==null)
                                    UG="";
				String UBRAN 		= resultset.getString("UG_BRANCH");
                                if (UBRAN==null)
                                    UBRAN="";
				String UINST		= resultset.getString("UG_INSTITUTE");
                                if (UINST==null)
                                    UINST="";
				String UGYR		= resultset.getString("UG_YEAR");
                                if (UGYR==null)
                                    UGYR="";
				String UPER 	        = resultset.getString("UG_PERCENTAGE");
                                if (UPER==null)
                                    UPER="";
                                
                                String PG		= resultset.getString("PG");
                                if (PG==null)
                                    PG="";
				String PBRAN		= resultset.getString("PG_BRANCH");
                                if (PBRAN==null)
                                    PBRAN="";
				String PINS		= resultset.getString("PG_INSTITUTE");
                                if (PINS==null)
                                    PINS="";
                                String PGYR		= resultset.getString("PG_YEAR");
                                if (PGYR==null)
                                    PGYR="";
				String PPER		= resultset.getString("PG_PERCENTAGE");
                                if (PPER==null)
                                    PPER="";
				String SPEY		= resultset.getString("SAP_EXP_YR");
                                if (SPEY==null)
                                    SPEY="";
                                String SPEM		= resultset.getString("SAP_EXP_MON");
                                if (SPEM==null)
                                    SPEM="";
				String FUNC		= resultset.getString("CORE_COMPETENCE");
                                if (FUNC==null)
                                    FUNC="";
				String TOTE		= resultset.getString("TOTAL_EXP_YR");
                                if (TOTE==null)
                                    TOTE="";
                                String TOTM		= resultset.getString("TOTAL_EXP_MON");
                                if (TOTM==null)
                                    TOTM="";
				String AREA		= resultset.getString("AREA_OF_EXPERTISE");
                                if (AREA==null)
                                    AREA="";
				String ATTA		= null;
                                if (ATTA==null)
                                    ATTA="";
				String LANG		= resultset.getString("LANGUAGES");
                                if (LANG==null)
                                    LANG="";
				String ERPP 		= resultset.getString("ERP_PACKAGES");
                                if (ERPP==null)
                                    ERPP="";
				String OPSM		= resultset.getString("OS");
                                if (OPSM==null)
                                    OPSM="";
				String DTBS		= resultset.getString("DB");
                                if (DTBS==null)
                                    DTBS="";
				String TOUT 	        = resultset.getString("TOOLS");
                                if (TOUT==null)
                                    TOUT="";
                                
				
				
				String DJBTY		= resultset.getString("DESIRED_JOB_TYPE");
                                if (DJBTY==null)
                                    DJBTY="";
				String DPOSN 		= resultset.getString("DESIRED_POSITION");
                                if (DPOSN==null)
                                    DPOSN="";
				String DLOC		= resultset.getString("DESIRED_LOCATION");
                                if (DLOC==null)
                                    DLOC="";
				String RNAM		= resultset.getString("REFERENCE_NAME");
                                if (RNAM==null)
                                    RNAM="";
				String RDES 	        = resultset.getString("REFERENCE_DESIGNATION");
                                if (RDES==null)
                                    RDES="";
                                String RORG		= resultset.getString("REFERENCE_ORG");
                                if (RORG==null)
                                    RORG="";
				String REID		= resultset.getString("REFERENCE_ID");
                                if (REID==null)
                                    REID="";
                                int statId              =   resultset.getInt("APPLICANT_STATUS");
				/*
                                String CCOD		= resultset.getString("CCOD");
                                if (CCOD==null)
                                    CCOD="";
                                String STDC		= resultset.getString("STDC");
                                if (STDC==null)
                                    STDC="";
				String RPHN		= resultset.getString("RPHN");
                                if (RPHN==null)
                                    RPHN="";
				String RMAIL		= resultset.getString("RMAIL");
                                if (RMAIL==null)
                                    RMAIL="";
				String DOB		= resultset.getString("DOB");
                                if (DOB==null)
                                    DOB="";
				String GNDR		= resultset.getString("GNDR");
                                if (GNDR==null)
                                    GNDR="";
				String MSTAT 		= resultset.getString("MSTAT");
                                if (MSTAT==null)
                                    MSTAT="";
				String PANC		= resultset.getString("PANC");
                                if (PANC==null)
                                    PANC="";
				String MADDR		= resultset.getString("MADDR");
                                if (MADDR==null)
                                    MADDR="";
				String CITY 	        = resultset.getString("CITY");
                                if (CITY==null)
                                    CITY="";
                                String PCODE		= resultset.getString("PCODE");
                                if (PCODE==null)
                                    PCODE="";
			*/
				String grad = UG;
                                String percentage = UPER;
                                String grdYear    = UGYR;
                                if(!PG.equals("")){
                                    grad =   PG;
                                    if(!PGYR.equals("")){
                                         grdYear  =PGYR;
                                    }else{
                                         grdYear="NA";
                                    }
                                    if(!PPER.equals("")){
                                        percentage   =   PPER;
                                    }else{
                                         percentage  ="NA";
                                    }
                                }			

                                String water = resultset.getString("WATER");
                            String rti = resultset.getString("RTI");
                            String rte = resultset.getString("RTE");
                            String habits = resultset.getString("HABITS");
                            String social = resultset.getString("SOCIAL");
                            if (water == null) {
                                water = "NA";
                            }
                            if (rti == null) {
                                rti = "NA";
                            }
                            if (rte == null) {
                                rte = "NA";
                            }
                            if (habits == null) {
                                habits = "NA";
                            }
                            if (social == null) {
                                social = "NA";
                            }
                            String apj="No";
                            if (APJBOOK == 0) {
                                apj = "No";
                            }else{
                                apj = "Yes";
                            }
                                 
                                    
                                        %>
                                        
                                        <table width="100%" bgcolor="E8EEF7">
                    <tr height="21">
                        <td align="left" width="100%"><b><font color="#0000FF">CITIZEN CHARTER</font></b></td>
                    </tr>
                </table>
                <table width="100%" bgcolor="E8EEF7">
                    <tr height="21">
                        <td width="40%"><B>Have you read the book "Governance for Growth in India" by APJ Abdul Kalam?</B></td><td colspan="2"><%=apj%></td>
        </tr>
                    <tr height="21">
                        <td width="40%"><B>1. How clean, safe, free drinking water can be provided to everyone in India by 2020? Write in detail.</B></td>
                    </tr>
                    <tr>
                        <td colspan="2"><%= water%></td>
                    </tr>
                    <tr>
                        <td width="40%"><B>2. Have you filed any RTI so far ? If so please share details. </B></td>
                    </tr>
                    <tr>
                        <td colspan="2"><%=rti%></td>
                    </tr>
                    <tr>
                        <td width="40%"><B>3. How RTE have changed the children educational status in your native or place of birth ? </B></td>
                    </tr>
                    <tr>
                        <td colspan="2"><%= rte%></td>
                    </tr>

                    <tr height="21">
                        <td width="40%"><B>4. How many of your family, relatives, friends smoke tobacco products or drink alcohol ? What steps have you taken so far to help them overcome their habits? </B></td>
                    </tr>
                    <tr>
                        <td colspan="2"><%= habits%></td>
                    </tr>
                    <tr>
                        <td width="40%"><B>5. What % of your salary you are planning to dedicate in your work life to the above social cause ? </B></td>
                    </tr>
                    <tr>
                        <td colspan="2"><%= social%></td>
                    </tr>
                </table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td align="left" width="100%"><b><font color="#0000FF">User
		Information </font></b></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td width="10%"><B>Name </B></td>
		<%
                                                String fullname="";
                                                fullname=ANAM+" "+LNAM;
                                                if((fullname.length())<20)
					{
					    %>
                    <td width="20%" id="imagePopup" name="imagePopup" onclick="showImage('../../Etracker_AttachedFiles/userPhotos/<%= apid%>.jpg', '<%= fullname%>', '<%=apid%>');"><%= fullname%></td>
		<%
                                                }else
                                                    {
                                                    %>
                    <td width="20%" id="imagePopup" name="imagePopup" onclick="showImage('../../Etracker_AttachedFiles/userPhotos/<%= apid%>.jpg', '<%= fullname%>', '<%=apid%>');"><%= fullname.substring(0, 20) %></td>
		<%
                                                    }
                                                %>
		<td width="15%"><B>Phone </B></td>
		<td width="20%"><%= LPHN %></td>
		<td width="15%"><B>Mobile </B></td>
		<td width="30%"><%= MPHN %></td>
	</tr>
       
	<tr height="21">
		<td width="10%"><B>Mail </B></td>
		<%
                                                if((MAIL.length())<20)
					{
					    %>
		<td width="20%"><%= MAIL %></td>
		<%      }else
                                                    {
                                                    %>
		<td width="20%"><%= MAIL.substring(0,20)+"..." %></td>
		<%
                                                    }
                                                %>
		<td width="15%"><B>Current Location </B></td>
		<td width="20%"><%= CLOC %></td>
		<td width="15%"><B>Referred By </B></td>
		<td width="30%"><%= GetProjectMembers.getUserNameByEid(REFID) %> - <%=REFID%></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td align="left" width="100%"><B><font color="#0000FF">Educational
		Details </font></B></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td width="10%"><B>UG Degree </B></td>
		<td width="20%"><%= UG %></td>
		<td width="15%"><B>UG Branch </B></td>
		<td width="20%"><%= UBRAN %></td>
		<td width="15%"><B>UG Institute</B></td>
		<td width="30%"><%= UINST %></td>
	</tr>
	<tr height="21">
		<td width="10%"><B>UG Year </B></td>
		<td width="20%"><%= UGYR %></td>
		<td width="15%"><B>UG Percentage </B></td>
		<td width="20%"><%= UPER %></td>
	</tr>
        <%
        if(PG!=""){
%>
	<tr height="21">
		<td width="10%"><B>PG Degree </B></td>
		<td width="20%"><%= PG %></td>
		<td width="15%"><B>PG Branch </B></td>
		<td width="20%"><%= PBRAN %></td>
		<td width="15%"><B>PG Institute</B></td>
		<td width="30%"><%= PINS %></td>
	</tr>
	<tr height="21">
		<td width="10%"><B>PG Year </B></td>
		<td width="20%"><%= PGYR %></td>
		<td width="15%"><B>PG Percentage </B></td>
		<td width="20%"><%= PPER %></td>
	</tr>
        <%}%>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td align="left" width="100%"><B><font color="#0000FF">Skills
		and Experience</font></B></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td width="10%"><B>SAP Exp </B></td>
		<td width="20%"><%=SPEY%> Yr&nbsp;<%=SPEM%>
		M</td>
		<td width="15%"><B>Functional Area </B></td>
		<%
                                                String Functional="";
                                                if (FUNC.equals("T"))
                                                    Functional="Technical";
                                                if (FUNC.equals("F"))
                                                    Functional="Functional";
                                                if (FUNC.equals("TF"))
                                                    Functional="Techno Functional";
                                                %>
		<td width="20%"><%= Functional %></td>
		<td width="15%"><B>Total Experience </B></td>
		<%
                                                if (TOTE.equals(null)) TOTE="0";
                                                if (TOTM.equals(null)) TOTM="0";
                                                %>
		<td width="30%"><%=TOTE%> Yr&nbsp;<%=TOTM%>
		M</td>
	</tr>

	<tr height="21">
		<td width="10%"><B>Expertise </B></td>
		<td width="20%"><%= AREA %></td>
		<td width="15%"><B>Languages </B></td>
		<%                                                if((LANG.length())<20)
					{
					    %>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(LANG) %></font></td>
		<%
					}
					else
					{
					    %>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= LANG.substring(1,20)+"..." %></font></td>
		<%
					}%>
		<td width="15%"><B>ERP Packages </B></td>
		<%                                                if((ERPP.length())<20)
					{
					    %>
		<td width="30%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(ERPP) %></font></td>
		<%
					}
					else
					{
					    %>
		<td width="30%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= ERPP.substring(1,20)+"..." %></font></td>
		<%
					}%>
	</tr>
	<tr height="21">

		<td width="10%"><B>OS </B></td>
		<%                                                if((OPSM.length())<20)
					{
					    %>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(OPSM) %></font></td>
		<%
					}
					else
					{
					    %>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= OPSM.substring(1,20)+"..." %></font></td>
		<%
					}%>

		<td width="15%"><B>Database </B></td>
		<%                                                if((DTBS.length())<20)
					{
					    %>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(DTBS) %></font></td>
		<%
					}
					else
					{
					    %>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= DTBS.substring(1,20)+"..." %></font></td>
		<%
					}%>
		<td width="15%"><B>Tools & Utilities </B></td>
		<%                                                if((TOUT.length())<20)
					{
					    %>
		<td width="30%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(TOUT) %></font></td>
		<%
					}
					else
					{
					    %>
		<td width="30%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= TOUT.substring(0,20)+"..." %></font></td>
		<%
					}%>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td align="left" width="100%"><B><font color="#0000FF">Previous
		Experience</font></B></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">

		<td width="10%"><B>Prev Employer </B></td>
		<%
                                                    SimpleDateFormat    sdf =   new SimpleDateFormat("DD-MMM-YY");
                                                    psEmp = connection.prepareStatement("select CURRENT_EMPLOYER,CURRENT_CTC,CURRENT_DESIGNATION,CURRENT_ROLE,JOB_PROFILE,to_char(CURRENT_DOJ, 'DD-Mon-YY') as CURRENT_DOJ, to_char(RELIEVING_DATE, 'DD-Mon-YY') as RELIEVING_DATE,EXPERIENCE_ID from ERM_APPLICANT_EXPERIENCE where APPLICANT_ID=? ORDER BY EXPERIENCE_ID");
                                                    psEmp.setString(1,apid);
                                                    rsEmp = psEmp.executeQuery();
                                                    String pEmp = "", pCtc = "", pDest = "", pRole = "", jPrl = "", pJdat = "", pRdat = "";
                                                    if(rsEmp.next()){
                                                        pEmp = rsEmp.getString("CURRENT_EMPLOYER");
                                                        if (pEmp == null)
                                                        pEmp = "";
                                                        pCtc = rsEmp.getString("CURRENT_CTC");
                                                        if (pCtc == null)
                                                        pCtc = "";
                                                        pDest = rsEmp.getString("CURRENT_DESIGNATION");
                                                        if (pDest==null)
                                                        pDest="";
                                                	pRole= rsEmp.getString("CURRENT_ROLE");
                                                        if (pRole==null)
                                                        pRole="";
                                                        jPrl = rsEmp.getString("JOB_PROFILE");
                                                        if (jPrl == null)
                                                        jPrl = "";
                                                        pJdat = rsEmp.getString("CURRENT_DOJ");
                                                        if (pJdat == null){
                                                            pJdat = "";
                                                        }else{
                                                     //       pJdat   = sdf.format(pJdat);
                                                        }
                                                        pRdat = rsEmp.getString("RELIEVING_DATE");
                                                        if (pRdat == null)
                                                        pRdat = "";
                                                    }
                                                
                                                %>
		<td width="20%"><%= pEmp %></td>
                <td width="10%"><B>Prev Designation </B></td>
		<td width="20%"><%= pDest %></td>
		<td width="15%"><B>Prev CTC </B></td>
		<td width="20%"><%= pCtc %> &nbsp; LPA in INR</td>
	</tr>
	<tr height="21">
		<td width="10%"><B>Prev. Join Date </B></td>
		<td width="20%"><%= pJdat %></td>
		<td width="15%"><B>Prev Relieving Date </B></td>
		<td width="20%"><%= pRdat %></td>
		<td width="15%"><B>Prev Role </B></td>
		<td width="20%"><%= pRole %></td>
		
	</tr>

	<tr height="21">
		<td width="10%"><B>Job Profile </B></td>
		<td width="30%" colspan="5"><%= jPrl %></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td align="left" width="100%"><B><font color="#0000FF">Desired
		Job</font></B></td>
	</tr>
</table>
<table width="100%" bgcolor="E8EEF7">
	<tr height="21">
		<td width="10%"><B>Job Type </B></td>
		<%
                                                String jobtype="";
                                                if (DJBTY.equals("P"))
                                                    jobtype="Permanent";
                                                if (DJBTY.equals("T"))
                                                    jobtype="Functional";
                                                %>
		<td width="20%"><%= jobtype %></td>
		<td width="15%"><B>Desired Position</B></td>
		<td width="20%"><%= DPOSN %></td>
		<td width="15%"><B>Desired Location </B></td>
		<td width="30%"><%= DLOC %></td>
	</tr>
        
</table>
        <%
                        HashMap hm =new HashMap<Integer,String>();
                        hm.put(new Integer(0), "Unscreened");
                        hm.put(new Integer(1), "Screening");
                        hm.put(new Integer(2), "Shortlisted");
                        hm.put(new Integer(3), "Rejected");
%>
        <form action="updateCandidate.jsp" method="post" onSubmit='return fun(this)'>
                  <table width="100%" border="0" id="testcasesavailable" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
         <tr>
            <td>
                <input type="hidden" name="name" value="<%=fullname%>">
                <input type="hidden" name="location" value="<%=CLOC%>">
                <input type="hidden" name="grd" value="<%=grad%>">
                <input type="hidden" name="gradyear" value="<%=grdYear%>">
                <input type="hidden" name="percentage" value="<%=percentage%>">
                <input type="hidden" name="areaofexpertise" value="<%=AREA%>">
                <input type="hidden" name="sapyears" value="<%=SPEY%>">
                <input type="hidden" name="sapmonths" value="<%=SPEM%>">
                <input type="hidden" name="totalyears" value="<%=TOTE%>">
                <input type="hidden" name="totalmonths" value="<%=TOTM%>">

            </td>
        </tr>
           <tr style="height:30px;">
               <td width="10%"><b>Status</b></td>
             <td align="left" width="20%">
                 <select id="statusid" name="statusid">
                     <%
                                       Collection set=hm.keySet();
                                        Iterator ite = set.iterator();
                                        int currentid=0;
                                        int ststusid=0;
                                  while (ite.hasNext()) {

                                      int key=(Integer)ite.next();
                                      String currentstatus=(String)hm.get(key);
                                      ststusid=key;
//                                      logger.info("Id"+ststusid+""+currentstatus);
				if (ststusid==statId)
   				{
					currentid=ststusid;
%>
			<option value="<%=currentid%>" selected><%=currentstatus%></option>
			<%
			}
			else
			{
					currentid=ststusid;
%>
			<option value="<%=currentid%>"><%=currentstatus%></option>
			<%
			}

		    }
                                    %>
                 </select>
             </td>
             <td align="left" width="15%"><b>Assigned To</b></td>
             <%
              ArrayList<String> al = new ArrayList();
   
    String users        =   ";";
                           users=users+GetProjectMembers.getEminentMembers();

                           users=   users.replaceAll(";", "");
                    String[] eminentUsers   =   users.split(",");
                    
%>
             <td  align="left">
                 <select id="assignedto" name="assignedto">
                     <%
                     String k="",id,name;
                     for(int i=0;i<eminentUsers.length;i++)
                                {

                                     k  =eminentUsers[i];


                                     id   =   k.substring(0,k.indexOf('-'));
                                     name   =   k.substring(k.indexOf('-')+1,k.length());


                                    if(userId==Integer.parseInt(id)){
%>
                                        <option value="<%=id%>" selected><%=name%></option>
<%
                                    }else{
%>
                                        <option value="<%=id%>"><%=name%></option>
<%                                        
                                    }

                                }

%>
                 </select>
                 
             </td>
             
         </tr>
         <tr>
		<td width="10%" align="left">
		<b>Comments</b>
		</td>


                <td style="width:700px;" colspan="3">
                                       <textarea
			rows="3" cols="68" name="comments" id="comments" maxlength="2000"
			onKeyDown="textCounter(document.getElementById('comments'),document.getElementById('remLen1'),2000)"
			onKeyUp="textCounter(document.getElementById('comments'),document.getElementById('remLen1'),2000)"></textarea>

                  <script type="text/javascript">
                                CKEDITOR.replace( 'comments',{toolbar:'Basic',height:100} );
                                var editor_data = CKEDITOR.instances.comments.getData();
                               CKEDITOR.instances["comments"].on("instanceReady", function()
                                {

                                                //set keyup event
                                                this.document.on("keyup", updateExpectedResult);
                                                 //and paste event
                                                this.document.on("paste", updateExpectedResult);

                                });
                                function updateExpectedResult()
                                {
                                        CKEDITOR.tools.setTimeout( function()
                                                    {
                                                        var desc    =   CKEDITOR.instances.comments.getData();
                                                       var leng    =   desc.length;
                                                       editorTextCounter(leng,document.getElementById('remLen1'),2000);

                                                    }, 0);
                                }
                        </script>
             </td><td>
        	<input readonly type="text" name="remLen1" id="remLen1" size="3" maxlength="4" value="2000">
        </td>
	</tr>
        <tr>
            <td colspan="6" align="center"><input type="submit" id="submit" value="Update"><input type="hidden" name="applicantId" id="applicantId" value="<%=apid%>"></td>
        </tr>
        </table>
                </form>

<%			
                        			

			}
		}
            
                }
                finally{
                   if(result!=null)
                        result.close();
                   if(stmt!=null)
                        stmt.close();
                   if(resultset!=null)
                        resultset.close();
                   if(ps!=null)
                        ps.close();     
                        
                   if(rsEmp != null){
                       rsEmp.close();
                    }   
                    if(psEmp != null){
                       psEmp.close();
                    }   
                    if(connection!=null)
                        connection.close();
                }
	
%>
<iframe src="${pageContext.request.contextPath}/admin/candidate/screeningComments.jsp?appId=<%=apid%>" scrolling="auto" frameborder="2" height="20%" width="100%"></iframe>
</BODY>
       <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
        <script src="https://code.jquery.com/jquery-1.9.0.js"></script>

                                                                                        <script type="text/javascript">
                                                                                        $('#imagePopup').hover(function () {
                                                                                            $(this).css("color", "blue");
                                                                                        });

                                                                                        $('#imagePopup').mouseout(function () {
                                                                                            $(this).css("color", "");
                                                                                        });
                                                                                        function showImage(src, name, applicantId) {
                                                                                           // console.log("src name is:" + src);
                                                                                                                                                                                       $('#overlay').attr('height', $(window).height());

                                                                                            $('#overlay').fadeIn('fast', 'swing');
                                                                                            $("#imagePopups").width(254).height(266);
                                                                                            document.getElementById('nameofEmp').innerHTML = applicantId + ":" + name;
                                                                                            $('#imagePopups').fadeIn('fast', 'swing');
                                                                                            var img = document.getElementById('userImage');
                                                                                            img.style.visibility = 'visible';
                                                                                            document.getElementById('userImage').src = src;
                                                                                        }
                                                                                        function closePopup() {
                                                                                            $('#overlay').fadeOut('fast', 'swing');
                                                                                            $('#imagePopups').fadeOut('fast', 'swing');

                                                                                        }

                                                                                    </script>
</HTML>
