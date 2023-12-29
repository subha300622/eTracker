<%-- 
    Document   : attendanceSummary
    Created on : 21 May, 2015, 1:17:05 PM
    Author     : EMINENT
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.util.Set"%>
<%@page import="com.eminentlabs.mom.MoMAttendance"%>
<%@page import="org.json.JSONArray"%>
<jsp:useBean id="ma" class="com.eminentlabs.mom.MoMAttendance"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<table class="mom" style="border-collapse: collapse;">
    <%
        Map<String,Integer> attStatus=new HashMap<String,Integer>();
        ma.attendanceSummary(request);
        Set<String> attStatu = MoMUtil.attendancsStatus();
        for (String status : attStatu) {
            int count = 0;
            for (MoMAttendance att : ma.getUserAttendies()) {
                if (status.equalsIgnoreCase(att.getStatus())) {
                    count = att.getCount();
                    break;
                }
            }
            attStatus.put(status, count);
        }%>
         <tr style="height: 21px;background: #c3d9ff">
   <%for (Map.Entry<String, Integer> entrySet : attStatus.entrySet()) {
           %>
    <td class="mom" style="font-weight: bold;"><%=entrySet.getKey()%></td>
     <%}%>
    </tr>
      <tr style="height: 21px;">
    <% for (Map.Entry<String, Integer> entrySet : attStatus.entrySet()) {%>
     <td class="mom"><%=entrySet.getValue()%></td>
    <%}%>
      </tr>
</table>