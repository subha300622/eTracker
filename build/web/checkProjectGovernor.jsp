<%-- 
    Document   : checkProjectGovernor
    Created on : 1 Oct, 2015, 10:20:54 AM
    Author     : EMINENT
--%>

<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
            String message = "";
            String project = request.getParameter("pid");
            String user = request.getParameter("userId");
            long pid = MoMUtil.parseLong(project, 0l);
            int userId = MoMUtil.parseInteger(user, 0);
            if (pid > 0l && userId > 0) {
                HashMap<Integer, String> members = GetProjectMembers.getProjectManagers(project);
                boolean flag=GetProjectMembers.checkIssueAssigned(userId,pid);
                if (members.containsKey(userId)) {
                    message = "You cannot remove this user as he involved as project governor.";
                }else if(flag==true){
                    message = "You cannot remove any one of the issue is assigned to him.";
                }
            }
            out.print(message);
        %>
    
