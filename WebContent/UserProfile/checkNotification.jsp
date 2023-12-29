<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="nc" class="com.eminent.notification.NotificationController"></jsp:useBean>
<%
 String res=nc.notificationDup(request);
 out.print(res);
%>
