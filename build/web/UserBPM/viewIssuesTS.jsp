<%-- 
    Document   : viewIssuesTS
    Created on : 2 Mar, 2015, 11:30:00 AM
    Author     : Muthu
--%>

<%@page import="com.eminentlabs.userBPM.ViewBPM"%>
<%@page import="com.eminent.issue.Issue"%>
<%@page import="java.util.List"%>
<%
    int assignedto = (Integer) session.getAttribute("userid_curr");

    String pid = request.getParameter("pid");
    String tsId = request.getParameter("tsId");
    int i = 0;
    String issuesList = "<input type='hidden' name='tsId' id='issueTsID' value='" + tsId + "'><table cellpadding='0' cellspacing='0' border='1'>", color = "white", ratingColor = "white";
    List<Issue> issueList = ViewBPM.getIssuesTS(pid);

    for (Issue issue : issueList) {
        if ((i % 2) != 0) {
            color = "#E8EEF7";
        } else {
            color = "white";
        }

        if (issue.getIssuestatus().equalsIgnoreCase("Closed")) {
            if (issue.getRating().equalsIgnoreCase("Excellent")) {
                ratingColor = "#336600";
            } else if (issue.getRating().equalsIgnoreCase("Good")) {
                ratingColor = "#33CC66";
            } else if (issue.getRating().equalsIgnoreCase("Average")) {
                ratingColor = "#CC9900";
            } else if (issue.getRating().equalsIgnoreCase("Need Improvement")) {
                ratingColor = "#CC0000";
            } else {
                ratingColor = "white";
            }
        }else{
             ratingColor = "white";
        }
        issuesList = issuesList + "<tr style='background-color:" + color + ";'><td style='width:1%;'><input type='checkbox' value='" + issue.getIssueid() + "' name='issues'></td><td ><a style='background-color:" + ratingColor + ";' target='_blank' href='/eTracker/viewIssueDetails.jsp?issueid=" + issue.getIssueid() + "'>" + issue.getIssueid() + "</a> </td><td>" + issue.getSubject() + "</td></tr>";
        i++;
    }
    issuesList = issuesList + "</table>";
    out.print(issuesList);
%>