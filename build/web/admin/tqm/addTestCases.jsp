<%-- 
    Document   : addTestCases
    Created on : 8 Apr, 2010, 12:17:07 PM
    Author     : Tamilvelan
--%>
<%@page  import="java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%


        session.setAttribute("forwardpage","/admin/tqm/listPTC.jsp");



	//Configuring log4j properties
	

	Logger logger = Logger.getLogger("Add Test Cases");
	

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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
         <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript">
            function SetChecked(val,chkName)
	{
		dml=document.forms[form];
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++)
		{
			if (dml.elements[i].name==chkName)
			{
				dml.elements[i].checked=val;
			}
		}
	}

	function validate(dml,chkName)
	{
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++)
		{
			if ((dml.elements[i].name==chkName) && (dml.elements[i].checked==1)) return true
		}
		alert("Please select at least one record to be added")
		return false;
	}



</script>
    </head>
    <body>
        <form name="addTestCases" action="updateExecutionPlan.jsp" onsubmit="return validate(this,'addtestcase')" method="post">
        <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td align="left"><b> Project Test Cases</b></td>

	</tr>

        </table>
        <%
            String pid  =   request.getParameter("pid");
            try{
                List l =TqmUtil.listProductTC(pid);
                int noOfRecords =   l.size();
                %>
                <br>
<table width="100%">

	<tr height="10">
		<td align="left" width="80%">This list shows <b> <%=noOfRecords %></b> Project Test Cases.</td>
               <td colspan="6" align="right"><a
			href="javascript:SetChecked(1,'addtestcase')"><font
			face="Arial, Helvetica, sans-serif" size="2">Select All</font></a>&nbsp;&nbsp;<a
			href="javascript:SetChecked(0,'addtestcase')"><font
			face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
	</tr>
</table>
<br>
<table width="100%">

    <tr bgcolor="#C3D9FF" width="100%">
        <td width="8%"><b>TestCaseId</b></td>
        <td width="20%"><b>Functionality</b></td>
        <td width="22%"><b>Description</b></td>
        <td width="20%"><b>Expected Result</b></td>
       
    </tr>
    <%
    int k=1;
     for (Iterator i = l.iterator(); i.hasNext();k++ ) {
            TqmPtcm t =(TqmPtcm)i.next();
            String ptcid     =   t.getPtcid();
            String func      =   t.getFunctionality();
            String desc      =   t.getDescription();
            String reslt     =   t.getExpectedresult();
            String project   =   GetProjects.getProjectName(((Integer)t.getPid()).toString());
            String created   =   GetProjectManager.getUserName(t.getCreatedby());

            java.util.Date date =t.getCreatedon();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
            String requestedOn  =   sdf.format(date);

            project=project.replace(":"," v");
            String funcTitle=func;
            String descTitle=desc;
            String rsltTitle=reslt;
            if(func.length()>30){
                func=func.substring(0,30)+"...";
                }
            if(desc.length()>30){
                desc=desc.substring(0,30)+"...";
                }
            if(reslt.length()>30){
                reslt=reslt.substring(0,30)+"...";
                }


%>
   <%
                if(( k % 2 ) != 0)
                {
%>
	<tr bgcolor="white" height="22">
		<%
                }
                else
                {
%>

	<tr bgcolor="#E8EEF7" height="22">
		<%
                }
%>
        <td><input type="checkbox" name="addtestcase" value="<%= ptcid %>"><a href="viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%></a></td>
      
        <td title="<%=funcTitle%>"><%=func%></td>
        <td title="<%=descTitle%>"><%=desc%></td>
        <td title="<%=rsltTitle%>"><%=reslt%></td>
      
    </tr>



               <%
                }
                }
            catch(Exception e){
                logger.error(e.getMessage());
                }
%>
        <tr>
            <td colspan="2" align="right"><input type="submit" name="Add TestCase"></td>
            <td colspan="2" align="left"><input  type="reset"  name="Reset"></td>
        </tr>
    </table>
    </form>
    </body>
</html>