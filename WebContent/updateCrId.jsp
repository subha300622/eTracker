<%-- 
    Document   : updateCrId
    Created on : Dec 23, 2013, 5:12:07 PM
    Author     : E0288
--%>

<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String issueId=request.getParameter("issueId");
        try {
                String crId[] = request.getParameterValues("crIda");
                String desc[] = request.getParameterValues("crIdDescriptiona");
                String sno[] = request.getParameterValues("sno");
                if(crId!=null){
                    for (int i = 0; i < crId.length; i++) {
                        
                        IssueDetails.editCRID(sno[i], crId[i], desc[i]);
                    }
                }

        } catch (Exception crExcep) {
                    crExcep.printStackTrace();
        }
        
        
        
        
        
        %>
        <jsp:forward page="/viewCrIdbyIssue.jsp">
            <jsp:param name="issueId" value="<%=issueId%>"/>
        </jsp:forward>
    </body>
</html>
