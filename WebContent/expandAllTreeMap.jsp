<%-- 
    Document   : testMap
    Created on : 22 Oct, 2011, 10:44:43 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
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
    Logger logger = Logger.getLogger("expanAllTreeMap");

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
        <script src="<%=request.getContextPath()%>/javaScript/bp.js?tree=red" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script> 
        <script type="text/javascript">    CKEDITOR.timestamp = '21072016';         </script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>

    <style type="text/css">
        ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
        ul li{padding: 3px 0px 3px 16px;margin: 0;}
        a{text-decoration: none;color: black;}

    </style>
    <script type="text/javascript">
            $(document).ready(function() {
            $("#divLoading").hide();
        });
        function expander(pid) {
            $("#divLoading").show();
            var param = 'expandAllTreeMap.jsp?pid=' + pid;
            document.theForm.action = param;
            document.theForm.submit();
        }
        function call(theForm)
        {
            var x = document.getElementById("pid").value;
            theForm.action = 'expandAllTreeMap.jsp?pid=' + x;
            theForm.submit();
        }
    </script>
</head>
<jsp:useBean id="viewBPM" class="com.eminentlabs.userBPM.ViewBPM"></jsp:useBean>

<%@ include file="/header.jsp"%>
<%
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
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
        String cases[][] = TestCases.showTestCases(pid.trim());
        int noOfTestcases = cases.length;
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

%>
<!-- edit by mukesh -->
<body>

    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr >
            <td border="1" align="left" width="80%">
                <font  size="4" COLOR="#0000FF"><b>View <%=GetProjects.getProject(Integer.parseInt(pid))%> Test Map Tree</b></font>
            </td>
            <!-- edit by mukesh -->
            <td style="text-align:right;" width="20%">
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
            </td>
            <!-- edit by mukesh -->
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">Test Map Dashboard View</a>&nbsp;&nbsp;&nbsp;
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
            </td>
        </tr>
    </table>
    <form name="theForm" id="theForm" method="Post">
        <div  style="text-align: right;">
            <jsp:useBean id="tpa" class="com.eminent.bpm.TreePrintAccess"></jsp:useBean>
            <%
                int type = 10;//default value of print authorization type
                BpmPrintaccess bpa = tpa.findByPid(pid);
                if (bpa != null) {
                    type = bpa.getType();
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
            <a href="#" id="expander" onclick="expander('<%=pid%>');" >Expand All</a>&nbsp;&nbsp;&nbsp;
            <a  href="testMap.jsp?pid=<%=pid%>" >Collapse All</a>&nbsp;&nbsp;&nbsp;
            <div id="summary"></div>
            <script type="text/javascript">
                summaryOfTree('<%=pid%>');
            </script>
        </div>
    </form>
    <div id='divLoading' >
        <div class="loading" align="center" id="divImageLoader">
            <img src="/eTracker/images/file-progress.gif" alt="Loading..."/>  Loading ...
        </div>
    </div>
    <div>
        <input type="hidden" value="<%=pid%>" id="pid"/>
        <input type="hidden" value="<%=project%>" id="pname"/>
        <ul id="mainTree">
            <%
                String IT = "1156";
                String hr = "1176";
                String mailids = "ckcsons.com";
                String wholedata = "";
                ArrayList<String> viewClient = ViewBPM.getClient(Integer.parseInt(pid));
                HashMap modules = GetProjects.getModules(pid);
                int companyCount = ViewBPM.getCompanyCount(Integer.parseInt(pid));
                for (String clientName : viewClient) {
            %>
            <li id="client">
                <div class="treeclass" onclick="javascript:viewCompany(<%=pid%>);"></div>
                <a href="#" onclick="javascript:viewCompany(<%=pid%>);"><b>Client: </b><%=clientName%> (<span id="ccount"><%=companyCount%></span>)</a>
                <span style='display:none;' onclick="javascript:editCompany(<%=pid%>);"><img style="position: relative;"src="<%=request.getContextPath()%>/images/edit.png"/></span>
                    <%

                            HashMap ncompanyMap = ViewBPM.getCompany(Integer.parseInt(pid));
                            LinkedHashMap ncompany = GetProjectMembers.sortHashMapByKeys(ncompanyMap, true);

                            if (ncompany.size() > 0) {
                                Collection set = ncompany.keySet();
                                Iterator ite = set.iterator();
                                int bpCount = 0;
                                int cmCount = 0;
                                while (ite.hasNext()) {

                                    int key = (Integer) ite.next();
                                    bpCount = ViewBPM.getBPCount(key);
                                    String nameofcomp = (String) ncompany.get(key);
                                    if (mailids.contains(url)) {
                                        if (hr.contains(userId)) {
                                            if (key == 138) {
                                                bpCount = bpCount - 1;
                                            }
                                        } else if (key == 138) {
                                            bpCount = bpCount - 1;
                                        } else if (key == 139) {
                                            bpCount = bpCount - 1;
                                        } else {
                                        }
                                    }
                                    if (cmCount == 0) {
                                        wholedata = wholedata = "<ul class='tree'>";
                                    }
                                    if (bpCount == 0) {
                                        wholedata = wholedata + "<li id='c" + key + "' class='expandable'> <div class='treeclass' onclick='javascript:viewBP(" + key + ")'></div><a href='#'  onclick='javascript:viewBP(" + key + ");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue" + key + "' value='" + nameofcomp + "'> <span id='cspan" + key + "'>" + nameofcomp + "</span> (<span id='bpcount" + key + "'>" + bpCount + "</span>) </a>";
                                        if (url.equalsIgnoreCase("eminentlabs.net")) {
                                            wholedata = wholedata + "<span  onclick='javascript:editc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span  id='deletec" + key + "' onclick='javascript:deleteCompany(" + key + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>";
                                        }
                                        wholedata = wholedata + "</li>";
                                    } else {
                                        wholedata = wholedata + "<li id='c" + key + "' class='expandable'> <div class='treeclass treeExpand' onclick='javascript:viewBP(" + key + ")'></div><a href='#'  onclick='javascript:viewBP(" + key + ");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue" + key + "' value='" + nameofcomp + "'> <span id='cspan" + key + "'>" + nameofcomp + "</span> (<span id='bpcount" + key + "'>" + bpCount + "</span>) </a>";
                                        if (url.equalsIgnoreCase("eminentlabs.net")) {
                                            wholedata = wholedata + "<span  onclick='javascript:editc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span>";
                                        }
                                        HashMap bProcess = ViewBPM.getBP(key);
                                        HashMap bPTypes = ViewBPM.getBPType(key);
                                        LinkedHashMap businessProcess = GetProjectMembers.sortHashMapByKeys(bProcess, true);
                                        if (businessProcess.size() > 0) {
                                            Collection bpset = businessProcess.keySet();
                                            Iterator bpite = bpset.iterator();
                                            int mpCount = 0;
                                            int buCount = 0;
                                            while (bpite.hasNext()) {
                                                int bpkey = (Integer) bpite.next();
                                                String nameofbp = (String) businessProcess.get(bpkey);
                                                boolean flag = false;
                                                if (mailids.contains(url)) {
                                                    if (hr.contains(userId)) {
                                                        if (key == 138) {
                                                            flag = true;
                                                        }
                                                    } else if (IT.contains(userId)) {
                                                        flag = true;
                                                    } else if (key == 138 || key == 139) {
                                                        flag = false;
                                                    } else {
                                                        flag = true;
                                                    }
                                                } else {
                                                    flag = true;
                                                }
                                                String bpType = "";
                                                String typeColor = "";
                                                if (bPTypes.get(bpkey) != null) {
                                                    bpType = (String) bPTypes.get(bpkey);
                                                    if (!bpType.equalsIgnoreCase("SAP")) {
                                                        typeColor = "red";
                                                    }
                                                }
                                                if (flag == true) {
                                                    mpCount = ViewBPM.getMPCount(bpkey);
                                                    if (buCount == 0) {
                                                        wholedata = wholedata + "<ul >";
                                                    }

                                                    if (mpCount == 0) {
                                                        wholedata = wholedata + "<li id='bp" + bpkey + "' class='expandable'> <div class='treeclass' onclick='javascript:viewMP(" + bpkey + ")'></div><a href='#'  onclick='javascript:viewMP(" + bpkey + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + bpkey + "' value='" + nameofbp + "'> <input type='hidden' id='bpType" + bpkey + "' value='" + bpType + "'> <span id='bpspan" + bpkey + "' style='color:" + typeColor + ";'>" + nameofbp + "</span> (<span id='mpcount" + bpkey + "'>" + mpCount + "</span>) </a>";
                                                        if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                            wholedata = wholedata + "<span  onclick='javascript:editbp(" + bpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span  id='deletebp" + bpkey + "' onclick='javascript:deleteBP(" + bpkey + "," + key + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                        }
                                                        wholedata = wholedata + "</li>";
                                                    } else {
                                                        wholedata = wholedata + "<li id='bp" + bpkey + "' class='expandable'> <div class='treeclass treeExpand' onclick='javascript:viewMP(" + bpkey + ")'></div><a href='#'  onclick='javascript:viewMP(" + bpkey + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + bpkey + "' value='" + nameofbp + "'> <input type='hidden' id='bpType" + bpkey + "' value='" + bpType + "'> <span id='bpspan" + bpkey + "' style='color:" + typeColor + ";'>" + nameofbp + "</span> (<span id='mpcount" + bpkey + "'>" + mpCount + "</span>) </a>";
                                                        if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                            wholedata = wholedata + "<span  onclick='javascript:editbp(" + bpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                                                        }
                                                        HashMap mProcess = ViewBPM.getMP(bpkey);
                                                        HashMap mPType = ViewBPM.getMPType(bpkey);

                                                        LinkedHashMap mainProcess = GetProjectMembers.sortHashMapByKeys(mProcess, true);

                                                        if (mainProcess.size() > 0) {
                                                            Collection mpset = mainProcess.keySet();
                                                            Iterator mpite = mpset.iterator();
                                                            int spCount = 0;
                                                            int maCount = 0;
                                                            while (mpite.hasNext()) {
                                                                int mpkey = (Integer) mpite.next();
                                                                String nameofmp = (String) mainProcess.get(mpkey);
                                                                String mpType = "";
                                                                String mpTypeColor = "";
                                                                if (mPType.get(mpkey) != null) {
                                                                    mpType = (String) mPType.get(mpkey);
                                                                    if (!mpType.equalsIgnoreCase("SAP")) {
                                                                        mpTypeColor = "red";
                                                                    }
                                                                }
                                                                spCount = ViewBPM.getSPCount(mpkey);
                                                                if (maCount == 0) {
                                                                    wholedata = wholedata + "<ul>";
                                                                }
                                                                if (spCount == 0) {
                                                                    wholedata = wholedata + "<li id='mp" + mpkey + "' class='expandable'><div class='treeclass'  onclick='javascript:viewSP(" + mpkey + ")'></div><a href='#'  onclick='javascript:viewSP(" + mpkey + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + mpkey + "' value='" + nameofmp + "'> <input type='hidden' id='mpType" + mpkey + "' value='" + mpType + "'> <span id='mpspan" + mpkey + "' style='color:" + mpTypeColor + ";'>" + nameofmp + "</span> (<span id='spcount" + mpkey + "'>" + spCount + "</span>) </a>";
                                                                    if (url.equals("eminentlabs.net")) {
                                                                        wholedata = wholedata + "<span  onclick='javascript:editmp(" + mpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletemp" + mpkey + "' onclick='javascript:deleteMP(" + mpkey + "," + bpkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                                    }
                                                                    wholedata = wholedata + " </li>";
                                                                } else {
                                                                    wholedata = wholedata + "<li id='mp" + mpkey + "' class='expandable'><div class='treeclass treeExpand'  onclick='javascript:viewSP(" + mpkey + ")'></div><a href='#'  onclick='javascript:viewSP(" + mpkey + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + mpkey + "' value='" + nameofmp + "'> <input type='hidden' id='mpType" + mpkey + "' value='" + mpType + "'> <span id='mpspan" + mpkey + "' style='color:" + mpTypeColor + ";'>" + nameofmp + "</span> (<span id='spcount" + mpkey + "'>" + spCount + "</span>) </a>";
                                                                    if (url.equals("eminentlabs.net")) {
                                                                        wholedata = wholedata + "<span  onclick='javascript:editmp(" + mpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                                                                    }
                                                                    HashMap sProcess = ViewBPM.getSP(mpkey);
                                                                    HashMap sPTypes = ViewBPM.getSPType(mpkey);
                                                                    LinkedHashMap subProcess = GetProjectMembers.sortHashMapByKeys(sProcess, true);

                                                                    if (subProcess.size() > 0) {
                                                                        Collection spset = subProcess.keySet();
                                                                        Iterator spite = spset.iterator();
                                                                        int scCount = 0;
                                                                        int suCount = 0;
                                                                        while (spite.hasNext()) {
                                                                            int spkey = (Integer) spite.next();
                                                                            String nameofsp = (String) subProcess.get(spkey);
                                                                            String spType = "";
                                                                            String spTypeColor = "";
                                                                            if (sPTypes.get(spkey) != null) {
                                                                                spType = (String) sPTypes.get(spkey);
                                                                                if (!spType.equalsIgnoreCase("SAP")) {
                                                                                    spTypeColor = "red";
                                                                                }
                                                                            }
                                                                            scCount = ViewBPM.getSCCount(spkey);
                                                                            if (suCount == 0) {
                                                                                wholedata = wholedata + "<ul >";
                                                                            }
                                                                            if (scCount == 0) {
                                                                                wholedata = wholedata + " <li id='sp" + spkey + "' class='expandable'><div class='treeclass' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <input type='hidden' id='spType" + spkey + "' value='" + spType + "'> <span id='spspan" + spkey + "' style='color:" + spTypeColor + ";'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a>";
                                                                                if (url.equals("eminentlabs.net")) {
                                                                                    wholedata = wholedata + "<span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesp" + spkey + "' onclick='javascript:deleteSP(" + spkey + "," + mpkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                                                }
                                                                                wholedata = wholedata + "</li>";
                                                                            } else {
                                                                                if (url.equals("eminentlabs.net")) {
                                                                                    wholedata = wholedata + "<li id='sp" + spkey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <input type='hidden' id='spType" + spkey + "' value='" + spType + "'> <span id='spspan" + spkey + "' style='color:" + spTypeColor + ";'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span title='Download Sub Process'>  <a href='/eTracker/UserBPM/downloadTree.jsp?spId=" + spkey + "' target='_blank'><img style='border:none;position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/down.png'/></a></span>";
                                                                                } else {
                                                                                    wholedata = wholedata + "<li id='sp" + spkey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <input type='hidden' id='spType" + spkey + "' value='" + spType + "'> <span id='spspan" + spkey + "' style='color:" + spTypeColor + ";'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a>";
                                                                                }
                                                                                HashMap scenarioMap = ViewBPM.getSC(spkey);
                                                                                HashMap scenarioTypes = ViewBPM.getSCTypes(spkey);
                                                                                LinkedHashMap scenario = GetProjectMembers.sortHashMapByKeys(scenarioMap, true);

                                                                                if (scenario.size() > 0) {
                                                                                    Collection scset = scenario.keySet();
                                                                                    Iterator scite = scset.iterator();
                                                                                    int vtCount = 0;
                                                                                    int sceCount = 0;
                                                                                    while (scite.hasNext()) {
                                                                                        int sckey = (Integer) scite.next();
                                                                                        String nameofsc = (String) scenario.get(sckey);
                                                                                        String scType = "";
                                                                                        String scTypeColor = "";
                                                                                        if (scenarioTypes.get(sckey) != null) {
                                                                                            scType = (String) scenarioTypes.get(sckey);
                                                                                            if (!scType.equalsIgnoreCase("SAP")) {
                                                                                                scTypeColor = "red";
                                                                                            }
                                                                                        }
                                                                                        vtCount = ViewBPM.getVTCount(sckey);
                                                                                        if (sceCount == 0) {
                                                                                            wholedata = wholedata + "<ul >";
                                                                                        }
                                                                                        if (vtCount == 0) {

                                                                                            wholedata = wholedata + "<li id='sc" + sckey + "' class='expandable'><div class='treeclass' onclick='javascript:viewVT(" + sckey + ")'></div><a href='#'  onclick='javascript:viewVT(" + sckey + ");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue" + sckey + "' value='" + nameofsc + "'> <input type='hidden' id='scType" + sckey + "' value='" + scType + "'> <span id='scspan" + sckey + "' style='color:" + scTypeColor + ";'>" + nameofsc + "</span>  (<span id='vtcount" + sckey + "'>" + vtCount + "</span>) </a>";
                                                                                            if (url.equals("eminentlabs.net")) {
                                                                                                wholedata = wholedata + "<span  onclick='javascript:editsc(" + sckey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesc" + sckey + "' onclick='javascript:deleteSC(" + sckey + "," + spkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                                                            }
                                                                                            wholedata = wholedata + "</li>";

                                                                                        } else {

                                                                                            if (url.equals("eminentlabs.net")) {
                                                                                                wholedata = wholedata + "<li id='sc" + sckey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewVT(" + sckey + ")'></div><a href='#'  onclick='javascript:viewVT(" + sckey + ");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue" + sckey + "' value='" + nameofsc + "'> <input type='hidden' id='scType" + sckey + "' value='" + scType + "'> <span id='scspan" + sckey + "' style='color:" + scTypeColor + ";'>" + nameofsc + "</span>  (<span id='vtcount" + sckey + "'>" + vtCount + "</span>) </a><span  onclick='javascript:editsc(" + sckey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                                                                                            } else {
                                                                                                wholedata = wholedata + "<li id='sc" + sckey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewVT(" + sckey + ")'></div><a href='#'  onclick='javascript:viewVT(" + sckey + ");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue" + sckey + "' value='" + nameofsc + "'> <input type='hidden' id='scType" + sckey + "' value='" + scType + "'> <span id='scspan" + sckey + "' style='color:" + scTypeColor + ";'>" + nameofsc + "</span>  (<span id='vtcount" + sckey + "'>" + vtCount + "</span>) </a>";
                                                                                            }
                                                                                            HashMap variantMap = ViewBPM.getVT(sckey);
                                                                                            HashMap variantMapTypes = ViewBPM.getVTTypes(sckey);
                                                                                            LinkedHashMap variant = GetProjectMembers.sortHashMapByKeys(variantMap, true);

                                                                                            if (variant.size() > 0) {
                                                                                                Collection vtset = variant.keySet();
                                                                                                Iterator vtite = vtset.iterator();
                                                                                                int tcCount = 0;
                                                                                                int vaCount = 0;
                                                                                                while (vtite.hasNext()) {
                                                                                                    int vtkey = (Integer) vtite.next();
                                                                                                    String nameofvt = (String) variant.get(vtkey);
                                                                                                    String vtType = "";
                                                                                                    String vtTypeColor = "";
                                                                                                    if (variantMapTypes.get(vtkey) != null) {
                                                                                                        vtType = (String) variantMapTypes.get(vtkey);
                                                                                                        if (!vtType.equalsIgnoreCase("SAP")) {
                                                                                                            vtTypeColor = "red";
                                                                                                        }
                                                                                                    }
                                                                                                    tcCount = ViewBPM.getTCCount(vtkey);
                                                                                                    if (vaCount == 0) {
                                                                                                        wholedata = wholedata + "<ul >";
                                                                                                    }
                                                                                                    if (tcCount == 0) {
                                                                                                        wholedata = wholedata + "<li id='vt" + vtkey + "' class='expandable'><div class='treeclass' onclick='javascript:viewTC(" + vtkey + ")'></div><a href='#'  onclick='javascript:viewTC(" + vtkey + ");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue" + vtkey + "' value='" + nameofvt + "'>  <input type='hidden' id='vtType" + vtkey + "' value='" + vtType + "'> <span id='vtspan" + vtkey + "' style='color:" + vtTypeColor + ";'>" + nameofvt + "</span>  (<span id='tccount" + vtkey + "'>" + tcCount + "</span>) </a>";
                                                                                                        if (url.equals("eminentlabs.net")) {
                                                                                                            wholedata = wholedata + "<span  onclick='javascript:editvt(" + vtkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletevt" + vtkey + "' onclick='javascript:deleteVT(" + vtkey + "," + sckey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                                                                        }
                                                                                                        wholedata = wholedata + "</li>";
                                                                                                    } else {
                                                                                                        wholedata = wholedata + "<li id='vt" + vtkey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewTC(" + vtkey + ")'></div><a href='#'  onclick='javascript:viewTC(" + vtkey + ");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue" + vtkey + "' value='" + nameofvt + "'>  <input type='hidden' id='vtType" + vtkey + "' value='" + vtType + "'> <span id='vtspan" + vtkey + "' style='color:" + vtTypeColor + ";'>" + nameofvt + "</span>  (<span id='tccount" + vtkey + "'>" + tcCount + "</span>) </a>";
                                                                                                        if (url.equals("eminentlabs.net")) {
                                                                                                            wholedata = wholedata + "<span  onclick='javascript:editvt(" + vtkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                                                                                                        }
                                                                                                        HashMap tcase = ViewBPM.getTC(vtkey);
                                                                                                        HashMap tcaseTypes = ViewBPM.getTCTypes(vtkey);
                                                                                                        LinkedHashMap testcase = GetProjectMembers.sortHashMapByKeys(tcase, true);
                                                                                                        String tcName = "";
                                                                                                        if (testcase.size() > 0) {
                                                                                                            Collection tcset = testcase.keySet();
                                                                                                            Iterator tcite = tcset.iterator();
                                                                                                            int tsCount = 0;
                                                                                                            int tcaCount = 0;
                                                                                                            while (tcite.hasNext()) {
                                                                                                                int tckey = (Integer) tcite.next();
                                                                                                                String nameoftc = (String) testcase.get(tckey);
                                                                                                                String tcType = "";
                                                                                                                String tcTypeColor = "";
                                                                                                                if (tcaseTypes.get(tckey) != null) {
                                                                                                                    tcType = (String) tcaseTypes.get(tckey);
                                                                                                                    if (!tcType.equalsIgnoreCase("SAP")) {
                                                                                                                        tcTypeColor = "red";
                                                                                                                    }
                                                                                                                }
                                                                                                                tsCount = ViewBPM.getTSCount(tckey);
                                                                                                                if (tcaCount == 0) {
                                                                                                                    wholedata = wholedata + "<ul >";
                                                                                                                }
                                                                                                                if (tsCount == 0) {
                                                                                                                    wholedata = wholedata + "<li id='tc" + tckey + "' class='expandable'><div class='treeclass' onclick='javascript:viewTS(" + tckey + ")'></div><a href='#'  onclick='javascript:viewTS(" + tckey + ");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue" + tckey + "' value='" + nameoftc + "'> <input type='hidden' id='tcType" + tckey + "' value='" + tcType + "'> <span id='tcspan" + tckey + "' style='color:" + tcTypeColor + ";'>" + nameoftc + "</span>  (<span id='tscount" + tckey + "'>" + tsCount + "</span>) </a>";
                                                                                                                    if (url.equals("eminentlabs.net")) {
                                                                                                                        wholedata = wholedata + "<span  onclick='javascript:edittc(" + tckey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletetc" + tckey + "' onclick='javascript:deleteTC(" + tckey + "," + vtkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                                                                                                                    }
                                                                                                                    wholedata = wholedata + "</li>";
                                                                                                                } else {
                                                                                                                    wholedata = wholedata + "<li id='tc" + tckey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewTS(" + tckey + ")'></div><a href='#'  onclick='javascript:viewTS(" + tckey + ");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue" + tckey + "' value='" + nameoftc + "'> <input type='hidden' id='tcType" + tckey + "' value='" + tcType + "'> <span id='tcspan" + tckey + "' style='color:" + tcTypeColor + ";'>" + nameoftc + "</span>  (<span id='tscount" + tckey + "'>" + tsCount + "</span>) </a>";
                                                                                                                    if (url.equals("eminentlabs.net")) {
                                                                                                                        wholedata = wholedata + "<span  onclick='javascript:edittc(" + tckey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                                                                                                                    }
                                                                                                                    HashMap tstep = ViewBPM.getTS(tckey);
                                                                                                                    HashMap tstepTypes = ViewBPM.getTSTypes(tckey);
                                                                                                                    LinkedHashMap teststep = GetProjectMembers.sortHashMapByKeys(tstep, true);
                                                                                                                    if (teststep.size() > 0) {
                                                                                                                        Collection tsset = teststep.keySet();
                                                                                                                        Iterator tsite = tsset.iterator();
                                                                                                                        int tscCount = 0;
                                                                                                                        int tstCount = 0;
                                                                                                                        while (tsite.hasNext()) {
                                                                                                                            int tskey = (Integer) tsite.next();
                                                                                                                            String nameofts = (String) teststep.get(tskey);
                                                                                                                            String tsType = "";
                                                                                                                            String tsTypeColor = "";
                                                                                                                            if (tstepTypes.get(tskey) != null) {
                                                                                                                                tsType = (String) tstepTypes.get(tskey);
                                                                                                                                if (!tsType.equalsIgnoreCase("SAP")) {
                                                                                                                                    tsTypeColor = "red";
                                                                                                                                }
                                                                                                                            }
                                                                                                                            tscCount = ViewBPM.getTestScriptCount(tskey);
                                                                                                                            List<IssueFormBean> list = viewBPM.getTestScriptIssues(tskey);
                                                                                                                            if (tstCount == 0) {
                                                                                                                                wholedata = wholedata + "<ul >";
                                                                                                                            }
                                                                                                                            if (tscCount == 0) {
                                                                                                                                wholedata = wholedata + "<li id='ts" + tskey + "' class='expandable'><div class='treeclass' onclick='javascript:viewTSC(" + tskey + ")'></div><a href='#'  onclick='javascript:viewTSC(" + tskey + ");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue" + tskey + "' value='" + nameofts + "'> <input type='hidden' id='tsType" + tskey + "' value='" + tsType + "'> <span id='tsspan" + tskey + "' style='color:" + tsTypeColor + ";'>" + nameofts + "</span> (<span id='tsrcount" + tskey + "'>" + tscCount + "</span>) </a>";
                                                                                                                                if (url.equals("eminentlabs.net")) {
                                                                                                                                    wholedata = wholedata + "<span  onclick='javascript:editts(" + tskey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletets" + tskey + "' onclick='javascript:deleteTS(" + tskey + "," + tckey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                                                                                                }
                                                                                                                                wholedata = wholedata + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue(" + tskey + ")'></span>";
                                                                                                                                if (!list.isEmpty()) {
                                                                                                                                    wholedata = wholedata + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view.png'/ title='View Issues' onclick='viewIssueByTSID(" + key + ")'></span>";
                                                                                                                                }
                                                                                                                                if (roleId == 1) {
                                                                                                                                    wholedata = wholedata + " <span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/link.png'/ title='View Issues'  onclick='viewIssueTS(" + tskey + ")'></span>";
                                                                                                                                }
                                                                                                                                wholedata = wholedata + "</li>";
                                                                                                                            } else {
                                                                                                                                wholedata = wholedata + "<li id='ts" + tskey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewTSC(" + tskey + ")'></div><a href='#'  onclick='javascript:viewTSC(" + tskey + ");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue" + tskey + "' value='" + nameofts + "'> <input type='hidden' id='tsType" + tskey + "' value='" + tsType + "'> <span id='tsspan" + tskey + "' style='color:" + tsTypeColor + ";'>" + nameofts + "</span> (<span id='tsrcount" + tskey + "'>" + tscCount + "</span>) </a>";
                                                                                                                                if (url.equals("eminentlabs.net")) {
                                                                                                                                    wholedata = wholedata + "<span  onclick='javascript:editts(" + tskey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                                                                                                                                }
                                                                                                                                wholedata = wholedata + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue(" + tskey + ")'></span>";
                                                                                                                                if (!list.isEmpty()) {
                                                                                                                                    wholedata = wholedata + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view.png'/ title='View Issues' onclick='viewIssueByTSID(" + key + ")'></span>";
                                                                                                                                }
                                                                                                                                if (roleId == 1) {
                                                                                                                                    wholedata = wholedata + " <span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/link.png'/ title='View Issues'  onclick='viewIssueTS(" + tskey + ")'></span>";
                                                                                                                                }
                                                                                                                                LinkedHashMap testscript = ViewBPM.getTestScript(tskey);
                                                                                                                                String tscName = "", color = "white";
                                                                                                                                int i = 0;
                                                                                                                                if (testscript.size() > 0) {
                                                                                                                                    Collection tscset = testscript.keySet();
                                                                                                                                    Iterator tscite = tscset.iterator();
                                                                                                                                    String testScript = null;
                                                                                                                                    String expRslt = null;
                                                                                                                                    String createdBy = null;
                                                                                                                                    String ptcId = null;
                                                                                                                                    String tscId = null;
                                                                                                                                    String uniqueId = null;
                                                                                                                                    while (tscite.hasNext()) {
                                                                                                                                        if ((i % 2) != 0) {
                                                                                                                                            color = "#E8EEF7";
                                                                                                                                        } else {

                                                                                                                                            color = "white";

                                                                                                                                        }
                                                                                                                                        String tsckey = (String) tscite.next();
                                                                                                                                        String nameoftsc = (String) testscript.get(tsckey);
                                                                                                                                        testScript = nameoftsc.substring(0, nameoftsc.indexOf("###"));
                                                                                                                                        expRslt = nameoftsc.substring(nameoftsc.indexOf("###") + 3, nameoftsc.lastIndexOf("###"));
                                                                                                                                        createdBy = nameoftsc.substring(nameoftsc.lastIndexOf("###") + 3, nameoftsc.indexOf("***") - 2);
                                                                                                                                        ptcId = nameoftsc.substring(nameoftsc.indexOf("***") + 3, nameoftsc.lastIndexOf("***"));
                                                                                                                                        tscId = nameoftsc.substring(nameoftsc.lastIndexOf("***") + 3);
                                                                                                                                        String testcaseId = "'" + tsckey + "'";
                                                                                                                                        uniqueId = tsckey + tskey;
                                                                                                                                        tscName = tscName + "<tr id='" + tscId + "' style='background-color:" + color + ";'><td><div id=" + uniqueId + " onclick=javascript:showComments('" + tsckey + "','" + tskey + "'); style='margin-left:2px;width:30px;bgcolor:red;' class='treeclass'></div>" + testScript + " </td><td>" + expRslt + " </td><td>" + createdBy + "</td><td>" + ptcId;
                                                                                                                                        if (url.equals("eminentlabs.net")) {
                                                                                                                                            tscName = tscName + "<span id='deletetsc" + tscId + "' onclick='javascript:deleteTSC(" + tscId + "," + tskey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                                                                                                                                        }
                                                                                                                                        tscName = tscName + "</td></tr><tr ><td colspan=4 > <div id='ptc" + uniqueId + "'></div></td></tr>";
                                                                                                                                        i++;

                                                                                                                                    }
                                                                                                                                    wholedata = wholedata + "<ul><li class='lasttestscript'><table id='" + tskey + "' style='border:solid 1px #696969'><tr style='background-color: #C3D9FF;'><td><b>Test Script</b></td><td><b>Expected Result</b></td><td><b>Created By</b></td><td><b>Status</b></td></tr>" + tscName;
                                                                                                                                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                                                                                        wholedata = wholedata + "<tr><td><a href='#' onclick='javascript:showTSC(" + tskey + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Test Script</a></td><td><a href='./uploadTscExcel.jsp?tsId=" + tskey + "'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' >Upload Test Script</a></td></tr>";
                                                                                                                                    }
                                                                                                                                    wholedata = wholedata + "</table></li></ul>";

                                                                                                                                }
                                                                                                                            }
                                                                                                                            tstCount++;
                                                                                                                            if (tstCount == teststep.size()) {
                                                                                                                                if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                                                                                    wholedata = wholedata + "<li class='lastts'><a href='#' onclick='javascript:showTS(" + tckey + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Business Step</a></li>";
                                                                                                                                }
                                                                                                                                wholedata = wholedata + "</ul>";
                                                                                                                            }
                                                                                                                        }

                                                                                                                    }
                                                                                                                }
                                                                                                                tcaCount++;
                                                                                                                if (tcaCount == testcase.size()) {
                                                                                                                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                                                                        wholedata = wholedata + "<li class='lasttc'><a href='#' onclick='javascript:showTC(" + vtkey + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Business Case</a></li>";
                                                                                                                    }
                                                                                                                    wholedata = wholedata + "</ul>";
                                                                                                                }

                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                    vaCount++;
                                                                                                    if (vaCount == variant.size()) {
                                                                                                        if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                                                            wholedata = wholedata + "<li class='lastvt'><a href='#' onclick='javascript:showVT(" + sckey + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Variant</a></li>";
                                                                                                        }
                                                                                                        wholedata = wholedata + "</ul>";
                                                                                                    }

                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        sceCount++;
                                                                                        if (sceCount == scenario.size()) {
                                                                                            if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                                                wholedata = wholedata + "<li class='lastsc'><a href='#' onclick='javascript:showSC(" + spkey + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Scenario</a><a href='./uploadExcel.jsp?spId=" + spkey + "'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' > Upload Scenario </a></li>";
                                                                                            }
                                                                                            wholedata = wholedata + "</ul>";
                                                                                        }

                                                                                    }
                                                                                }
                                                                            }
                                                                            suCount++;
                                                                            if (suCount == subProcess.size()) {
                                                                                if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                                    wholedata = wholedata + "<li class='lastsp'><a href='#' onclick='javascript:showSP(" + mpkey + ");return false;' style='margin-left:0px;color:#C0C0C0;'>  Add Sub Process</a></li>";
                                                                                }
                                                                                wholedata = wholedata + "</ul>";
                                                                            }

                                                                        }
                                                                    }
                                                                }
                                                                maCount++;
                                                                if (maCount == mainProcess.size()) {
                                                                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                                        wholedata = wholedata + "<li class='lastmp'><a href='#' onclick='javascript:showMP(" + bpkey + ");return false;' style='color:#C0C0C0;'> Add Main Process</a></li>";
                                                                    }
                                                                    wholedata = wholedata + "</ul>";

                                                                }

                                                            }
                                                        }
                                                    }
                                                    buCount++;
                                                }
                                                if (buCount == businessProcess.size()) {
                                                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                                                        wholedata = wholedata + "<li class='lastbp'><a href='#' onclick='javascript:showBP(" + key + ");return false;' style='color:#C0C0C0;'>  Add Business Process</a></li>";
                                                    }
                                                    wholedata = wholedata + "</ul>";
                                                }

                                            }
                                        }
                                    }

                                    cmCount++;
                                    if (cmCount == ncompany.size()) {
                                        wholedata = wholedata + "<li class='lastcompany'><a href='#' onclick='javascript:showCompany(" + pid + ");return false;' style='margin-left:0px;color:#C0C0C0;'>Add Company</a></li></ul>";
                                    }

                                }
                            }
                        }
                    %>
                    <%=wholedata%>
                    <%wholedata = "";

                    %>
            </li>
        </ul>
    </div>
    <div id="overlay"></div>
    <div id="comppopup" class="popup">
        <h3 class="popupHeading">Add Company</h3>
        <div>
            <div style="color:red;display: none;" id="errormsg">Please enter the correct company name</div>
            <p>Enter New Company Name/Code</p>
            <hr />
            <!-- Update form action -->

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Company Name</label>
                    </td>
                    <td colspan="2">
                        <input type="text" name="comp" id='comp'/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
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
                        <input type="submit" value="Update Scenario" onclick="javascript:updateSC()"/>
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
            <div style="color:red;display: none;" id="createvttypeerrormsg">Please enter the correct Variant Type</div>
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
                        <label for="pswd">Type</label>
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
            <div style="color:red;display: none;" id="vttypeerrormsg">Please enter the correct Variant Type</div>
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
                </tr>
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
            <p>Enter New Business Step</p>
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
                <!--                                        <script type="text/javascript">
                                                            CKEDITOR.replaceAll(
                                                                 
                                                                    function( textarea, config ){
                                                                        config.width	=	350;
                                                                        config.height	=	50;
                                                                        config.toolbar  =   [[ '']];
                                                                    }
                                                            );
                
                
                                                    </script>-->
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

            <table>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Test Script</label>
                    </td>
                    <td>
                        <input type="text" name="edittscname" id='edittscname'/>
                    </td>
                </tr>
                <tr style="height:50px;">
                    <td>
                        <label for="pswd">Expected Result</label>
                    </td>
                    <td>
                        <input type="text" name="edittscresult" id='edittscresult'/>
                    </td>
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
</body>
<script type="text/javascript">
    $(window).load(function () {
        $("#divLoading").fadeOut(100);

    });
</script>
<%} else {%>
<br/><div style="text-align: center;color: red;">You are not authorized to access it</div>
<%}%>
</html>
