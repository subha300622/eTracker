<%-- 
    Document   : newjsp
    Created on : 30 Jul, 2015, 5:32:33 PM
    Author     : EMINENT
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%List<IssueSearchFormBean> refIssues = new ArrayList<IssueSearchFormBean>();
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    String issueId = request.getParameter("issueId");
    String subject = request.getParameter("sub");
    if (url.equals("eminentlabs.net")) {
        refIssues = IssueDetails.eTrackerIssueSearch(subject, issueId);
    }
long startTime = System.currentTimeMillis(); //fetch starting time
while(false||(System.currentTimeMillis()-startTime)<1000)
{
    // do something
}
%>
<div >
    <%if (refIssues.isEmpty()) {%>
    <span style="text-align: center;">No Reference issues</span>
    <%} else {%>

    <table style="width: 100%;border-top: 2px solid #CCC;">

        <%int k = 0;
            for (IssueSearchFormBean isfb : refIssues) {
                if (k % 2 == 0) {%>
        <tr style="height: 21px;"> 
            <%} else {%>
        <tr style="background-color: #E8EEF7;height: 21px;">
            <%}
                        k++;%>


            <td style="width: 20%;"><a target="_blank" href='<%=request.getContextPath()%>/issueForEveryOne.jsp?issueid=<%=isfb.getIssueId()%>'><%=isfb.getIssueId()%></a></td>
            <td><%=isfb.getSubject()%></td>
        </tr>
        <%}%>
    </table>


    <%}%>
</div>

