<%-- 
    Document   : getCRMCompany
    Created on : Sep 25, 2014, 12:19:18 PM
    Author     : RN.Khans
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> al = new ArrayList<String>();
    String crmType = request.getParameter("crmType");
    List<String> list = CRMUtil.getCompany(crmType);
    int rowcount = list.size();
    int count = 0;
    String totalCompanies = "";
    totalCompanies = ";";//rowcount+",";
    totalCompanies = totalCompanies.trim();
    if (rowcount >= 1) {
        totalCompanies = totalCompanies + "All Information" + ",";
        count++;
    } else if (rowcount == 0) {
        totalCompanies = totalCompanies + "All Information" + ",";
        count++;
    } else {
        totalCompanies = ";";
    }
    for (String company : list) {
        totalCompanies = totalCompanies + company.trim() + ",";
        count++;
    }
    totalCompanies = totalCompanies + count;
    al.add(totalCompanies);
    String f[] = new String[al.size() + 1];
    Object a[] = al.toArray();
    f[0] = (String) a[0];
    //System.out.println(f[0]);
    out.println(f[0]);
    count = 0;
    totalCompanies = ";";
%>