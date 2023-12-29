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
    <%Logger logger = Logger.getLogger("contact");
        Connection connection = null;
        String link = (String) session.getAttribute("forwardpage");
        try {
            connection = MakeConnection.getConnection();
            String customerEmail = request.getParameter("email");
            String industry = request.getParameter("industry");
            String newIndustry = request.getParameter("newIndustry");
            String newVendor = request.getParameter("newVendor");
            String newMailingarea = request.getParameter("newMailingarea");
            String newMailingcity = request.getParameter("newMailingcity");
            String newMailingcountry = request.getParameter("newMailingcountry");
            String newMailingstate = request.getParameter("newMailingstate");
            String newDepartment = request.getParameter("newDepartment");
            String mailingcity = request.getParameter("mailingcity");
            String mailingstate = request.getParameter("mailingstate");
            String mailingcountry = request.getParameter("mailingcountry");
            String department = request.getParameter("department");
            String vendor = request.getParameter("vendor");
            String mailingarea = request.getParameter("mailingarea");
            if (industry.equalsIgnoreCase("new")) {
                industry = Contact.addIndustry(connection, newIndustry) + "";
            }
            if (vendor.equalsIgnoreCase("new")) {
                vendor = newVendor;
            }
                                if (mailingarea.equalsIgnoreCase("new")) {
                                    mailingarea = newMailingarea;
                                }

                                if (mailingcity.equalsIgnoreCase("new")) {
                                    mailingcity = newMailingcity;
                                }

                                if (mailingstate.equalsIgnoreCase("new")) {
                                    mailingstate = newMailingstate;
                                }

                                if (mailingcountry.equalsIgnoreCase("new")) {
                                    mailingcountry = newMailingcountry;
                                }

                                if (department.equalsIgnoreCase("new")) {
                                    department = newDepartment;
                                }
            if (connection != null) {
                boolean state = Contact.CheckContact(connection, customerEmail);
                if (state == true) {
    %>
    <jsp:forward page="customerExist.jsp" />
    <%
    } else {
        Contact.CreateContact(connection, customerEmail, industry, vendor, mailingarea, mailingcity, mailingstate, mailingcountry, department);
    %>


    <jsp:forward page="<%=link%>" >
        <jsp:param name="email" value="<%=customerEmail%>"/>
        <jsp:param name="newcontact" value="Added"/>
    </jsp:forward>
    <%
                }
            }
        } catch (Exception e) {

            logger.error(e.getMessage());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    %>
</body>
</html>