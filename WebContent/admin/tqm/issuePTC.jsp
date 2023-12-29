<%-- 
    Document   : issuePTC
    Created on : 17 Jun, 2010, 3:52:22 PM
    Author     : ADAL
--%>
<%@page  import="java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%@ include file="/header.jsp"%>
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

		

		Logger logger = Logger.getLogger("Test case Comments");
		
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
            <tr bgcolor="#C3D9FF" width="100%">
                <td width="100%"> <b>Test Case Details</b></td>
                            </tr>
        </table>
        <br>
        <br>

       <%
                String ptcID    =request.getParameter("ptcID");
                int statId    =   Integer.parseInt(request.getParameter("statusid"));
                String issueId    =   request.getParameter("issueid");
                logger.info("Status"+issueId);
                TqmPtcm ptc=TqmUtil.viewPTC(ptcID);
              try{
                    if(ptc!=null){
                        String functionality    =   ptc.getFunctionality();
                        String ptcId            =   ptc.getPtcid();
                        String desc             =   ptc.getDescription();
                        String expected         =   ptc.getExpectedresult();
                        String createdBy        =   GetProjectManager.getUserName(ptc.getCreatedby());
                        String projectName      =   GetProjects.getProjectName(ptc.getPid().toString());
                        String moduleName       =   GetProjects.getModuleName(ptc.getMid().toString());



                        HashMap hm =new HashMap<Integer,String>();
                        hm.put(new Integer(0), "Yet to Test");
                        hm.put(new Integer(1), "Not Applicable");
                        hm.put(new Integer(2), "Not Run");
                        hm.put(new Integer(3), "Failed");
                        hm.put(new Integer(4), "Passed");

                         projectName=projectName.replace(":"," v");
                        %>
                        <table width="100%">
                             <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Project</b></td><td><%=projectName%></td>   <td><b>Module</b></td><td><%=moduleName%></td>
                            </tr>
                            <tr >
                                <td width="15%"><b>Test Case ID</b></td><td><%=ptcId%></td>   <td><b>Created By</b></td><td><%=createdBy%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Functionality</b></td><td colspan="3"><%=functionality%></td>
                            </tr>
                            <tr >
                                <td><b>Description</b></td><td colspan="3"><%=desc%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Expected Result</b></td><td colspan="3"><%=expected%></td>
                            </tr>
                             <tr>
                                <td><b>Status</b></td>
                                <td colspan="3">
                                  <%=hm.get(statId)%>
                                </td>
                            </tr>
                            
                        </table>
                        
                       <iframe
	src="<%=request.getContextPath()%>/admin/tqm/testComments.jsp?ptcID=<%=ptcID%>&issueId=<%= issueId %>"
	scrolling="auto" frameborder="2" height="40%" width="100%"></iframe>

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