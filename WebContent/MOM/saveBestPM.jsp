<%-- 
    Document   : saveBestPM
    Created on : Aug 8, 2014, 2:03:32 PM
    Author     : RN.Khans
--%>

<%@page import="com.eminentlabs.mom.PmPerformance"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.mom.PerformanceType"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminentlabs.mom.UsersPerformance"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ResourceBundle"%>

<%
    int branch=0;
    String startDate = request.getParameter("fromDate");
    String endDate = request.getParameter("toDate");
    String bestPidNPMid = request.getParameter("bestPM");
    String[] split = bestPidNPMid.split(",");
    String pid = split[0];    
    String pmid = split[1];
    Calendar c = new GregorianCalendar();
    Date date = c.getTime();
    
            String branchId = request.getParameter("branch");
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = (Integer) session.getAttribute("branch");
        }
        
    PmPerformance pp = new PmPerformance();
    
    pp.setStartdate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(startDate)));
    pp.setEnddate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(endDate)));
    pp.setPid(Integer.parseInt(pid));
    pp.setPmid(Integer.parseInt(pmid));
    pp.setCreatedon(date);
    pp.setBranchId(branch);
    MoMUtil.saveBestPM(pp);
%>

<jsp:forward page="projectWiseClosedReport.jsp">
    <jsp:param name="fromdate" value="<%=startDate%>"/>
    <jsp:param name="todate" value="<%=endDate%>"/>
</jsp:forward>