

<%@page import="java.util.Date"%>
<%@page import="com.eminentlabs.meeting.ApmMeetingParticipants"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminentlabs.meeting.ApmMeetings"%>
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
                        alert('Comments size is exceeding ' + maxlimit + ' characters');
                    } else
                        cntfield.value = maxlimit - field;
                }
                function edittextCounter(field, cntfield, maxlimit)
                {
                    if (field.value.length > maxlimit)
                    {
                        field.value = field.value.substring(0, maxlimit);
                        if (maxlimit === 3000)
                            alert('Escalation subject size is exceeding 3000 characters');
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
                        alert('Description size is exceeding ' + maxlimit + ' characters');
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
                    var userid = "";
                    if (flag === true) {
                        alert('There is a repetition in the selection');
                    } else {
                        for (i = 0; i < m1len; i++) {
                            if (m1.options[i].selected === true) {
                                userid += m1.options[i].value + ",";
                            }
                        }
                        userid = userid.substr(0, userid.length - 1);

                        for (i = 0; i < m1len; i++) {
                            if (m1.options[i].selected === true) {
                                m2len = m2.length;
                                m2.options[m2len] = new Option(m1.options[i].text, m1.options[i].value);
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

                    if (document.getElementById('heldOn').value === '') {
                        alert('Please pick a meeting date');
                        document.getElementById('heldOn').focus();
                        return false;
                    }
                    var teamFinal = document.getElementById("attendiesFinal");
                    var teamFinalOptions = teamFinal.options;
                    var teamFinalOLength = teamFinalOptions.length;
                    if (teamFinalOLength < 1) {
                        alert("Please select atleast one participant.");
                        return false;
                    }
                    for (var i = 0; i < teamFinalOLength; i++) {
                        teamFinalOptions[i].selected = true;
                    }
                    if (trim(CKEDITOR.instances.subject.getData()) === "")
                    {
                        alert("Please Enter the subject");
                        CKEDITOR.instances.subject.focus();
                        return false;
                    }
                    if (CKEDITOR.instances.subject.getData().length > 1000)
                    {
                        alert(" Subject exceeds 1000 character");
                        CKEDITOR.instances.subject.focus();
                        //        document.theForm.description.value == "";
                        return false;
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
                    theForm.action = 'meetingDetail.jsp?pid=' + x;
                    theForm.submit();
                }
            </script>
            </head>
            <body onload="updateComments();">
                <%@ include file="/header.jsp"%>
                <br/>
                <jsp:useBean id="twm" class="com.eminentlabs.meeting.MeetingController"></jsp:useBean>
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
                %>
                <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
                    <tr>  <td style="width:30%;text-align: left"> Schedule a Meeting for <%=twm.getPname()%></td>
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
                            <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=twm.getPid()%>"  title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                            <a href="<%=request.getContextPath()%>/MOM/meetingDetail.jsp?pid=<%=twm.getPid()%>" style="font-weight: bold;" title="Meeting Schedule">Meetings</a>&nbsp;&nbsp;&nbsp; 
                            <%if (project.contains("eTracker")) {%>
                            <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                            <%}%>
                        </td>
                    </tr>
                </table>

                <%if (twm.getMessage() != null) {%>
                <div style="text-align: center;color: #33CC33;font-weight: bold;"><%=twm.getMessage()%></div>
                <%}%>
                <form name="theForm" id="theForm" action="meetingDetail.jsp" method="post" onsubmit="return fun();">

                    <table style="background-color: #E8EEF7;">
                        <tr>
                            <td style="font-weight: bold;">Meeting On </td><td>:</td>
                            <td><input type="text" id="heldOn" name="heldOn" value="<%=twm.getHeldOn() == null ? "" : twm.getHeldOn()%>" maxlength="10" size="10"  readonly  /><a href="javascript:NewCal('heldOn','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a> </td>
                            <td style="font-weight: bold;">Meeting At </td><td>:</td>
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
                            <td style="font-weight: bold;">Participants </td><td>:</td>
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
                                    %>
                                    <option value="<%=val%>" <%if (twm.getStartTimeH().equalsIgnoreCase(val)) {%>selected<%}%>><%=val%></option>
                                    <%}%>
                                </select><select name="startM" id="startM" >
                                    <%for (int i = 0; i < 60; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                    %>
                                    <option value="<%=val%>" <%if (twm.getStartTimeM().equalsIgnoreCase(val)) {%>selected<%}%>><%=val%></option>
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
                                    <option value="<%=val%>" <%if (twm.getEndTimeH().equalsIgnoreCase(val)) {%>selected<%}%>><%=val%></option>
                                    <%}%>
                                </select><select name="endM" id="endM" >
                                    <%for (int i = 0; i < 60; i++) {
                                            String val = String.valueOf(i);
                                            if (i < 10) {
                                                val = "0" + val;
                                            }
                                    %>
                                    <option value="<%=val%>" <%if (twm.getEndTimeM().equalsIgnoreCase(val)) {%>selected<%}%>><%=val%></option>
                                    <%}%>
                                </select></td>
                        </tr>

                        <tr>
                            <td style="font-weight: bold;">Subject </td><td>:</td>
                            <td colspan="5" align="left"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                        rows="2" cols="28" name="subject" id="subject" maxlength="1000"
                                        onKeyDown="textCounter(document.theForm.subject, document.theForm.remLen1, 1000);"
                                        onKeyUp="textCounter(document.theForm.subject, document.theForm.remLen1, 1000);"><%=twm.getSubject() == null ? "" : twm.getSubject()%></textarea></font>
                            </td><td><input readonly type="text" name="remLen1"
                                            size="1" maxlength="4" value="1000"/>
                            </td>

                            <script type="text/javascript">
                                CKEDITOR.replace('subject', {height: 100});
                                var editor_data = CKEDITOR.instances.subject.getData();
                                CKEDITOR.instances["subject"].on("instanceReady", function ()
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
                                        var desc = CKEDITOR.instances.subject.getData();
                                        var leng = desc.length;
                                        editorTextCounter(leng, document.theForm.remLen1, 1000);

                                    }, 0);
                                }
                            </script>
                        </tr>
                        <%
                            SimpleDateFormat sdfdd = new SimpleDateFormat("dd-MM-yyyy");
                            Date today = new Date();
                            if (twm.getHeldOn() != null && today.compareTo(sdfdd.parse(twm.getHeldOn())) == 0) {
                        %>
                        <tr>
                            <td style="font-weight: bold;">Discussion </td><td>:</td>
                            <td colspan="5" align="left"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                        rows="2" cols="28" name="discussion" id="discussion" maxlength="4000"
                                        onKeyDown="textCounter(document.theForm.discussion, document.theForm.remLen1, 4000);"
                                        onKeyUp="textCounter(document.theForm.discussion, document.theForm.remLen1, 4000);"><%=twm.getSubject() == null ? "" : twm.getSubject()%></textarea></font>
                            </td><td><input readonly type="text" name="remLen2"
                                            size="1" maxlength="4" value="4000"/>
                            </td>

                            <script type="text/javascript">
                                CKEDITOR.replace('discussion', {height: 100});
                                var editor_data = CKEDITOR.instances.discussion.getData();
                                CKEDITOR.instances["discussion"].on("instanceReady", function ()
                                {

                                    //set keyup event
                                    this.document.on("keyup", updateDiscussion);
                                    //and paste event
                                    this.document.on("paste", updateDiscussion);

                                });
                                function updateDiscussion()
                                {
                                    CKEDITOR.tools.setTimeout(function ()
                                    {
                                        var desc = CKEDITOR.instances.discussion.getData();
                                        var leng = desc.length;
                                        editorTextCounter(leng, document.theForm.remLen2, 4000);

                                    }, 0);
                                }
                            </script>
                        </tr>
                        <%}%>


                        <tr style="text-align: center;">
                            <td colspan="4">
                                <%if (twm.getMeetingId() != 0) {%>
                                <input type="hidden" name="meetingId" value="<%=twm.getMeetingId()%>">
                                    <%}%>
                                    <input type="hidden" name="pid" value="<%=twm.getPid()%>"><input type="submit" name="submit" id="submit" value="Submit"></input><input type="reset" name="reset" id="reset" value="Reset"></input></td></tr>
                                        </table>
                                        </form>
                                        <br/>
                                        <%if (!twm.getApmMeetings().isEmpty()) {%>
                                        <div>The below list shows meetings of <%=twm.getPname()%><%=today%> <%=today.compareTo(sdfdd.parse(twm.getHeldOn()))%></div>
                                        <table style="width: 100%;">
                                            <tr style="height:21px;background-color: #C3D9FF;font-weight: bold;">
                                                <td>Held On</td>
                                                <td>Start Time</td>
                                                <td>End Time</td>
                                                <td>Held At</td>
                                                <td>Participants</td>

                                            </tr>
                                            <%int i = 0;
                                                String name = "";
                                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                                                HashMap<Integer, String> member = GetProjectMembers.showUsers();

                                                for (ApmMeetings momForClient : twm.getApmMeetings()) {
                                                    name = "";
                                                    for (ApmMeetingParticipants mca : momForClient.getApmMeetingParticipantsList()) {
                                                        name = name + member.get(mca.getParticipant()) + ",";
                                                    }
                                                    if (name.length() > 0) {
                                                        name = name.substring(0, name.length() - 1);
                                                    }

                                                    if ((i % 2) != 0) {%>
                                            <tr bgcolor="#E8EEF7" height="21">
                                                <%                     } else {%>
                                                <tr bgcolor="white" height="21">
                                                    <%                    }
                                                        i++;
                                                    %>
                                                    <td style="width: 9%;"><a href="meetingDetail.jsp?meetingId=<%=momForClient.getMeetingId()%>&pid=<%=twm.getPid()%>"><%=sdf.format(momForClient.getHeldOn())%></a></td>
                                                    <td style="width: 9%;" ><%=momForClient.getStartTime()%></td>
                                                    <td style="width: 9%;"><%=momForClient.getEndTime()%></td>
                                                    <td style="width: 9%;" id="<%=i%>tab" onmouseover="xstooltip_show('<%=i%>', '<%=i%>tab', 489, 49);" onmouseout="xstooltip_hide('<%=i%>');" >
                                                        <div class="issuetooltip" id="<%=i%>"><%= momForClient.getSubject()%></div><%=twm.getHeldAt().get(momForClient.getHeldAt())%></td>

                                                    <td title="<%=name%>">
                                                        <%if (name.length() > 100) {%>
                                                        <%=name.substring(0, 99)%>               
                                                        <%} else {%>
                                                        <%=name%>                    
                                                        <%}%>
                                                    </td>
                                                </tr>

                                                <%}%>
                                        </table>
                                        <%}%>
                                        </body>

                                        </html>
