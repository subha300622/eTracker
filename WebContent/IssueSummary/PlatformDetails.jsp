<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%! Connection connection;
    Statement stmt1;
    ArrayList<String> al;
    ResultSet rs1 = null;
    String platform = "";
    String totalplatform = "";
    int count = 0;
%>
<%Logger logger = Logger.getLogger("PlatformDetails");
    String cus4 = "";
    Integer current_userId = (Integer) session.getAttribute("userid_curr");
    String cus[] = request.getParameter("customer").split(",");
    String prod[] = (request.getParameter("product").split(","));
    String prod4 = "";
    for (int i = 0; i < prod.length; i++) {
        prod4 = prod4 + "'" + prod[i].trim() + "',";
    }
    if (prod4.length() > 3) {
        prod4 = prod4.substring(0, prod4.length() - 1);
    } else {
        prod4 = "'All Information'";
    }
    for (int i = 0; i < cus.length; i++) {
        cus4 = cus4 + "'" + cus[i].trim() + "',";
    }
    if (cus4.length() > 3) {
        cus4 = cus4.substring(0, cus4.length() - 1);
    } else {
        cus4 = "'All Information'";
    }
    String found_versiona[] = request.getParameter("version").trim().split(",");
    String ver4 = "";
    for (int i = 0; i < found_versiona.length; i++) {
        ver4 = ver4 + "'" + found_versiona[i].trim() + "',";
    }
    if (ver4.length() > 3) {
        ver4 = ver4.substring(0, ver4.length() - 1);
    } else {
        ver4 = "'All Information'";
    }
    try {
       
        connection = MakeConnection.getConnection();
        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
         /*edit by sowjanya*/
        if (cus4.equals("'All Information'") && prod4.equals("'All Information'") && ver4.equals("'All Information'")) {
            rs1 = stmt1.executeQuery("SELECT DISTINCT PLATFORM FROM PROJECT where pid in(select pid from userproject where userid=" + current_userId + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (!(cus4.equals("'All Information'")) && !(prod4.equals("'All Information'")) && ver4.equals("'All Information'")) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE CUSTOMER in (" + cus4 + ") and PNAME in (" + prod4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (!(cus4.equals("'All Information'")) && (!prod4.equals("'All Information'")) && !(ver4.equals("'All Information'"))) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE CUSTOMER in(" + cus4 + ") and PNAME in (" + prod4 + ") and version in (" + ver4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (!(cus4.equals("'All Information'")) && prod4.equals("'All Information'") && !(ver4.equals("'All Information'"))) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE CUSTOMER in (" + cus4 + ") and version in (" + ver4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (cus4.equals("'All Information'") && !(prod4.equals("'All Information'")) && !(ver4.equals("'All Information'"))) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE PNAME in(" + prod4 + ") and version in (" + ver4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (!(cus4.equals("'All Information'")) && prod4.equals("'All Information'") && ver4.equals("'All Information'")) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE CUSTOMER in (" + cus4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (cus4.equals("'All Information'") && !(prod4.equals("'All Information'")) && ver4.equals("'All Information'")) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE PNAME in(" + prod4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        } else if (cus4.equals("'All Information'") && prod4.equals("'All Information'") && !(ver4.equals("'All Information'"))) {
            rs1 = stmt1.executeQuery("SELECT PLATFORM FROM PROJECT WHERE version in (" + ver4 + ") GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
        }
 /*edit by sowjanya*/
        al = new ArrayList<String>();
        rs1.last();
        int rowcount = rs1.getRow();
        rs1.beforeFirst();

        totalplatform = ";";//rowcount+",";
        totalplatform = totalplatform.trim();
        if (rowcount >= 2) {
            totalplatform = totalplatform + "All Information" + ",";
            count++;
        } else if (rowcount == 0) {
            totalplatform = totalplatform + "All Information" + ",";
            count++;
        } else {
            totalplatform = ";";
        }
        while (rs1.next()) {
            platform = rs1.getString("PLATFORM");
            totalplatform = totalplatform + platform.trim() + ",";
            count++;
        }
        totalplatform = totalplatform + count;
        al.add(totalplatform);
        String f[] = new String[al.size() + 1];
        Object a[] = al.toArray();
        f[0] = (String) a[0];

        out.println(f[0]);
        count = 0;
        totalplatform = ";";
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