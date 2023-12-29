<%-- 
    Document   : escalationQustions
    Created on : 14 Oct, 2020, 3:58:42 PM
    Author     : vanithaalliraj
--%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <style>
            b{
                font:bold;
            }
            tr{
                height:21;
            }
        </style>
    </head>
    <body>
        <%  String issue = request.getParameter("issueId");
                    EscalationDAO esc = new EscalationDAOImpl();
            Map<Integer, String> map = esc.getEscalationAnswer(issue);%>
        <table style="background-color: #E8EEF7;width: 100%">
            <tr>
                <td style="width: 70%"><b>Is requirement provided clearly?</b></td>
                <td><%=map.get(1)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is QA-BTC reviewed to make the requirement understandable to all?</b></td>
                <td><%=map.get(2)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue highlighted in WRM before escalation?</b></td>
                <td><%=map.get(3)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the WRM highlighted issue planned daily?</b></td>
                <td><%=map.get(4)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue escalated in production?</b></td>
                <td><%=map.get(5)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue replicable in quality?</b></td>
                <td><%=map.get(6)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is access to Development,Quality and Production provided?</b></td>
                <td><%=map.get(7)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is sufficient authorization provided with debug option to resolve this issue?</b></td>
                <td><%=map.get(8)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is sufficient time provided to resolve this issue?</b></td>
                <td><%=map.get(9)%></td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue escalated questioning the capability of Eminentlabs?</b></td>
                <td><%=map.get(10)%></td>
            </tr>
            
</table>
</body>
</html>
