<%-- 
    Document   : assignmentExceeds
    Created on : 30 Dec, 2021, 3:58:42 PM
    Author     : Eminent
--%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.server.ServerSystem"%>
<%@page import="com.eminent.server.SapSystemType"%>
<%@page import="com.eminent.server.SapServerType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">      
    </head>
    <jsp:useBean id="sm" class="com.eminent.issue.controller.AssignmentExceedCotroller"></jsp:useBean>
    <%sm.getTypes(request);%>
    <body>

        <table style="background-color: #E8EEF7;width: 99%" id="matirx">
            <tr><td>No of Days</td>
                <td><input type="text" name="days" id="days" value="<%=sm.getIssueAssignment() == null ? "" : sm.getIssueAssignment().getDays()%>"></td>

            </tr>
            <tr><td>Type</td>
                <td>
                    <%for (Map.Entry<Integer, String> type : sm.getAssignType().entrySet()) {%>
                    <input type="radio" name="atype" value="<%=type.getKey()%>" <%if (sm.getIssueAssignment() != null && sm.getIssueAssignment().getAssignType() == type.getKey()) {%>checked="true"<%}%>/><%=type.getValue()%>
                    <%}%>
                </td>
            </tr>
            <tr><td>User Level</td>
                <td>

                    <%for (Map.Entry<Integer, String> type : sm.getUserType().entrySet()) {%>
                    <input type="checkbox" name="utype" class="utype"  value="<%=type.getKey()%>" 

                           <%if (sm.getIssueAssignment() != null) {
                                   for (String utype : sm.getIssueAssignment().getUserType().split(",")) {
                                       if (type.getKey() == Integer.parseInt(utype)) {%>checked="true"<%}
                                           }
                                       }%>/><%=type.getValue()%>
                    <%}%>
                </td>
            </tr>

        </table>


    </body>

</html>
