<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%Logger logger = Logger.getLogger("userupdate");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
</head>
<body>

    <%@ page language="java"%>
    <%@ page import="java.sql.*,pack.eminent.encryption.*"%>
    <jsp:useBean id="Admin" class="com.pack.AdminBean" />

    <%
        Connection connection = null;
        String fname = request.getParameter("firstName");
        out.println(fname);
        String lname = request.getParameter("lastName");
        String company = request.getParameter("company");
        String email1 = request.getParameter("userEmail");
        String mobile = request.getParameter("mobile");
        String mobile1 = request.getParameter("mobile1");

        String phone = request.getParameter("phone");
        String phone1 = request.getParameter("phone1");
        String phone2 = request.getParameter("phone2");

        String team = request.getParameter("Team");
        String empId = request.getParameter("empId");
        String mail1 = (String) session.getAttribute("mail");
        String branch = request.getParameter("branch");
        String newBranch = request.getParameter("newBranch");
        String userId = request.getParameter("userId");
        String role = request.getParameter("role");
        int loggedUser = (Integer) session.getAttribute("uid");

        try {
    //		connection=Admin.ConnectToDatabase();
            connection = MakeConnection.getConnection();
            if (connection != null) {
                Admin.UserUpdate(connection, fname, lname, company, email1, mobile, mobile1, phone, phone1, phone2, mail1, team, empId, Integer.parseInt(branch), Integer.parseInt(newBranch), Integer.parseInt(userId), loggedUser,Integer.parseInt(role));
    %>
    <jsp:forward page="/admin/user/viewuser.jsp" />
    <%
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