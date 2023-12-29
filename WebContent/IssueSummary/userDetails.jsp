<%-- 
    Document   : userDetails
    Created on : 26 Aug, 2011, 6:34:21 AM
    Author     : Tamilvelan
--%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>

<%
    Logger logger = Logger.getLogger("userDetails");
    Connection connection = null;
    Statement stmt1 = null;
    ArrayList<String> al;
    ResultSet rs1 = null;
    String customer = "";
    String totalcustomer = "";
    int count = 0;
    try {
        connection = MakeConnection.getConnection();
        String prod1 = (request.getParameter("product")).trim();
        int uid = (Integer) session.getAttribute("userid_curr");
        int roleId = (Integer) session.getAttribute("Role");
        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

        if (!prod1.equalsIgnoreCase("")) {
            rs1 = stmt1.executeQuery("select distinct u.userid,firstname,lastname from userproject up,project p,users u where p.pid=up.pid and p.pname='" + prod1 + "' and u.userid=up.userid order by firstname");
        } else {
            if (roleId == 1) {
                rs1 = stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT ORDER BY UPPER(CUSTOMER) ASC");
            } else {
                rs1 = stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT WHERE PNAME IN ( SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = " + uid + " ) ORDER BY UPPER(CUSTOMER) ASC");
            }
        }

        al = new ArrayList<String>();
        rs1.last();
        int rowcount = rs1.getRow();
        rs1.beforeFirst();
        totalcustomer = ";";//rowcount+",";
        totalcustomer = totalcustomer.trim();
        if (rowcount >= 2) {
            totalcustomer = totalcustomer + "All Information" + ",";
            count++;
        } else if (rowcount == 0) {
            totalcustomer = totalcustomer + "All Information" + ",";
            count++;
        } else {
            totalcustomer = ";";
        }
        while (rs1.next()) {
            customer = rs1.getString("CUSTOMER");
            totalcustomer = totalcustomer + customer.trim() + ",";
            count++;
        }
        totalcustomer = totalcustomer + count;
        al.add(totalcustomer);
        String f[] = new String[al.size() + 1];
        Object a[] = al.toArray();
        f[0] = (String) a[0];
        // System.out.println(f[0]);
        out.println(f[0]);
        count = 0;
        totalcustomer = ";";
    } catch (ArrayIndexOutOfBoundsException e) {
        logger.error(e.getMessage());
    } finally {
        if (rs1 != null) {
            rs1.close();
        }
        if (stmt1 != null) {
            stmt1.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>

