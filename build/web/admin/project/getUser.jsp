<%-- 
    Document   : getUser
    Created on : Aug 4, 2008, 1:19:29 PM
    Author     : Balaguru Ramasamy
--%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page
	import="java.sql.*,java.util.*,com.eminent.util.GetProjectManager"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                int userId      = Integer.valueOf(request.getParameter("userId"));
                
                String name        = GetProjectManager.getUserFullName(userId);
                String total = ","+name+",";
                total = total.trim();
                al.add(total);
                String f[]=new String[al.size()+1];
                Object a[]=al.toArray();
                f[0]=(String)a[0];
//                System.out.println(f[0]);
                out.println(f[0]);
%>


