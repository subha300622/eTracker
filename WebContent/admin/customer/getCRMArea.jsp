<%-- 
    Document   : getCRMArea
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
    List<String> list = CRMUtil.getArea(crmType);
    int rowcount = list.size();
    int count = 0;
    String totalArea = "";
    totalArea = ";";//rowcount+",";
    totalArea = totalArea.trim();
    if (rowcount >= 1) {
        totalArea = totalArea + "All Information" + ",";
        count++;
    } else if (rowcount == 0) {
        totalArea = totalArea + "All Information" + ",";
        count++;
    } else {
        totalArea = ";";
    }
    for (String city : list) {
        totalArea = totalArea + city.trim() + ",";
        count++;
    }
    totalArea = totalArea + count;
    al.add(totalArea);
    String f[] = new String[al.size() + 1];
    Object a[] = al.toArray();
    f[0] = (String) a[0];
    out.println(f[0]);
    count = 0;
    totalArea = ";";
%>