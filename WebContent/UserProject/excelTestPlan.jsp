<%-- 
    Document   : excelTestPlan
    Created on : May 14, 2014, 9:15:17 AM
    Author     : E0288
--%>
<%@ page language="java"
         contentType="application/vnd.ms-excel;"
         pageEncoding="UTF-8"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="dashboard.TestCases"%>
<%@page  import="dashboard.CheckCategory,com.eminent.tqm.TestCasePlan,java.text.SimpleDateFormat, com.eminent.tqm.TqmTestcaseexecutionplan,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmIssuetestcases, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%
//Configuring log4j properties
	
	Logger logger = Logger.getLogger("excelTestPlan");

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
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
            response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\""); 
            int roleId  =   (Integer)session.getAttribute("Role");
            int userId  =   (Integer)session.getAttribute("uid");
            String pId  =   request.getParameter("pid");
            String category =   CheckCategory.getProjectCategory(pId);
            logger.info("Pid in list test plan"+pId);
            List l  =null;
             long startRetriveTime = System.currentTimeMillis();

            try{
                if(pId!=null){
                    l   =   TestCasePlan.listProjectPlan(pId);
                }else if(roleId==1){
                     l   =   TestCasePlan.listPlan();
                }
                else{
                    l   =   TestCasePlan.listUserPlan(userId);
                }
             long endRetriveTime = System.currentTimeMillis();

 //            logger.info("Time Taken for retriving values from DB"+(endRetriveTime-startRetriveTime));
                %>
                
<br>
<table width="100%" id="myTable" class="tablesorter" border="1">
<thead>
    <tr bgcolor="#C3D9FF" width="100%">
        <td width="13%"><b>Test Plan</b></td>
        <td width="10%"><b>Test Result</b></td>
        <td width="5%"><b>Build #</b></td>
        <td width="8%"><b>Status</b></td>
        <td width="10%"><b>Quality Manager</b></td>
        <td width="10%"><b>Created By</b></td>
        <td width="10%"><b>Planned Start Date</b></td>
        <td width="10%"><b>Planned End Date</b></td>
        <td width="10%"><b>Test Cases</b></td>
        <td width="7%"><b>Completion %</b></td>
    </tr>
    </thead> 
<tbody> 
    <%
    int k=1;
    SimpleDateFormat sdf    =   new SimpleDateFormat("dd-MMM-yy");
    String buildno  =   null, qManager  =   null, StartDate=null, EndDate   =   null,createdBy  ;
    Date pStart =   null, pEnd  =   null;
     long processstartTime = System.currentTimeMillis();
     HashMap per=new HashMap();
     for (Iterator i = l.iterator(); i.hasNext();) {
            TqmTestcaseexecutionplan t =(TqmTestcaseexecutionplan)i.next();
            int tepId    =   t.getTepid();
            per.put(tepId,TestCasePlan.calculatePercentage(((Integer)tepId).toString()));
     }
     List mapValues = new ArrayList(per.values());
     List mapKeys = new ArrayList(per.keySet());
     Collections.sort(mapValues);
     Collections.reverse(mapValues);
     LinkedHashMap<Integer, Float>  orderByPer = new LinkedHashMap();
        Iterator valueIt = mapValues.iterator();
        while (valueIt.hasNext()) {
            Float val =(Float) valueIt.next();
            Iterator keyIt = mapKeys.iterator();
            while (keyIt.hasNext()) {
                Integer key =(Integer) keyIt.next();
                if (per.get(key).toString().equalsIgnoreCase(val.toString())) {
                    per.remove(key);
                    mapKeys.remove(key);
                    orderByPer.put(key, val);
                    break;
                }
            }
        }
     for (Map.Entry<Integer, Float> entry : orderByPer.entrySet() ) {
         
     for (Iterator i = l.iterator(); i.hasNext(); ) {
         
            long startTime = System.currentTimeMillis();
            TqmTestcaseexecutionplan t =(TqmTestcaseexecutionplan)i.next();
            if(entry.getKey()==t.getTepid()){
                k++;
            int pid      =   t.getPid();
            int tepId    =   t.getTepid();
            String name  =   t.getPlanname();
            String status=   t.getTqmTestcaseplanstatus().getStatus();
            buildno      =   t.getBuildno();
            qManager     =   t.getQualitymanager().getFirstname();
            createdBy     =   t.getCreatedby().getFirstname();
            pStart       =   t.getPlannedstart();
            pEnd         =   t.getPlannedend();
            StartDate    =   sdf.format(pStart);
            EndDate      =   sdf.format(pEnd);
          %>
   <%
                if(( k % 2 ) != 0)
                {
%>
	<tr bgcolor="#E8EEF7" height="22">
		<%
                }
                else
                {
%>

	<tr bgcolor="white" height="22">
		<%
                }
%>
  <td><%=name%></td>
<td><%=GetProjects.getProjectName(((Integer)pid).toString())%></td>
        <td title="<%=buildno%>"><%=buildno%></td>
         <td title="<%=status%>"><%=status%></td>
        <td title="<%=qManager%>"><%=qManager%></td>
        <td title="<%=createdBy%>"><%=createdBy%></td>
        <td title="<%=StartDate%>"><%=StartDate%></td>
        <td title="<%=EndDate%>"><%=EndDate%></td>
         <%
        int size        =   TqmUtil.getTceTestcases(tepId);
        int remtestcase =   0;
        
        // This check is for BPM. if test case created via bpm then this logic is applicable
        if(category.equalsIgnoreCase("SAP Project")){
            remtestcase = TestCasePlan.listNoModulePTCForSAP(pid, tepId);
        }else{
            remtestcase = TestCasePlan.listNoModulePTC(pid, tepId);
        }
        
  //      remtestcase = TestCasePlan.listNoModulePTC(pid, tepId);
        
        if(size>0 &&(!status.equalsIgnoreCase("Completed") && !status.equalsIgnoreCase("Aborted"))){
            %>
            <td><a href="<%=request.getContextPath()%>/UserProject/viewTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">View(<%=size%>)</a>       |  <a href="addTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">Add(<%=remtestcase%>)</a></td>
<%
        }else if(size>0){
%>
         <td><a  href="<%=request.getContextPath()%>/UserProject/viewTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">View (<%=size%>)</a></td>
<%
        }else{
%>
         <td><a href="<%=request.getContextPath()%>/UserProject/addTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">Add (<%=remtestcase%>)</a></td>
<%
       }
        %>
        <td><%=entry.getValue()%></td>
    </tr>



               <%
               long endTime = System.currentTimeMillis();
    //           logger.info("Total elapsed time in execution of this Value:"+ (endTime-startTime));
                }
                  long processsEndTime = System.currentTimeMillis();
  //              logger.info("Total Process Time"+(processsEndTime-processstartTime));
                }
     }
            }
            catch(Exception e){
                logger.error(e.getMessage());
                }
%>
</tbody>
    </table>
    </body>
</html>

