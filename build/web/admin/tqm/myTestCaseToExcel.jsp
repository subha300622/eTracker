<%-- 
    Document   : myTestCaseToExcel
    Created on : Jan 24, 2014, 6:55:32 PM
    Author     : E0288
--%>

<%@ page language="java"
         contentType="application/vnd.ms-excel;"
         pageEncoding="UTF-8"%>
<%@page import="com.eminent.tqm.TqmTestcaseexecutionresult"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page  import="com.pack.StringUtil,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmPtcm,com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers,java.util.*,org.apache.log4j.*"%>
<%

    response.setHeader("Content-Disposition", "attachment; filename=\"myTestCaseExcelExport.xls\""); 

        session.setAttribute("forwardpage","/admin/tqm/listPTCTest.jsp");



	//Configuring log4j properties
	

	Logger logger = Logger.getLogger("myTestCasesToExcel");
	

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
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
         <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    </head>
    <body>
        
        <%
            int userId  =   (Integer)session.getAttribute("uid");
            HashMap <String,String> testCaseStatus=IssueDetails.getTestCaseStatus();
            HashMap statusMap   =   TestCasePlan.getTescaseStatus();
            
            List l  =   null;
            List<String> ptcIdList=new ArrayList<String>();
            try{
                int adminId =   GetProjectMembers.getAdminID();
                
                String pId  =   request.getParameter("pid");

               if(pId!=null){
                    l =TqmUtil.listProjectTC(Integer.parseInt(pId));
                }else{
                    l   =   TqmUtil.listUserPTCTest(userId);
                }
                HashMap issueTestCaseMap=new HashMap();
                if(l!=null){
                    int a=0;
                    for (Iterator it = l.iterator(); it.hasNext();a++ ) {
                        TqmPtcm t =(TqmPtcm)it.next();
                        String ptcid     =   t.getPtcid();
                        ptcIdList.add(ptcid);
                    }
                    if(ptcIdList!=null && !ptcIdList.isEmpty()){
                        issueTestCaseMap=TestCasePlan.getAllIssueId(ptcIdList);
                    }
                }
                
                 
                %>

<table width="100%" id="testcase">
 <tr bgcolor="#C3D9FF" >
        <td width="6%"><b>TestCaseId</b></td>
        <td width="6%"><b>IssueId</b></td>
        <td width="10%"><b>Project</b></td>
        <td width="10%"><b>Module</b></td>
        <td width="18%"><b>Functionality</b></td>
        <td width="20%"><b>Description</b></td>
        <td width="20%"><b>Expected Result</b></td>
        <%
         if(adminId==userId){
        %>
        <td width="10%"><b>Createdby</b></td>
        <%}%>
       
    </tr>
  
    <%
     String created   =  null;
     for (Iterator i = l.iterator(); i.hasNext(); ) {
            TqmPtcm t =(TqmPtcm)i.next();
            String ptcid     =   t.getPtcid();
            String func      =   t.getFunctionality();
            String desc      =   t.getDescription();
            String reslt     =   t.getExpectedresult();
            String project   =   GetProjects.getProjectName(((Integer)t.getPid()).toString());
            String module    =   GetProjects.getModuleName(((Integer)t.getMid()).toString());

            if(adminId==userId){
                created   =   GetProjectManager.getUserName(t.getCreatedby());
            }



            String issueid="";
            if(issueTestCaseMap.get(ptcid)!=null){
                    issueid=(String)issueTestCaseMap.get(ptcid);
            }
            project=project.replace(":"," v");
%>
	<tr bgcolor="white" height="22">
	
<td><a   href="viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%> </a>
         <%if(!TqmUtil.isPtcExist(ptcid)){%>
         <img alt="Common Test Case" title="Common Test Case" src="<%=request.getContextPath()%>/images/tick.png">
         <%}%>
   </td>
        <td><%=issueid%></td>
   <td><%=project%></td>
        <td><%=module%></td>
        
        <td ><%=StringUtil.encodeHtmlTag(func)%></td>
        <td ><%=StringUtil.encodeHtmlTag(desc)%></td>
        <td ><%=StringUtil.encodeHtmlTag(reslt)%></td>
        <%
         if(adminId==userId){
        %>
        <td><%=created%></td>
        <%}%>
        
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
