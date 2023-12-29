<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="sm" class="com.eminent.issue.controller.AssignmentExceedCotroller"/>
<%sm.setAll(request);
    out.print(sm.getMessage());
%>
