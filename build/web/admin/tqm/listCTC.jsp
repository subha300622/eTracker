<%-- 
    Document   : listIssueTestCases
    Created on : Dec 9, 2009, 9:36:43 AM
    Author     : Administrator
--%>

<%@page  import="com.eminent.tqm.TqmCtcm,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmIssuetestcases, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%


        session.setAttribute("forwardpage","/admin/tqm/listPTC.jsp");



	//Configuring log4j properties
	
	Logger logger = Logger.getLogger("List CTC");
	
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

    </head>
    <body>
        <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td align="left"><b> Common Test Cases</b></td>

	</tr>

        </table>
        <%
            try{
                List l =TqmUtil.listCTC();
                int noOfRecords =   l.size();
                %>
                <br>
<table width="100%">

	<tr height="10">
		<td align="left" width="80%">This list shows <b> <%=noOfRecords %></b> Common Test Cases.</td>
     <!--           <td align="right"><a href="createPTC.jsp">Create Test Case</a></td> -->
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
            TqmCtcm t =(TqmCtcm)i.next();
            String ctcid     =   t.getCtcid();
            String func      =   t.getFunctionality();
            String desc      =   t.getDescription();
            String reslt     =   t.getExpectedresult();
          

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
<td><a href="viewCTC.jsp?ctcID=<%=ctcid%>"><%=ctcid%></a></td>
       
        <td title="<%=func%>"><%=func%></td>
        <td title="<%=desc%>"><%=desc%></td>
        <td title="<%=reslt%>"><%=reslt%></td>
      
    </tr>



               <%
                }
                }
            catch(Exception e){
                logger.error(e.getMessage());
                }
%>
    </table>
    </body>
</html>
