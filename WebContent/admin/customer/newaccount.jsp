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
            Logger logger = Logger.getLogger("New Account");

            Connection connection = null;

            String accountowner = request.getParameter("accountowner");
            String accountname = request.getParameter("accountname");
            String parentaccount = request.getParameter("parentaccount");
            String phone = request.getParameter("phone");
            String fax = request.getParameter("fax");
            String website = request.getParameter("website");
            String type = request.getParameter("type");
            String industry = request.getParameter("industry");
            String employees = request.getParameter("employees");
            String annualrevenue = request.getParameter("annualrevenue");
            String description = request.getParameter("description");

            String billingstreet = request.getParameter("billingstreet");
            String billingcity = request.getParameter("billingcity");
            String billingstate = request.getParameter("billingstate");
            String billingzip = request.getParameter("billingzip");
            String billingcountry = request.getParameter("billingcountry");
            String shippingstreet = request.getParameter("shippingstreet");
            String shippingcity = request.getParameter("shippingcity");
            String shippingstate = request.getParameter("shippingstate");
            String shippingzip = request.getParameter("shippingzip");
            String shippingcountry = request.getParameter("shippingcountry");

            String assignedto = request.getParameter("assignedto");

            String duedate = request.getParameter("duedate");
            String storeDate = com.pack.ChangeFormat.getDateFormat(duedate);

            String account_amount = request.getParameter("accountamount");

            PreparedStatement ps = null;
            Statement st = null;
            ResultSet rs = null;

            int roleid = 2;

            try {
                connection = MakeConnection.getConnection();
                logger.debug("Connection:" + connection);
                if (connection != null) {
                    if (accountname != null) {

                        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs = st.executeQuery("select accountid_seq.nextval from dual");
                        if (rs != null) {
                            if (rs.next()) {
                                int nextValue = rs.getInt("nextval");
                                ps = connection.prepareStatement("insert into account (accountid,account_owner,accountname,parentaccount,phone,fax,website,type,industry,employees,annualrevenue,description,billingstreet,billingcity,billingstate,billingzip,billingcountry,shippingstreet,	shippingcity,shippingstate,shippingzip,shippingcountry,createdon,assignedto,duedate,modifiedon,account_amount,roleid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                ps.setInt(1, nextValue);
                                ps.setString(2, StringUtil.fixSqlFieldValue(accountowner));
                                ps.setString(3, StringUtil.fixSqlFieldValue(accountname));
                                ps.setString(4, StringUtil.fixSqlFieldValue(parentaccount));
                                ps.setString(5, StringUtil.fixSqlFieldValue(phone));
                                ps.setString(6, StringUtil.fixSqlFieldValue(fax));
                                ps.setString(7, StringUtil.fixSqlFieldValue(website));
                                ps.setString(8, StringUtil.fixSqlFieldValue(type));
                                ps.setString(9, StringUtil.fixSqlFieldValue(industry));
                                ps.setString(10, StringUtil.fixSqlFieldValue(employees));
                                ps.setString(11, StringUtil.fixSqlFieldValue(annualrevenue));
                                ps.setString(12, StringUtil.fixSqlFieldValue(description));
                                ps.setString(13, StringUtil.fixSqlFieldValue(billingstreet));
                                ps.setString(14, StringUtil.fixSqlFieldValue(billingcity));
                                ps.setString(15, StringUtil.fixSqlFieldValue(billingstate));
                                ps.setString(16, StringUtil.fixSqlFieldValue(billingzip));
                                ps.setString(17, StringUtil.fixSqlFieldValue(billingcountry));
                                ps.setString(18, StringUtil.fixSqlFieldValue(shippingstreet));
                                ps.setString(19, StringUtil.fixSqlFieldValue(shippingcity));
                                ps.setString(20, StringUtil.fixSqlFieldValue(shippingstate));
                                ps.setString(21, StringUtil.fixSqlFieldValue(shippingzip));
                                ps.setString(22, StringUtil.fixSqlFieldValue(shippingcountry));
                                ps.setTimestamp(23, ts);
                                ps.setInt(24, Integer.parseInt(assignedto));
                                ps.setDate(25, java.sql.Date.valueOf(storeDate));
                                ps.setTimestamp(26, ts);
                                ps.setInt(27, Integer.parseInt(account_amount));
                                ps.setInt(28, roleid);
                                ps.executeUpdate();
                                connection.commit();
                                logger.info("Successfully updated!!!");
                            }
                        }
                    }
                }

            } catch (SQLException Ex) {
                logger.error("Exception While Creating new account:" + Ex);
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
        <jsp:forward page="/admin/customer/viewaccount.jsp">
            <jsp:param name="newaccount" value="true" />
            <jsp:param name="accountname" value="<%= accountname%>" />
        </jsp:forward>
        <!-- End of Java Coding -->

    </body>
</html>