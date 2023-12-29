<%-- 
    Document   : planedIssuesExcel
    Created on : 12 Aug, 2015, 1:35:12 PM
    Author     : Tamilvelan
--%>
<%@ page language="java"
         contentType="application/vnd.ms-excel;"
         pageEncoding="UTF-8"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="org.apache.log4j.Logger"%>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=\"plannedIssueReport.xls\""); 

    Logger logger = Logger.getLogger("plannedIssuesReport");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>

    <body>
        <br/>
        <jsp:useBean id="pir" class="com.eminent.issue.formbean.PlannedIssueReport"></jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 

        <%
        int wrmSize = mas.wrmIssues().size();
        pir.planIssueReport(request);%>



        <%int assignedto = (Integer) session.getAttribute("userid_curr");%>
    
        <br/>

<table width="100%" height="23">
                <TR bgcolor="#C3D9FF">
                    <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                    <TD width="11%"><font><b>Issue No</b></font></TD>
                    <TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
                    <TD width="12%"><font><b>Project</b></font></TD>
                    <TD width="7%"><font><b>Module</b></font></TD>
                    <TD width="29%"><font><b>Subject</b></font></TD>
                    <TD width="9%"><font><b>Status</b></font></TD>
                    <TD width="9%"><font><b>Due Date</b></font></TD>
                    <TD width="10%"><font><b>AssignedTo</b></font></TD>
                    <TD width="7%"><font><b>Refer</b></font></TD>
                    <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

                </TR>
</table>
        <%
            boolean flag = true;
            for (String project : pir.getProjectsList()) {
                int i = 0;
                for (IssueFormBean isfb : pir.getIssuesList()) {
                    if (isfb.getpName().equals(project)) {
                        if (pir.getPlannedIssuesList().contains(isfb.getIssueId()) && pir.getMomplannedIssuesList().contains(isfb.getIssueId())) {
                            if (i == 0) {
                                if (flag == true) {
        %>

      
            <%flag = false;
                }%>

            <table width="100%" height="23">
               
                <% }
                    if ((i % 2) != 0) {
                %>
                <tr bgcolor="#E8EEF7" height="21">
                    <%} else {%>
                <tr bgcolor="white" height="21">
                    <%                    }
                        i++;%>

                    <td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                    <td width="11%" title="<%=isfb.getType()%>"><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a></td>
                    <td width="3%"><%=isfb.getPriority()%></td>
                    <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                    <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                    <td width="29%"  ><%=isfb.getSubject()%></td>
                    <td onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;" width="9%" ><%=isfb.getStatus()%></td>
                    <td width="9%" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                    <td width="10%" title="Created By <%=isfb.getCreatedBy()%>"><%=isfb.getAssignto()%></td>
                    <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                    <td width="7%"><%=isfb.getRefer()%></td>
                    <%} else {%>
                    <td width="7%"><a href="<%=request.getContextPath()%>/issueUpdateFile.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getRefer()%></a></td>
                        <%}%>
                    <td width="5%" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>

                <%}
                        }
                    }%></table><%
                        int j = 0;
                        for (IssueFormBean isfb : pir.getIssuesList()) {
                            if (isfb.getpName().equals(project)) {
                                if (!pir.getPlannedIssuesList().contains(isfb.getIssueId()) && pir.getMomplannedIssuesList().contains(isfb.getIssueId())) {
                                    if (j == 0) {
                                        if (flag == true) {%>

          
                <%flag = false;
                    }%>

                <table width="100%" height="23">
                    
                    <% }
                        if ((j % 2) != 0) {
                    %>
                    <tr bgcolor="#E8EEF7" height="21">
                        <%} else {%>
                    <tr bgcolor="white" height="21">
                        <%                    }
                            j++;
                        %><td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                        <td width="11%" title="<%=isfb.getType()%>"><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a></td>
                        <td width="3%"><%=isfb.getPriority()%></td>
                        <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td width="29%" ><%=isfb.getSubject()%></td>
                        <td width="9%" onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
                        <td width="9%" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td width="10%" title="Created By <%=isfb.getCreatedBy()%>"><%=isfb.getAssignto()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td width="7%"><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td width="7%"><a href="<%=request.getContextPath()%>/issueUpdateFile.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td width="5%" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>
                        <%
                                    }
                                }
                            }%></table></div>
                    <%flag = true;
                        }%>
        </table>
        <%
            if (pir.getProjectsList().isEmpty()) {%>
        <div style="text-align: left;"> Neither PM planned nor MOM planned issues  for <%=pir.getPlannedDate()%> </div>
        <%}
        %>
</body>

</html>
