<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%! Connection connection;
    Statement stmt1;
    ArrayList<String> al;
    ResultSet rs1 = null;
    String version = "";
    String totalversion = "";
    int count = 0;
%>
<%Logger logger = Logger.getLogger("VersionDetails");
    String cus2 = "";
    String cus[] = request.getParameter("customer").split(",");
    String prod[] = (request.getParameter("product").split(","));
    Integer current_userId = (Integer) session.getAttribute("userid_curr");
    String prod2 = "";
    
    for (int i = 0; i < prod.length; i++) {
        prod2 = prod2 + "'" + prod[i].trim() + "',";
    }
    if (prod2.length() > 3) {
        prod2 = prod2.substring(0, prod2.length() - 1);
    } else {
        prod2 = "'All Information'";
    }
    for (int i = 0; i < cus.length; i++) {
        cus2 = cus2 + "'" + cus[i].trim() + "',";
    }
    if (cus2.length() > 3) {
        cus2 = cus2.substring(0, cus2.length() - 1);
    } else {
        cus2 = "'All Information'";
    }
    try {
        connection = MakeConnection.getConnection();

        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        /*edit by sowjanya*/
        if (current_userId != 104) {
            if (prod2.equals("'All Information'") && cus2.equals("'All Information'")) {

                rs1 = stmt1.executeQuery("select distinct  version from project where pname in(select p.pname  from project p,userproject up where up.pid=p.pid and up.userid=" + current_userId + ") and pid in(select pid from userproject where userid=" + current_userId + ")ORDER By version ");
            } else if (!(cus2.equals("'All Information'")) && (prod2.equals("'All Information'"))) {

                rs1 = stmt1.executeQuery("select DISTINCT VERSION from PROJECT where customer in(" + cus2 + ") and pid in(select pid from userproject where userid=" + current_userId + ")ORDER By version ");
            } else if (!(cus2.equals("'All Information'")) && !(prod2.equals("'All Information'"))) {

                rs1 = stmt1.executeQuery("select DISTINCT VERSION from PROJECT where customer in(" + cus2 + ") and pname in(" + prod2 + ") and pid in(select pid from userproject where userid=" + current_userId + ") ORDER By version ");
            } else if (cus2.equals("'All Information'") && !(prod2.equals("'All Information'"))) {

                rs1 = stmt1.executeQuery("select DISTINCT VERSION from PROJECT where pname in(" + prod2 + ") and pid in(select pid from userproject where userid=" + current_userId + ")ORDER By version ");
            }
        } else {
            if (prod2.equals("'All Information'") && cus2.equals("'All Information'")) {
                // rs1 = stmt1.executeQuery("SELECT DISTINCT VERSION  FROM PROJECT,USERPROJECT where  pid in(select pid from userproject where userid="+current_userId+")");
                rs1 = stmt1.executeQuery("select distinct  version from project where pname in(select p.pname  from project p,userproject up where up.pid=p.pid ) ORDER By version");
            } else if (!(cus2.equals("'All Information'")) && (prod2.equals("'All Information'"))) {
                rs1 = stmt1.executeQuery("select DISTINCT VERSION from PROJECT where customer in(" + cus2 + ") ORDER By version");
            } else if (!(cus2.equals("'All Information'")) && !(prod2.equals("'All Information'"))) {
                rs1 = stmt1.executeQuery("select DISTINCT VERSION from PROJECT where customer in(" + cus2 + ") and pname in(" + prod2 + ") ORDER By version");
            } else if (cus2.equals("'All Information'") && !(prod2.equals("'All Information'"))) {
                rs1 = stmt1.executeQuery("select DISTINCT VERSION from PROJECT where pname in(" + prod2 + ") ORDER By version");
            }
        }
        /*edit by sowjanya*/
        al = new ArrayList<String>();
        rs1.last();
        int rowcount = rs1.getRow();
        rs1.beforeFirst();
        totalversion = ";";//rowcount+",";
        totalversion = totalversion.trim();
        if (rowcount >= 2) {
            totalversion = totalversion + "All Information" + ",";
            count++;
        } else if (rowcount == 0) {
            totalversion = totalversion + "All Information" + ",";
            count++;
        } else {
            totalversion = totalversion + "All Information" + ",";
             count++;
        }
        while (rs1.next()) {
            version = rs1.getString("VERSION");
            totalversion = totalversion + version.trim() + ",";
            count++;
        }
        totalversion = totalversion + count;
        al.add(totalversion);
        String f[] = new String[al.size() + 1];
        Object a[] = al.toArray();
        f[0] = (String) a[0];
        out.println(f[0]);
        count = 0;
        totalversion = ";";
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