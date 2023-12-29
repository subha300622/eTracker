<%-- 
    Document   : withoutSort
    Created on : 11 Aug, 2016, 1:00:09 PM
    Author     : EMINENT
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mi" class="com.eminent.issue.formbean.MyIssues"/>
<%
    mi.witout_sort(request,response);
      if (mi.getIssue() != "") {
        out.print(mi.getIssue());
     }
 
%>
