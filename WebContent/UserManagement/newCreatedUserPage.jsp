<%-- 
    Document   : newCreatedUserPage.jsp
    Created on : 17 Feb, 2016, 2:50:18 PM
    Author     : admin
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>
    <body>

        <jsp:useBean id="register" class="com.pack.RegisterNewUser">

        </jsp:useBean>
        <%

            String res = register.registernewUser(request);
            if (res.equalsIgnoreCase("alreadyusersExits")) {
        %>
        <jsp:forward page="userexist.jsp" />
        <%
        } else if (res.equals("create")) {%>
        <jsp:forward page="registersuccess.jsp" />
        <%
        } else {%>
        <span style="color: red;font-size: 14px">Something went wrong. please contact to try again.</span>
        <%}%>


    </body>
</html>