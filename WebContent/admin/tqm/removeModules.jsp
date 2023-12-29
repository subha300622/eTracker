<%-- 
    Document   : removeModules
    Created on : 12 Aug, 2010, 10:53:35 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.tqm.TestCasePlan" %>
<%
                String modules[]  =   request.getParameterValues("name");
                String planId     =   request.getParameter("planid");
                int noOfRows      =   TestCasePlan.removeModule(modules, planId);

%>