<%-- 
    Document   : withoutSortPosition
    Created on : 22 Aug, 2016, 9:46:35 AM
    Author     : EMINENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mi" class="com.eminent.issue.formbean.MyIssues"/>
<%
     mi.witout_sort(request,response);
 if(mi.getPosition()!=""){
            out.print(mi.getPosition());
        }
%>
