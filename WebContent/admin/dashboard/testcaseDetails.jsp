<%-- 
    Document   : testcaseDetails
    Created on : Jul 22, 2010, 3:56:23 PM
    Author     : Tamilvelan
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page  import="com.eminent.tqm.TqmTestcaseexecution,com.eminent.util.GetProjectMembers,java.util.*,java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%@ include file="/header.jsp"%>
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

		

		Logger logger = Logger.getLogger("Testcase Details");
		
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
       <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
       <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
       
    </head>
    <body>
        
            <table width="100%">
            <tr bgcolor="#C3D9FF" >
                <td width="100%"> <b>Test Case Details</b></td>
                            </tr>
        </table>
        <br>
        <br>

       <%
                String ptcID    =request.getParameter("ptcID");
                int statId    =   Integer.parseInt(request.getParameter("statusId"));
                int tceId    =   Integer.parseInt(request.getParameter("tceId"));
                String issueId    =   request.getParameter("issueid");
                String assignedto =   request.getParameter("assignedto");
                logger.info("Status"+issueId);
                TqmTestcaseexecution ptc=TestCasePlan.viewExecutionTestcase(((Integer)tceId).toString(), ptcID);

              try{
                    if(ptc!=null){
                         HashMap statusMap   =   TestCasePlan.getTescaseStatus();
                        String functionality    =   ptc.getPtcid().getFunctionality();
                        String ptcId            =   ptc.getPtcid().getPtcid();
                        String desc             =   ptc.getPtcid().getDescription();
                        String expected         =   ptc.getPtcid().getExpectedresult();
                        String createdBy        =   GetProjectManager.getUserName(ptc.getPtcid().getCreatedby());
                        String projectName      =   GetProjects.getProjectName(ptc.getPtcid().getPid().toString());
                        String moduleName       =   GetProjects.getModuleName(ptc.getPtcid().getMid().toString());
                        String planName         =   ptc.getTqmTestcaseexecutionplan().getPlanname();
                        String planCreated      =   GetProjectManager.getUserName(ptc.getTqmTestcaseexecutionplan().getCreatedby().getUserid());
                        String refIssueid       =   ptc.getIssuereference();
                        String assignedTo        =   ptc.getAssignedto().getFirstname();
                        String status           =   (String)statusMap.get(ptc.getStatusid());



                        HashMap hm =new HashMap<Integer,String>();
                        hm.put(new Integer(0), "Yet to Test");
                        hm.put(new Integer(1), "Not Applicable");
                        hm.put(new Integer(2), "Not Run");
                        hm.put(new Integer(3), "Failed");
                        hm.put(new Integer(4), "Passed");

                         projectName=projectName.replace(":"," v");
                        %>
                        <table width="100%" id="testcases">
                             <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Test Plan Name</b></td><td><%=planName%></td>   <td><b>Plan Created By</b></td><td><%=planCreated%></td>
                            </tr>
                             <tr >
                                <td width="15%"><b>Project</b></td><td><%=projectName%></td>   <td><b>Module</b></td><td><%=moduleName%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Test Case ID</b></td><td><%=ptcId%></td>   <td><b>Created By</b></td><td><%=createdBy%></td>
                            </tr>
                            <tr >
                                <td><b>Functionality</b></td><td colspan="3"><%=functionality%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Description</b></td><td colspan="3"><%=desc%></td>
                            </tr>
                            <tr >
                                <td><b>Expected Result</b></td><td colspan="3"><%=expected%></td>
                            </tr>
                             <tr bgcolor="#E8EEF7">
                                <td><b>Status</b></td>
                                <td ><%=status%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <%

                                    if(refIssueid!=null){

                                     %>
                                  <b>Reference Issue:</b>  <%=refIssueid%>
                                  <%
                                    }
                                        %>
                                </td>
                                		<td width="12%"><B>AssignedTo</B></td>

		<td width="24%"><%=assignedTo%></td>
                            </tr>
                            

                        </table>

                       <iframe src="<%=request.getContextPath()%>/admin/tqm/testExecutionComments.jsp?ptcID=<%=ptcID%>&tceId=<%= tceId %>"
	scrolling="auto" frameborder="2" height="60%" width="100%"></iframe>

                        <%
                    }
                    else{
                         %>
            <br>
            <br>
            <br>
            <table align="center">
            <tr>
                <td width="100%"><b style="color:red">Test Case not available.</b></td>
            </tr>
            </table>
            <%
                    }
                }
                catch(Exception e){
                    logger.error(e.getMessage());
                }
        %>
    </body>
</html>

