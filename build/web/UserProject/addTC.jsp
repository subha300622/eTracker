<%-- 
    Document   : addTC
    Created on : 6 Jul, 2010, 10:04:57 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.tqm.TqmUtil,java.util.ArrayList" %>

<%
    int userId      =   (Integer)session.getAttribute("uid");
    String tepId    =   request.getParameter("tepId");
    String ptc[]    =   request.getParameterValues("ptcid");
    String assi[]   =   request.getParameterValues("assignedto");
    String dueDate  =   request.getParameter("duedate");
    String pid  =   request.getParameter("pid");
     
    ArrayList<String> userlist=new ArrayList<String>();
    for(String s:assi){
            if(!s.equalsIgnoreCase("--Select One--")){
                userlist.add(s);
            }
        }
    
    TqmUtil.addTestPlanTestCase(Integer.parseInt(tepId), ptc,userId,userlist,dueDate);


%>
<jsp:forward page="listProjectTestPlan.jsp">
     <jsp:param name="pid" value="<%=pid%>"/>
</jsp:forward>