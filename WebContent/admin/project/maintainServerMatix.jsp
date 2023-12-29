<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="sm" class="com.eminent.server.ServerMaintenace"/>
<%sm.maintainMatirx(request);
    out.print(sm.getMessge());

%>
