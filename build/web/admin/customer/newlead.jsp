<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%

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
        <TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
            Solution</TITLE>
    </head>

    <body>
        <!-- Java Package Import Declarations -->
        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*"%>
        <%@ page import="org.apache.log4j.*,java.util.Calendar"%>


        <!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->

        <!--<jsp:useBean id="Register" class="com.pack.RegisterBean">
            <jsp:setProperty name="Register" property="*"/>
        </jsp:useBean>
        -->
        <!-- Java Coding Starts Here -->

        <%
            java.util.Date d = new java.util.Date();

            Calendar cal = Calendar.getInstance();
            cal.setTime(d);
            //Timestamp ts = new Timestamp(cal.getTimeInMillis());
            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

                        //Configuring log4j properties
            Logger logger = Logger.getLogger("Adding Lead");

            Connection connection = null;

            String leadowner = request.getParameter("leadowner");

            String title = request.getParameter("title");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");

            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String company = request.getParameter("company");

            String mobile = request.getParameter("mobile");
            String leadstatus = request.getParameter("leadstatus");
            String assignedto = request.getParameter("assignedto");

            String rating = request.getParameter("rating");
            String website = request.getParameter("website");
            String leadpotential = request.getParameter("leadpotential");
            int potential = 0;
            if (leadpotential != "") {
                potential = Integer.parseInt(leadpotential);
            } else {

                logger.info("Lead Potential is null");
                potential = 1;
            }

            String duedate = request.getParameter("duedate");
            String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);

            String product = request.getParameter("product");

            String street = request.getParameter("street");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zip = request.getParameter("zip");
            String country = request.getParameter("country");

            String noofemployees = request.getParameter("noofemployees");
            String leadsource = request.getParameter("leadsource");
            String annualrevenue = request.getParameter("annualrevenue");
            String industry = request.getParameter("industry");
            String description = request.getParameter("description");

            int leadrole = 0;

            PreparedStatement ps = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                connection = MakeConnection.getConnection();
                logger.debug("Connection:" + connection);
                if (connection != null) {
                    if (lastname != null && company != null) {

                        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs = st.executeQuery("select leadid_seq.nextval from dual");
                        if (rs != null) {
                            if (rs.next()) {
                                int nextValue = rs.getInt("nextval");
        //								ps=connection.prepareStatement("insert into lead (lead_owner,firstname,lastname,company,title,leadstatus,phone,email,rating,street,city,state,zip,country,website,noofemployees,annualrevenue,leadsource,industry,description,leadid,roleid,mobile,leadpotential,createdon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                ps = connection.prepareStatement("insert into lead (lead_owner,title,firstname,lastname,phone,email,company,mobile,leadstatus,assignedto,rating,website,leadpotential,duedate,interested,street,city,state,zip,country,annualrevenue,noofemployees,industry,leadsource,description,leadid,roleid,createdon,modifiedon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

                                ps.setString(1, StringUtil.fixSqlFieldValue(leadowner));

                                ps.setString(2, StringUtil.fixSqlFieldValue(title));
                                ps.setString(3, StringUtil.fixSqlFieldValue(firstname));
                                ps.setString(4, StringUtil.fixSqlFieldValue(lastname));

                                ps.setString(5, StringUtil.fixSqlFieldValue(phone));
                                ps.setString(6, StringUtil.fixSqlFieldValue(email));
                                ps.setString(7, StringUtil.fixSqlFieldValue(company));

                                ps.setString(8, mobile);
                                ps.setString(9, StringUtil.fixSqlFieldValue(leadstatus));
                                ps.setInt(10, Integer.parseInt(assignedto));

                                ps.setString(11, StringUtil.fixSqlFieldValue(rating));
                                ps.setString(12, StringUtil.fixSqlFieldValue(website));
                                ps.setInt(13, potential);

                                ps.setDate(14, java.sql.Date.valueOf(storeDate));
                                ps.setString(15, StringUtil.fixSqlFieldValue(product));

                                ps.setString(16, StringUtil.fixSqlFieldValue(street));
                                ps.setString(17, StringUtil.fixSqlFieldValue(city));
                                ps.setString(18, StringUtil.fixSqlFieldValue(state));

                                ps.setString(19, StringUtil.fixSqlFieldValue(zip));
                                ps.setString(20, StringUtil.fixSqlFieldValue(country));

                                ps.setString(21, StringUtil.fixSqlFieldValue(annualrevenue));
                                ps.setString(22, StringUtil.fixSqlFieldValue(noofemployees));

                                ps.setString(23, StringUtil.fixSqlFieldValue(industry));
                                ps.setString(24, StringUtil.fixSqlFieldValue(leadsource));

                                ps.setString(25, StringUtil.fixSqlFieldValue(description));

                                ps.setInt(26, nextValue);
                                ps.setInt(27, leadrole);

                                ps.setTimestamp(28, ts);
                                ps.setTimestamp(29, ts);

                                ps.executeUpdate();
                                connection.commit();
                                logger.info("Successfully updated!!!");

        %>
        <jsp:forward page="/admin/customer/waitingLead.jsp">
            <jsp:param name="newlead" value="true" />
            <jsp:param name="company" value="<%=company%>" />
        </jsp:forward>
        <%
                            }
                        }
                    }
                }

            } catch (SQLException ex) {
                logger.error(ex.getMessage());
            } finally {
                if (rs != null) {
                    rs.close();
                }

                if (st != null) {
                    st.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            }

        %>

        <!-- End of Java Coding -->

    </body>

</html>