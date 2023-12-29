<%-- 
    Document   : testMap
    Created on : 22 Oct, 2011, 10:44:43 PM
    Author     : Tamilvelan
--%>

<%@page import="java.util.Map"%>
<%@page import="com.eminent.util.ModuleUtil"%>
<%@page import="dashboard.CountIssue"%>
<%@page import="com.eminent.bpm.BpmPrintaccess"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="com.eminent.tqm.TqmTestcaseexecutionresult"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.tqm.TqmTestcaseresult"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.log4j.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers" %>
<%@page import="com.eminentlabs.userBPM.ViewBPM" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.LinkedHashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator,dashboard.CheckCategory,dashboard.TestCases" %>


<%
    Logger logger = Logger.getLogger("ViewProject");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta content="IE=EmulateIE8" http-equiv="X-UA-Compatible" >
    <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/bp.js?tt=05022021001" type="text/javascript"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?tt=161020151020" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-select2.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=4">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <style type="text/css">

        .compMap:first-child .upcom {
            display: none;
        }
        .compMap:nth-last-child(2) .downcom {
            display: none;
        }
        .bpMap:first-child .upbp {
            display: none;
        }
        .bpMap:nth-last-child(2) .downbp {
            display: none;
        }
        .mpMap:first-child .upmp {
            display: none;
        }
        .mpMap:nth-last-child(2) .downmp {
            display: none;
        }
        .spMap:first-child .upsp {
            display: none;
        }
        .spMap:nth-last-child(2) .downsp {
            display: none;
        }

        .scMap:first-child .upsc {
            display: none;
        }
        .scMap:nth-last-child(2) .downsc {
            display: none;
        }
        .vtMap:first-child .upvt {
            display: none;
        }
        .vtMap:nth-last-child(2) .downvt {
            display: none;
        }

        .tcMap:first-child .uptc {
            display: none;
        }
        .tcMap:nth-last-child(2) .downtc {
            display: none;
        }
        .tsMap:first-child .upts {
            display: none;
        }
        .tsMap:nth-last-child(2) .downts {
            display: none;
        }
        .tscMap tbody tr:first-child  td.up {
            display: none;
        }
        .tscMap tbody tr:nth-last-child(2) .down {
            display: none;
        }

        a img{height: 12px;}
    </style>
    <style type="text/css">
        ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
        ul li{padding: 3px 0px 3px 16px;margin: 0;}
        a{text-decoration: none;color: black;}

    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#divImageLoader").hide();
        });
        function expander(pid) {
            $("#divImageLoader").show();
            var param = 'expandAllTreeMap.jsp?pid=' + pid;
            document.theForm.action = param;
            document.theForm.submit();
        }
        function trim(str)
        {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function expand(pid) {
            $("#divImageLoader").show();
            if ($('#client').has("ul").length === 0) {
                viewCompany(pid);
                if (xmlhttp !== null) {
                    var client = document.getElementById('pid').value;

                    xmlhttp.open("GET", "/eTracker/expandTestMap.jsp?client=" + client + "&pid=" + pid + "&rand=" + Math.random(1, 10), true);
                    xmlhttp.onreadystatechange = function () {
                        callbackExpand();
                    };
                    xmlhttp.send(null);
                }
            } else {
                $('#client ul').toggle('slow');
            }
        }
        function callbackExpand() {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var comp = xmlhttp.responseText.split(";");
                    for (var j = 0; j < comp.length; j++) {
                        if (j === 1) {
                            var bpresults = comp[j - 1].split(",");
                            for (i = 0; i <= bpresults.length - 1; i++) {
                                var num = trim(bpresults[i]);
                                var test = parseInt(num);
                                viewBP(test);
                            }
                        }
                        if (j === 2) {
                            var mpresults = comp[j - 1].split(",");
                            for (i = 0; i <= mpresults.length - 1; i++) {
                                var mp = mpresults[i];
                                viewMP(mp);
                            }
                        }
                        if (j === 3) {
                            var spresults = comp[j - 1].split(",");
                            for (i = 0; i <= spresults.length - 1; i++) {
                                var sp = spresults[i];
                                viewSP(sp);
                            }
                        }
                        if (j === 4) {
                            var scresults = comp[j - 1].split(",");
                            for (i = 0; i <= scresults.length - 1; i++) {
                                var sc = scresults[i];
                                viewSC(sc);
                            }
                        }
                        if (j === 5) {
                            var vtresults = comp[j - 1].split(",");
                            for (i = 0; i <= vtresults.length - 1; i++) {
                                var vt = vtresults[i];
                                viewVT(vt);
                            }
                        }
                        if (j === 6) {
                            var tcresults = comp[j - 1].split(",");
                            for (i = 0; i <= tcresults.length - 1; i++) {
                                var tc = tcresults[i];

                                viewTC(tc);
                            }
                        }
                        if (j === 7) {
                            var tsresults = comp[j - 1].split(",");
                            for (i = 0; i <= tsresults.length - 1; i++) {
                                var ts = tsresults[i];
                                viewTS(ts);
                            }
                        }
                        if (j === 8) {
                            var tscresults = comp[j - 1].split(",");

                            for (i = 0; i <= tscresults.length - 1; i++) {
                                var tsc = tscresults[i];
                                viewTSC(tsc);
                            }
                        }
                    }
                }
            }
        }
    </script>
    <script>
        function call(theForm)
        {
            var x = document.getElementById("pid").value;
            theForm.action = 'testMap.jsp?pid=' + x;
            theForm.submit();
        }
    </script>
</head>
<%@ include file="/header.jsp"%>
<jsp:useBean id="mdu" class="com.eminent.util.ModuleUtil"/>  
<%
    String pid = request.getParameter("pid");
    Integer current_userId = (Integer) session.getAttribute("userid_curr");
    String userId = current_userId.toString();
    boolean projectAccess = false;
    int roleId = (Integer) session.getAttribute("Role");
    if (roleId != 1) {
        projectAccess = GetProjectMembers.isAssigned(userId, pid);
    } else {
        projectAccess = true;
    }
    if (projectAccess == true) {
        String project = GetProjects.getProjectName(pid);
        String category = "NA";
        if (project != null) {
            category = CheckCategory.getCategory(project);
        }
        String cases[][] = TestCases.showTestCases(pid);
        int noOfTestcases = cases.length;
        logger.info("Category :" + category);
        session.setAttribute("testMapPid", pid);
        // edit by mukesh**********************
        //Getting User Id and Role
        Integer role = (Integer) session.getAttribute("Role");
        Integer uid = (Integer) session.getAttribute("userid_curr");
        int roleValue = role.intValue();
        int uidValue = uid.intValue();
        HashMap<String, String> projects = null;
        if (roleValue == 1) {
            projects = GetProjectManager.getProjects();
        } else {
            //Displaying only assigned projects to other roles
            projects = GetProjectManager.getUserProjects(uidValue);
        }
        Collection se1 = projects.keySet();
String pname = GetProjects.getProject(Integer.parseInt(pid));
%>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF" >
        <tr style="height:15px;">
            <td border="1" align="left" width="80%">
                <b>View <%=pname%> Business Process Map </b></td>
            <td style="text-align:right;">
                <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                    <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 

                        <%                            //Displaying all the projects for Admin role
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
                    </select></form>
                <!-- edit by mukesh -->
            </td>
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
    </table><jsp:useBean id="tpa" class="com.eminent.bpm.TreePrintAccess"></jsp:useBean>
        <form name="theForm" id="theForm" method="Post">
            <div  style="text-align: right;">
            <%
                int type = 10;//default value of print authorization type
                BpmPrintaccess bpa = tpa.findByPid(pid);
                if (bpa != null) {
                    type = bpa.getType();
                }
                String mail = (String) session.getAttribute("theName");
                String url = null;
                if (mail != null) {
                    url = mail.substring(mail.indexOf("@") + 1, mail.length());
                }
                if (!url.equals("eminentlabs.net")) {
                    if (type == 1 || type == 2) {%>
            <a  href="printTreeMap.jsp?pid=<%=pid%>" target="_blank" >Print Tree</a>&nbsp;&nbsp;&nbsp;
            <%}
            } else {
                if (type == 0 || type == 1) {%>

            <a  href="printTreeMap.jsp?pid=<%=pid%>" target="_blank" >Print Tree</a>&nbsp;&nbsp;&nbsp;
            <% }
                }%>
            <a href="#" id="addAttach" onclick="showModuleAttach();" >Add document</a>&nbsp;&nbsp;&nbsp;
            <a href="#"  onclick="displayModuleAttach('<%=pid%>');" >View document</a>&nbsp;&nbsp;&nbsp;
            <a href="#" id="expander" onclick="expander('<%=pid%>');" >Expand All</a>&nbsp;&nbsp;&nbsp;
            <a  href="testMap.jsp?pid=<%=pid%>" >Collapse All</a>&nbsp;&nbsp;&nbsp;
            <div id="summary"></div>

        </div>
    </form>
    <script type="text/javascript">
        summaryOfTree('<%=pid%>');
    </script>
    <div class="loading" align="center" id="divImageLoader">
        <img src="/eTracker/images/file-progress.gif" alt="Loading..."/>  Loading ...
    </div>
    <div>
        <input type="hidden" value="<%=pid%>" id="pid"/>
        <input type="hidden" value="<%=project%>" id="pname"/>
        <ul id="mainTree">
            <%

                ArrayList<String> viewClient = ViewBPM.getClient(Integer.parseInt(pid));
                HashMap modules = GetProjects.getModules(pid);
                int companyCount = ViewBPM.getCompanyCount(Integer.parseInt(pid));
                Map<Integer, String> companyAll = ViewBPM.getAllCompany();
                for (String clientName : viewClient) {
            %>
            <li id="client">
                <div class="treeclass" onclick="javascript:viewCompany(<%=pid%>);"></div>
                <a href="#" onclick="javascript:viewCompany(<%=pid%>);"><b>Client: </b><%=clientName%> (<span id="ccount"><%=companyCount%></span>)</a>
                <span style='display:none;' onclick="javascript:editCompany(<%=pid%>);"><img style="position: realtive;"src="<%=request.getContextPath()%>/images/edit.png"/></span>
            </li>
        </ul></div>
        <%}%>

    <!-- Page overlay and pop-ups must be outside the container div to avoid them being constrained by the container -->
    <div id="overlay"></div>
    <div id="comppopup" class="popup" style="width: 450px;height: 300px">
        <h3 class="popupHeading">Add Company</h3>
        <div>
            <div style="color:red;display: none;" id="errormsg">Please enter the correct company name</div>
            <p>Enter New Company Name/Code</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd" style="margin-left: 0px">Company Name</label>
                    </td>
                    <td colspan="2">
                        <input type="text" name="comp" id='comp'/>
                    </td>
                </tr>

                <tr style="height:50px;">
                    <td>
                        <label for="pswd" style="margin-left: 0px"> Source Company  </label>
                    </td>
                    <td colspan="2">
                        <select name="srcCompany" id='srcCompany'>
                            <option value="">--Select One--</option>
                            <%for (Map.Entry<Integer, String> e : companyAll.entrySet()) {%>
                            <option value="<%=e.getKey()%>"><%=e.getValue()%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>
                <tr style="height:50px; display: none;" id="srccom">
                    <td>
                        <label for="pswd" style="margin-left: 0px"> Source Company  </label>
                    </td>
                    <td colspan="2">
                        <select name="srcCompany" id='srcCompany'>
                            <option value="">--Select One--</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input type="hidden" name="pId" id='pId' />

                        <input type="submit" value="Create Company" onclick='return createCompany(this)'/>

                        <input type="button" value="Cancel" onclick="javascript:closeCompany();"  />
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="compEditpopup" class="popup">
        <h3 class="popupHeading">Edit Company</h3>
        <div>
            <div style="color:red;display: none;" id="editcerrormsg">Please enter the correct company name</div>
            <p>Edit Company Name/Code</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Company Name</label>
                    </td>
                    <td colspan="2">
                        <input type="text" name="editcname" id='editcname'/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
                        <input type="hidden" name="editcid" id='editcid' />

                        <input type="submit" value="Update Company" onclick='return updateCompany(this)'/>

                        <input type="button" value="Cancel" onclick="javascript:closeEditCompany();"  />
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="BPpopup" class="popup">
        <h3 class="popupHeading">Add Business Process</h3>
        <div>
            <div style="color:red;display: none;" id="bperrormsg">Please enter the correct BP name</div>
            <div style="color:red;display: none;" id="createbptypeerrormsg">Please Select the correct BP Type</div>
            <p>Enter New Business Process</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Busniess Process</label>
                    </td>
                    <td>
                        <input type="text" name="bp" id='bp'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createBpType" id='createBpType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="compid" id='compid'/>
                        <input type="submit" value="Create BP" onclick="javascript:createBP();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeBP();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="BPEditpopup" class="popup">
        <h3 class="popupHeading">Edit Business Process</h3>
        <div>
            <div style="color:red;display: none;" id="bpediterrormsg">Please enter the correct BP name</div>
            <div style="color:red;display: none;" id="bptypeerrormsg">Please Select the correct BP Type</div>
            <p>Edit Business Process</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Busniess Process</label>
                    </td>
                    <td>
                        <input type="text" name="editbpname" id='editbpname'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="bpType" id='bpType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="editbpid" id='editbpid'/>
                        <input type="submit" value="Update BP" onclick="javascript:updateBP();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditBP();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="MPpopup" class="popup">
        <h3 class="popupHeading">Add Main Process</h3>
        <div>
            <div style="color:red;display: none;" id="mperrormsg">Please enter the correct MP name</div>
            <div style="color:red;display: none;" id="createmptypeerrormsg">Please Select the correct MP Type</div>
            <p>Enter New Main Process</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Main Process</label>
                    </td>
                    <td>
                        <input type="text" name="mp" id='mp'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createMpType" id='createMpType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>

                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="bpid" id='bpid'/>
                        <input type="submit" value="Create MP" onclick="javascript:createMP();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeMP();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="MPEditpopup" class="popup">
        <h3 class="popupHeading">Edit Main Process</h3>
        <div>
            <div style="color:red;display: none;" id="mpediterrormsg">Please enter the correct MP name</div>
            <div style="color:red;display: none;" id="mptypeerrormsg">Please select the correct MP Type</div>
            <p>Edit Main Process</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Main Process</label>
                    </td>
                    <td>
                        <input type="text" name="editmpname" id='editmpname'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="mpType" id='mpType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="editmpid" id='editmpid'/>
                        <input type="submit" value="Update MP" onclick="javascript:updateMP();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditMP();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="SPpopup" class="popup">
        <h3 class="popupHeading">Add Sub Process</h3>
        <div>
            <div style="color:red;display: none;" id="sperrormsg">Please enter the correct Sub Process name</div>
            <div style="color:red;display: none;" id="createsptypeerrormsg">Please select the correct Sub Process Type</div>
            <p>Enter New Sub Process</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Sub Process</label>
                    </td>
                    <td>
                        <input type="text" name="sp" id='sp'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createSpType" id='createSpType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="mpid" id='mpid'/>
                        <input type="submit" value="Create SP" onclick="javascript:createSP();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeSP();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="SPEditpopup" class="popup">
        <h3 class="popupHeading">Edit Sub Process</h3>
        <div>
            <div style="color:red;display: none;" id="spediterrormsg">Please enter the correct Sub Process name</div>
            <div style="color:red;display: none;" id="sptypeerrormsg">Please select the correct Sub Process Type</div>
            <p>Edit Sub Process</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Sub Process</label>
                    </td>
                    <td>
                        <input type="text" name="editspname" id='editspname'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="spType" id='spType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="editspid" id='editspid'/>
                        <input type="submit" value="Update SP" onclick="javascript:updateSP();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditSP();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="SCpopup" class="popup">
        <h3 class="popupHeading">Add Scenario</h3>
        <div>
            <div style="color:red;display: none;" id="scerrormsg">Please enter the correct Scenario name</div>
            <div style="color:red;display: none;" id="createsctypeerrormsg">Please enter the correct Scenario Type</div>
            <p>Enter New Scenario</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Scenario</label>
                    </td>
                    <td>
                        <input type="text" name="sc" id='sc'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createScType" id='createScType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="spid" id='spid'/>
                        <input type="submit" value="Create Scenario" onclick="javascript:createSC()"/>
                        <input type="button" value="Cancel" onclick="javascript:closeSC();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="SCEditpopup" class="popup">
        <h3 class="popupHeading">Edit Scenario</h3>
        <div>
            <div style="color:red;display: none;" id="scediterrormsg">Please enter the correct Scenario name</div>
            <div style="color:red;display: none;" id="sctypeerrormsg">Please enter the correct Scenario Type</div>
            <p>Edit Scenario</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Scenario</label>
                    </td>
                    <td>
                        <input type="text" name="editscname" id='editscname'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="scType" id='scType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="editscid" id='editscid'/>
                        <input type="submit" value="Update Scenario" onclick="javascript:updateSC();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditSC();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="VTpopup" class="popup">
        <h3 class="popupHeading">Add Variant</h3>
        <div>
            <div style="color:red;display: none;" id="vterrormsg">Please enter the correct Variant name</div>
            <p>Enter New Variant</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Variant Name</label>
                    </td>
                    <td>
                        <input type="text" name="vt" id='vt'/>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Lead Module</label>
                    </td>
                    <td>
                        <select name="lead" id='lead'>
                            <option value="">--Select One--</option>
                            <%
                                LinkedHashMap lhp = GetProjectMembers.sortHashMapByValues(modules, true);
                                LinkedHashMap im = (LinkedHashMap) lhp.clone();
                                Collection se = lhp.keySet();
                                Iterator iter = se.iterator();
                                while (iter.hasNext()) {
                                    String key = (String) iter.next();
                                    String nameofthemodule = (String) lhp.get(key);
                            %>
                            <option value="<%=key%>"><%=nameofthemodule%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Impacted Module</label>
                    </td>
                    <td>
                        <select name="impact" id='impact'>
                            <option value="">--Select One--</option>
                            <%
                                Collection set = im.keySet();
                                Iterator ite = set.iterator();
                                while (ite.hasNext()) {
                                    String key = (String) ite.next();
                                    String nameofthemodule = (String) im.get(key);
                            %>
                            <option value="<%=key%>"><%=nameofthemodule%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Data Type</label>
                    </td>
                    <td>
                        <select name="type" id='type'>
                            <option value="">--Select One--</option>
                            <option value="Master Data">Master Data</option>
                            <option value="Transaction">Transaction</option>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Classification</label>
                    </td>
                    <td>

                        <select name="calssification" id='calssification'>
                            <option value="">--Select One--</option>
                            <option value="FT">FT</option>
                            <option value="IT">IT</option>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Priority</label>
                    </td>
                    <td>
                        <select name="priority" id='priority'>
                            <option value="">--Select One--</option>
                            <option value="Core">Core</option>
                            <option value="Critical">Critical</option>
                            <option value="Essential">Essential</option>
                        </select>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createVtType" id='createVtType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="scid" id='scid'/>
                        <input type="submit" value="Create Variant" onclick="javascript:createVT();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeVT();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="VTEditpopup" class="popup">
        <h3 class="popupHeading">Edit Variant</h3>
        <div>
            <div style="color:red;display: none;" id="vtediterrormsg">Please enter the correct Variant name</div>
            <p>Edit Variant</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Variant</label>
                    </td>
                    <td>
                        <input type="text" name="editvtname" id='editvtname'/>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Lead Module</label>
                    </td>
                    <td>
                        <select name="editlead" id='editlead'>
                            <option value="">--Select One--</option>
                            <%
                                Iterator iter1 = se.iterator();
                                while (iter1.hasNext()) {
                                    String key = (String) iter1.next();
                                    String nameofthemodule = (String) lhp.get(key);
                            %>
                            <option value="<%=key%>"><%=nameofthemodule%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Impacted Module</label>
                    </td>
                    <td>
                        <select name="editimpact" id='editimpact'>
                            <option value="">--Select One--</option>
                            <%
                                Iterator ite1 = set.iterator();
                                while (ite1.hasNext()) {
                                    String key = (String) ite1.next();
                                    String nameofthemodule = (String) im.get(key);
                            %>
                            <option value="<%=key%>"><%=nameofthemodule%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Data Type</label>
                    </td>
                    <td>
                        <select name="edittype" id='edittype'>
                            <option value="">--Select One--</option>
                            <option value="Master Data">Master Data</option>
                            <option value="Transaction">Transaction</option>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Classification</label>
                    </td>
                    <td>

                        <select name="editcalssification" id='editcalssification'>
                            <option value="">--Select One--</option>
                            <option value="FT">FT</option>
                            <option value="IT">IT</option>
                        </select>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Priority</label>
                    </td>
                    <td>
                        <select name="editpriority" id='editpriority'>
                            <option value="">--Select One--</option>
                            <option value="Core">Core</option>
                            <option value="Critical">Critical</option>
                            <option value="Essential">Essential</option>
                        </select>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="vtType" id='vtType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="editvtid" id='editvtid'/>
                        <input type="submit" value="Update Variant " onclick="javascript:updateVT()"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditVT();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>                             
    <div id="TCpopup" class="popup">
        <h3 class="popupHeading">Add Business Case</h3>
        <div>
            <div style="color:red;display: none;" id="tcerrormsg">Please enter the correct Business Case name</div>
            <div style="color:red;display: none;" id="createtctypeerrormsg">Please enter the correct Business Case Type</div>
            <p>Enter New Business Case</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Business Case</label>
                    </td>
                    <td>
                        <input type="text" name="tc" id='tc'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createTcType" id='createTcType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="vtid" id='vtid'/>
                        <input type="submit" value="Create Business Case" onclick="javacript:createTC();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeTC();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="TCEditpopup" class="popup">
        <h3 class="popupHeading">Edit Business Case</h3>
        <div>
            <div style="color:red;display: none;" id="tcediterrormsg">Please enter the correct Business Case name</div>
            <div style="color:red;display: none;" id="tctypeerrormsg">Please enter the correct Business Case Type</div>
            <p>Edit Business Case</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Business Case</label>
                    </td>
                    <td>
                        <input type="text" name="edittcname" id='edittcname'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="tcType" id='tcType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                    <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="edittcid" id='edittcid'/>
                        <input type="submit" value="Update Business Case" onclick="javacript:updateTC();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditTC();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="TSpopup" class="popup">
        <h3 class="popupHeading">Add Business Step</h3>
        <div>
            <div style="color:red;display: none;" id="tserrormsg">Please enter the correct Business Step name</div>
            <div style="color:red;display: none;" id="createtstypeerrormsg">Please enter the correct Business Step Type</div>
            <p>Enter New Business Step</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Business Step</label>
                    </td>
                    <td>
                        <input type="text" name="ts" id='ts'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="createTsType" id='createTsType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="tcid" id='tcid'/>
                        <input type="submit" value="Create Business Step" onclick="javascript:createTS();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeTS();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div id="TSEditpopup" class="popup">
        <h3 class="popupHeading">Edit Step</h3>
        <div>
            <div style="color:red;display: none;" id="tsediterrormsg">Please enter the correct Business Step name</div>
            <div style="color:red;display: none;" id="tstypeerrormsg">Please enter the correct Business Step Type</div>
            <p>Edit Business Step</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Business Step</label>
                    </td>
                    <td>
                        <input type="text" name="edittsname" id='edittsname'/>
                    </td>
                </tr>
                <%if (category.equalsIgnoreCase("SAP Project")) {%>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Type</label>
                    </td>
                    <td>
                        <select name="tsType" id='tsType'>
                            <option value="">--Select One--</option>
                            <option value="SAP">SAP</option>
                            <option value="Non SAP">Non SAP</option>

                        </select>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="edittsid" id='edittsid'/>
                        <input type="submit" value="Update Business Step" onclick="javascript:updateTS();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditTS();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>               
    <div id="TSCpopup" class="popup">
        <h3 class="popupHeading">Add Test Script</h3>
        <div>
            <div style="color:red;display: none;" id="terrormsg">Please enter the correct Test Script name</div>
            <p>Enter New Test Script</p>
            <table>
                <tr >
                    <td>
                        <label for="pswd">Test Script</label>
                    </td>
                    <td>
                        <textarea  name="testScript" id='testScript' cols="35" rows="4"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="pswd">Expected Result</label>
                    </td>
                    <td>
                        <textarea  name="expRslt" id='expRslt' cols="35" rows="4"></textarea>
                    </td>
                </tr>
                <tr>
                <table>
                    <form id="file-form" name="file-form"  method="POST">
                        <input type="file" id="file-select" name="photos[]" multiple/>                                 
                    </form>
                </table>                       
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="tsid" id='tsid'/>
                        <input type="hidden" name="pid" id='pid' value="<%=pid%>"/>
                        <input type="submit" value="Create Test Script" onclick="javascript:createTSC();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeTSC();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>

    <div id="TSCEditpopup" class="popup">
        <h3 class="popupHeading">Edit Test Script</h3>
        <div>
            <div style="color:red;display: none;" id="tscediterrormsg">Please enter the correct Test Script name</div>
            <div style="color:red;display: none;" id="tscResultediterrormsg">Please enter the correct Expected Result</div>

            <p>Edit Test Script</p>
            <hr />
            <!-- Update form action -->

            <table style="">
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Test Script</label>
                    </td>
                    <td>
                        <textarea name="edittscname" id='edittscname' cols="35" rows="4"></textarea>
                    </td>
                </tr>
                <tr style="height:20px;">
                    <td>
                        <label for="pswd">Expected Result</label>
                    </td>
                    <td>
                        <textarea name="edittscresult" id='edittscresult' cols="35" rows="4"></textarea>

                    </td>
                </tr>
                <tr>

                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <input type="hidden" name="edittscid" id='edittscid'/>
                        <input type="hidden" name="ptcId" id='ptcId'/>
                        <input type="submit" value="Update Test Script" onclick="javascript:updateTSC();"/>
                        <input type="button" value="Cancel" onclick="javascript:closeEditTSC();"/>
                    </td>
                </tr>
            </table>

        </div>
    </div>                                                                            
    <div id="TSISSUEpopup" class="popup">
        <h3 class="popupHeading">Add Issues To Test Script</h3>
        <div>
            <div style="color:red;display: none;" id="tsissueerrormsg">Please select the Issues</div>    
            <div class="clear"></div>
            <div class="tableshow">
                <div class="mid" id="popupIssueList">
                </div>
                <br/>
                <br/>
                <div>
                    <input type="submit" value="Add" onclick="javascript:assignIssueTS();"/>
                    <input type="button" value="Cancel" onclick="javascript:closeIssueTS();"/>
                </div>
            </div>
        </div>
    </div>
    <div id="MDApopup" class="popup">
        <form id="file-mod-form" name="file-mod-form"  method="POST">

            <h3 class="popupHeading">Add document</h3>
            <div>
                <div style="color:red;display: none;" id="mdaterrormsg">Please select module</div>
                <p>Upload document</p>
                <hr />
                <!-- Update form action -->


                <table >
                    <tr style="height:50px;">
                        <td>
                            <label for="pswd">Module</label>
                        </td>
                        <td>
                            <select name="moduleId" id='moduleId'>
                                <option value="">--Select One--</option>
                                <%
                                    Iterator itera = se.iterator();
                                    while (itera.hasNext()) {
                                        String key = (String) itera.next();
                                        String nameofthemodule = (String) lhp.get(key);
                                %>
                                <option value="<%=key%>"><%=nameofthemodule%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr style="height:40px;">
                        <td colspan="2">
                            <label for="pswd"><input type="file" id="file-mod-select" name="photos[]" multiple/></label> 
                        </td>
                    </tr>
                    <tr style="height:40px;">
                        <td colspan="2" align="right">
                            <input type="hidden" name="projId" id='projId' value="<%=pid%>"/>
                            <input type="button" id="mod-upload-button" value="Add Document" onclick="javascript:createModuleAttach();"/>
                            <input type="button" id="mod-upload-cancel"value="Cancel" onclick="javascript:closeModuleAttach();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </form>

    </div>
    <div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Documents</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div class="mid" id="MDAVpopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeMDVAPopup();" type="button">close</button>

            </div>
        </div>
    </div>
                            

    <div id="TSApopup" class="popup">
        <form id="file-ts-form" name="file-ts-form"  method="POST">
           
            <h3 class="popupHeading">Add document</h3>
            <div>
                 <div style="color:red;display: none;" id="tsamsg">Please select Test Step</div>
                <p>Upload document</p>
                <hr />
                <!-- Update form action -->
                <table >
                    <tr style="height:40px;">
                        <td colspan="2">
                            <label for="pswd"><input type="file" id="file-ts-select" name="photos[]" multiple/></label> 
                        </td>
                    </tr>
                    <tr style="height:40px;">
                        <td colspan="2" align="right">
                            <input type="hidden" name="testStepId" id='testStepId'/>
                            <input type="button" id="ts-upload-button" value="Add Document" onclick="javascript:createTSAttach();"/>
                            <input type="button" id="ts-upload-cancel"value="Cancel" onclick="javascript:closeTSAttach();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>

    <div id="TSAVpopup" class="popup">
        <h3 class="popupHeading">View Documents</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div class="mid" id="TSAVpopupFiles">
                </div>
                <button class="custom-popup-close" onclick="closeTSVAPopup();" type="button">close</button>
            </div>
        </div>
    </div>
    <div id="dialog" title="View Issues">

    </div>


</body>
<%} else {%>
<br/><div style="text-align: center;color: red;">You are not authorized to access it</div>
<%}%>

<script type="text/javascript">
    var formq = document.getElementById('file-form');
    var fileSelect = document.getElementById('file-select');
    var uploadButton = document.getElementById('upload-button');
    formq.onsubmit = function (event) {
        event.preventDefault();

        // Update button text.
        uploadButton.innerHTML = 'Uploading...';

        // The rest of the code will go here...
        var files = fileSelect.files;
        var formData = new FormData();
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            // Add the file to the request.
            formData.append('photos[]', file, file.name);
        }
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'handler.jsp', true);
        xhr.send(formData);
        xhr.onload = function () {
            if (xhr.status === 200) {
                // File(s) uploaded.
                alert('Uploaded!!!');
            } else {
                alert('An error occurred!');
            }
        };
    };
    $(function () {
        $("#dialog").dialog({
            autoOpen: false,
            width: 1000,
            maxHeight: 500,
            top: 0,
            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "blind",
                duration: 1000
            }
        });
    });
    function showPrint(issueid) {
        window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
    }
    $(".Ajax-loder").hide();

    $(document).on('click', '.up,.down', function () {
        var row = $(this).parents("tr");
        var table = $(this).closest('table').attr('id');
        if ($(this).is(".up")) {
            if (typeof (row.prev().attr('id')) === 'undefined') {
                if (typeof (row.prev().prev().attr('id')) === 'undefined') {
                    row.insertBefore(row.prev().prev().prev());
                } else {
                    row.insertBefore(row.prev().prev());
                }
            } else {
                row.insertBefore(row.prev());
            }
        } else {
            if (typeof (row.next().attr('id')) === 'undefined') {
                if (typeof (row.next().next().attr('id')) === 'undefined') {
                    row.insertAfter(row.next().next().next());
                } else {
                    row.insertAfter(row.next().next());
                }
            } else {
                row.insertAfter(row.next());
            }
        }
        var phrase = '';
        $("#" + table + " tr").each(function () {
            if (this.id.length > 0) {
                phrase += this.id + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'tsc'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });

    });
    $(document).on('click', '.upcom,.downcom', function () {
        if ($(this).is(".upcom")) {
            var hook = $(this).closest('.compMap').prev('.compMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.compMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.compMap').next('.compMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.compMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".compMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("c", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'com'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });

    $(document).on('click', '.upbp,.downbp', function () {
        if ($(this).is(".upbp")) {
            var hook = $(this).closest('.bpMap').prev('.bpMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.bpMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.bpMap').next('.bpMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.bpMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".bpMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("bp", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'bp'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });
    $(document).on('click', '.upmp,.downmp', function () {
        if ($(this).is(".upmp")) {
            var hook = $(this).closest('.mpMap').prev('.mpMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.mpMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.mpMap').next('.mpMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.mpMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".mpMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("mp", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'mp'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });

    $(document).on('click', '.upsp,.downsp', function () {
        if ($(this).is(".upsp")) {
            var hook = $(this).closest('.spMap').prev('.spMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.spMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.spMap').next('.spMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.spMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".spMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("sp", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'sp'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });
    $(document).on('click', '.upsc,.downsc', function () {
        if ($(this).is(".upsc")) {
            var hook = $(this).closest('.scMap').prev('.scMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.scMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.scMap').next('.scMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.scMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".scMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("sc", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'sc'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });

    $(document).on('click', '.upvt,.downvt', function () {
        if ($(this).is(".upvt")) {
            var hook = $(this).closest('.vtMap').prev('.vtMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.vtMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.vtMap').next('.vtMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.vtMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".vtMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("vt", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'vt'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });
    $(document).on('click', '.uptc,.downtc', function () {
        if ($(this).is(".uptc")) {
            var hook = $(this).closest('.tcMap').prev('.tcMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.tcMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.tcMap').next('.tcMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.tcMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".tcMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("tc", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'tc'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });

    $(document).on('click', '.upts,.downts', function () {
        if ($(this).is(".upts")) {
            var hook = $(this).closest('.tsMap').prev('.tsMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.tsMap').detach();
                hook.before(elementToMove);
            }
        } else {
            var hook = $(this).closest('.tsMap').next('.tsMap');
            if (hook.length) {
                var elementToMove = $(this).closest('.tsMap').detach();
                hook.after(elementToMove);
            }
        }
        var phrase = '';
        $(".tsMap").each(function () {
            var bpId = this.id;
            if (bpId.length > 0) {
                phrase += bpId.replace("ts", "") + ",";
            }
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/UserBPM/updateTSCSeq.jsp',
            type: 'POST',
            data: {
                seq: phrase, level: 'ts'
            },
            async: true,
            success: function (response, statusTxt, calslback) {
            }
        });
    });
</script>
</html>
