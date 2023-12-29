<%-- 
    Document   : sorting_onPosition
    Created on : 22 Aug, 2016, 9:47:22 AM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mi" class="com.eminent.issue.formbean.MyIssues"/>
<%
    mi.sorting_method(request,response);
     
        if(mi.getPosition()!=""){
            out.print(mi.getPosition());
        }
     

%>
