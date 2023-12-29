<%@ page import="pack.eminent.encryption.*"%>
<%@ page language="java" errorPage="error.jsp"%>

<%@ page import="org.apache.log4j.*"%>
<%@ page import="org.apache.commons.codec.language.*"%>
<%@ page import="java.sql.*,dashboard.*,java.util.*,com.pack.SessionCounter,com.eminent.util.UserUtils"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <?target data?>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <meta http-equiv="Content-Type" content="text/html ">
</HEAD>
<BODY>

    <%

        //Configuring log4j properties
        String fireName = (String) session.getAttribute("Name");

        if (fireName != null) {

    %>
    <jsp:forward page="login.jsp" />
    <%    }
        Logger logger = Logger.getLogger("LoginValidation");

        String id = session.getId();
        logger.debug("SessionID Status:" + session.isNew());
        logger.info("SesssionID:" + id);

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {

            //extracting domain & mailserver details from servletContext
            //		
            //		String domain = (String)application.getAttribute("Domain");
            //		String mailServer = (String)application.getAttribute("MailServerName");
            //		
            //		logger.debug("Domain:"+domain);
            //		logger.debug("MailServer:"+mailServer);
            //		
            connection = MakeConnection.getConnection();

            String email = request.getParameter("username");
            if (email != null) {
                email = email.trim();

                //Storing the email Id in Cookie which will be stored in client's disk
                Cookie emailId = new Cookie("emailId", email);
                emailId.setMaxAge(60 * 60 * 24 * 365);
                response.addCookie(emailId);

                String password = request.getParameter("password");

                String resolution = request.getParameter("res");
                String zone = request.getParameter("zone");
                logger.info("resolution:" + resolution);
                logger.info("time zone:" + zone);

                String refinedpwd = Encryption.encrypt(password);
                logger.debug("REFINED PWD:" + refinedpwd);

                ps = connection.prepareStatement("SELECT userid,email,password,roleid,company,to_char(LASTLOGGEDON,'dd-Mon-yyyy hh24:mi:ss') as lastlogon,branch_id,team,FIRSTNAME,LASTNAME FROM USERS where lower(email)=?");
                ps.setString(1, email.toLowerCase());
                rs = ps.executeQuery();
                if (rs.next()) {
                    String db_email = rs.getString("email");
                    String db_pwd = rs.getString("password");

                    int userid = rs.getInt("userid");

                    String company = rs.getString("company");
                    session.setAttribute("company", company);

                    String lastlogon = rs.getString("lastlogon");
                    session.setAttribute("lastlogon", lastlogon);
                    session.setAttribute("branch", rs.getInt("branch_id"));
                    session.setAttribute("team", rs.getString("team"));
                    String fName = rs.getString("firstname");
                    String lName = rs.getString("lastname");

                    //System.out.println("DB Encrypted Password:\t"+db_pwd);
                    //		Encryption encryption = new Encryption();
                    //		String decrypted_pwd = encryption.decrypt(db_pwd);
                    int role = rs.getInt("roleid");
                    String browserDetails = request.getHeader("User-Agent");
                    String ipAddress = request.getRemoteAddr();

                    logger.info("Remote Address" + ipAddress);
                    if ((email.equalsIgnoreCase(db_email)) && (db_pwd.equals(refinedpwd))) {
                        if (role > 0) {
                            UserUtils.updateLoginHistory(userid, browserDetails, id, ipAddress, resolution, zone);
                        }
                        email = db_email;
                        session.setAttribute("Name", email);
                        session.setAttribute("Currentpwd", password);
                        logger.info("Valid User");
                        logger.info("User:" + db_email);
                        logger.info("SessionID:" + session.getId());
                        logger.debug("Session Status:" + session.isNew());
                        request.getSession();

                        if (role == 1) {

                            session.setAttribute("theName", email);
                            session.setAttribute("userid_curr", new Integer(userid));
                            session.setAttribute("Role", new Integer(1));
//                            ArrayList<String> al = CountIssue.getCurrentUser(email);
//
                            session.setAttribute("fName", fName);
                            session.setAttribute("lName", lName);

                            session.setAttribute("uid", new Integer(userid));
                            SessionCounter.setActiveUsers(id, ((Integer) userid).toString());

                            response.sendRedirect("admin/user/adminwelcome.jsp");
                        } else if (role == 2) {
                            session.setAttribute("theName", email);
                            //System.out.println("theName"+name );
                            session.setAttribute("userid_curr", new Integer(userid));
                            session.setAttribute("Role", new Integer(2));

               //              ArrayList<String> al = CountIssue.getCurrentUser(email);
//
                            session.setAttribute("fName", fName);
                            session.setAttribute("lName", lName);

                            session.setAttribute("uid", new Integer(userid));
                           
                            SessionCounter.setActiveUsers(id, ((Integer) userid).toString());

                            response.sendRedirect("welcome.jsp");

                        } else if (role == 3) {
                            session.setAttribute("theName", email);
                            //System.out.println("theName"+name );
                            session.setAttribute("userid_curr", new Integer(userid));
                            session.setAttribute("Role", new Integer(3));

//                            ArrayList<String> al = CountIssue.getCurrentUser(email);
                            session.setAttribute("fName", fName);
                            session.setAttribute("lName", lName);

                            session.setAttribute("uid", new Integer(userid));

                            SessionCounter.setActiveUsers(id, ((Integer) userid).toString());

                            response.sendRedirect("welcome.jsp");

                        } else if (role == 4) {
                            session.setAttribute("theName", email);
                            //System.out.println("theName"+name );
                            session.setAttribute("userid_curr", new Integer(userid));
                            session.setAttribute("Role", new Integer(4));

                            //ArrayList<String> al = CountIssue.getCurrentUser(email);
                            session.setAttribute("fName", fName);
                            session.setAttribute("lName", lName);

                            session.setAttribute("uid", new Integer(userid));
                            SessionCounter.setActiveUsers(id, ((Integer) userid).toString());

                            response.sendRedirect("welcome.jsp");
                        } else if (role == 5) {
                            session.setAttribute("theName", email);
                            //System.out.println("theName"+name );
                            session.setAttribute("userid_curr", new Integer(userid));
                            session.setAttribute("Role", new Integer(5));

                            //  ArrayList<String> al = CountIssue.getCurrentUser(email);
                            session.setAttribute("fName", fName);
                            session.setAttribute("lName", lName);

                            session.setAttribute("uid", new Integer(userid));
                            SessionCounter.setActiveUsers(id, ((Integer) userid).toString());

                            response.sendRedirect("welcome.jsp");

                        } else {
    %>
    <jsp:forward page="error.jsp" />
    <%
        }
    } else {
        connection.close();
        //				session.removeAttribute("dbconnection");
        session.invalidate();
        logger.debug("User Session has been terminated");
    %>
    <jsp:forward page="login.jsp">
        <jsp:param name="userAuthentication" value="false" />
        <jsp:param name="username"
        value="<%= request.getParameter("username")%>" />
    </jsp:forward>
    <%
        }
    } else {
        connection.close();
        //				session.removeAttribute("dbconnection");
        session.invalidate();
        logger.debug("User Session has been terminated");
    %>
    <jsp:forward page="login.jsp">
        <jsp:param name="userAuthentication" value="false" />
        <jsp:param name="username"
        value="<%= request.getParameter("username")%>" />
    </jsp:forward>
    <%
        }
    } else {
        connection.close();

        session.invalidate();
        logger.debug("User Session has been terminated");
    %>
    <jsp:forward page="login.jsp">
        <jsp:param name="userAuthentication" value="true" />
        <jsp:param name="username"
        value="<%= request.getParameter("username")%>" />
    </jsp:forward>
    <%

            }
        } catch (Exception e) {
            logger.error("Exception:" + e);
            //System.err.println(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
            logger.debug("Closing all the JDBC Connection recources");
        }
    %>
</BODY>
</HTML>