<%-- 
    Document   : getCRMCreatedUsers
    Created on : Sep 25, 2014, 13:19:18 PM
    Author     : RN.Khans
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> al = new ArrayList();
    String crmType = request.getParameter("crmType");
    List<String> list = CRMUtil.getCRMCreatedUsers(crmType);
    int rowcount = list.size();
    int count = 0;
    String totalcreator = "";
    totalcreator = ";";//rowcount+",";
    totalcreator = totalcreator.trim();
    if (rowcount >= 1) {
        totalcreator = totalcreator + "All Information" + ",";
        count++;
    } else if (rowcount == 0) {
        totalcreator = totalcreator + "All Information" + ",";
        count++;
    } else {
        totalcreator = ";";
    }
    for (String user : list) {
        totalcreator = totalcreator + user.trim() + ",";
        count++;
    }
    totalcreator = totalcreator + count;
    al.add(totalcreator);
    String f[] = new String[al.size() + 1];
    Object a[] = al.toArray();
    f[0] = (String) a[0];
    //System.out.println(f[0]);
    out.println(f[0]);
    count = 0;
    totalcreator = ";";
%>