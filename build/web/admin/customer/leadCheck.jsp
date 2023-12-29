<%-- 
    Document   : leadCheck
    Created on : Jan 10, 2009, 6:59:22 PM
    Author     : Tamilvelan
--%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.OpportunityFinder"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                String email        = request.getParameter("name");

                String flag            = OpportunityFinder.isLeadExist(email.trim());

                String total = ","+flag+",";
                total = total.trim();
                al.add(total);
                String f[]=new String[al.size()+1];
                Object a[]=al.toArray();
                f[0]=(String)a[0];
//                System.out.println(f[0]);
                out.println(f[0]);

%>