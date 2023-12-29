<%-- 
    Document   : moduleCheck
    Created on : Aug 12, 2008, 9:37:43 AM
    Author     : Balaguru Ramasamy
--%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.ProjectFinder"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                String version        = request.getParameter("version");
                String project        = (String)session.getAttribute("projectName");
                String originalVersion = (String)session.getAttribute("versionValue");
                String module          = (String)session.getAttribute("moduleName");
                String flag            = ProjectFinder.isModuleExist(module.trim(), project.trim(), version.trim());                
               
                String total = ","+flag+","+originalVersion.trim()+",";
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
