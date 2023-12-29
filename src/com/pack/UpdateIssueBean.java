package com.pack;

import com.eminent.util.GetProjectMembers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import org.apache.log4j.Logger;

public class UpdateIssueBean {

    Statement st = null;
    ResultSet rs = null;
    PreparedStatement pt = null;
    static Logger logger = Logger.getLogger("UpdateIssueBean");

    public ResultSet Query(Connection connection, String theissu) {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT,amanager, dmanager, pmanager, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result,estimated_time,SAP_ISSUE_TYPE FROM ISSUE I, PROJECT P, MODULES M WHERE I.PID = P.PID  AND MODULEID = MODULE_ID AND ISSUEID='" + theissu + "'");//CHANGED
            ResultSetMetaData rsmd = rs.getMetaData();
            int NoofColumns = rsmd.getColumnCount();
            int i = 0;

            while (i <= NoofColumns) {

                i++;

            }
        } catch (Exception e) {
            logger.error("Query(Connection, String)" + e.getMessage());
        }

        /*			finally
         {
         try{
         if(connection!=null)
         {
         if(st!=null) {
         st.close();
         }
         if(rs!=null) {
         rs.close();
         }
         }
         }
         catch(Exception e){}
         }*/
        return rs;
    }

    public ResultSet Query1(Connection connection) throws SQLException {
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = st.executeQuery("SELECT USERID,FIRSTNAME,LASTNAME  FROM USERS  where roleid>0 ORDER BY FIRSTNAME ASC ");
        return rs;

    }

    public void Query2(Connection connection, String status, String theissu) throws SQLException {
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        st.executeUpdate("update ISSUESTATUS set status='" + status + "' where issueid='" + theissu + "' ");
    }

    public ResultSet Query3(Connection connection, String theissu) throws SQLException {
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = st.executeQuery("SELECT FILEID,FILENAME FROM FILEATTACH WHERE ISSUEID='" + theissu + "' ");//CHANGED
        return rs;
    }

    public ResultSet FixVersion(Connection connection, String prj) {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT version FROM project WHERE pname='" + prj + "' order by version");//CHANGED

        } catch (Exception e) {
            logger.error("FixVersion(Connection, String)" + e.getMessage());
        }
        return rs;
    }

    public ResultSet FixVersionForSAP(Connection connection, String prj, String foundVersion) {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT version FROM project p,project_type t WHERE p.pid=t.pid and pname='" + prj + "'");

        } catch (Exception e) {
            logger.error("FixVersion(Connection, String)" + e.getMessage());
        }
        return rs;
    }

    public HashMap<Integer, String> showUsers(Connection connection) throws SQLException {
        HashMap<Integer, String> hm = new HashMap<Integer, String>();

        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement("Select userid,firstname,lastname from users", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = ps.executeQuery();
            while (rs.next()) {
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");
                lastname = lastname.substring(0, 1);
                lastname = lastname.toUpperCase();
                int userid = rs.getInt("userid");

                Integer userId = userid;//new Integer(userid);

                hm.put(userId, firstname + " " + lastname);
            }
        } catch (Exception e) {
            logger.error("Exception in getUser:" + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return hm;
    }

    public ResultSet myAssignment(Connection connection, int assignedto) {
        try {
            pt = connection.prepareStatement("select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            pt.setInt(1, assignedto);
            rs = pt.executeQuery();

        } catch (Exception e) {
            logger.error("FixVersion(Connection, String)" + e.getMessage());
        }
        return rs;
    }

    public ResultSet myAssignmentByType(Connection connection, int assignedto, String query) {
        try {
            pt = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            pt.setInt(1, assignedto);
            rs = pt.executeQuery();

        } catch (Exception e) {
            logger.error("FixVersion(Connection, String)" + e.getMessage());
        }
        return rs;
    }

    public ResultSet issueSearch(Connection connection, String theissu, int userId) {
        try {
            int adminUserId = 0;
            HashMap<String, String> hm = GetProjectMembers.getAdminDetail();
            if (hm != null) {
                adminUserId = Integer.parseInt("userid");
            }
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (userId != adminUserId) {
                rs = st.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result FROM ISSUE I, PROJECT P, MODULES M,USERPROJECT UP WHERE I.PID = P.PID AND P.PID IN (SELECT P.PID FROM PROJECT P,USERPROJECT UP WHERE P.PID=UP.PID) AND ASSIGNEDTO=UP.USERID AND UP.USERID = '" + userId + "'  AND MODULEID = MODULE_ID AND ISSUEID='" + theissu + "'");//CHANGED
            } else {
                rs = st.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result FROM ISSUE I, PROJECT P, MODULES M,USERPROJECT UP WHERE I.PID = P.PID AND P.PID IN (SELECT P.PID FROM PROJECT P,USERPROJECT UP WHERE P.PID=UP.PID) AND ASSIGNEDTO=UP.USERID AND MODULEID = MODULE_ID AND ISSUEID='" + theissu + "'");//CHANGED
            }

        } catch (Exception e) {
            logger.error("issueSerach(Connection, String,string)" + e.getMessage());
        }

        return rs;
    }

    public void close() throws SQLException {
        if (st != null) {
            st.close();
        }
        if (pt != null) {
            pt.close();
        }
        logger.debug("Closing JDBC resources in close()");
    }
}
