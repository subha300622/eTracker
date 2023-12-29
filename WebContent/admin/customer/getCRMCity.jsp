<%-- 
    Document   : getCRMCity
    Created on : Sep 25, 2014, 13:19:18 PM
    Author     : RN.Khans
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> al = new ArrayList<String>();
    String crmType = request.getParameter("crmType");
    List<String> list = CRMUtil.getCity(crmType);
    int rowcount = list.size();
    int count = 0;
    String totalCity = "";
    totalCity = ";";//rowcount+",";
    totalCity = totalCity.trim();
    if (rowcount >= 1) {
        totalCity = totalCity + "All Information" + ",";
        count++;
    } else if (rowcount == 0) {
        totalCity = totalCity + "All Information" + ",";
        count++;
    } else {
        totalCity = ";";
    }
    for (String city : list) {
        totalCity = totalCity + city.trim() + ",";
        count++;
    }
    totalCity = totalCity + count;
    al.add(totalCity);
    String f[] = new String[al.size() + 1];
    Object a[] = al.toArray();
    f[0] = (String) a[0];
    //System.out.println(f[0]);
    out.println(f[0]);
    count = 0;
    totalCity = ";";
%>