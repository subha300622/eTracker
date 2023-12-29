<%--
    Document   : editMomForClient
    Created on : Apr 11, 2014, 3:25:56 PM
    Author     : E0288
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

    Logger logger = Logger.getLogger("editMomForClient");
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
                var xmlhttp = createRequest();
                function createRequest() {
                    var reqObj = null;
                    try {
                        reqObj = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (err) {
                        try {
                            reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (err2) {
                            try {
                                reqObj = new XMLHttpRequest();
                            } catch (err3) {
                                reqObj = null;
                            }
                        }
                    }
                    return reqObj;
                }
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
                        alert("No Selections in the attendie\nPlease Select using the [Add] button");
                        return false;
                    }
                    for (var i = 0; i < teamFinalOLength; i++) {
                        teamFinalOptions[i].selected = true;
                    }
                    if (trim(CKEDITOR.instances.comments.getData()) === "")
                    {
                        alert("Please Enter the Comments");
                        CKEDITOR.instances.comments.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.comments.getData().length > 3000)
                    {
                        alert(" Comments exceeds 3000 character");
                        CKEDITOR.instances.comments.focus();
                        //        document.theForm.description.value == "";
                        return false;
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
                function callreview(momClientId) {
                    if (xmlhttp !== null) {

                        xmlhttp.open("GET", "/eTracker/MOM/reviewMeeting.jsp?momClientId=" + encodeURIComponent(momClientId) + "&rand=" + Math.random(1, 10), false);

                        xmlhttp.onreadystatechange = function () {
                            callbackreview();
                        };
                        xmlhttp.send(null);

                    } else {
                        alert('no ajax request');
                    }
                }
                function callbackreview() {
                    if (xmlhttp.readyState === 4)
                    {
                        if (xmlhttp.status === 200)
                        {
                            var comp = xmlhttp.responseText;
                            var res = comp.split(";;;");
                            var heldat = res[5].split(":");

                            var prevnextheader = '';
                            var allids = res[13].split(",");
                            var index = -1;
                            var previd = 0;
                            var nextid = 0;
                            for (var n = -1; n < allids.length - 1; n++) {
                                if (Number(res[3]) === Number(allids[n])) {
                                    index = n;
                                }
                            }


                            if (res[0] === "false")
                            {
                                var updatemode = $("#editreviewmeeting").css('display');
                                if (updatemode === "none") {
                                    $("#escalationlinks").hide();
                                }
                                if (document.getElementById('tabid' + res[3]) === null) {
                                    var viewContent = "<div id='tabid" + res[3] + "' style='width:100%;font-weight:bold;color:blue;background-color:#C3D9FF;'>" + res[4] + "<span style='float:right;font-weight:normal;'><a target='_blank' href='printWRM.jsp?momClientId=" + res[3] + "'>Print WRM</a></span></td></div><div style='height:2px;'></div><table style='background-color: #E8EEF7;width:100%;'><tr style='height:21px;'>" +
                                            "<td style='font-weight: bold;width:14%;'>Held On </td><td style='width:1%;'>:</td><td style='width:8%;'>" + res[4] + "</td>" +
                                            "<td style='font-weight: bold;width:8%;'>Held At </td><td style='width:1%;'>:</td><td  style='width:8%;'>" + heldat[1] + "</td>" +
                                            "<td style='font-weight: bold;width:12%;'>Start Time</td><td style='width:1%;'>:</td><td  style='width:8%;'>" + res[7] + "</td>" +
                                            "<td style='font-weight: bold;width:12%;'>End Time</td><td style='width:1%;'>:</td><td  style='width:8%;'>" + res[8] + "</td>" +
                                            "</tr>" +
                                            "<tr style='height:21px;'>" +
                                            "<td style='font-weight: bold;'>Attendies </td><td>:</td><td colspan='8' align='left' id='tdattendies'>" + res[9] + "</td>" +
                                            "</tr><tr style='font-weight: bold;color: blue;' id='test" + res[3] + "'></tr><tr>" +
                                            "<td style='font-weight: bold;'>Points Discussed </td><td>:</td><td colspan='8' align='left' id='tddiscussion'>" +
                                            "<font size='2' face='Verdana, Arial, Helvetica, sans-serif'> " + res[10] + "</font></td>" +
                                            "</tr><tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;width:8%;'>Rating </td><td>:</td><td  style='width:30%;'>" + res[11] + "</td>"
                                            + "<td style='font-weight: bold;width:12%;'>Feedback</td><td>:</td><td  style='width:8%;'>" + res[12] + "</td></tr>";
                                    if (res.length > 14) {
                                        var rperson = res[15].split(":");
                                        viewContent = viewContent + "<tr><td style='font-weight: bold;'>Escalation</td><td>:</td>" +
                                                "<td colspan='6' >" + res[14] + "</td>" +
                                                "</tr><tr  >" +
                                                "<td style='font-weight: bold;'>Responsible Person</td><td>:</td><td colspan='6' >" + rperson[1] + "</td></tr>";

                                    } else {
                                        viewContent = viewContent + "<tr><td style='font-weight: bold;'>Escalation</td><td>:</td>" +
                                                "<td colspan='6' >Nil</td>" +
                                                "</tr>";
                                    }
                                    viewContent = viewContent + "</table>";

                                    $("#viewcontent").append(viewContent);
                                    $("#viewcontent").show();
                                    if (xmlhttp !== null) {

                                        xmlhttp.open("GET", "/eTracker/MOM/getWrmIssues.jsp?momClientId=" + encodeURIComponent(res[3]) + "&rand=" + Math.random(1, 10), false);

                                        xmlhttp.onreadystatechange = function () {
                                            callbackwrmplanissue(res[3]);
                                        };
                                        xmlhttp.send(null);
                                    } else {
                                        alert('no ajax request');
                                    }
                                } else {

                                }
                            } else
                            {
                                $("#escalationlinks").show();
                                $("#editreviewmeeting").show();
                                $("#updateHeading").html("<div id='tabid" + res[3] + "'>Update Meeting Held On " + res[4] + "</div>");

                                var attendiesfinal = res[9].split(",");
                                var teamFinal = document.getElementById("attendiesFinal");
                                var teamFinalOptions = teamFinal.options;
                                var teamFinalOLength = teamFinalOptions.length;

                                for (var i = 0; i < teamFinalOLength; i++) {
                                    teamFinalOptions[i].selected = true;
                                }
                                two2one();
                                var teamSelect = document.getElementById("attendies");
                                for (var j = 0; j < attendiesfinal.length; j++) {
                                    var attendie = attendiesfinal[j].split(":");
                                    for (var i = 0; i < teamSelect.length; i++) {

                                        if (teamSelect[i].value === attendie[0]) {
                                            teamSelect[i].selected = true;
                                        }
                                    }
                                }
                                one2two();
                                document.getElementById("momClientId").value = res[3];
                                document.getElementById("printwrm").href = "printWRM.jsp?momClientId=" + res[3];
                                document.getElementById("heldOn").value = res[4];
                                var heldat = res[5].split(":");
                                document.getElementById("heldAt").value = heldat[0];
                                var start = res[7].split(":");
                                var end = res[8].split(":");
                                document.getElementById("startH").value = start[0];
                                document.getElementById("startM").value = start[1];
                                document.getElementById("endH").value = end[0];
                                document.getElementById("endM").value = end[1];
                                document.getElementById("rating").value = res[11];
                                document.getElementById("feedback").value = res[12];
                                CKEDITOR.instances['comments'].setData(res[10]);
                                if (res.length > 14) {
                                    addEscalation();
                                    var rperson = res[15].split(":");
                                    document.getElementById("responsiblePerson").value = rperson[0];
                                    document.getElementById("escalationPoints").value = res[14];
                                } else {
                                    removeEscalation();
                                    document.getElementById("responsiblePerson").value = "";
                                    document.getElementById("escalationPoints").value = "";
                                }
                                if (xmlhttp !== null) {

                                    xmlhttp.open("GET", "/eTracker/MOM/getWrmIssues.jsp?momClientId=" + encodeURIComponent(res[3]) + "&rand=" + Math.random(1, 10), false);

                                    xmlhttp.onreadystatechange = function () {
                                        callbackwrmupdateplanissue();
                                    };
                                    xmlhttp.send(null);
                                } else {
                                    alert('no ajax request');
                                }
                            }
                            var k = -1;
                            if (index >= 0) {
                                var goPrevious = 1;
                                var goNext = 1;
                                for (var n = 0; n < allids.length; n++) {
                                    k++;
                                    if (index > 0) {
                                        if (k === index - goPrevious) {
                                            previd = Number(allids[n]);

                                            if (previd !== 0) {
                                                if (document.getElementById('tabid' + previd) !== null) {

                                                    var flag = "yes";
                                                    for (var z = 0; z < allids.length; z++) {
                                                        if (flag === "yes") {
                                                            if (n - z >= 0) {
                                                                previd = Number(allids[n - z]);
                                                                if (previd !== 0) {
                                                                    if (document.getElementById('tabid' + previd) === null) {
                                                                        flag = "no";
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    goPrevious++;
                                                }
                                            }
                                        }

                                    }
                                    if (index < (allids.length - 1)) {
                                        if (k === index + goNext) {
                                            nextid = Number(allids[n]);
                                            if (nextid !== 0) {
                                                if (document.getElementById('tabid' + nextid) !== null) {
                                                    goNext++;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if (previd !== 0) {
                                if (document.getElementById('tabid' + previd) === null) {
                                    prevnextheader = "<a href='javascript:void(0)'  onclick='callreview(" + previd + ");'>Next</a><span>&nbsp;&nbsp;</span>";
                                }
                            }
                            if (nextid !== 0) {
                                if (document.getElementById('tabid' + nextid) === null) {
                                    prevnextheader = prevnextheader + "<a href='javascript:void(0)'   onclick='callreview(" + nextid + ");'>Prev</a>";
                                }
                            }
                            $("#prevnext").html(prevnextheader);
                            var reviewid = trim("tabid" + Number(res[3]));
                            var tabname = document.getElementsByName('tabname');

                            if (document.getElementById(reviewid) === null) {


                                $("#reviewtabs").append($("<a href='javascript:void(0)' name='tabname' id=" + reviewid + " onclick='callreview(" + Number(res[3]) + ");'>" + res[4] + "</a><span>&nbsp;&nbsp;</span>"));
                                for (var i = 0; i < tabname.length; i++) {
                                    if (tabname[i].id === reviewid) {
                                        $("#" + tabname[i].id).css("font-weight", "bold");
                                        $("#" + tabname[i].id).css("background-color", "white");
                                    } else {
                                        $("#" + tabname[i].id).css("font-weight", "normal");
                                        $("#" + tabname[i].id).css("background-color", "#C3D9FF");
                                    }
                                }
                            } else {
                                for (var i = 0; i < tabname.length; i++) {
                                    if (tabname[i].id === reviewid) {

                                        $("#" + tabname[i].id).css("font-weight", "bold");
                                        $("#" + tabname[i].id).css("background-color", "white");
                                    } else {
                                        $("#" + tabname[i].id).css("font-weight", "normal");
                                        $("#" + tabname[i].id).css("background-color", "#C3D9FF");
                                    }
                                }
                            }
                        }

                    }
                }
                function callbackwrmplanissue(momClientId) {
                    if (xmlhttp.readyState === 4)
                    {
                        if (xmlhttp.status === 200)
                        {
                            var comp = xmlhttp.responseText;
                            $("#test" + momClientId).replaceWith(comp);
                        }
                    }
                }
                function callbackwrmupdateplanissue() {
                    if (xmlhttp.readyState === 4)
                    {
                        if (xmlhttp.status === 200)
                        {
                            var comp = xmlhttp.responseText;
                            $("#test").empty();
                            $("#test1").empty();
                            $("#test").html(comp);
                        }
                    }
                }

                function call(theForm)
                {
                    var x = document.getElementById("pid").value;
                    theForm.action = 'momProjectTeamWise.jsp?pid=' + x;
                    theForm.submit();
                }
            </script>
            <!-- edit by mukesh end -->
            </head>
            <body>
                <%@ include file="/header.jsp"%>
                <br/>
                <jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom"></jsp:useBean>

                    <!-- edit by mukesh start-->
                <%
                    String pid = request.getParameter("pid");
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

                    twm.setAll(request);
                %>
                <table  style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
                    <tr>
                        <td style="width:40%; text-align: left;"> Minutes Of Meeting for <%=twm.getPname()%></td>
                        <td style="width:40%;left:200px ;text-align: center;"><a href="printWRM.jsp?pid=<%=twm.getPid()%>" target="_blank">Print All</a></td>

                        <td  style="width:40%;text-align: right;">       
                            <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                                <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 

                                    <%

                                        Iterator iter3 = se1.iterator();
                                        int projectId = 0;
                                        while (iter3.hasNext()) {

                                            String key = (String) iter3.next();
                                            String nameofproject = (String) projects.get(key);
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
                <!-- edit by mukesh end-->
                <table width="100%">
                    <tr>
                        <td width="5%">
                            <%
                                if (twm.getCategory().equalsIgnoreCase("SAP Project")) {
                            %>
                            <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=twm.getPid()%>">Test Map Tree View</a>&nbsp;&nbsp;&nbsp;
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
                        </td>
                    </tr>
                </table>
                <br/>
                <%if (twm.getMessage() != null) {%>
                <div style="text-align: center;color: #33CC33;font-weight: bold;"><%=twm.getMessage()%></div>
                <%}%>
                <%
                    int index = -1;
                    int j = -1;
                    for (MomForClientFormbean mcfb : twm.getMomForClients()) {
                        j++;
                        if (mcfb.getMomClientId() == twm.getMomClientId()) {
                            index = j;
                        }
                    }
                    int previd = 0;
                    int nextid = 0;
                    int k = -1;
                    if (index >= 0) {
                        for (MomForClientFormbean mcfb : twm.getMomForClients()) {
                            k++;
                            if (index > 0) {
                                if (k == index - 1) {
                                    previd = mcfb.getMomClientId();
                                }

                            }
                            if (index < (twm.getMomForClients().size() - 1)) {
                                if (k == index + 1) {
                                    nextid = mcfb.getMomClientId();
                                }
                            }
                        }
                    }
                %>

                <div id="viewcontent" style="display:none;width:100%;"></div>
                <div id="prevnext" style="text-align: center;">
                    <%if (previd != 0) {%>
                    <a href="javascript:void(0)"  onclick="callreview(<%=previd%>);">Next</a>
                    <%}
                if (nextid != 0) {%>
                    <a href="javascript:void(0)"   onclick="callreview(<%=nextid%>);">Previous</a>
                    <%}%>
                </div>
                <!--        <div id="escalationlinks" style="text-align: right;"><a href="#"id="addescalation" onclick="javascript:addEscalation();">Add Escalation</a>  <a href="#"  id="removeescalation" onclick="javascript:removeEscalation();">Remove Escalation</a> </div>-->
                <form name="theForm" id="theForm" action="updateMomForClient.jsp" method="post" onsubmit="return fun();">
                    <table style="background-color: #E8EEF7;" id="editreviewmeeting">
                        <tr bgcolor="#C3D9FF" style="height:25px;"><td colspan="7" id="updateHeading" style="font-weight: bold;"><%if (twm.isDisplayMode() == true) {%>
                                <div id="tabid<%=twm.getMomClientId()%>">
                                    Update Meeting Held On <%=twm.getHeldOn()%></div><%} else {%>
                                Update Meeting Held On <%=twm.getHeldOn()%> 
                                <%}%></td><td ><a id='printwrm'target="_blank" href="printWRM.jsp?momClientId=<%=twm.getMomClientId()%>">Print WRM</a></td></tr>
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
                            <td style="font-weight: bold;">Attendees </td><td>:</td>
                            <td><select name="attendies" id="attendies" multiple="true" style="width: 200px;"  size="4" >
                                    <%for (Map.Entry<String, String> entry : twm.getMomTeamMembers().entrySet()) {
                                            if (!twm.getSelectedMembers().containsKey(entry.getKey())) {
                                    %>
                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                    <% }
                                        }
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
                                            if (twm.getStartTimeH().equalsIgnoreCase(val)) {%>
                                    <option value="<%=val%>" selected><%=val%></option>
                                    <%} else {
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}
                                }%>
                                </select><select name="startM" id="startM" >
                                    <%for (int i = 0; i < 60; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                            if (twm.getStartTimeM().equalsIgnoreCase(val)) {%>
                                    <option value="<%=val%>" selected><%=val%></option>
                                    <%} else {
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}
                                }%>
                                </select></td>
                            <td style="font-weight: bold;">End Time</td>
                            <td>:</td>
                            <td><select name="endH" id="endH">
                                    <%for (int i = 0; i < 24; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                            if (twm.getEndTimeH().equalsIgnoreCase(val)) {%>
                                    <option value="<%=val%>" selected><%=val%></option>
                                    <%} else {
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}
                                }%>
                                </select><select name="endM" id="endM" >
                                    <%for (int i = 0; i < 60; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                            if (twm.getEndTimeM().equalsIgnoreCase(val)) {%>
                                    <option value="<%=val%>" selected><%=val%></option>
                                    <%} else {
                                    %>
                                    <option value="<%=val%>"><%=val%></option>
                                    <%}
                                }%>
                                </select></td>
                        </tr>

                        <%if (twm.getWrmplanIssueDetails().size() > 0) {%>
                        <tr  id="test"><td colspan="16"><font color='blue'>Issues Reviewed and Committed for Next Week</font></td></tr>

                        <tr id="test1">
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


                                    <%int p = 0;
                                        String rating = "", color = "";

                                        for (IssueFormBean isfb : twm.getWrmplanIssueDetails()) {
                                            p++;
                                            if ((p % 2) == 0) {

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
                                            <td width="11%" title="<%=isfb.getType()%>" bgcolor="<%=color%>"><a href="${pageContext.servletContext.contextPath}/viewIssueDetails.jsp?issueid=<%=isfb.getIssueId()%>" target="_blank"><%=isfb.getIssueId()%></a></td>
                                            <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                                            <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
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
                        <%} else {%>
                        <tr id="test"></tr>
                        <%}%>
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
                        <%} else {%>
                        <tr id="testa"></tr>
                        <%}%>
                        <tr>
                            <td style="font-weight: bold;">Points Discussed </td><td>:</td>
                            <td colspan="5" align="left"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                        rows="3" cols="68" name="comments" id="comments" maxlength="3000"
                                        onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 3000);"
                                        onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 3000);"><%=twm.getDiscussion()%></textarea></font>
                            </td><td><input readonly type="text" name="remLen1"
                                            size="3" maxlength="4" value="3000">
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
                        <tr>
                            <td><b>Rating</b></td>
                            <td>:</td>
                            <td><select name="rating" id="rating">
                                    <option value="" >Select</option>
                                    <%for (Map.Entry<String, String> entry : twm.getRatingList().entrySet()) {
                                    if (entry.getKey().equals(twm.getMrating())) {%>
                                    <option value="<%=entry.getKey()%>" selected><%=entry.getKey()%></option>
                                    <% } else {%>
                                    <option value="<%=entry.getKey()%>"><%=entry.getKey()%></option>
                                    <%}
                                }%>
                                </select>
                            </td>
                            <td><b>Feedback</b></td>
                            <td>:</td>
                            <td><input type="text" name="feedback" id="feedback" size="57" maxlength="400" value="<%=twm.getMfeedback()%>"></input></td>
                        </tr>
                        <%if (twm.getEscalationPoints() != null) {%>
                        <tr  class="escalation">
                            <td style="font-weight: bold;">Escalation</td><td>:</td>
                            <td colspan="5" ><textarea name="escalationPoints" id="escalationPoints" rows="3" cols="84" onKeyDown="edittextCounter(document.theForm.escalationPoints, document.theForm.remLen2, 3000);"
                                                       onKeyUp="edittextCounter(document.theForm.escalationPoints, document.theForm.remLen2, 3000);"><%=twm.getEscalationPoints()%></textarea></td>
                            <td><input readonly type="text" name="remLen2"
                                       id="remLen2" size="1" maxlength="4" value="3000"></td>
                        </tr>
                        <tr style="display: none;" class="escalation">
                            <td style="font-weight: bold;">Responsible Person</td><td>:</td>
                            <td  ><select name="responsiblePerson" id="responsiblePerson" style="width: 200px;"  >
                                    <option value="0">--Select One--</option>
                                    <%for (Map.Entry<String, String> entry : twm.getMomTeamMembers().entrySet()) {
                                    if (entry.getKey().equals(twm.getrPerson())) {%>
                                    <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                    <%} else {
                                    %>
                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                    <% }
                                        }
                                    %>
                                </select></td>
                        </tr>
                        <script type="text/javascript">
                            addEscalation();
                            $(document).ready(function () {
                                $("#removeescalation").show();
                            });
                        </script>
                        <%} else {%>
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
                                    <%for (Map.Entry<String, String> entry : twm.getMomTeamMembers().entrySet()) {
                                    if (entry.getKey().equals(twm.getrPerson())) {%>
                                    <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                    <%} else {
                                    %>
                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                    <% }
                                        }
                                    %>
                                </select></td>
                        </tr>
                        <%}%>
                        <tr style="text-align: center;">
                            <td colspan="4">
                                <%if (twm.getMomClientId() != 0) {%>
                                <input type="hidden" name="momClientId" id="momClientId" value="<%=twm.getMomClientId()%>">
                                    <%}%>
                                    <input type="hidden" name="pid" value="<%=twm.getPid()%>"><input type="submit" name="submit" id="submit" value="Update"></input><input type="reset" name="reset" id="reset" value="Reset"></input></td></tr>
                                        </table>
                                        </form>
                                        <script type="text/javascript">

                                            <%logger.info(twm.isDisplayMode());
                                                if (twm.isDisplayMode() == false) {%>
                                            $("#editreviewmeeting").hide();
                                            callreview(<%=twm.getMomClientId()%>);
                                            <%} else {%>

                                            <%}%>
                                        </script>



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
                                                    <td style="width: 9%;"><a href="#" onclick="callreview(<%=momForClient.getMomClientId()%>);"><%=momForClient.getHeldOn()%></a></td>
                                                    <td style="width: 9%;" ><%=momForClient.getStartTime()%></td>
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
                                                $(".tablesorter").tablesorter({
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

