<%-- 
    Document   : uploadIssues
    Created on : 21 Nov, 2016, 1:58:16 PM
    Author     : Muthu
--%>


<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.eminentlabs.userBPM.ViewBPM"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="com.eminent.util.ProjectFinder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="dashboard.TestCases"%>
<%@page import="dashboard.CheckCategory"%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminent.issue.ApmTeam"%>
<%@page import="com.eminentlabs.mom.BestPMTeamBean"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminentlabs.mom.formbean.PMReportFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("BestPMandTeamReport");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>



    </head>
    <jsp:useBean id="uic" class="com.eminent.issue.controller.UploadIssuesController"></jsp:useBean>
    <%
        uic.setAll(request, pageContext.getServletContext());

        String pid = request.getParameter("pid");
        if (pid == null) {
            pid = uic.getPid();
        }
        String project = GetProjects.getProjectName(pid);
        String category = "NA";
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

        if (project != null) {
            category = CheckCategory.getCategory(project);
        }
        HashMap companyMap = ViewBPM.getCompany(Integer.parseInt(pid));
        LinkedHashMap company = GetProjectMembers.sortHashMapByKeys(companyMap, true);

        String cases[][] = TestCases.showTestCases(pid);
        int noOfTestcases = cases.length;

        String clientName = ViewBPM.getClientName(Integer.parseInt(pid));
    %>
    <body>
        <%@ include file="/header.jsp"%>



       
        <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
            <tr>  <td style="width:30%;text-align: center"> Upload Issues </td>
                <td style="text-align:center"></td>

            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">Business Process Map Dashboard View</a>&nbsp;&nbsp;&nbsp;
                    <% if (category.equalsIgnoreCase("SAP Project")) {
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
    <!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
                    <%
                        }
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;

                    <%
                        if (noOfTestcases > 0) {
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                    <%if (project.contains("eTracker")) {%>
                    <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
        </table>
                 <br/>
                  <br/>
                   <br/>
                   <%if (uic.getStatus()== null) {%>

            <%} else {%>
            <div class="success" style="color: #00f;"><%=uic.getStatus()%></div>
            <%}%>
            
            <br/>
        <form name="theForm" enctype="multipart/form-data" method="post" action="uploadIssues.jsp" onsubmit="return validate()">
            <table width="70%" bgColor=#E8EEF7 border="0" align="center">
                <tr>
                    <td height="21" style="width: 15%;"><b>
                            Project
                        </b></td>   

                    <td>
                        <select id="pid" name="pid" size=1>                 

                            <%
                                //Displaying all the projects for Admin role
                                Iterator iter3 = se1.iterator();
                                int projectId = 0;
                                while (iter3.hasNext()) {

                                    String key = (String) iter3.next();
                                    String nameofproject = (String) projects.get(key);
                                    //      logger.info("Userid"+key);
                                    //      logger.info("Name"+nameofuser);
                                    projectId = Integer.parseInt(key);
                                    if (projectId == Integer.parseInt(pid)) {

                            %>
                            <option value="<%=pid%>" selected><%=nameofproject%></option>
                            <%
                            } else {%>
                            <option value="<%=projectId%>"><%=nameofproject%></option>
                            <% }
                                }%>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td height="21" style="width: 15%;"><b>
                            Upload Excel
                        </b></td>   

                    <td>

                        <input type="file" id="files" name="files" class="file" /></td>
                </tr>
                <tr>
                    <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                </tr>
                <!--                    <tr>
                                        <td></td><td ><a target="_blank" href="<%=request.getContextPath()%>/Reimbursement_vouchers/ReimbursementVoucher.xls">Click here to download format</a></td>
                                    </tr>-->
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Submit" name="submit" id="submit"> </td>
                </tr>             

            </table>
        </form>
        <br/>
        <script type="text/javascript">




            function validate()
            {

                var extensions = new Array("xls", "xlsx");

                var image_file = $('#files').val();

                var image_length = $.trim(image_file).length;

                var pos = image_file.lastIndexOf('.') + 1;

                var ext = image_file.substring(pos, image_length);

                var final_ext = ext.toLowerCase();

                for (i = 0; i < extensions.length; i++)
                {
                    if (extensions[i] == final_ext)
                    {
                        document.getElementById('submit').value = 'Processing';
                        document.getElementById('submit').disabled = true;
                        document.getElementById('progressbar').style.visibility = 'visible';
                        return true;
                    }
                }

                alert("You must upload a file with one of the following extensions: " + extensions.join(', ') + ".");
                return false;
                monitorSubmit();
            }

        </script>
    </body>
</html>
