<%-- 
    Document   : accountCheck
    Created on : Dec 16, 2008, 9:37:43 AM
    Author     : Tamilvelan
 --%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.OpportunityFinder"%>

<%
                ArrayList<String> al  = new ArrayList<String>();
                String opportunity        = request.getParameter("name");
              
                String flag            = OpportunityFinder.isAccountExist(opportunity.trim());                
               
                String total = ","+flag+",";
                total = total.trim();
                al.add(total);
                String f[]=new String[al.size()+1];
                Object a[]=al.toArray();
                f[0]=(String)a[0];
//                System.out.println(f[0]);
                out.println(f[0]);
          
%>
