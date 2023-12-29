<%-- 
    Document   : getCRMState
    Created on : Sep 25, 2014, 12:36:10 PM
    Author     : RN.Khans
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> al = new ArrayList();
    String crmType = request.getParameter("crmType");
    List<String> list = CRMUtil.getState(crmType);
    int rowcount = list.size();
    int count = 0;
    String totalSity = "";
    totalSity = ";";//rowcount+",";
    totalSity = totalSity.trim();
    if (rowcount >= 1) {
        totalSity = totalSity + "All Information" + ",";
        count++;
    } else if (rowcount == 0) {
        totalSity = totalSity + "All Information" + ",";
        count++;
    } else {
        totalSity = ";";
    }
 //   System.out.println("State Name:::"+list.size());
    for (String state : list) {
   //     System.out.println("State Name:::"+company);
        totalSity = totalSity + state.trim() + ",";
        count++;
    }
    totalSity = totalSity + count; 
    al.add(totalSity);
    String f[] = new String[al.size() + 1];
    Object a[] = al.toArray();
    f[0] = (String) a[0];
    out.println(f[0]);
    count = 0;
    totalSity = ";";
%>
