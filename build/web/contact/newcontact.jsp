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
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <script language="JavaScript">
            function check(theForm)
            {

                if (top.treeframe !== undefined) {
                    top.treeframe.location.reload();
                }
                var x = document.getElementById("email").value;
                var y = document.getElementById("newcontact").value;
                theForm.action = 'viewcontact.jsp?email=' + x + '&newcontact=' + y;
                theForm.submit();
            }
        </script>
    </head>

    <body onload="check(theForm)">
        <form name="theForm" METHOD="POST" ACTION="viewcontact.jsp">
            <!-- Java Package Import Declarations -->
            <%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*,java.util.Calendar,java.text.*,com.eminent.util.*"%>
            <%@ page import="org.apache.log4j.*"%>


            <!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->

            <!--<jsp:useBean id="Register" class="com.pack.RegisterBean">
                <jsp:setProperty name="Register" property="*"/>
            </jsp:useBean>
            -->
            <!-- Java Coding Starts Here -->

            <%
                //Configuring log4j properties
                Logger logger = Logger.getLogger("*User Contact Creation in Admin Module");

                Connection connection = null;
                String owner = request.getParameter("owner");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String accounts = request.getParameter("accounts");
                String title = request.getParameter("title");
                String phone = request.getParameter("phone");
                String mobile = request.getParameter("mobile");
                String email = request.getParameter("email");
                String pmail = request.getParameter("personalemail");
                String reportsto = request.getParameter("reportsto");
                String company = request.getParameter("company");

                String mailingstreet = request.getParameter("mailingstreet");
                String mailingcity = request.getParameter("mailingcity");
                String mailingstate = request.getParameter("mailingstate");
                String mailingzip = request.getParameter("mailingzip");
                String mailingcountry = request.getParameter("mailingcountry");
                String otherstreet = request.getParameter("otherstreet");
                String othercity = request.getParameter("othercity");
                String otherstate = request.getParameter("otherstate");
                String otherzip = request.getParameter("otherzip");
                String othercountry = request.getParameter("othercountry");

                String fax = request.getParameter("fax");
                String homephone = request.getParameter("homephone");
                String otherphone = request.getParameter("otherphone");
                String assistant = request.getParameter("assistant");
                String asstphone = request.getParameter("asstphone");

                String leadsource = request.getParameter("leadsource");
                String birthdate = request.getParameter("birthdate");
                String department = request.getParameter("department");
                String description = request.getParameter("description");
                String mailingarea = request.getParameter("mailingarea");

                String rating = "Hot";
                String account = "Eminentlabs";

                String pname = "CRM";
                String version = "1.0";
                String manager = GetProjectManager.getManager(pname, version);

                PreparedStatement ps = null;
                Statement st = null;
                ResultSet rs = null;
                Statement stmt = null;
                ResultSet result = null;
                int roleId = 0;

                int userId = (Integer) session.getAttribute("userid_curr");
                if (userId == Integer.parseInt(manager)) {
                    roleId = 2;
                }
                try {
                    connection = MakeConnection.getConnection();
                    logger.debug("Connection:" + connection);
                    if (connection != null) {

                        stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        result = stmt.executeQuery("select email from contact");
                        if (result != null) {
                            if (result.next()) {
                                result.first();
                                do {
                                    if (result.getString("email").equals(email)) {
            %>
            <jsp:forward page="contactexist.jsp" />
            <%
                            }
                        } while (result.next());
                    }
                }

                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs = st.executeQuery("select contactid_seq.nextval from dual");
                if (rs != null) {
                    if (rs.next()) {
                        int nextValue = rs.getInt("nextval");

                        java.util.Date d = new java.util.Date();

                        Calendar cal = Calendar.getInstance();
                        cal.setTime(d);
                        //Timestamp ts = new Timestamp(cal.getTimeInMillis());
                        Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

                        SimpleDateFormat dfm = new SimpleDateFormat("yyyymdd");
                        String dueDate = "NA";

                        dueDate = dfm.format(ts);
                        logger.info(dueDate);

                        ps = connection.prepareStatement("insert into contact (contactid,title,firstname,lastname,phone,email,mobile,company,reportsto,rating,contact_owner,mailingstreet,mailingcity,mailingstate,mailingzip,mailingcountry,fax,homephone,otherphone,department,assistant,asstphone,birthdate,leadsource,description,createdon,modifiedon,roleid,accountname,assignedto,personalemail,mailingarea) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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

                        ps.setString(11, StringUtil.fixSqlFieldValue(owner));

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
                        ps.setInt(30, Integer.parseInt(manager));
                        ps.setString(31, pmail);
                        ps.setString(32, StringUtil.fixSqlFieldValue(mailingarea));

                        ps.executeUpdate();
                        connection.commit();
                        logger.info("Successfully updated!!!");

            %>

            <table>
                <tr><td><input type="hidden" name="email" value="<%=email%>"></td><td><input type="hidden" name="newcontact" value="true"></td></tr>
            </table>
            <%
                            }
                        }

                    }

                } catch (SQLException ex) {
                    logger.error("Exception While Creating new Contact:" + ex.getMessage());
                } finally {
                    if (result != null) {
                        result.close();
                    }
                    if (rs != null) {
                        rs.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (stmt != null) {
                        stmt.close();
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
        </form>
    </body>

</html>