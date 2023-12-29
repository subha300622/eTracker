<%-- 
    Document   : ermDeleteView
    Created on : Feb 26, 2014, 4:34:28 PM
    Author     : E0288
--%>

<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="JavaScript">
            function check(theForm)
            {

                if(top.treeframe!==undefined){
                top.treeframe.location.reload();
                }
               if(document.getElementById("status")!==null){
                var x = document.getElementById("status").value;
               
                theForm.action = '/eTracker/MyQuery/MyQueryView.jsp?status=' + x;
               }else{
                   var x = document.getElementById("errormessage").value;
               
                theForm.action = '/eTracker/MyQuery/MyQueryView.jsp?errormessage=' + x;
               }
                theForm.submit();
            }
        </script>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

        <META content=0 http-equiv=Expires>
        <META content=no-cache http-equiv=Pragma>
        <META content=no-cache http-equiv=Cache-Control>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    </head>
    <%@ include file="../noScript.jsp" %>
    <body onload="check(theForm);">
        <form name="theForm" METHOD="POST" >
            <jsp:useBean id="edv" class="com.eminentlabs.erm.ERMDeleteView"></jsp:useBean>
            <%
                edv.deleteView(request);
                if (edv.getStatus() != null) {
            %>
            <input type="hidden" name="status" id="status" value="<%=edv.getStatus()%>">
            <%}else{%>
                 <input type="hidden" name="errormessage" id="errormessage" value="<%=edv.getErrormessage()%>">  
                <%}%>
        </form>
    </body>
</html>
