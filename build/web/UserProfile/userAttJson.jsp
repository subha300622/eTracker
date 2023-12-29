<%-- 
    Document   : userAttJson
    Created on : 21 Apr, 2015, 12:25:42 PM
    Author     : EMINENT
--%>


<%@page import="org.json.JSONArray"%>
<jsp:useBean id="ma" class="com.eminentlabs.mom.MoMAttendance"/>

<%
    ma.setAll(request);
    String json = ma.getnewJsonRes(ma.getYear(), ma.getMonth(), ma.getUserAttendies(),ma.getBranch(),ma.getLeaveDetail());
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.println(json);
%>
