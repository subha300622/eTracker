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
    <%@ include file="/header.jsp"%>


<body>
      <br/>
    <jsp:useBean id="uic" class="com.eminent.issue.controller.UploadIssuesFromAdminController"></jsp:useBean>
<%
    uic.setAll(request, pageContext.getServletContext());
    int roleId = (Integer) session.getAttribute("Role");
    if (roleId == 1) {
%>
     <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4"
                                                          COLOR="#0000FF"><b>Upload Issues</b></font> <FONT SIZE="3"
                                                                           COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br>
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp" >WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp; 
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" style="cursor: pointer;font-weight: bold;">Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <br/>
    <br/>
    <%if (uic.getStatus() == null) {%>

    <%} else {%>
    <div class="success" style="color: #00f; text-align: center;"><%=uic.getStatus()%></div>
    <%}%>

    <br/>
    <form name="theForm" enctype="multipart/form-data" method="post" action="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" onsubmit="return validate()">
        <table width="70%" bgColor=#E8EEF7 border="0" align="center">
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

            <tr>
                <td>&nbsp;</td>
                <td><input type="submit" value="Submit" name="submit" id="submit"> </td>
            </tr>             

        </table>
    </form>
    <br/>
   
    <%
        
    } else {
    %>
    <BR>
    <table align="center">
        <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
    </table>
      <%
        
    } 
    %>
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
