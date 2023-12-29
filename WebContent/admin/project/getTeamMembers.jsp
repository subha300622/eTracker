<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%Logger logger = Logger.getLogger("getTeamMembers");
    Connection connection = null;
    Statement stmt1 = null;
    ArrayList<String> al;
    ResultSet rs1 = null;
    int rowcount = 0,pid,count=0;
    String sql = "", sql1 = "",domain = "",totalteam = ";",token = "";
    //Edit By sowjanya
    String sql_default = "";
    String domainValues[] = null;
    try {
        pid = Integer.parseInt(request.getParameter("pid"));
        token = request.getParameter("selValue");
        al = new ArrayList<String>();
        String domaina = request.getParameter("domainValues");
        connection = MakeConnection.getConnection();
        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        sql_default = "select firstname,lastname,u.userid from userproject up, project p,users u  where up.pid=p.pid and p.pid=" + pid + " and u.userid=up.userid and u.roleid>0 and team='" + token + "' union  select firstname,lastname,userid from users where roleid>0 and email like '%eminentlabs.net' and team='" + token + "'  ORDER BY firstname asc";

        if (domaina == null || domaina.equals("")) {
            sql = sql_default;

        } else {
            domainValues = domaina.split(",");
            String domain1 = "";
            for (int i = 0; i < domainValues.length; i++) {

                domain = " email like '%" + domainValues[i].trim() + "'" + " or";
                domain1 = domain + domain1;

            }
            sql1 = "SELECT distinct firstname,lastname,userid FROM users where team='" + token + "' and roleid>0  and (" + domain1.substring(0, domain1.length() - 2) + ")";
            sql = sql1 + " union " + sql_default;
        }
        rs1 = stmt1.executeQuery(sql);
        //Edit End by sowjanya
        rs1.last();
        rowcount = rs1.getRow();
        rs1.beforeFirst();
        while (rs1.next()) {
            count++;
            totalteam = totalteam + rs1.getString("firstname") + " " + rs1.getString("lastname") + "," + rs1.getInt("userid") + ";";
        }
        totalteam = totalteam.substring(1, totalteam.length());
        al.add(totalteam);

        String f[] = new String[al.size() + 1];
        Object a[] = al.toArray();
        f[0] = (String) a[0];
        out.println(f[0]);
        rowcount = 0;
        count = 0;
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

