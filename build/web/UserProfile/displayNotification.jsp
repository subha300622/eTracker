<%-- 
    Document   : displayNotification
    Created on : 29 Aug, 2019, 12:25:15 PM
    Author     : Muthu
--%>

<%@page import="com.eminent.notification.Notification"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
     <jsp:useBean id="nc" class="com.eminent.notification.NotificationController"></jsp:useBean>
      <%nc.news();%>

    
  <%                for (Notification notification : nc.getNotifications()) {
%>
 <li>
<%=notification.getNotification()%>

 </li>
 </br>
 <%}%>
  
 
