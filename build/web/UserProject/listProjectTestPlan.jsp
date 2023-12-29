<%-- 
    Document   : listProjectTestPlan
    Created on : 9 Aug, 2011, 10:29:25 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="dashboard.TestCases"%>
<%@page  import="dashboard.CheckCategory,com.eminent.tqm.TestCasePlan,java.text.SimpleDateFormat, com.eminent.tqm.TqmTestcaseexecutionplan,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmIssuetestcases, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%
//Configuring log4j properties
 
    Logger logger = Logger.getLogger("List Execution Plan");
  
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

        <!-- Demo stuff -->
        <link class="ui-theme" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/cupertino/jquery-ui.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function()
            {
                $("#myTable").tablesorter({
                    // change the multi sort key from the default shift to alt button 
                    sortMultiSortKey: 'altKey'
                });

            }
            );
          function call(theForm)
                {
                var x = document.getElementById("pid").value;
                        theForm.action = 'listProjectTestPlan.jsp?pid='+ x;
                        theForm.submit();
                }
    </script>
         <!--Edit by mukesh -->
    </head>
    <body>
    
        <%String pId = request.getParameter("pid");
        //Getting User Id and Role
                            Integer role = (Integer) session.getAttribute("Role");
                            Integer uid = (Integer) session.getAttribute("userid_curr");
                            int roleValue = role.intValue();
                            int uidValue = uid.intValue();
        //Displaying all the projects for Admin role
                            HashMap<String, String> projects = null;
                                if (roleValue == 1) {
                                    projects = GetProjectManager.getProjects();
                                } else {
                                    //Displaying only assigned projects to other roles
                                    projects = GetProjectManager.getUserProjects(uidValue);
                                }
                                Collection se1 = projects.keySet();
                              
                                
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td align="left"><b> Test Cases Execution Plan :<%=GetProjects.getProject(Integer.parseInt(pId))%></b></td>
                <td align="center">Export to <b><a href="excelTestPlan.jsp?pid=<%=pId%>">Excel</a> </b></td>
               
                 <td align="right" >  <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                   <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 

                        <%
                          Iterator iter3 = se1.iterator();
                            int projectId = 0;
                                while (iter3.hasNext()) {
                                    String key = (String) iter3.next();
                                    String nameofproject = (String) projects.get(key);
            //      logger.info("Userid"+key);
                                    //      logger.info("Name"+nameofuser);
                                    projectId = Integer.parseInt(key); 
                                    if (projectId == Integer.parseInt(pId)) {
                                        %>
                            <option value="<%=pId%>" selected><%=nameofproject%></option>
                            <%
                            } else {     %>
                            <option value="<%=projectId%>"><%=nameofproject%></option>
                            <% } }%>
                        </select></form></td>
                         <!-- edit by mukesh-->
            </tr>

        </table>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            int userId = (Integer) session.getAttribute("uid");

            String project = GetProjects.getProjectName(pId);
            String cases[][] = TestCases.showTestCases(pId);
            int noOfTestcases = cases.length;
            String category = CheckCategory.getProjectCategory(pId);
            logger.info("Pid in list test plan" + pId);
            List l = null;
            long startRetriveTime = System.currentTimeMillis();

            try {
                if (pId != null) {
                    l = TestCasePlan.listProjectPlan(pId);
                } else if (roleId == 1) {
                    l = TestCasePlan.listPlan();
                } else {
                    l = TestCasePlan.listUserPlan(userId);
                }
                long endRetriveTime = System.currentTimeMillis();

                //            logger.info("Time Taken for retriving values from DB"+(endRetriveTime-startRetriveTime));
                int noOfRecords = l.size();
        %>
        <br>
        <table width="100%">
            <tr>
                <td width="5%">
                    <%
                        if (category.equalsIgnoreCase("SAP Project")) {
                    %>
                    <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pId%>">Business Process Map</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
    <!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pId%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
                    <%
                        }
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;

                    <%
                        if (noOfTestcases > 0) {
                    %>              <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pId%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pId%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;

                    <%}%>

                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pId%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pId%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pId%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                  <%if (project.contains("eTracker")) {%>
                    <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
                          <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pId%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
        </table>
        <table width="100%">

            <tr height="10">
                <td align="left" width="80%">This list shows <b> <%=noOfRecords%></b>  Test Case Execution Plan.</td>
                <%
                    if (category.equalsIgnoreCase("SAP Project")) {
                %>
                <td align="right"><a href="<%= request.getContextPath()%>/admin/tqm/newSAPExecutionPlan.jsp?pid=<%=pId%>">Create Test Execution Plan</a></td>
                <%
                } else {
                %>
                <td align="right"><a href="<%= request.getContextPath()%>/admin/tqm/executionPlan.jsp?pid=<%=pId%>">Create Test Execution Plan</a></td>
                <%}%>
            </tr>
        </table>
        <br>
        <table width="100%" id="myTable" class="tablesorter">
            <thead>
                <tr bgcolor="#C3D9FF" width="100%">
                    <th  class="header" width="13%"><b>Test Plan</b></th>
                    <th  class="header" width="10%"><b>Test Result</b></th>
                    <th  class="header" width="5%"><b>Build #</b></th>
                    <th  class="header" width="8%"><b>Status</b></th>
                    <th  class="header" width="10%"><b>Quality Manager</b></th>
                    <th  class="header" width="10%"><b>Created By</b></th>
                    <th  class="header" width="10%"><b>Planned Start Date</b></th>
                    <th  class="header" width="10%"><b>Planned End Date</b></th>
                    <th  class="header" width="10%"><b>Test Cases</b></th>
                    <th  class="header" width="7%"><b>Completion %</b></th>
                </tr>
            </thead> 
            <tbody> 
                <%
                    int k = 1;
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                    String buildno = null, qManager = null, StartDate = null, EndDate = null, createdBy;
                    Date pStart = null, pEnd = null;
                    long processstartTime = System.currentTimeMillis();
                    HashMap per = new HashMap();
                    for (Iterator i = l.iterator(); i.hasNext();) {
                        TqmTestcaseexecutionplan t = (TqmTestcaseexecutionplan) i.next();
                        int tepId = t.getTepid();
                        per.put(tepId, TestCasePlan.calculatePercentage(((Integer) tepId).toString()));
                    }
                    List mapValues = new ArrayList(per.values());
                    List mapKeys = new ArrayList(per.keySet());
                    Collections.sort(mapValues);
                    Collections.reverse(mapValues);
                    LinkedHashMap<Integer, Float> orderByPer = new LinkedHashMap();
                    Iterator valueIt = mapValues.iterator();
                    while (valueIt.hasNext()) {
                        Float val = (Float) valueIt.next();
                        Iterator keyIt = mapKeys.iterator();
                        while (keyIt.hasNext()) {
                            Integer key = (Integer) keyIt.next();
                            if (per.get(key).toString().equalsIgnoreCase(val.toString())) {
                                per.remove(key);
                                mapKeys.remove(key);
                                orderByPer.put(key, val);
                                break;
                            }
                        }
                    }
                    for (Map.Entry<Integer, Float> entry : orderByPer.entrySet()) {

                        for (Iterator i = l.iterator(); i.hasNext();) {

                            long startTime = System.currentTimeMillis();
                            TqmTestcaseexecutionplan t = (TqmTestcaseexecutionplan) i.next();
                            if (entry.getKey() == t.getTepid()) {
                                k++;
                                int pid = t.getPid();
                                int tepId = t.getTepid();
                                String name = t.getPlanname();
                                String status = t.getTqmTestcaseplanstatus().getStatus();
                                buildno = t.getBuildno();
                                qManager = t.getQualitymanager().getFirstname();
                                createdBy = t.getCreatedby().getFirstname();
                                pStart = t.getPlannedstart();
                                pEnd = t.getPlannedend();
                                StartDate = sdf.format(pStart);
                                EndDate = sdf.format(pEnd);
                %>
                <%
                    if ((k % 2) != 0) {
                %>
                <tr bgcolor="#E8EEF7" height="22">
                    <%                } else {
                    %>

                <tr bgcolor="white" height="22">
                    <%                    }
                    %>
                    <td title="<%=name%>"><a href="<%=request.getContextPath()%>/UserProject/editTestPlan.jsp?planId=<%=tepId%>&pId=<%=pId%>"><%=name%></a></td>
                    <td><a href="<%= request.getContextPath()%>/admin/dashboard/executionChart.jsp?planId=<%=tepId%>&pid=<%=pid%>"><%=GetProjects.getProjectName(((Integer) pid).toString())%></a></td>

                    <td title="<%=buildno%>"><%=buildno%></td>
                    <td title="<%=status%>" <%if(status.equalsIgnoreCase("Completed")){%> style="background-color: green;color: white ;"<%}%>><%=status%></td>
                    <td title="<%=qManager%>"><%=qManager%></td>
                    <td title="<%=createdBy%>" ><%=createdBy%></td>
                    <td title="<%=StartDate%>"><%=StartDate%></td>
                    <td title="<%=EndDate%>"><%=EndDate%></td>
                    <%
                        int size = TqmUtil.getTceTestcases(tepId);
                        int remtestcase = 0;

                        // This check is for BPM. if test case created via bpm then this logic is applicable
                        if (category.equalsIgnoreCase("SAP Project")) {
                            remtestcase = TestCasePlan.listNoModulePTCForSAP(pid, tepId);
                        } else {
                            remtestcase = TestCasePlan.listNoModulePTC(pid, tepId);
                        }

                        //      remtestcase = TestCasePlan.listNoModulePTC(pid, tepId);

                        if (size > 0 && (!status.equalsIgnoreCase("Completed") && !status.equalsIgnoreCase("Aborted"))) {
                    %>
                    <td><a href="<%=request.getContextPath()%>/UserProject/viewTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">View(<%=size%>)</a>       |  <a href="addTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">Add(<%=remtestcase%>)</a></td>
                    <%
                    } else if (size > 0) {
                    %>
                    <td><a  href="<%=request.getContextPath()%>/UserProject/viewTEP.jsp?tepId=<%=tepId%>&pid=<%=pid%>&qm=<%= t.getQualitymanager().getUserid()%>&edate=<%=EndDate%>">View (<%=size%>)</a></td>
                    <%
                    } else {
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
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }
                %>
            </tbody>
        </table>
    </body>
</html>

