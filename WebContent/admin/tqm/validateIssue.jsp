<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eminent.tqm.TqmUtil" %>
<%
    String issueId  =   request.getParameter("issueid");
    String pId      =   request.getParameter("pid");
    String msg      =   TqmUtil.validateIssue(issueId, pId);
    msg="-"+msg+"-";
    out.println(msg);
 %>
