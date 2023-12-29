<%-- 
Document   : retrieveAlltags
    Created on : 25 May, 2016, 11:11:14 AM
    Author     : EMINENT
--%>



<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.tags.Tags"%>
<%@page import="java.util.List"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tc" class="com.eminent.tags.TagController"/>


<option value = "" selected = "" >Select</ option>
    <% Long tagId = MoMUtil.parseLong(request.getParameter("tagId"), 0l);
        tc.getTagsByUser(request);
        if (tc.getTagList().isEmpty()) {
        } else {
            for (Tags tag : tc.getTagList()) {
                if(tagId==tag.getTagId().longValue()){
    %>
    
<option value="<%=tag.getTagId()%>" selected=""><%=tag.getTagName()%></option>
<%}else{%>
<option value="<%=tag.getTagId()%>" ><%=tag.getTagName()%></option>
       <% }
    }
        }

%> 



