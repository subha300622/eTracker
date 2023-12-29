<%-- 
    Document   : planedIssuesExcel
    Created on : 12 Aug, 2015, 1:35:12 PM
    Author     : Tamilvelan
--%>
<%@page import="java.util.Map"%>
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

        <%        
            pir.userplanIssueReport(request);
          %>

        <br/>
        <%String name = "User_wise_planned_";
            name = name + pir.getPlannedDate();
            name = name + ".xls";
            response.setHeader("Content-Disposition", "attachment; filename=" + name + "");

        %>

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
                <TD width="10%"><font><b>Planned To</b></font></TD>
                <TD width="7%"><font><b>Refer</b></font></TD>
                <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

            </TR>
        </table>
        <%         int i = 0;
            for (Map.Entry<Integer, String> user : pir.getUsersList().entrySet()) {
                  if (pir.getUserwise().containsKey(user.getKey())) {
                for (IssueFormBean isfb : pir.getUserwise().get(user.getKey())) {
        %>
        <table width="100%" height="23">
            <%
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
                <td width="7%"><%=isfb.getRefer()%></td>
                    <%}%>
                <td width="5%" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>

            <%}
                    }
                }%></table>


    </body>

</html>
