<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.ProjectFinder"%>
<%@ page import="java.sql.*,java.util.*"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                String project        = request.getParameter("project");
                String version        = request.getParameter("version");
                String flag = "NA";
                if ( project != null ) {
                    project = project.trim();
                    version = version.trim();
                    flag            = ProjectFinder.getProjectEndDate(project,version); 
                }                                  
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