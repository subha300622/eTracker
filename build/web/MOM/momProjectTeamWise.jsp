<%-- 
    Document   : momProjectTeamWise
    Created on : Apr 7, 2014, 2:50:13 PM
    Author     : E0288
--%>

<%@page import="com.eminent.util.GetProjects"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminentlabs.mom.formbean.MomForClientFormbean"%>
<%@page import="com.eminentlabs.mom.MomClientAttendies"%>
<%@page import="com.eminentlabs.mom.MomForClient"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("momProjectTeamWise");
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
            <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
            <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"/>
            <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
            <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>



            <script type="text/javascript" language="JavaScript">

                function editorTextCounter(field, cntfield, maxlimit)
                {
                    if (field > maxlimit)
                    {

                        if (maxlimit === 3000)
                            alert('Comments size is exceeding 3000 characters');
                        else
                            alert('Comments size is exceeding 3000 characters');
                    } else
                        cntfield.value = maxlimit - field;
                }
                function edittextCounter(field, cntfield, maxlimit)
                {
                    if (field.value.length > maxlimit)
                    {
                        field.value = field.value.substring(0, maxlimit);
                        if (maxlimit === 3000)
                            alert('Escalation comments size is exceeding 3000 characters');
                        else
                            alert('Expected Result size is exceeding 3000 characters');
                    } else
                        cntfield.value = maxlimit - field.value.length;
                }
                function trim(str) {
                    while (str.charAt(str.length - 1) === " ")
                        str = str.substring(0, str.length - 1);
                    while (str.charAt(0) === " ")
                        str = str.substring(1, str.length);
                    return str;
                }

                function textCounter(field, cntfield, maxlimit) {
                    if (field.value.length > maxlimit)
                    {
                        field.value = field.value.substring(0, maxlimit);
                        alert('Description size is exceeding 3000 characters');
                    } else
                        cntfield.value = maxlimit - field.value.length;
                }
                function isRepeat(m1, m2) {

                    m1len = m1.length;
                    teamLength = m2.length;
                    var flag = false;
                    if (teamLength !== 0) {
                        for (i = 0; i < m1len; i++) {
                            if (m1.options[i].selected === true) {
                                for (j = 0; j < teamLength; j++) {
                                    if (flag === false) {
                                        if (m1.options[i].value === m2.options[j].value) {

                                            flag = true;

                                        }
                                    }
                                }
                            }
                        }

                    }
                    return flag;

                }
                function one2two() {
                    var m1 = document.theForm.attendies;
                    var m2 = document.theForm.attendiesFinal;
                    m1len = m1.length;
                    teamFinalLength = m2.length;
                    var flag = isRepeat(m1, m2);

                    if (flag === true) {
                        alert('There is a repetition in the selection');
                    } else {
                        for (i = 0; i < m1len; i++) {
                            if (m1.options[i].selected === true) {
                                m2len = m2.length;
                                m2.options[m2len] = new Option(m1.options[i].text, m1.options[i].value);
                            }
                        }

                        for (i = (m1len - 1); i >= 0; i--) {
                            if (m1.options[i].selected === true) {
                                m1.options[i] = null;
                            }
                        }
                    }
                }

                function two2one() {
                    var m1 = document.theForm.attendies;
                    var m2 = document.theForm.attendiesFinal;
                    m2len = m2.length;
                    teamLength = m1.length;
                    teamSelectLength = m2.length;
                    if (m2len !== 0) {
                        for (i = 0; i < m2len; i++) {
                            // alert(m2.options[i].text);
                            if (m2.options[i].selected === true) {
                                flag = false;
                                for (j = 0; j < teamLength; j++) {
                                    // alert(m1.options[j].text);

                                    if (m2.options[i].value === m1.options[j].value) {
                                        flag = true;

                                    }
                                }
                                if (flag !== true) {
                                    m1index = m1.length;
                                    m1.options[m1index] = new Option(m2.options[i].text, m2.options[i].value);
                                }
                            }
                        }


                    }

                    for (i = (m2len - 1); i >= 0; i--) {
                        if (m2.options[i].selected === true) {
                            m2.options[i] = null;
                        }
                    }
                }
                function fun() {
                    var teamFinal = document.getElementById("attendiesFinal");
                    var teamFinalOptions = teamFinal.options;
                    var teamFinalOLength = teamFinalOptions.length;
                    if (teamFinalOLength < 1) {
                        alert("No Selections in the team\nPlease Select using the [Add] button");
                        return false;
                    }
                    for (var i = 0; i < teamFinalOLength; i++) {
                        teamFinalOptions[i].selected = true;
                    }
//                    if (trim(CKEDITOR.instances.comments.getData()) === "")
//                    {
//                        alert("Please Enter the Comments");
//                        CKEDITOR.instances.comments.focus();
//                        return false;
//                    }
//                    if (CKEDITOR.instances.comments.getData().length > 3000)
//                    {
//                        alert(" Comments exceeds 3000 character");
//                        CKEDITOR.instances.comments.focus();
//                        //        document.theForm.description.value == "";
//                        return false;
//                    }

                    if (document.getElementById("escalationPoints") !== null) {
                        if (document.getElementById("escalationPoints") > 3000)
                        {
                            alert(" Comments exceeds 3000 character");
                            document.getElementById("escalationPoints").focus();
                            return false;
                        }
                    }
                    if (document.getElementById('rating').value === '') {
                        alert('Please rate your satisfaction');
                        document.getElementById('rating').focus();
                        return false;
                    }
                    if (document.getElementById('rating').value != 'Excellent') {

                        if (document.getElementById('feedback').value === '') {
                            alert('Your feedback is valuable for us');
                            document.getElementById('feedback').focus();
                            return false;
                        }
                        if (document.getElementById('escalationPoints').value === '') {
                            alert('Please enter the escalation points');
                            document.getElementById('escalationPoints').focus();
                            return false;
                        }
                        if (document.getElementById('responsiblePerson').value === '') {
                            alert('Please select the responsible person');
                            document.getElementById('responsiblePerson').focus();
                            return false;
                        }

                    }

                    monitorSubmit();

                }
                $(document).ready(function () {
                    $("#removeescalation").hide();
                });
                function addEscalation() {
                    $(".escalation").show();
                    $("#addescalation").hide();
                    $("#removeescalation").show();
                }
                function removeEscalation() {
                    $(".escalation").hide();
                    $("#escalationPoints").val("");
                    $("#responsiblePerson").val("0");
                    $("#addescalation").show();
                    $("#removeescalation").hide();
                }
            </script>
            <script>
                function call(theForm)
                {
                    var x = document.getElementById("pid").value;
                    theForm.action = 'momProjectTeamWise.jsp?pid=' + x;
                    theForm.submit();
                }
            </script>
            </head>
            <body>
                <%@ include file="/header.jsp"%>
                <br/>
                <jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom"></jsp:useBean>
                <%twm.setAll(request);
                    String pid = request.getParameter("pid");
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
                    String project = GetProjects.getProjectName(pid);
                    Collection se1 = projects.keySet();
                    int count = 0;
                    if (!twm.getMomForClients().isEmpty()) {
                        MomForClientFormbean mfcf = twm.getMomForClients().get(0);
                        DateFormat dfor = new SimpleDateFormat("dd-MM-yyyy");
                        DateFormat dfora = new SimpleDateFormat("dd-MMM-yyyy");
                        String org = dfora.format(dfor.parse(twm.getHeldOn()));
                        if (mfcf.getHeldOn().equals(org)) {
                            count++;

                %>
                <script type="text/javascript">
                    window.location = '<%=request.getContextPath()%>/MOM/editMomForClient.jsp?momClientId=<%=mfcf.getMomClientId()%>&pid=<%=twm.getPid()%>';
                </script>
                <%}
                    }

                    if (count == 0) {

                %>

                <!-- edit by mukesh-->
                <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
                    <tr>  <td style="width:30%;text-align: left"> Minutes Of Meeting for <%=twm.getPname()%></td>
                        <td style="text-align:center"><a href="printWRM.jsp?pid=<%=twm.getPid()%>" target="_blank">Print All</a></td>
                        <td style="width:30%;text-align:right; height: 25px;">
                            <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                                <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 

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
                                </select></form>
                        </td>
                    </tr>
                </table>
                <!-- edit by mukesh-->
                <table> <tr>
                        <td width="5%">
                            <%
                                if (twm.getCategory().equalsIgnoreCase("SAP Project")) {
                            %>
                            <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=twm.getPid()%>">Business Process Map</a>&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=twm.getPname()%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
            <!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=twm.getPid()%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
                            <%
                                }
                            %>
                            <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=twm.getPname()%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                            <%
                                if (twm.getNoOfTestCases() > 0) {
                            %>
                            <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=twm.getPid()%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=twm.getPid()%>&project=<%=twm.getPid()%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                            <%}%>
                            <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=twm.getPid()%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=twm.getPid()%>" >View Issues</a>&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=twm.getPid()%>" style="font-weight: bold;" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                            <%if (project.contains("eTracker")) {%>
                            <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                            <%}%>
                        </td>
                    </tr>
                </table>
                <!--                <div style="text-align: right;"><a href="#"id="addescalation" onclick="javascript:addEscalation();">Add Escalation</a>  <a href="#"  id="removeescalation" onclick="javascript:removeEscalation();">Remove Escalation</a> </div>-->
                <br/>
                <%if (twm.getMessage() != null) {%>
                <div style="text-align: center;color: #33CC33;font-weight: bold;"><%=twm.getMessage()%></div>
                <%}%>
                <form name="theForm" id="theForm" action="momProjectTeamWise.jsp" method="post" onsubmit="return fun();">

                    <table style="background-color: #E8EEF7;">
                        <tr>
                            <td style="font-weight: bold;">Held On </td><td>:</td>
                            <td><input type="text" id="heldOn" name="heldOn" value="<%=twm.getHeldOn()%>" maxlength="10" size="10"  readonly  /><a href="javascript:NewCal('heldOn','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a> </td>
                            <td style="font-weight: bold;">Held At </td><td>:</td>
                            <td><select name="heldAt" id="heldAt">
                                    <%for (Map.Entry<Integer, String> entry : twm.getHeldAt().entrySet()) {
                                            if (entry.getKey() == twm.getHeldat()) {%>
                                    <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                    <% } else {
                                    %>
                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                    <%}
                                        }%>

                                </select></td>
                        </tr>

                        <tr>
                            <td style="font-weight: bold;">Attendies </td><td>:</td>
                            <td><select name="attendies" id="attendies" multiple="true" style="width: 200px;"  size="4" >
                                    <%for (Map.Entry<String, String> entry : twm.getMomTeamMembers().entrySet()) {%>
                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                    <% }
                                    %>
                                </select></td>

                            <td>
                                <p style="text-align: left;"><input type="button" onClick="one2two();"	value=" >> "></p>
                                <p style="text-align: left;"><input type="button" onClick="two2one();"	value=" << "></p>
                            </td>
                            <td></td>
                            <td align="left"><select id="attendiesFinal" name="attendiesFinal" style="width: 200px;"  size="4" multiple>
                                    <%for (Map.Entry<String, String> entry : twm.getSelectedMembers().entrySet()) {%>
                                    <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                    <%}%>

                                </select>

                            </td>    
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">Start Time</td>
                            <td>:</td>
                            <td><select name="startH" id="startH" >
                                    <%for (int i = 0; i < 24; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}%>
                                </select><select name="startM" id="startM" >
                                    <%for (int i = 0; i < 60; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}%>
                                </select></td>
                            <td style="font-weight: bold;">End Time</td>
                            <td>:</td>
                            <td><select name="endH" id="endH">
                                    <%for (int i = 0; i < 24; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}%>
                                </select><select name="endM" id="endM" >
                                    <%for (int i = 0; i < 60; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}%>
                                </select></td>
                        </tr>
                        <%if (twm.isPreWrm()) {%>
                        <tr style="font-weight: bold;color: blue;"><td colspan="16">Issues Reviewed and Committed for Last Week</td></tr>

                        <tr>
                            <td colspan="16">
                                <table style="width: 100%;" id="wrmPlanTable" class="tablesorter">
                                    <thead> 
                                        <tr>
                                            <!--                                //     <TH style="background-color: #C3D9FF;" width="1%" TITLE="Severity"><font><b>S</b></font></TH>-->
                                            <TH class="header" width="12%"><font><b>Issue No</b></font></TH>
                                            <!--<TH class="header" width="2%" TITLE="Priority"><font><b>P</b></font></TH>-->
                                            <TH class="header" width="7%"><font><b>Module</b></font></TH>
                                            <TH class="header" width="12%"><font><b>Last WRM Status</b></font></TH>
                                            <TH class="header" width="12%"><font><b>Current Status</b></font></TH>
                                            <TH class="header" width="28%"><font><b>Subject</b></font></TH>
                                            <th class="header"><font><b>Review Comments</b></font></th>
                                        </tr>
                                    </thead>


                                    <%int k = 0;
                                        String rating = "", color = "", preStatus = "", staColor = "";
                                        for (IssueFormBean isfb : twm.getWrmplanIssueDetails()) {
                                            preStatus = "";
                                            staColor = "";
                                            if (twm.getIssueStatus().containsKey(isfb.getIssueId())) {
                                                preStatus = twm.getIssueStatus().get(isfb.getIssueId());
                                            }
                                            if (preStatus.equalsIgnoreCase(isfb.getStatus())) {
                                                staColor = "red";
                                            }
                                            k++;
                                            if ((k % 2) == 0) {

                                    %>
                                    <tr bgcolor="#E8EEF7" height="23">
                                        <%                } else {
                                        %>

                                        <tr bgcolor="white" height="23">
                                            <%                    }
                                                rating = isfb.getRating();
                                                color = "";
                                                if (rating != null) {
                                                    if (rating.equalsIgnoreCase("Excellent")) {
                                                        color = "#336600";

                                                    } else if (rating.equalsIgnoreCase("Good")) {
                                                        color = "#33CC66";

                                                    } else if (rating.equalsIgnoreCase("Average")) {
                                                        color = "#CC9900";

                                                    } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                        color = "#CC0000";

                                                    }
                                                }
                                            %>
                                    <!--<td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>-->
                                            <td width="11%" title="<%=isfb.getType()%>" bgcolor="<%=color%>"><a href="${pageContext.servletContext.contextPath}/viewIssueDetails.jsp?issueid=<%=isfb.getIssueId()%>" target="_blank"><%=isfb.getIssueId()%></a></td>
                                    <!--<td width="3%"><%=isfb.getPriority()%></td>-->
                                            <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>

                                            <td width="7%" bgcolor="<%=staColor%>"> <%=preStatus%>   </td>
                                            <td width="7%" bgcolor="<%=staColor%>"><%=isfb.getStatus()%></td>
                                            <td width="29%" bgcolor="<%=staColor%>" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                                            <td>
                                                <%
                                                    String comments = null;
                                                    for (ApmWrmPlan awp : twm.getWrmPlanList()) {
                                                        if (awp.getIssueid().equalsIgnoreCase(isfb.getIssueId())) {
                                                            comments = awp.getComments();
                                                        }
                                                    }
                                                    if (comments == null) {
                                                        comments = "";
                                                    }
                                                %><%=comments%>
                                            </td>
                                        </tr>
                                        <%}%>
                                </table>
                            </td>
                        </tr>
                        <%if (twm.getAdditionalClosedIssueDetails().size() > 0) {%>
                        <tr  id="test"><td colspan="16"><font color='blue' style="font-weight: bold;">Additional Issues Closed</font></td></tr>

                        <tr id="test1">
                            <td colspan="16">
                                <table style="width: 100%;" id="wrmAdditionalTable" class="tablesorter">
                                    <thead> 
                                        <tr>
                                            <!--                                //     <TH style="background-color: #C3D9FF;" width="1%" TITLE="Severity"><font><b>S</b></font></TH>-->
                                            <TH class="header" width="12%"><font><b>Issue No</b></font></TH>
                                            <!--<TH class="header" width="2%" TITLE="Priority"><font><b>P</b></font></TH>-->
                                            <TH class="header" width="17%"><font><b>Module</b></font></TH>
                                            <TH class="header" width="68%"><font><b>Subject</b></font></TH>
                                        </tr>
                                    </thead>


                                    <%int p = 0;
                                        for (IssueFormBean isfb : twm.getAdditionalClosedIssueDetails()) {
                                            p++;
                                            if ((p % 2) == 0) {

                                    %>
                                    <tr bgcolor="#E8EEF7" height="23">
                                        <%                } else {
                                        %>

                                        <tr bgcolor="white" height="23">
                                            <%                    }

                                            %>
                                            <td width="11%" title="<%=isfb.getType()%>" bgcolor="<%=isfb.getRatingColor()%>"><a href="${pageContext.servletContext.contextPath}/viewIssueDetails.jsp?issueid=<%=isfb.getIssueId()%>" target="_blank"><%=isfb.getIssueId()%></a></td>
                                            <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                                            <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>

                                        </tr>
                                        <%}%>
                                </table>
                            </td>
                        </tr>
                        <%} %>

                        <%} else {
                            if (twm.getWrmplanIssueDetails().size() > 0) {%>        
                        <tr style="font-weight: bold;color: blue;"><td colspan="16">Issues Reviewed and Committed for Next Week</td></tr>

                        <tr>
                            <td colspan="16">
                                <table style="width: 100%;" id="wrmPlanTable" class="tablesorter">
                                    <thead> 
                                        <tr>
                                            <!--                                //     <TH style="background-color: #C3D9FF;" width="1%" TITLE="Severity"><font><b>S</b></font></TH>-->
                                            <TH class="header" width="12%"><font><b>Issue No</b></font></TH>
                                            <!--<TH class="header" width="2%" TITLE="Priority"><font><b>P</b></font></TH>-->
                                            <TH class="header" width="7%"><font><b>Module</b></font></TH>
                                            <TH class="header" width="28%"><font><b>Subject</b></font></TH>
                                            <th class="header"><font><b>Review Comments</b></font></th>
                                        </tr>
                                    </thead>


                                    <%int k = 0;
                                        String rating = "", color = "", preStatus = "", staColor = "";
                                        for (IssueFormBean isfb : twm.getWrmplanIssueDetails()) {

                                            k++;
                                            if ((k % 2) == 0) {

                                    %>
                                    <tr bgcolor="#E8EEF7" height="23">
                                        <%                } else {
                                        %>

                                        <tr bgcolor="white" height="23">
                                            <%                    }
                                                rating = isfb.getRating();
                                                color = "";
                                                if (rating != null) {
                                                    if (rating.equalsIgnoreCase("Excellent")) {
                                                        color = "#336600";

                                                    } else if (rating.equalsIgnoreCase("Good")) {
                                                        color = "#33CC66";

                                                    } else if (rating.equalsIgnoreCase("Average")) {
                                                        color = "#CC9900";

                                                    } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                        color = "#CC0000";

                                                    }
                                                }
                                            %>
                                    <!--<td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>-->
                                            <td width="11%" title="<%=isfb.getType()%>" bgcolor="<%=color%>"><a href="${pageContext.servletContext.contextPath}/viewIssueDetails.jsp?issueid=<%=isfb.getIssueId()%>" target="_blank"><%=isfb.getIssueId()%></a></td>
                                    <!--<td width="3%"><%=isfb.getPriority()%></td>-->
                                            <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>

                                            <td width="29%" bgcolor="<%=staColor%>" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                                            <td>
                                                <%
                                                    String comments = null;
                                                    for (ApmWrmPlan awp : twm.getWrmPlanList()) {
                                                        if (awp.getIssueid().equalsIgnoreCase(isfb.getIssueId())) {
                                                            comments = awp.getComments();
                                                        }
                                                    }
                                                    if (comments == null) {
                                                        comments = "";
                                                    }
                                                %>
                                                <input type="text" name="<%=isfb.getIssueId()%>reviewcomment" value="<%=comments%>" maxlength="150" size="50"/>
                                            </td>
                                        </tr>
                                        <%}%>
                                </table>
                            </td>
                        </tr>
                        <%}
                            }%>
                        <%if (twm.isPreWrm() == false) {%>
                        <tr>
                            <td style="font-weight: bold;">Points Discussed </td><td>:</td>
                            <td colspan="5" align="left"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                        rows="3" cols="68" name="comments" id="comments" maxlength="3000"
                                        onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 3000);"
                                        onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 3000);"></textarea></font>
                            </td><td><input readonly type="text" name="remLen1"
                                            size="1" maxlength="4" value="3000"/>
                            </td>

                            <script type="text/javascript">
                                CKEDITOR.replace('comments', {height: 100});
                                var editor_data = CKEDITOR.instances.comments.getData();
                                CKEDITOR.instances["comments"].on("instanceReady", function ()
                                {

                                    //set keyup event
                                    this.document.on("keyup", updateComments);
                                    //and paste event
                                    this.document.on("paste", updateComments);

                                });
                                function updateComments()
                                {
                                    CKEDITOR.tools.setTimeout(function ()
                                    {
                                        var desc = CKEDITOR.instances.comments.getData();
                                        var leng = desc.length;
                                        editorTextCounter(leng, document.theForm.remLen1, 3000);

                                    }, 0);
                                }
                            </script>
                        </tr>
                        <%}%>
                        <tr>
                            <td><b>Rating</b></td>
                            <td>:</td>
                            <td><select name="rating" id="rating">
                                    <option value="">Select</option>
                                    <%for (Map.Entry<String, String> entry : twm.getRatingList().entrySet()) {%>
                                    <option value="<%=entry.getKey()%>"><%=entry.getKey()%></option>
                                    <%}%>
                                </select>
                            </td>
                            <td><b>Feedback</b></td>
                            <td>:</td>
                            <td><input type="text" name="feedback" id="feedback" size="57" maxlength="400"></input></td>
                        </tr>
                        <tr style="display: none;" class="escalation">
                            <td style="font-weight: bold;">Escalation</td><td>:</td>
                            <td colspan="5" ><textarea name="escalationPoints" id="escalationPoints" rows="3" cols="84" onKeyDown="edittextCounter(document.theForm.escalationPoints, document.theForm.remLen2, 3000);"
                                                       onKeyUp="edittextCounter(document.theForm.escalationPoints, document.theForm.remLen2, 3000);"></textarea></td>
                            <td><input readonly type="text" name="remLen2" 
                                       id="remLen2" size="1" maxlength="4" value="3000"></td>
                        </tr>
                        <tr style="display: none;" class="escalation">
                            <td style="font-weight: bold;">Responsible Person</td><td>:</td>
                            <td  ><select name="responsiblePerson" id="responsiblePerson" style="width: 200px;"  >
                                    <option value="0">--Select One--</option>
                                    <%for (Map.Entry<String, String> entry : twm.getMomTeamMembers().entrySet()) {%>
                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                    <% }
                                    %>
                                </select></td>
                        </tr>
                        <tr style="text-align: center;">
                            <td colspan="4">
                                <%if (twm.getMomClientId() != 0) {%>
                                <input type="hidden" name="momClientId" value="<%=twm.getMomClientId()%>">
                                    <%}%>
                                    <input type="hidden" name="pid" value="<%=twm.getPid()%>"><input type="submit" name="submit" id="submit" value="Submit"></input><input type="reset" name="reset" id="reset" value="Reset"></input></td></tr>
                                        </table>
                                        </form>
                                        <br/>
                                        <div>The below list shows Weekly review meetings of <%=twm.getPname()%></div>
                                        <table style="width: 100%;">
                                            <tr style="height:21px;background-color: #C3D9FF;font-weight: bold;">
                                                <td>Held On</td>
                                                <td>Start Time</td>
                                                <td>End Time</td>
                                                <td>Held At</td>
                                                <td>Rating</td>
                                                <td>Responsible Person</td>
                                                <td>Attendies</td>

                                            </tr>
                                            <%int i = 0;
                                                String color = "";
                                                for (MomForClientFormbean momForClient : twm.getMomForClients()) {
                                                    if ((i % 2) != 0) {%>
                                            <tr bgcolor="#E8EEF7" height="21">
                                                <%                     } else {%>
                                                <tr bgcolor="white" height="21">
                                                    <%                    }
                                                        i++;
                                                        color = "";
                                                        if (momForClient.getmRating() != null) {
                                                            if (momForClient.getmRating().equalsIgnoreCase("Excellent")) {
                                                                color = "#336600";

                                                            } else if (momForClient.getmRating().equalsIgnoreCase("Good")) {
                                                                color = "#33CC66";

                                                            } else if (momForClient.getmRating().equalsIgnoreCase("Average")) {
                                                                color = "#CC9900";

                                                            } else if (momForClient.getmRating().equalsIgnoreCase("Need Improvement")) {
                                                                color = "#CC0000";

                                                            }
                                                        }
                                                    %>
                                                    <td style="width: 9%;"><a href="editMomForClient.jsp?momClientId=<%=momForClient.getMomClientId()%>&pid=<%=twm.getPid()%>"><%=momForClient.getHeldOn()%></a></td>
                                                    <td style="width: 9%;" title="<%=momForClient.getEscalation()%>"><%=momForClient.getStartTime()%></td>
                                                    <td style="width: 9%;"><%=momForClient.getEndTime()%></td>
                                                    <td style="width: 9%;" id="<%=i%>tab" onmouseover="xstooltip_show('<%=i%>', '<%=i%>tab', 489, 49);" onmouseout="xstooltip_hide('<%=i%>');" ><div class="issuetooltip" id="<%=i%>"><%= momForClient.getDiscussion()%></div><%=momForClient.getHeldAt()%></td>
                                                    <td style="width: 9%;" bgcolor="<%=color%>"><%=momForClient.getmRating()%></td>
                                                    <td style="width: 14%;" title="<%=momForClient.getEscalation()%>"><%=momForClient.getResponsiblePerson()%></td>
                                                    <td title="<%=momForClient.getAttendies()%>"><%=momForClient.getMinattendies()%></td>
                                                </tr>

                                                <%}%>
                                        </table>
                                        </body>
                                        <script>
                                            $(document).ready(function ()
                                            {
                                                $("#wrmPlanTable").tablesorter({
                                                    // change the multi sort key from the default shift to alt button 


                                                });
                                            });
                                            $("#rating").change(function () {
                                                var val = $(this).val();
                                                if (val === 'Excellent') {
                                                    removeEscalation();
                                                } else {
                                                    addEscalation();
                                                }
                                            });
                                        </script>
                                        </html>
                                        <%}%>