<%-- 
    Document   : exportToNotePad
    Created on : 18 Feb, 2016, 10:06:57 AM
    Author     : admin
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@ page contentType="octet/stream" %>



<jsp:useBean id="log" class="pack.eminent.encryption.GetServerLog"></jsp:useBean>
<%
    log.getexportToNtopad(request);

    StringBuffer stringBuffer = new StringBuffer(log.getNotpadText());
    out.println(stringBuffer);
    String nameOfTextFile = "D:/serverlog.txt";
    try {
        PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile));
        pw.println(log.getNotpadText());
        //clean up
        pw.close();
    } catch (IOException e) {
        out.println(e.getMessage());
    }%>
