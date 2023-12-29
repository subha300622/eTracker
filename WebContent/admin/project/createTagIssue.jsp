
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tic" class="com.eminent.tags.TagIssueController"/>
<%tic.doAction(request);
    if (tic.getTotalTagIssues() != "") {
        out.print(tic.getTotalTagIssues());
}
%>