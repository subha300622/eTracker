<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="trd" class="com.eminent.issue.controller.TRDisplayController"/>
<% trd.doAction(request);
    if (trd.getTotalTrFormats() != "") {
        out.print(trd.getTotalTrFormats());
}
%>