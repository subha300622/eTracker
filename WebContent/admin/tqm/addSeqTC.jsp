<%-- 
    Document   : addSeqTEP
    Created on : 18 Aug, 2010, 11:17:19 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.tqm.TqmUtil,java.util.ArrayList" %>

<%
    int userId      =   (Integer)session.getAttribute("uid");
    String tepId    =   request.getParameter("tepId");
    String ptc[]    =   request.getParameterValues("ptcid");
    String assi[]   =   request.getParameterValues("assignedto");
    String dueDate  =   request.getParameter("duedate");

    ArrayList<String> userlist=new ArrayList<String>();
    for(String s:assi){
            if(!s.equalsIgnoreCase("--Select One--")){
                userlist.add(s);
            }
        }

 //   TqmUtil.addExecutionTestCase(Integer.parseInt(tepId), ptc,userId,userlist,dueDate);


%>
<jsp:forward page="listExecutionPlan.jsp"></jsp:forward>
