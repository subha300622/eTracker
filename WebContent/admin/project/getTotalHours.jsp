<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%! 
String total="";
ArrayList<String> al;
%>

<%
                al=new ArrayList<String>();
                String startDate      = request.getParameter("startDate");
                String endDate        =  request.getParameter("endDate");
                //System.out.println("StartDate"+startDate);
                //System.out.println("EndDate"+endDate);
                int totalhours        = getInterval.calculateInterval(startDate,endDate);
                total=","+totalhours+",";
                total=total.trim();
                al.add(total);
                String f[]=new String[al.size()+1];
                Object a[]=al.toArray();
                f[0]=(String)a[0];
//                System.out.println(f[0]);
                out.println(f[0]);
%>

