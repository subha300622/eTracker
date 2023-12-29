<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

    <meta http-equiv="Content-Type" content="text/html ">
    <TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
        Solution</TITLE>
</head>

<body>
    <!-- Java Package Import Declarations -->
    <%@ page
        import="java.sql.*,pack.eminent.encryption.*,com.pack.*,org.apache.log4j.*"%>
        <%@ page import="javax.mail.*,com.eminent.util.GetProjectMembers"%>
        <%@ page import="com.pack.MyAuthenticator,javax.mail.Authenticator"%>
        <%@ page import="javax.mail.internet.*,java.util.Calendar"%>
        <%@ page
            import="javax.mail.internet.MimeMessage,java.util.Properties,javax.mail.Message,javax.mail.Session,javax.mail.Transport"%>



            <%

                            //Configuring log4j properties
                Logger logger = Logger.getLogger("Contact Creation in Admin Module");

                Connection connection = null;
                int owner = GetProjectMembers.getAdminID();
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");

                String title = request.getParameter("title");
                String phone = request.getParameter("phone");
                String mobile = request.getParameter("mobile");
                String email = request.getParameter("email");
                String reportsto = request.getParameter("reportsto");
                String company = request.getParameter("company");

                String mailingstreet = request.getParameter("mailingstreet");
                if (mailingstreet == null) {
                    mailingstreet = "NA";
                }
                String mailingcity = request.getParameter("mailingcity");
                if (mailingcity == null) {
                    mailingcity = "NA";
                }
                String mailingstate = request.getParameter("mailingstate");
                if (mailingstate == null) {
                    mailingstate = "NA";
                }
                String mailingzip = request.getParameter("mailingzip");
                if (mailingzip == null) {
                    mailingzip = "NA";
                }
                String mailingcountry = request.getParameter("mailingcountry");
                if (mailingcountry == null) {
                    mailingcountry = "NA";
                }
                String otherstreet = request.getParameter("otherstreet");
                if (otherstreet == null) {
                    otherstreet = "NA";
                }
                String othercity = request.getParameter("othercity");
                if (othercity == null) {
                    othercity = "NA";
                }
                String otherstate = request.getParameter("otherstate");
                if (otherstate == null) {
                    otherstate = "NA";
                }
                String otherzip = request.getParameter("otherzip");
                if (otherzip == null) {
                    otherzip = "NA";
                }
                String othercountry = request.getParameter("othercountry");
                if (othercountry == null) {
                    othercountry = "NA";
                }
                String fax = request.getParameter("fax");
                if (fax == null) {
                    fax = "NA";
                }

                String homephone = request.getParameter("homephone");
                if (homephone == null) {
                    homephone = "NA";
                }

                String otherphone = request.getParameter("otherphone");
                if (otherphone == null) {
                    otherphone = "NA";
                }

                String assistant = request.getParameter("assistant");
                if (assistant == null) {
                    assistant = "NA";
                }

                String asstphone = request.getParameter("asstphone");
                if (asstphone == null) {
                    asstphone = "NA";
                }
                String leadsource = request.getParameter("leadsource");
                if (leadsource == null) {
                    leadsource = "NA";
                }
                String birthdate = request.getParameter("birthdate");
                if (birthdate == null) {
                    birthdate = "NA";
                }
                String department = request.getParameter("department");
                if (department == null) {
                    department = "NA";
                }
                String description = request.getParameter("description");
                if (description == null) {
                    description = "NA";
                }
                String product = request.getParameter("product");
                if (product == null) {
                    product = "NA";
                }
                String rating = "Hot";
                String account = "Eminentlabs";

                String mailingarea = request.getParameter("mailingarea");
                if (mailingarea == null) {
                    mailingarea = "NA";
                }
                int roleId = 0;

                PreparedStatement ps = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    connection = MakeConnection.getConnection();
                    logger.debug("Connection:" + connection);
                    if (connection != null) {
                        if (lastname != null && account != null) {

                            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rs = st.executeQuery("select contactid_seq.nextval from dual");
                            if (rs != null) {
                                if (rs.next()) {

                                    java.util.Date d = new java.util.Date();

                                    Calendar cal = Calendar.getInstance();
                                    cal.setTime(d);
                                    //Timestamp ts = new Timestamp(cal.getTimeInMillis());
                                    Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

                                    int nextValue = rs.getInt("nextval");

                                    ps = connection.prepareStatement("insert into contact (contactid,title,firstname,lastname,phone,email,mobile,company,reportsto,rating,contact_owner,mailingstreet,mailingcity,mailingstate,mailingzip,mailingcountry,fax,homephone,otherphone,department,assistant,asstphone,birthdate,leadsource,description,createdon,modifiedon,roleid,accountname,interested,assignedto,mailingarea,CONTACT_TYPE) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                    ps.setInt(1, nextValue);
                                    ps.setString(2, StringUtil.fixSqlFieldValue(title));
                                    ps.setString(3, StringUtil.fixSqlFieldValue(firstname));
                                    ps.setString(4, StringUtil.fixSqlFieldValue(lastname));

                                    ps.setString(5, StringUtil.fixSqlFieldValue(phone));
                                    ps.setString(6, StringUtil.fixSqlFieldValue(email));
                                    ps.setString(7, StringUtil.fixSqlFieldValue(mobile));

                                    ps.setString(8, StringUtil.fixSqlFieldValue(company));
                                    ps.setString(9, StringUtil.fixSqlFieldValue(reportsto));
                                    ps.setString(10, StringUtil.fixSqlFieldValue(rating));

                                    ps.setInt(11, owner);

                                    ps.setString(12, StringUtil.fixSqlFieldValue(mailingstreet));
                                    ps.setString(13, StringUtil.fixSqlFieldValue(mailingcity));
                                    ps.setString(14, StringUtil.fixSqlFieldValue(mailingstate));

                                    ps.setString(15, StringUtil.fixSqlFieldValue(mailingzip));
                                    ps.setString(16, StringUtil.fixSqlFieldValue(mailingcountry));

                                    ps.setString(17, StringUtil.fixSqlFieldValue(fax));
                                    ps.setString(18, StringUtil.fixSqlFieldValue(homephone));
                                    ps.setString(19, StringUtil.fixSqlFieldValue(otherphone));

                                    ps.setString(20, StringUtil.fixSqlFieldValue(department));
                                    ps.setString(21, StringUtil.fixSqlFieldValue(assistant));
                                    ps.setString(22, StringUtil.fixSqlFieldValue(asstphone));

                                    ps.setString(23, StringUtil.fixSqlFieldValue(birthdate));
                                    ps.setString(24, StringUtil.fixSqlFieldValue(leadsource));
                                    ps.setString(25, StringUtil.fixSqlFieldValue(description));

                                    ps.setTimestamp(26, ts);
                                    ps.setTimestamp(27, ts);
                                    ps.setInt(28, roleId);
                                    ps.setString(29, account);
                                    ps.setString(30, product);
                                    ps.setInt(31, owner);
                                    ps.setString(32, StringUtil.fixSqlFieldValue(mailingarea));
                                    ps.setString(33, "Normal");

                                    ps.executeUpdate();
                                    connection.commit();
                                    logger.info("Successfully updated!!!");

                                }
                            }
                        }
                    }

                } catch (SQLException Ex) {
                    logger.error("Exception While Creating new guest Contact:" + Ex);
                } finally {
                    if (ps != null) {
                        ps.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
                /* Sending SMS while Lead is registered
	        
                 */
                try {

                    String subject = "Eminentlabs Customer Relationship Management";
                    String Recipient = email;
                    String content = "<font color=blue><p>Dear Sir/Madam,<br></p><b><p>Thanks for registering with our Eminentlabs Customer Relationship Management!!!<br></p><p>Our normal business hours are Monday through Friday, 8am to 5pm and you can expect a response within 48 hours.<br></p><p>Thanks again for your inquiry and feel free to contact us @ +919880031332 if you have any further questions!<br></p></b><p>Business Development<br>Eminentlabs Group Companies<br>sales@eminentlabs.net<br></p></font>";
                    MimeMessage msg = MakeConnection.getMailConnections();
                      msg.setHeader("Content-Type", "text/plain;charset=UTF-8");
                    msg.setFrom(new InternetAddress("admin@eminentlabs.net"));
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(Recipient));
                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress("tgopal@eminentlabs.net"));
                    //          msg.addRecipient(Message.RecipientType.TO, new InternetAddress("+919980518397@airtelkk.com"));
                    msg.setSubject(subject);
                    msg.setContent(content, "text/html");
                    Transport.send(msg);
                    logger.info("The SMS has been sent");

                } catch (Exception ex) {
            //		System.err.println("Error while sending an SMS:"+sms);
                    logger.error(ex.getMessage());
                }
            %>
            <jsp:forward page="closeContactWindow.jsp">
                <jsp:param name="flag" value="true" />
            </jsp:forward>
            <!-- End of Java Coding -->

        </body>

    </html>