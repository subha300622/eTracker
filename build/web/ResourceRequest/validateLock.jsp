<%-- 
    Document   : validateLock
    Created on : Nov 21, 2008, 4:59:04 PM
    Author     : Balaguru Ramasamy
--%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.pack.eminent.applicant.*"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                String lockId        = request.getParameter("apId");
                
                String flag            = Applicant.validateLock(lockId);                
               
                String total = ","+flag+",";
                total = total.trim();
                al.add(total);
                String f[]=new String[al.size()+1];
                Object a[]=al.toArray();
                f[0]=(String)a[0];
//                System.out.println(f[0]);
                out.println(f[0]);
                
%>

