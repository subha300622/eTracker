<%-- 
    Document   : saveErmQuery
    Created on : Feb 25, 2014, 10:59:44 AM
    Author     : E0288
--%>

<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
              Logger logger = Logger.getLogger("saveErmQuery");
  

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    </head>
    <body>
        <jsp:useBean id="qs" class="com.eminentlabs.erm.ErmQuerySave"></jsp:useBean>
        <%
            String queryStatus = qs.saveOrUpdateErmQuery(request);
            String queryname = request.getParameter("queryname");
            String description = request.getParameter("description");
            if (queryStatus != null) {
        %>
        <jsp:forward page="ermSearchSave.jsp">
            <jsp:param name="querystatus" value="true" />
            <jsp:param name="description" value="<%= description%>" />
            <jsp:param name="queryname" value="<%= queryname%>" />
        </jsp:forward>
        <%}%>
        <jsp:forward page="../MyQuery/MyQueryView.jsp">
            <jsp:param name="saveView" value="<%= queryname%>" />
            <jsp:param name="Updated" value="Saved" />

        </jsp:forward>
    </body>
</html>
