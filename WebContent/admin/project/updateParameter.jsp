<%-- 
    Document   : manageServers
    Created on : 18 May, 2020, 12:59:40 PM
    Author     : vanithaalliraj
--%>


<%@page import="com.eminent.issue.IssueUtil"%>
<%@page import="com.eminent.server.ParameterStatus"%>
<%@page import="com.eminent.server.SapSystemType"%>
<%@page import="com.eminent.server.SapMonitoringParamaters"%>
<%@page import="com.eminent.server.ServerSystem"%>
<%@page import="com.eminent.server.SapServerType"%>
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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <style>
        th{
            font: bolder;
            color: black;
        }
    </style>
    <script>
        function callServer(theForm)
        {

            var x = document.getElementById("serverId").value;
            var pid = document.getElementById("pid").value;
            document.theForm.action = '/eTracker/admin/project/updateParameter.jsp?pid=' + pid + "&serverId=" + x;
            document.theForm.submit();
        }
        function call()
        {

            var pid = document.getElementById("pid").value;
            document.projectForm.action = '/eTracker/admin/project/updateParameter.jsp?pid=' + pid;
            document.projectForm.submit();
        }
    </script>


</head>
<%
    String pid = request.getParameter("pid");
    String companyCode = request.getParameter("companyCode");
    String team = (String) session.getAttribute("team");
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
    LinkedHashMap companyMap = ViewBPM.getCompany(Integer.parseInt(pid));
    LinkedHashMap company = GetProjectMembers.sortHashMapByKeys(companyMap, true);

    String cases[][] = TestCases.showTestCases(pid);
    int noOfTestcases = cases.length;

    String clientName = ViewBPM.getClientName(Integer.parseInt(pid));
%>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>

    <%@ include file="/header.jsp"%>

    <jsp:useBean id="sm" class="com.eminent.server.ServerMaintenace"></jsp:useBean>
    <%sm.updateParameterStatus(request);
        String no = sm.getMonitoringIssue(Integer.parseInt(pid), Integer.parseInt(companyCode));
        int count1 = IssueUtil.getAttachedFile(no);
    %>
    <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
        <tr>
            <td style="width:30%;text-align: left">Update Monitoring Parameters</td>
            <td><p  id="fileUpload" title="Upload Document" src="/eTracker/images/attachment.png" style="cursor: pointer;vertical-align: middle; " onclick="showFileAttach()">Upload File</p></td>
            <%if (count1 > 0) {%>
            <td style="text-align:center" id="filesIssue">
                <A onclick="viewFileAttachForIssue('<%=no%>');" href="#"
                   >ViewFiles(<%=count1%>)</A>
            </td>
            <%} else {%>
            <td id="filesIssue"> </td>
            <%}%>
        </tr>
    </table>

    <%
        if (!sm.getMatrixServers().isEmpty()) {
    %>
    <form name="theForm" >       
        <table width="100%" bgColor=#E8EEF7 border="0" style="text-align: " align="center">
            <tr>
                <td height="21" style="width: 15%;"><b>Server Type</b></td>
                <td><input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
                    <input type="hidden" name="companyCode" id="companyCode" value="<%=companyCode%>"/>
                    <select name="serverId" id="serverId" onchange="callServer(this);">
                        <option value="0">Select</option>
                        <%for (SapServerType ss : sm.getAllServers()) {
                                if (sm.getMatrixServers().contains(ss.getSId())) {
                        %>
                        <option value="<%=ss.getSId()%>" <%if (ss.getSId() == sm.getServerId()) {%>selected<%}%>><%=ss.getServerName()%></option>
                        <%}
                            }%>
                    </select>
                </td>

            </tr>
        </table>
    </form>

    <%if (sm.getMessge() != null) {%>
    <div class="error2" style="text-align: center; font: bold;color:<%if (sm.getMessge().contains("success")) {%>green<%}%>">
        <%=sm.getMessge()%>
    </div>
    <%}%>

    <%if (!sm.getSapMonitoringParamaterses().isEmpty()) {%>
    <form name="monitorForm" method="post" onSubmit='return submit(this);' action="<%=request.getContextPath()%>/admin/project/updateParameter.jsp">   
        <table width="100%" bgColor=#E8EEF7 border="1"  align="center">
            <tr>
                <th style="width:60%">Parameter</th><input type="hidden" name="pid" id="pid" value="<%=pid%>"/><input type="hidden" name="companyCode" id="companyCode" value="<%=companyCode%>"/>
            <input type="hidden" name="serverId" id="serverId" value="<%=sm.getServerId()%>"/>
            <%for (Integer systemId : sm.getMap().keySet()) {
                    for (SapSystemType ss : sm.getAllSystems()) {
                        if (systemId == ss.getSId()) {
            %>
            <th><%=ss.getSName()%></th>
                <%}
                        }
                    }%>
            </tr>


            <%int a = 0, b = 0;
                String color = "#E8EEF7", radioApp = "";
                for (SapMonitoringParamaters smp : sm.getSapMonitoringParamaterses()) {
                    if (sm.getCheckedParameters().contains(smp.getParameterId())) {
                        if (a % 2 == 0) {
                            color = "white";
                        } else {
                            color = "#E8EEF7";
                        }
            %>
            <tr style="background-color: <%=color%>"> 
                <td><%=smp.getParameterName()%></td>
                <%for (Integer systemId : sm.getMap().keySet()) {
                        for (ParameterStatus ss : sm.getMap().get(systemId)) {
                            if (smp.getParameterId() == ss.getParameterId()) {
                                radioApp = "";
                %>
                <td style="width:20%">
                    <input type="hidden" name="matrixParamId" value="<%=ss.getMatrixParamId()%>" />
                    <input type="hidden" name="stat" value="<%=ss.getMatrixParamId()%>" />
                    <%if (smp.getParameterType().equalsIgnoreCase("radio")) {%>
                    <%if (!smp.getParameterValues().endsWith(",NA")) {
                            radioApp = smp.getParameterValues() + ",NA";
                        } else {
                            radioApp = smp.getParameterValues();
                        }
                        for (String val : radioApp.split(",")) {%>
                    <input type="radio" required="true" name="<%=ss.getMatrixParamId()%>val" value="<%=val%>" <%if (val.equalsIgnoreCase(ss.getParamStatus())) {%> checked="true" <%}%>/><%=val.trim()%><%}%>
                    <%} else if (smp.getParameterType().equalsIgnoreCase("checkbox")) {%>
                    <%for (String val : smp.getParameterValues().split(",")) {%>
                    <input type="hidden" value="<%=ss.getParamStatus()%>"/>
                    <input type="checkbox" name="<%=ss.getMatrixParamId()%>val" value="<%=val%>"
                           <%if (ss.getParamStatus() != null) {
                                   for (String checked : ss.getParamStatus().split(",")) {
                                       if (checked.equalsIgnoreCase(val)) {%> checked="true"
                           <%}
                                   }
                               }%>/><%=val.trim()%><%}%>
                    <%} else {%>
                    <textarea required="true" name="<%=ss.getMatrixParamId()%>val" ><%=ss.getParamStatus() == null ? "" : ss.getParamStatus()%></textarea>
                    <%}%>
                </td>
                <%}
                        }
                    }%>
            </tr>
            <%a++;
                    }
                }%>
        </table>        
        <table width="100%" bgColor=#E8EEF7 border="0" align="center">
            <tr><td colspan="3" style="text-align: center;">
                    <input type="submit" value="Submit" name="submit" id="submit"> 
                </td>
            </tr>
        </table>
    </form>
    <div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Attached Files</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div id="IssuePopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

            </div>
        </div>
    </div>
    <div id="MDApopup" class="popup" style="height: 200px;">
        <form id="file-mod-form" name="file-mod-form" enctype="multipart/form-data"  method="POST" action="<%=request.getContextPath()%>/fileAttachIssueIE.jsp" onsubmit="return validate(this);">
            <h3 class="popupHeadinga">Upload document for <%=no%></h3>
            <div style="color:red;display: none;" id="mdaterrormsg"></div>
            <div style="margin-bottom: 10px;">
                <table >
                    <tr >
                        <td><label style="margin-left: 0px;">Choose File(s) to upload</label></td>
                        <td >
                            <label for="pswd"><input type="file" id="file-mod-select" name="photos[]" multiple/></label> 
                        </td>
                    </tr>
                    <tr style="height:40px;">
                        <td>
                            <%

                                String requestURL = request.getServletPath() + "?" + request.getQueryString();
                            %>
                            <input type="hidden" name="issueId" id='issueId' value="<%=no%>"/>
                            <input type="hidden" name="url" id='url' value="<%=requestURL%>"/>
                            <input type="submit" id="upload" value="Upload" />
                            <input type="button" id="mod-upload-button" value="Upload Document" onclick="javascript:createFileAttach();"/>
                            <input type="button" id="mod-upload-cancel"value="Cancel" onclick="javascript:closeFileAttach();"/>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                    </tr>
                </table>
            </div>
            <div id="msgForIE">
                <p style="color: red;">This page will refresh after uploading file.So Please type the comments or changes after uploading.For better performance use other browsers.. </p>
            </div>
        </form>
    </div>
    <%} else {
        if (sm.getServerId() > 0) {%>
    <table align="center">
        <tr align="center" ><td><font color="red">Parameter is not maintained. Please maintain it.</font></td></tr>
    </table>
    <%}
        }%>
    <%} else {%>
    <table align="center">
        <tr align="center" ><td><font color="red">Server type with system matrix is maintained for this project. Please contact Admin(Tamilvelan)</font></td></tr>
    </table>
    <%}%>
</body>
<script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>

<script>



                                $(".Ajax-loder").hide();
                                function submit() {
                                    $(".Ajax-loder").show();
                                    disableSubmit();
                                }
                                $(document).ready(function() {
                                    $(".Ajax-loder").hide();
                                    var message = $('#message').val();

                                    var ua = window.navigator.userAgent;

                                    var msie = ua.indexOf('MSIE ');
                                    var trident = ua.indexOf('Trident/');
                                    var edge = ua.indexOf('Edge/');

                                    if (msie > 0 || trident > 0 || edge > 0) {
                                        $('#mod-upload-button').hide();
                                        if (message === null || message === 'null') {

                                        } else {
                                            alert(message);
                                        }
                                    } else {
                                        $('#upload').hide();
                                        $('#msgForIE').hide();
                                    }
                                });

                                function validate() {
                                    if (document.getElementById("file-mod-select").value == '') {
                                        document.getElementById('mdaterrormsg').style.display = 'block';
                                        document.getElementById('mdaterrormsg').innerHTML = "Please select the file";
                                        return false;
                                    } else {
                                        var count = 1, abort = true;
                                        var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                        var ua = window.navigator.userAgent;
                                        var msie = ua.indexOf('MSIE ');
                                        var trident = ua.indexOf('Trident/');
                                        var edge = ua.indexOf('Edge/');
                                        if (msie > 0 || trident > 0 || edge > 0) {
                                            var fileName = document.getElementById('file-mod-select').value;
                                            var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                            for (var i = 0; i <= allowed_extensions.length; i++)
                                            {
                                                if (allowed_extensions[i] == file_extension)
                                                {
                                                    count = 0;
                                                }
                                            }
                                            if (count == 0) {
                                                $('#progressbar').fadeIn('slow');
                                                document.getElementById('upload').value = "Processing";
                                                document.getElementById('upload').disabled = true;
                                                document.getElementById('mod-upload-cancel').value = "Processing";
                                                document.getElementById('mod-upload-cancel').disabled = true;
                                            } else {
                                                return false;
                                            }
                                        }

                                    }
                                }
                                $('#file-mod-select').bind('change', function() {
                                    $('#progressbar').fadeIn('slow');
                                    var fileModSelect = document.getElementById('file-mod-select');
                                    document.getElementById('mdaterrormsg').innerHTML = "";
                                    var files = fileModSelect.files;
                                    var count = 1, abort = true;
                                    var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                    var ua = window.navigator.userAgent;
                                    var msie = ua.indexOf('MSIE ');
                                    var trident = ua.indexOf('Trident/');
                                    var edge = ua.indexOf('Edge/');
                                    if (msie > 0 || trident > 0 || edge > 0) {
                                        var fileName = document.getElementById('file-mod-select').value;
                                        var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                        for (var i = 0; i <= allowed_extensions.length; i++)
                                        {
                                            if (allowed_extensions[i] == file_extension)
                                            {
                                                count = 0;
                                            }
                                        }
                                    } else {
                                        for (var i = 0; i < files.length && abort; i++)
                                        {
                                            var fileName = files[i].name;
                                            var file_extension = fileName.split('.').pop().toLowerCase();
                                            for (var j = 0; j < allowed_extensions.length; j++)
                                            {
                                                if (allowed_extensions[j] == file_extension)
                                                {
                                                    abort = true
                                                    count = 0;
                                                    break;
                                                } else {
                                                    count = 1;
                                                    abort = false;
                                                }
                                            }
                                        }

                                    }
                                    if (count == 0) {
                                    } else {
                                        document.getElementById('file-mod-select').value = '';
                                        document.getElementById('mdaterrormsg').style.display = 'block';
                                        document.getElementById('mdaterrormsg').innerHTML = "You must upload a file with one of the following extensions: " + allowed_extensions.join(', ') + ".'";
                                    }
                                    $('#progressbar').fadeOut('slow');
                                });
</script>
</html>
