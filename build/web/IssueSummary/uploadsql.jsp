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
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <script type="text/javascript">
        function refreshLeft() {
            alert('refresh');
            parent.treeframe.location.reload();
        }
    </script>
</head>
<body onload="javascript;refreshLeft();">
    <%@ page autoFlush="true" buffer="1094kb"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>

    <%@ include file="../header.jsp"%>

    <%
        Logger logger = Logger.getLogger("uploadsql");

        Connection connection = null;
        Statement stmt1 = null, stmt = null;
        Statement stmt2 = null;
        ResultSet rs = null, resultSet1 = null, resultSet2 = null;
        Statement st = null;
        ResultSet rs_query = null;
        int query_id = 0;
        try {

            String queryname = request.getParameter("queryname");
            String description = request.getParameter("description");
            String querystring = request.getParameter("querystring");
            String issuedayHistory = request.getParameter("issuedayHistory");
            String issueRating = request.getParameter("issuerating");
            String query_name = (String) session.getAttribute("query_name");
            if (session.getAttribute("query_id") != null) {
                query_id = (Integer) session.getAttribute("query_id");
            }

            if (issuedayHistory == null || issuedayHistory.isEmpty() || issuedayHistory.equalsIgnoreCase("")) {
                issuedayHistory = "no";
            }
            connection = MakeConnection.getConnection();
            stmt1 = connection.createStatement();
            stmt2 = connection.createStatement();
            //stmt3	= connection.createStatement();
            st = connection.createStatement();
            if (query_name != null) {
                String description_ses = (String) session.getAttribute("description");
                PreparedStatement preparedStatement2 = connection.prepareStatement("update myquery set query_string=?,name=?,description=?,ISSUEDAYHISTORY=?,ISSUERATING=? where query_id=?");
                preparedStatement2.setString(1, querystring);
                preparedStatement2.setString(2, queryname);
                preparedStatement2.setString(3, description);
                preparedStatement2.setString(4, issuedayHistory);
                preparedStatement2.setString(5, issueRating);
                preparedStatement2.setInt(6, query_id);
                preparedStatement2.executeUpdate();
                connection.commit();

    %>

    <jsp:forward page="../MyQuery/MyQueryView.jsp">
        <jsp:param name="uploadsql" value="<%= query_name%>" />
        <jsp:param name="Updated" value="Updated" />
    </jsp:forward>
    <%

        }
        String mail = (String) session.getAttribute("theName");

        //rs_query = st.executeQuery("select name from myquery");
        rs_query = st.executeQuery("select upper(name) as name from myquery where email='" + mail + "'");
        while (rs_query.next()) {
            String str1 = rs_query.getString("name");
            if (str1.equals(queryname.trim().toUpperCase())) {

    %>
    <jsp:forward page="IssueSummarySave.jsp">
        <jsp:param name="querystatus" value="true" />
        <jsp:param name="description" value="<%= description%>" />
        <jsp:param name="queryname" value="<%= queryname%>" />
    </jsp:forward>
    <%
            }

        }

        Date date1;
        resultSet1 = stmt1.executeQuery("select queryid_seq.nextval from dual");
        if (resultSet1 != null) {
            while (resultSet1.next()) {
                String st2 = resultSet1.getString("nextval");
                int st1 = Integer.parseInt(st2);
                int i = ((Integer) session.getAttribute("uid")).intValue();

                resultSet2 = stmt2.executeQuery("select email from users where userid='" + i + "'");
                String email = "";
                if (resultSet2.next()) {
                    email = resultSet2.getString("email");
                }
                stmt = connection.createStatement();
                rs = stmt.executeQuery("SELECT DISTINCT CURRENT_DATE FROM DUAL");
                if (rs != null) {

                    while (rs.next()) {
                        try {
                            date1 = rs.getDate("CURRENT_DATE");
                            PreparedStatement preparedStatement1 = connection.prepareStatement("insert into myquery(query_id,name,description,query_string,email,createdon,search_type,ISSUEDAYHISTORY,ISSUERATING) values(?,?,?,?,?,?,?,?,?)");
                            preparedStatement1.setInt(1, st1);
                            preparedStatement1.setString(2, queryname);
                            preparedStatement1.setString(3, description);
                            preparedStatement1.setString(4, querystring);
                            preparedStatement1.setString(5, email);
                            preparedStatement1.setDate(6, date1);
                            preparedStatement1.setString(7, "APM");
                            preparedStatement1.setString(8, issuedayHistory);
                            preparedStatement1.setString(9, issueRating);
                            preparedStatement1.executeUpdate();
                            connection.commit();
                        } catch (Exception e) {
                            logger.error(e);
                        }
    %>

    <jsp:forward page="../MyQuery/MyQueryView.jsp">
        <jsp:param name="saveView" value="<%= queryname%>" />
        <jsp:param name="updated" value="Saved" />

    </jsp:forward>
    <%
                        }

                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {

            if (stmt != null) {
                stmt.close();
            }
            if (stmt1 != null) {
                stmt1.close();
            }
            if (stmt2 != null) {
                stmt2.close();
            }

            if (rs != null) {
                rs.close();
            }
            if (resultSet1 != null) {
                resultSet1.close();
            }
            if (resultSet2 != null) {
                resultSet2.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    %>

</body>

</html>