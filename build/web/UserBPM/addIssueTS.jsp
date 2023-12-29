<%-- 
    Document   : addIssueTS
    Created on : 2 Mar, 2015, 2:47:56 PM
    Author     : Muthu
--%>
<%@page import="java.util.Date"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.eminentlabs.dao.DAOFactory"%>
<%@page import="com.eminent.issue.ApmIssueTeststepId"%>
<%
    String pid = request.getParameter("pid");
    String tsid = request.getParameter("tsid");
    String issues = request.getParameter("issues");
    int createdby = (Integer) session.getAttribute("userid_curr");

    StringTokenizer st = new StringTokenizer(issues, ",");
    while (st.hasMoreTokens()) {
        String issue = st.nextToken();
        ApmIssueTeststepId aiti = new ApmIssueTeststepId();
        aiti.setPid(Integer.parseInt(pid));
        aiti.setTeststepId(Integer.parseInt(tsid));
        aiti.setIssueId(issue);
        aiti.setCreatedon(new Date());
        aiti.setCreatedby(createdby);
        DAOFactory.addTESTSTEPID(aiti);
    }


%>