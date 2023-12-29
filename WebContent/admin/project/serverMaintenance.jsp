<%-- 
    Document   : serverMaintenance
    Created on : 16 Oct, 2020, 3:58:42 PM
    Author     : vanithaalliraj
--%>
<%@page import="com.eminent.server.ServerSystem"%>
<%@page import="com.eminent.server.SapSystemType"%>
<%@page import="com.eminent.server.SapServerType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">      
    </head>
    <jsp:useBean id="sm" class="com.eminent.server.ServerMaintenace"></jsp:useBean>
    <%sm.getTypes(request);%>
    <body>

        <table style="background-color: #E8EEF7;width: 99%" id="matirx">
            <tr><td></td><%for (SapSystemType systemType : sm.getAllSystems()) {%>
                <td><%=systemType.getSName()%></td>
                <%}%>
            </tr>
            <%for (SapServerType serverType : sm.getAllServers()) {%>
            <tr><td><input type="hidden" name="serverName" value="<%=serverType.getServerName()%>"/>
                    <%=serverType.getServerName()%></td>
                <%for (SapSystemType systemType : sm.getAllSystems()) {%>
                <td>
                    <input type="checkbox" class="serverMaintain" value="<%=serverType.getSId()%>-<%=systemType.getSId()%>"
                           <%for (ServerSystem serverSystem : sm.getServerMatrix()) {%>

                           <%if (serverType.getSId() == serverSystem.getServerId() && systemType.getSId() == serverSystem.getSyId()) {%>
                           checked="true"
                           <%}%>
                           <%}%>
                           ></td>
                    <%}%>
            </tr>
            <%}%>
        </table>
        

</body>

</html>
