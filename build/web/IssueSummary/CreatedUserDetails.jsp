<%@page import="com.eminent.issue.ApmTeam"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"></jsp:useBean>

<%! Connection connection;
    Statement stmt1;
    ResultSet rs1;
    ArrayList<String> al;
    String created = "";
    String totalcreated = "", totalassigned = "", assigned = "";%>
<%Logger logger = Logger.getLogger("CreatedUserDetails");
    try {
        connection = MakeConnection.getConnection();
        String prod[] = (request.getParameter("product").split(","));
        String prod1 = "";
        for (int i = 0; i < prod.length; i++) {
            prod1 = prod1 + "'" + prod[i].trim() + "',";
        }
        if (prod1.length() > 3) {
            prod1 = prod1.substring(0, prod1.length() - 1);
        } else {
            prod1 = "'All Information'";
        }
         /*edit by sowjanya*/
        if (prod1.equals("'All Information'")) {
             stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs1 = stmt1.executeQuery("select distinct firstname,lastname,createdby from users,issue where to_char(userid) = createdby order by firstname");
        } else { /*edit by sowjanya*/
            stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs1 = stmt1.executeQuery("select distinct firstname,lastname,createdby from users,issue,project where to_char(userid) = createdby and project.pid=issue.pid and project.pname in (" + prod1 + ") order by firstname");
        } 
            al = new ArrayList<String>();
        rs1.last();
        int rowcount = rs1.getRow();
        rs1.beforeFirst();
        totalassigned = rowcount + ",";
        while (rs1.next()) {
            assigned = rs1.getString("createdby") + "--" + rs1.getString("firstname") + " " + rs1.getString("lastname");
            totalassigned = totalassigned + assigned.trim() + ",";
        }
         for (ApmTeam apmTeam : atc.findAllTeams()) {                                               
            assigned = apmTeam.getTeamName() + "-TEAM --" + apmTeam.getTeamName();
            totalassigned = totalassigned + assigned.trim() + ",";                                    
          }
        al.add(totalassigned);
        String f[] = new String[al.size() + 1];
        Object a[] = al.toArray();
        f[0] = (String) a[0];
        //  System.out.println(f[0]);
        out.println(f[0]);
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