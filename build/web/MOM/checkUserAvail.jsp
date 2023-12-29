
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tc" class="com.eminent.tags.TagController"/>
<% tc.doAction(request);
    out.print(tc.getResult());
%>