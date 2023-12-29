<%-- 
    Document   : testcaseView
    Created on : 13 Aug, 2010, 10:39:03 AM
    Author     : Tamilvelan
--%>
<%@page  import="com.eminent.util.GetProjectMembers,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties
	Logger logger = Logger.getLogger("Testcase View");
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
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/XMLHttpRequest.js"></script>
       
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
                String ptcID=request.getParameter("testcaseid");
                int userId  =  (Integer)session.getAttribute("uid");
                TqmPtcm ptc=TqmUtil.viewPTC(ptcID);
                try{
                    if(ptc!=null){
                        String functionality    =   ptc.getFunctionality();
                        String ptcId            =   ptc.getPtcid();
                        String desc             =   ptc.getDescription();
                        String expected         =   ptc.getExpectedresult();
                        String pId              =   ptc.getPid().toString();
                        int creby            =   ptc.getCreatedby();
                        String createdBy        =   GetProjectManager.getUserName(creby);
                        String projectName      =   GetProjects.getProjectName(pId);
                        String moduleName      =   GetProjects.getModuleName(ptc.getMid().toString());

                         projectName=projectName.replace(":"," v");
                         int role	= (Integer)session.getAttribute("Role");

                         HashMap<String,String> userDetail=GetProjectMembers.getTeamMembers(pId);
                         if(userDetail.get(((Integer)userId).toString())!=null||role==1){
                        %>
                        <table width="100%" id="ptc">
                             <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Project</b></td><td><%=projectName%></td>   <td width="7%"><b>Module</b></td><td><%=moduleName%></td>
                            </tr>
                            <tr >
                                <td width="15%"><b>Test Case ID</b></td><td><%=ptcId%></td>   <td width="7%"><b>Created By</b></td><td><%=createdBy%></td>
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
                            
                        </table>
                            <iframe src="<%=request.getContextPath()%>/executionHistory.jsp?ptcID=<%=ptcID%>"
	scrolling="auto" frameborder="2" height="70%" width="100%"></iframe>
                        <%
                        }else{
%>
                            <table align="center">
                            <tr>

                                 <td width="100%"><b style="color:red">You are not authorized to access this Testcase.</b></td>
                            </tr>
                            </table>
<%
                        }
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

