<%-- 
    Document   : createContact
    Created on : 12 Oct, 2011, 3:05:02 PM
    Author     : Tamilvelan
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="pack.eminent.encryption.*"%>
        <%@ page import="org.apache.log4j.*"%>
        <%@ page import="com.pack.MyAuthenticator,com.eminent.util.*"%>
        <%@ page import="javax.mail.*,dashboard.*"%>
        <%@ page import="java.util.*,java.text.*"%>
        <%@ page import="javax.mail.internet.*"%>
        <%@ page import="javax.mail.internet.MimeMessage"%>
        <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration">
            <jsp:setProperty name="Contact" property="*" />
        </jsp:useBean>
        <%
            Connection connection = null;
            String link = (String) session.getAttribute("forwardpage");
            try {
                connection = MakeConnection.getConnection();
                String customerEmail = request.getParameter("email");

                if (connection != null) {
                    boolean state = Contact.CheckContact(connection, customerEmail);
                    if (state == true) {
        %>
        <jsp:forward page="customerExist.jsp" />
        <%
        } else {
            Contact.CreateContact(connection, customerEmail);
        %>


        <jsp:forward page="<%=link%>" >
            <jsp:param name="email" value="<%=customerEmail%>"/>
            <jsp:param name="newcontact" value="Added"/>
        </jsp:forward>
        <%
                    }
                }
            } catch (Exception e) {

                //  logger.error(e.getMessage());
            } finally {
                if (connection != null) {
                    connection.close();
                }
            }
        %>
    </body>
</html>