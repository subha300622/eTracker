<%-- 
    Document   : getActionwiseCount
    Created on : 1 Sep, 2020, 10:27:14 AM
    Author     : vanithaalliraj
--%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.gstn.GstnLogController"%>
<%@page import="com.eminent.gstn.Log"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=11" type="text/css" rel="STYLESHEET"/>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">


    <title></title>

</head>
<body>
 <jsp:useBean id="far" class="com.eminent.gstn.GstnLogController"></jsp:useBean>

    <%
        List<Log> list = far.getActionDetail(request);

    %>

    <div class="tablecontent">
        <TABLE width="100%" id="filtersort" class="tablesorter">
            <thead>
                <TR bgcolor="#C3D9FF">
                    <td width="8%"><font><b>Transaction Id</b></font></td>
                    <td width="8%" ><font><b>Request Time</b></font></td>
                    <td width="8%" ><font><b>Response Time</b></font></td>
                    <td width="8%" ><font><b>Invoice</b></font></td>
                    <td width="50%" ><font><b>Request Payload</b></font></td>
                    <td width="18%" ><font><b>Response Payload</b></font></td>
                </TR>
            </thead>
            <tbody>
                <%int i = 0;
                    for (Log isfb : list) {
                        if ((i % 2) != 0) {
                %>
                <tr class="zebralinealter" height="21">
                    <%} else {%>
                <tr class="zebraline" height="21">
                    <%}
                            i++;%>

                   
                    <td class="background"><%=isfb.getTransId()%></td>
                    <td class="background"><%=isfb.getRequestTime()%></td>
                    <td class="background"><%=isfb.getResponseTime()%></td>
                    <td class="background"><%=isfb.getInvoice()%></td>
                    <td class="background"><%=isfb.getRequestJson()%></td>
                    <td class="background"><%=isfb.getResponseJson()%></td>
                   

                <%
                        }%>
            </tbody>
        </table>
    </div>

</body>
    
</html>