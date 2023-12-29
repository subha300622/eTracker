<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*, org.apache.log4j.*"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
        Solution</title>
</head>
<body>

    <%
        //Configuring log4j properties
        Logger logger = Logger.getLogger("MyCRM approveContacts");

        String[] formname = request.getParameterValues("submit");
        String[] email = request.getParameterValues("approve");
        String[] assigned = request.getParameterValues("assignedto");
        ArrayList<String> userlist = new ArrayList<String>();
        for (String s : assigned) {
            if (!s.equalsIgnoreCase("")) {
                userlist.add(s);
            }
        }
        Connection connection = null;
        PreparedStatement ps = null;
        connection = MakeConnection.getConnection();
        if (formname[0].equalsIgnoreCase("Approve")) {
            try {
                ps = connection.prepareStatement("update contact set roleid=2,MODIFIEDON=(select sysdate from dual),assignedto=? where email=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                for (int x = 0; x < email.length; x++) {
                    logger.info("CRM Assignment-->" + assigned[x]);
                    ps.setString(2, email[x]);
                    ps.setString(1, userlist.get(x));
                    ps.addBatch();
                }
                int y[] = ps.executeBatch();
                connection.commit();
                logger.info(y.length + "rows updated");
    %>
    <jsp:forward page="waitingContacts.jsp">
        <jsp:param name="update" value="approved" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%
        } catch (Exception e) {
            //System.err.println("Error while performing SQL operations!!!...");
            logger.error(e.getMessage());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Deny")) {
        try {
            ps = connection.prepareStatement("update contact set roleid=-1 where email=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < email.length; x++) {

                ps.setString(1, email[x]);
                ps.addBatch();
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="waitingContacts.jsp">
        <jsp:param name="update" value="denied" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

            //System.out.println(y.length+"rows updated");
        } catch (Exception e) {
            logger.error("Error while performing SQL operations!!!...");
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Disable")) {
        try {
            ps = connection.prepareStatement("update contact set roleid=-2 where email=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < email.length; x++) {
                ps.setString(1, email[x]);
                ps.addBatch();
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="viewcontact.jsp">
        <jsp:param name="update" value="disabled" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

            //System.out.println(y.length+"rows updated");
        } catch (Exception e) {
            logger.error("Error while performing SQL operations!!!...");
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else if (formname[0].equalsIgnoreCase("Enable")) {
        try {
            ps = connection.prepareStatement("update contact set roleid=2 where email=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            for (int x = 0; x < email.length; x++) {
                ps.setString(1, email[x]);
                ps.addBatch();
            }
            int y[] = ps.executeBatch();
            connection.commit();
    %>
    <jsp:forward page="viewcontact.jsp">
        <jsp:param name="update" value="enabled" />
        <jsp:param name="noofrecords" value="<%= y.length%>" />
    </jsp:forward>
    <%

                //System.out.println(y.length+"rows updated");
            } catch (Exception e) {
                logger.error("Error while performing SQL operations!!!...");
            } finally {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            }
        }

    %>


</body>
</html>