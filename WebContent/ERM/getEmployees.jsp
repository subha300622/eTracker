<%-- 
    Document   : getEmployees
    Created on : Mar 13, 2012, 10:47:11 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.UserUtils" %>
<%
String refId = request.getParameter("refempid").trim().toUpperCase();
boolean flag=UserUtils.getEmp(refId);
String value    =   "0";
if(flag){
    value="1";
}
out.println(value);
%>