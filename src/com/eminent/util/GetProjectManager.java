package com.eminent.util;

import static com.eminent.util.GetProjects.logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import pack.eminent.encryption.MakeConnection;

public class GetProjectManager {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("GetProjectManager");

    }

    public static String getProjects(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pname = null, projects = null;

        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT distinct PNAME FROM PROJECT P, USERPROJECT U where USERID = " + userId + " AND P.PID = U.PID AND STATUS != 'Finished' ORDER BY PNAME ASC");
            while (resultset.next()) {
                pname = resultset.getString(1);
                if (count == 0) {
                    projects = pname;
                } else {
                    projects = projects + "," + pname;
                }

                count++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return projects;

    }

    public static HashMap<String, String> getProjects() {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid,pname,version from project where status not like 'Finished'");

            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2) + " " + resultset.getString(3);
                member.put(id, name);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return member;

    }

    public static HashMap<String, String> getUserProjects(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();
            //edit by mukesh query only
            resultset = statement.executeQuery("SELECT P.PID,P.PNAME as project,P.VERSION FROM PROJECT P, USERPROJECT U where USERID = " + userId + " AND P.PID = U.PID AND status in('Work in progress','To be started') and pmanager!=104 order by upper(project) asc,version asc");
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2) + " " + resultset.getString(3);
                member.put(id, name);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return member;

    }

    public static List getManagingProjects(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap<String, String>();
        List l = new ArrayList<Integer>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();

            resultset = statement.executeQuery("SELECT P.PID,P.PNAME as project,P.VERSION FROM PROJECT P where (PMANAGER = " + userId + " OR DMANAGER = " + userId + " OR AMANAGER = " + userId + " OR SPONSORER = " + userId + " OR STAKEHOLDER = " + userId + " OR COORDINATOR = " + userId + ") AND status != 'Finished' order by upper(project) asc,version asc");
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2) + " " + resultset.getString(3);
                member.put(id, name);
                l.add(Integer.parseInt(id));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return l;

    }

    public static List getAssignedProjects(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap<String, String>();
        List l = new ArrayList<Integer>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();

            resultset = statement.executeQuery("SELECT P.PID,P.PNAME as project,P.VERSION FROM PROJECT P, USERPROJECT U where USERID = " + userId + " AND P.PID = U.PID AND status != 'Finished' order by upper(project) asc,version asc");
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2) + " " + resultset.getString(3);
                member.put(id, name);
                l.add(Integer.parseInt(id));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return l;

    }

    public static String getManager(String projectName, String version) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pmanager = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pmanager from project where project.pname='" + projectName + "'and version='" + version + "'");
            while (resultset.next()) {
                pmanager = resultset.getString(1);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return pmanager;

    }

    public static String getDManager(String projectName, String version) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pmanager = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select dmanager from project where project.pname='" + projectName + "'and version='" + version + "'");
            while (resultset.next()) {
                pmanager = resultset.getString(1);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return pmanager;

    }

    // Fetching the user name(First name with Initial) with the help of user id 
    public static String getUserName(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String userName = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select firstname,lastname from users where userid = " + userId);
            while (resultset.next()) {
                String firstname = resultset.getString("firstname");
                String lastname = resultset.getString("lastname");
                lastname = lastname.substring(0, 1);
                lastname = lastname.toUpperCase();
                userName = firstname + " " + lastname;

            }

        } catch (Exception e) {
            logger.error("Error while fetching the user name : " + e.getMessage());
        } finally {
            try {

                if (statement != null) {
//					logger.info("closing Statement");
                    statement.close();
                }
                if (resultset != null) {
//					logger.info("closing resultset");
                    resultset.close();
                }
                if (connection != null) {
//					logger.info("closing Connection");
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while fetching the user name : " + ex.getMessage());
            }
        }

        return userName;

    }

    public static String getUserDesignation(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String userName = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select designation from users where userid = " + userId);
            while (resultset.next()) {

                userName = resultset.getString(1);

            }

        } catch (Exception e) {
            logger.error("Error while fetching the user name : " + e.getMessage());
        } finally {
            try {

                if (statement != null) {
//					logger.info("closing Statement");
                    statement.close();
                }
                if (resultset != null) {
//					logger.info("closing resultset");
                    resultset.close();
                }
                if (connection != null) {
//					logger.info("closing Connection");
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while fetching the user name : " + ex.getMessage());
            }
        }

        return userName;

    }

    // Fetching the user name with the help of user id
    public static String getUserFullName(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String userName = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select firstname||' '||lastname as name from users where userid = " + userId);
            while (resultset.next()) {

                userName = resultset.getString("name");

            }

        } catch (Exception e) {
            logger.error("Error while fetching the user name : " + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
//					logger.info("closing resultset");
                    resultset.close();
                }
                if (statement != null) {
//					logger.info("closing statement");
                    statement.close();
                }
                if (connection != null) {
//					logger.info("closing Connection");
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while fetching the user name : " + ex.getMessage());
            }
        }

        return userName;

    }

    public static int checkProjectManager(String userId) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select count(*) from project where pmanager='" + userId + "' and status!='Finished'");

            rs = ps.executeQuery();
            if (rs != null) {
                rs.next();
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return count;
    }

    public static List<Integer> findMomProjectManagers(String users) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Integer> pmanagers = new ArrayList<Integer>();
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select distinct(pmanager) from project where pmanager in (" + users + ") and status!='Finished'");

            rs = ps.executeQuery();
            while (rs.next()) {
                pmanagers.add(rs.getInt(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return pmanagers;
    }

    public static List<Integer> findProjectManagersFromIssueComments(String monthYear) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Integer> pmanagers = new ArrayList<Integer>();
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            String query = "select distinct(ic.COMMENTEDTO) from ISSUECOMMENTS ic,(select min(comment_date) as commentDate,issueId as issueID from ISSUECOMMENTS where status in ('Unconfirmed','Solution Review') and to_char(comment_date,'Mon-YYYY')='" + monthYear + "' group by issueid,status) fil  where ic.issueId=fil.issueID and ic.comment_date=fil.commentDate";
            System.out.println(query);
            ps = connection.prepareStatement(query);

            rs = ps.executeQuery();
            while (rs.next()) {
                pmanagers.add(rs.getInt(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return pmanagers;
    }

    public static List<String> getProjectNameByPmDM(int userid) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        List<String> projects = new ArrayList();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT pname FROM EMINENTTRACKER.PROJECT WHERE pmanager=" + userid + " or dmanager=" + userid + "  and status not like 'Finished'");
            while (resultset.next()) {
                if (!projects.contains(resultset.getString(1))) {
                    projects.add(resultset.getString(1));
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return projects;

    }
    public static List<Integer> getPMWorkingInProgressProjects() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        List<Integer> projectdetails = new ArrayList<>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select distinct(pmanager)  from project p where status='Work in progress' and pmanager!=104 ");
            while (resultset.next()) {
                projectdetails.add(resultset.getInt(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return projectdetails;

    }
    public static int getProjectManagerByPID(int pid) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        int pmanager = 0;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select pmanager from project where pid=" + pid + "");

            rs = ps.executeQuery();
            if (rs != null) {
                rs.next();
                pmanager = rs.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return pmanager;
    }
    public static int checkProjectManagerFromWRM(int userId, String startDate, String endDate) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select count(*) from mom_for_client where pmanager=" + userId + " and TO_DATE(TO_CHAR(HELD_ON,'DD-MM-YYYY'),'DD-MM-YYYY') BETWEEN  '" + startDate + "' and '" + endDate + "'");
            rs = ps.executeQuery();
            if (rs != null) {
                rs.next();
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return count;
    }
    public static Map<Integer, String> getWIPProjects() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> member = new HashMap<Integer, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select p.pid,CONCAT(CONCAT(p.pname,' v'),p.version) pname  from project p where status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate");
            while (resultset.next()) {
                member.put(resultset.getInt(1), resultset.getString(2));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return member;
    }
    public static Map<Integer, List<String>> getBasisMembersByProjects() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, List<String>> member = new HashMap<Integer, List<String>>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select p.pid,u.userid||'-'||firstname||' '||lastname  from project p,users u,USERPROJECT up where p.PID=up.PID and u.USERID=up.USERID and status='Work in progress' and category='SAP Project' and pmanager!=104 and u.TEAM='BASIS' and u.ROLEID>0 order by p.PID,u.FIRSTNAME");
            while (resultset.next()) {
                List<String> list = member.get(resultset.getInt(1));
                if (list == null) {
                    list = new ArrayList<>();
                }
                list.add(resultset.getString(2));
                member.put(resultset.getInt(1), list);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return member;
    }
    public static Set<Integer> getPMnDMByPID(int pid) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        Set<Integer> pmanager = new HashSet<>();
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select pmanager,DMANAGER from project where pid=" + pid + "");

            rs = ps.executeQuery();
            if (rs != null) {
                rs.next();
                pmanager.add(rs.getInt(1));
                pmanager.add(rs.getInt(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return pmanager;
    }
    public static Map<Long, String> getWIPProjectsByBranch(int branch) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Long, String> member = new HashMap<Long, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            if (branch > 0) {//and u.branch_id=" + branchId + " 
                resultset = statement.executeQuery("select pid,CONCAT(pname ,CONCAT(' v',version))as project,pmanager from project p,users u where u.userid=p.pmanager and  u.branch_id=" + branch + " and status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate");
            } else {
                resultset = statement.executeQuery("select pid,CONCAT(pname ,CONCAT(' v',version))as project,pmanager from project p,users u where u.userid=p.pmanager and status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate");
            }
            while (resultset.next()) {
                member.put(resultset.getLong(1), resultset.getString(2)+"--"+resultset.getInt(3));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return member;
    }

}