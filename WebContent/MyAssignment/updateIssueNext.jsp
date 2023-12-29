<%-- 
    Document   : updateIssueNext
    Created on : 15 Apr, 2015, 5:22:15 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.issue.formbean.UserPlannedIssues"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" ></jsp:useBean>

    <table><tbody class='addCont'>
        <%mas.setAll(request);%>
        <%int i = 1;
            for (IssueFormBean isfb : mas.getIssuesList()) {
                if ((i % 2) != 0) {
        %>
        <tr class="zebralinealter" height="21">
            <%} else {%>
        <tr class="zebraline" height="21">
            <%}
                i++;%>
                
            <td  bgcolor="<%=isfb.getSeverity()%>">   <%for (UserPlannedIssues u : mas.getPlannedIssuesList()) {
                                        if (u.getIssueno().equals(isfb.getIssueId())) {
                    %><%=u.getSino()%> <%}
                    }%></td>
            <td  title="<%=isfb.getType()%>"><a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=<%=isfb.getIssueId()%>">

                    <%=isfb.getIssueId()%></a>
                
                
                    <%for (UserPlannedIssues u : mas.getPlannedIssuesList()) {
                                        if (u.getIssueno().equals(isfb.getIssueId())) {
                    %>
                <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                <%}
                    }%>
					
					  <%--   <%if (mas.wrmIssues().contains(isfb.getIssueId())) {
                %>
                <img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                <%
                    }%>
                 <%if (!mas.getWrmTouchedIssues().contains(isfb.getIssueId())) {%>
                <img src="<%=request.getContextPath()%>/images/Bomb.png"  title="WRM Untouched"  style="cursor: pointer;vertical-align: middle;"/>
                <% 
                    }
                %>--%>
				</td>
            <td ><%=isfb.getPriority()%></td>
            <td  title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
            <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
            <td  id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
            <td  onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
            <td  title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
            <td title="Assignedby <%=isfb.getLastAssigneeName()%> at <%=isfb.getLastModifiedOn()%>"><%=isfb.getCreatedBy()%></td>
            <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
            <td ><%=isfb.getRefer()%></td>
            <%} else {%>
            <td ><a    onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                <%}%>
            <td title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>

        <%
            }%></tbody></table><%if (mas.getIssuesList().size() >= 15) {%>
<div class='otherclass'><div class="next jscroll-next-parent"><a class="jscroll-next" href="<%=request.getContextPath()%>/MyAssignment/updateIssueNext.jsp?userId=<%=mas.getUserId()%>&pageNumber=<%=mas.getPageNo() + 1%>">next</a></div></div>

<%}%>

<div class='scriptremoval'>
    <SCRIPT type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>

    <script type="text/javascript">
                $(document).ready(function() {
                    $('#searchTable tbody').append($(".addCont").html());
                    $('.jscroll-added').insertAfter($(".otherclass").html());
                    $('.jscroll-added').remove();

                });
                $.tablesorter.addParser({
                    id: "ddMMMyy",
                    is: function(s) {
                        return false;
                    },
                    format: function(s, table) {
                        var from = s.split("-");
                        var year = "20" + from[2];
                        var mon = from[1];
                        var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                        return new Date(year, month, from[0]).getTime() || '';
                    },
                    type: "numeric"
                });
                $(document).ready(function() {
                    $("#searchTable").tablesorter({
                        widgets: ['zebra'],
                        widgetZebra: {css: ['zebraline', 'zebralinealter']},
                        // change the multi sort key from the default shift to alt button 
                        sortMultiSortKey: 'altKey',
                        headers: {
                            7: {// <-- replace 6 with the zero-based index of your column
                                sorter: 'ddMMMyy'
                            }
                        }
                    });
                });
        <%if (mas.getPageNo() % 2 > 0) {%>
                $.tablesorter.addParser({
                    id: "ddMMMyy",
                    is: function(s) {
                        return false;
                    },
                    format: function(s, table) {
                        var from = s.split("-");
                        var year = "20" + from[2];
                        var mon = from[1];
                        var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                        return new Date(year, month, from[0]).getTime() || '';
                    },
                    type: "numeric"
                });
                $(document).ready(function() {
                    $("#searchTable").tablesorter({
                        widgets: ['zebra'],
                        widgetZebra: {css: ['zebraline', 'zebralinealter']},
                        // change the multi sort key from the default shift to alt button 
                        sortMultiSortKey: 'altKey',
                        headers: {
                            7: {// <-- replace 6 with the zero-based index of your column
                                sorter: 'ddMMMyy'
                            }
                        }
                    });
                });
        <%}%>
    </script>
</div>