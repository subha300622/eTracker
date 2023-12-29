<%-- 
    Document   : addNewModuleTwo
    Created on : 11 May, 2016, 12:27:17 PM
    Author     : admin
--%>

<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
    </head>
    <body>
        <jsp:useBean id="aemc" class="com.pack.controller.AdminEditModuleController"></jsp:useBean>


        <% int pid = (Integer) session.getAttribute("projectid");
            String res = aemc.addModuleForProjet(request);
            if (res.equalsIgnoreCase("true")) {
        %>
        <jsp:forward page="/admin/project/addmodules.jsp" />
        <%
        } else {%>
        <jsp:forward page="/admin/project/addmodules.jsp" />

        <%}
        %>
    </body>
</html>