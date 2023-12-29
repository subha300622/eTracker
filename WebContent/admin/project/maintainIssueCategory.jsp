<%-- 
    Document   : maintainIssueCategory
    Created on : 24 Dec, 2021, 3:40:46 PM
    Author     : Eminent
--%>

<%@page import="com.eminent.issue.IssueCategory"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=120720161653" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js?c=0"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/css/displayColumns.css?test=280620161553" type="text/css" rel="STYLESHEET">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/dragtable.css" />

    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.dragtable.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.chili-2.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    </head>
    <body class="home-bg">
<!--        <div class="Ajax-loder">

            <div class="bg"></div>

            <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
                 alt="loading...." /></div>-->

        <%@ include file="/header.jsp"%>

        <jsp:useBean id="icc" class="com.eminent.issue.controller.IssueCategoryController"></jsp:useBean>
        <%
            HashMap<String, String> projects = GetProjectManager.getProjects();
            icc.setAll(request);
        %>


        <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
            <tr>
                <td style="width:30%;text-align: left">Maintain Issue Category</td>

            </tr>
        </table>
        <table width="100%" >
            <tr> <td>
                    <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/viewWRM.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>
                    <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                    <a href="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp" style="cursor: pointer;font: bold">Issue Category</a>

                </td>
            </tr>
        </table>
		<br/>
<center>
        <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp" >
            <table style="background-color: #E8EEF7;">

                <tr>
                    <td><b>Project</b></td><td> 
                        <select id="project" name="project" required="true">   
						<option value="">Select</option>
                            <% for (Map.Entry<String, String> entry : projects.entrySet()) {%>
                            <option value="<%=entry.getKey()%>" <% if (icc.getIssueCategory() != null && entry.getKey().equalsIgnoreCase(String.valueOf(icc.getIssueCategory().getPid()))) { %>selected  <% }%>><%=entry.getValue()%></option>
                            <% }%>
                        </select>

                    </td>               
                    <td><b>Category Name</b></td><td><input type="text" name="category" id="category" maxlength="50" required="true" value="<%=icc.getIssueCategory() == null ? "" : icc.getIssueCategory().getCategoryName()%>"></td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4" align="center"><input type="submit" name="Submit" id="submit" value="Submit">
                        <input type="Reset" name="Reset" id="reset" value="Reset">
                    </td>
                </tr>
            </table>
        </form>


        <%if (!icc.getIssueCategorys().isEmpty()) {%>
		<br/>
		<br/>
        
            <table class="userTable" border="0" >
               <thead>
				<tr>
                    <th >Project Name</th>
                    <th >Category Name</th>
                </tr>
				</thead>
				<tbody>
                <%int k=0;
		for (IssueCategory ic : icc.getIssueCategorys()) {    k++; if ((k % 2) == 0) {

                                    %>
                                    <tr class="zebraline" height="23">
                                        <%                } else {
                                        %>

                                    <tr class="zebralinealter" height="23">
                                        <%                    }
                                        %>
                    <td><%=projects.get(String.valueOf(ic.getPid()))%></td>
                    <td><a href="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp?categoryId=<%=ic.getId()%>"><%=ic.getCategoryName()%></a></td>
                </tr>
                <%}%>
				</tbody>
            </table>
      
        <%}%>
		</center>
    </div>
</div>
</div>

</body>
<script src="<%=request.getContextPath()%>/js/jquery-1.10.2.js"></script> 
<script src="<%=request.getContextPath()%>/js/jquery.multiple.select.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery-ui.css?test=2" />
<script>
    $('#type').multipleSelect({
        filter: true,
        maxHeight: 150,
        width: 250

    }
    );
	 $(document).ready(function()
        {
	 $(".userTable").tablesorter({
                widgets: ['zebra'],
                widgetOptions: {
                    zebra: ["zebraline", "zebralinealter"]
                },
                // change the multi sort key from the default shift to alt button 
                sortMultiSortKey: 'altKey',
                headers: {
                   
                }
            });
			 });
    $(function () {
//Created By: Brij Mohan
//Website: https://techbrij.com
        function groupTable($rows, startIndex, total) {
            if (total === 0) {
                return;
            }
            var i, currentIndex = startIndex, count = 1, lst = [];
            var tds = $rows.find('td:eq(' + currentIndex + ')');
            var ctrl = $(tds[0]);
            lst.push($rows[0]);
            for (i = 1; i <= tds.length; i++) {
                if (ctrl.text() == $(tds[i]).text()) {
                    count++;
                    $(tds[i]).addClass('deleted');
                    lst.push($rows[i]);
                } else {
                    if (count > 1) {
                        ctrl.attr('rowspan', count);
                        groupTable($(lst), startIndex + 1, total - 1)
                    }
                    count = 1;
                    lst = [];
                    ctrl = $(tds[i]);
                    lst.push($rows[i]);
                }
            }
        }
        groupTable($('.userTable tr:has(td)'), 0, 1);
        $('.userTable .deleted').remove();
    });
</script>
</html>