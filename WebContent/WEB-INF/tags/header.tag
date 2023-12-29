<%-- 
    Document   : header
    Created on : Dec 11, 2008, 2:24:55 PM
    Author     : Balaguru Ramasamy
--%>

<%@tag description="My first Tag file" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="message" required="true" rtexprvalue="true"%>

<%-- any content can be specified here e.g.: --%>
<h2>${message}</h2>