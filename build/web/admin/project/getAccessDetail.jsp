<%-- 
    Document   : getAccessDetail
    Created on : 27 Aug, 2020, 4:27:38 PM
    Author     : vanithaalliraj
--%>
<%@page import="com.eminent.gstn.LogDetail"%>
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
    <%  String project = request.getParameter("project");
        String type = request.getParameter("type");
        String gstin = request.getParameter("gstin");
        String category = request.getParameter("category");
        String month = request.getParameter("month");
    %>
    <div class="tablecontent">
        <TABLE width="100%" id="filtersort" class="tablesorter">
            <thead>
                <tr><th colspan="7"><span style="background-color: #E8EEF7;text-align: left;font-weight: bold;color:blue;">This count shows of <%=project%> - <%=type%>- <%=gstin%> - <%=category%> for <%=month%></span></th></tr>
                <TR bgcolor="#C3D9FF">
                    <th>Category</th>
                    <th>Action</th>
                    <th>API Calls</th>
                    <th>Total Invoices</th>
                    <th>Unique Invoices</th>
                    <th>Duplicate Invoices</th>
                    <th>Total</th>
                </TR>
            </thead>
            <tbody>

                <% int c = 0;
                    for (LogDetail ld : GstnLogController.getAccessDetail(request)) {
                        c++;
                        if ((c % 2) != 0) {
                %>
                <tr bgcolor="white" align="left">
                    <%} else {%>
                <tr bgcolor="#E8EEF7" align="left">
                    <%}%>
                    <td><%=ld.getCategory()%></td>
                    <td><span class="showActionCounta" project="<%=project%>" type="<%=type%>" gstin="<%=gstin%>" category="<%=ld.getCategory()%>" action="<%=ld.getAction()%>" ><%=ld.getAction()%></span></td>
                    <td><%=ld.getApiCount()%></td>
                    <td><%=ld.getTotInvoices()%></td>
                    <td><%=ld.getOrgInvoices()%></td>
                    <td><%=ld.getDupInvoices()%></td>
                    <td><%=ld.getTotCount()%></td>
                </tr>
                <%}%>

            </tbody>
        </table>
    </div>

</body>
</html>   