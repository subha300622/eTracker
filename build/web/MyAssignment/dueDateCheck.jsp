<%-- 
    Document   : dueDateCheck
    Created on : Nov 7, 2008, 6:30:48 PM
    Author     : Balaguru Ramasamy
--%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.ProjectFinder"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                String dueDate        = request.getParameter("dueDate");
                String project        = (String)session.getAttribute("projectName");
                String version        = (String)session.getAttribute("versionValue");
                
                String flag            = ProjectFinder.isDuedateCorrect(dueDate, project, version);                
               
                String total = ","+flag+",";
                total = total.trim();
                al.add(total);
                String f[]=new String[al.size()+1];
                Object a[]=al.toArray();
                f[0]=(String)a[0];
//                System.out.println(f[0]);
                out.println(f[0]);
                //session.removeAttribute("projectName");
                //session.removeAttribute("versionValue");
                //session.removeAttribute("moduleName");
%>
