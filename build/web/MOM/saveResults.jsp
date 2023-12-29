<%-- 
    Document   : saveResults
    Created on : Jan 24, 2014, 4:00:10 PM
    Author     : E0288
--%>

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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
    <%mmc.setSendMomAll(request);%>
<%int branch=0;
        List<Integer> modList = new ArrayList(mmc.getTotalUsers());
        String startDate=request.getParameter("fromDate");
        String endDate=request.getParameter("toDate");
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();  String branchId = request.getParameter("branch");
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = (Integer) session.getAttribute("branch");
        }
        
        
        Map<String,List<Integer>> teamWise=GetProjectMembers.getEminentUsersByTeam(branch);
        String typeparamgen="teamName";
        String team=request.getParameter(typeparamgen);
        List<Integer> users=new ArrayList<Integer>();
        if(team!=null){
        if(teamWise.containsKey(team)){
            users=(List<Integer>)teamWise.get(team);
        }
        }
        UsersPerformance usersPerformance=new UsersPerformance();
        
        for(Integer userid :modList){
            String totalIssues=null;
        String paramgen="issueid"+userid;
        String tasks[]=request.getParameterValues(paramgen);
        
            if(tasks!=null){
                for(int i=0;i<tasks.length;i++){
                    if(totalIssues!=null){
                    totalIssues=totalIssues+tasks[i]+",";
                    }else{
                        totalIssues=tasks[i]+",";
                    }
                }
                if(totalIssues!=null){
                   if(totalIssues.length()>11){
                        totalIssues=totalIssues.substring(0,totalIssues.length()-1);
                   }
                }
                    
            }
                    usersPerformance.setStartDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(startDate)));
                    usersPerformance.setEndDate(java.sql.Date.valueOf(com.pack.ChangeFormat.getDateFormat(endDate)));
                    usersPerformance.setTasks(totalIssues);
                    usersPerformance.setBranchId(branch);
                    usersPerformance.setUserId(userid);
                    if(totalIssues==null){
                        totalIssues="";
                    }
                    if(users.contains(userid)){
                        usersPerformance.setPerformanceType(PerformanceType.WINNER.getStatusCode());
                    }else if(totalIssues.length()>11){
                        usersPerformance.setPerformanceType(PerformanceType.COMPETITOR.getStatusCode());
                    }
                    else{
                        usersPerformance.setPerformanceType(PerformanceType.NOPARTICIPATION.getStatusCode());
                    }
                    usersPerformance.setEvaluationDate(date);
                    usersPerformance.setCreatedOn(date);
                    Collection set=teamWise.keySet();
                    Iterator ite = set.iterator();
        
                    while(ite.hasNext()){
                        String key=(String)ite.next();
                        List<Integer> teamusers=(List<Integer>)teamWise.get(key);
                        if(teamusers.contains(userid)){
                            usersPerformance.setTeam(key);
                        }
                    }
                    MoMUtil.createUsersPerformance(usersPerformance);
        }

%>
<jsp:forward page="weekPerformers.jsp">
    <jsp:param name="fromdate" value="<%=startDate%>"/>
    <jsp:param name="todate" value="<%=endDate%>"/>
    <jsp:param name="branch" value="<%=branch%>"/>
</jsp:forward>
