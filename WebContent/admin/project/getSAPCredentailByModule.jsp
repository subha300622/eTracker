<%-- 
    Document   : getActionwiseCount
    Created on : 1 Sep, 2020, 10:27:14 AM
    Author     : vanithaalliraj
--%>
<%@page import="com.eminent.server.ApmSapLogonCredential"%>
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
    <jsp:useBean id="sm" class="com.eminent.server.VpnController"></jsp:useBean>

    <%
         sm.getCredentialByModule(request);

    %>

    <div class="tablecontent">
        <TABLE width="100%" id="filtersort" class="tablesorter">
            <thead>
                <TR bgcolor="#C3D9FF">
                    <td width="20%" ><font><b>Client</b></font></td>
                    <td width="20%" ><font><b>Module</b></font></td>
                    <td width="40%" ><font><b>Username</b></font></td>
                    <td width="40%" ><font><b>Password</b></font></td>
                </TR>
            </thead>
            <tbody>
                
                   
                    <td class="background"><%=sm.getCredential()==null?"NA":sm.getCredential().getClinetNo()==0?"NA":sm.getCredential().getClinetNo()%></td>
                    <td class="background"><%=sm.getModuleid()%></td>
                    <td class="background"><%=sm.getCredential()==null?"NA":sm.getCredential().getUname()==null?"NA":sm.getCredential().getUname()%></td>
                    <td class="background"><%=sm.getCredential()==null?"NA":sm.getCredential().getPwd()==null?"NA":sm.getCredential().getPwd()%></td>
                   

                
            </tbody>
        </table>
    </div>

</body>
    
</html>