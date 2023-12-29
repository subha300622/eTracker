package com.eminent.util;

import com.eminentlabs.dao.DAOFactory;
import com.pack.ApmTargetIssueCount;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import pack.eminent.encryption.MakeConnection;

public class GetProjects {
    
    static org.apache.log4j.Logger logger = null;
    
    static {
        logger = org.apache.log4j.Logger.getLogger("GetProjects");
    }
//Getting Assigned projects for a PM

    public static HashMap<String, String> getProjects(String pmanager) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        
        HashMap<String, String> member = new HashMap<String, String>();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid,pname from project where  pmanager=" + pmanager + " and status!='Finished' and phase!='Closed' and phase!='Suspended' order by UPPER(PNAME) ASC");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                name = getProjectName(id);
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
    
    public static String getProject(int pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        String name = null;
        String version = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pname from project where  pid=" + pid);
            
            while (resultset.next()) {
                
                name = resultset.getString(1);
                
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
        
        return name;
    }
    
    public static String getProjectName(String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        String name = null;
        String version = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pname,version from project where  pid=" + pid);
            
            while (resultset.next()) {
                
                name = resultset.getString(1);
                version = resultset.getString(2);
                
                name = name + ":" + version;
                
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
        
        return name;
    }
    
    public static String getProjectId(String projectVersion) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int index = 0;
        String name = "null";
        if (projectVersion != null) {
            index = projectVersion.lastIndexOf(":");
        }
        
        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid from project where  pname='" + project + "' and version='" + version + "'");
            
            while (resultset.next()) {
                
                name = resultset.getString(1);
                
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
        
        return name;
    }
    
    public static HashMap<String, String> getModules(String pId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        
        HashMap<String, String> member = new HashMap<String, String>();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("Select moduleid,module from modules where pid='" + pId + "'");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                
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
//Add Method to get Module name

    public static String getModuleName(String mid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        String name = null;
        String version = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select module from modules where  moduleid=" + mid);
            
            while (resultset.next()) {
                
                name = resultset.getString(1);
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
        
        return name;
    }

//Add Method to get all projects to assign it to user when admin create a user
    public static HashMap<String, String> getAllProjects() {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        String version = null;
        String pnameversion = null;
        
        HashMap<String, String> projectdetails = new HashMap<String, String>();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid,pname,version from project order by UPPER(PNAME) ASC");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                version = resultset.getString(3);
                pnameversion = name + ":" + version;
                projectdetails.put(id, pnameversion);
                
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
    
    public static String getProjectDetails(String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        String name = null;
        String version = null;
        String category = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pname,version,category from project where  pid=" + pid);
            
            while (resultset.next()) {
                
                name = resultset.getString(1);
                version = resultset.getString(2);
                category = resultset.getString(3);
                
                name = category + " " + name + ":" + version;
                
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
        
        return name;
    }
    
    public static String getCustomer(int projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String customer = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select customer from project where  pid=" + projectId);
            while (resultset.next()) {
                customer = resultset.getString(1);
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
        return customer;
    }
    
    public static String[] getCustomer() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        String customer[] = new String[7];
        String version = null;
        String category = null;
        int row = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resultset = statement.executeQuery("select accountname from account order by accountname asc");
            resultset.last();
            row = resultset.getRow();
            String name[] = new String[row];
            int i = 0;
            resultset.beforeFirst();
            while (resultset.next()) {
                name[i] = resultset.getString(1);
                i++;
            }
            customer = name;
            
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
        
        return customer;
    }
    
    public static ArrayList showEmailAlers(int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pid = null;
        String pname = null;
        String version = null;
        String alert = null;
        String total = null;
        ArrayList al = new ArrayList<String>();
        int row = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resultset = statement.executeQuery("select distinct a.project, pname,version, alert from project p,apm_projectalerts a where p.pid=a.project and status!='Finished' and phase!='Suspended' and a.manager=" + userId + " and (dmanager=" + userId + " or amanager=" + userId + " or sponsorer = " + userId + " or stakeholder = " + userId + " or coordinator=" + userId + ")");
            resultset.last();
            row = resultset.getRow();
            String name[] = new String[row];
            int i = 0;
            resultset.beforeFirst();
            while (resultset.next()) {
                pid = resultset.getString(1);
                pname = resultset.getString(2);
                version = resultset.getString(3);
                alert = resultset.getString(4);
                
                total = pid + ":" + pname + " v" + version + ":" + alert;
                al.add(total);
                
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
        return al;
    }
    
    public static String getProjectCategory(String Name) {
        String type = "None";
        String category = "None";
        String name = "None";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resultset = statement.executeQuery("select category,type from project p left join project_type t on t.pid=p.pid where upper(pname)=upper('" + Name + "')");
            if (resultset.next()) {
                category = resultset.getString(1);
                type = resultset.getString(2);
            }
            name = category + ":" + type;
            
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
        return name;
    }
    
    public static String getProjectCategory(String Name, String version) {
        String type = "None";
        String category = "None";
        String name = "None";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        int row = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resultset = statement.executeQuery("select category,type from project p left join project_type t on t.pid=p.pid where upper(pname)=upper('" + Name + "') and version='" + version + "'");
            if (resultset.next()) {
                category = resultset.getString(1);
                type = resultset.getString(2);
            }
            name = category + ":" + type;
            
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
        return name;
    }
    
    public static ArrayList userEmailAlers(int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pid = null;
        ArrayList al = new ArrayList<String>();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resultset = statement.executeQuery("select project from apm_projectalerts where manager='" + userId + "'");
            while (resultset.next()) {
                pid = resultset.getString(1);
                
                al.add(pid);
                
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
        return al;
    }
    
    public static HashMap<String, String> getTestPlan(String pId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        
        HashMap<String, String> plan = new HashMap<String, String>();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select tepid,planname from tqm_testcaseexecutionplan where statusid not in (2,3) and pid='" + pId + "'");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                
                plan.put(id, name);
                
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
        
        return plan;
        
    }
    
    public static String[][] phaseDates(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = "select phase,plannedstartdate,actualstartdate,plannedenddate,actualenddate,totalhours from apm_phasedate where pid=" + projectId;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 6;
            
            String issues[][] = new String[rowcount][column];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);
                issues[i][3] = resultset.getString(4);
                issues[i][4] = resultset.getString(5);
                issues[i][5] = resultset.getString(6);
                
                i++;
                
            }
            total = issues;
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
        return total;
    }
    
    public static LinkedHashMap<Integer, String> getProjectPhases(String type) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id = 0;
        String name = null;
        String sql = null;
        
        LinkedHashMap<Integer, String> member = new LinkedHashMap<Integer, String>();
        
        try {
            connection = MakeConnection.getConnection();
            if (type.equalsIgnoreCase("Implementation")) {
                sql = "select distinct phaseindex,phase from PROJECT_IMPLEMENTATION order by phaseindex";
            } else if (type.equalsIgnoreCase("Support")) {
                sql = "select distinct phaseindex,phase from PROJECT_SUPPORT order by phaseindex";
            } else {
                sql = "select distinct phaseindex,phase from PROJECT_UPGRADATION order by phaseindex";
            }
            statement = connection.createStatement();
            resultset = statement.executeQuery(sql);
            
            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(2);
                
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
    
    public static void updateEndPhasedate(int pId, String phase) {
        Connection connection = null;
        PreparedStatement prepareSt = null;
        try {
            connection = MakeConnection.getConnection();
            prepareSt = connection.prepareStatement("update apm_phasedate set actualenddate=? where phase=? and pid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            prepareSt.setTimestamp(1, date);
            prepareSt.setString(2, phase);
            prepareSt.setInt(3, pId);
            prepareSt.executeUpdate();
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (prepareSt != null) {
                try {
                    prepareSt.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
    }
    
    public static void updateStartPhasedate(int pId, String phase) {
        Connection connection = null;
        PreparedStatement prepareSt = null;
        try {
            connection = MakeConnection.getConnection();
            prepareSt = connection.prepareStatement("update apm_phasedate set actualstartdate=? where phase=? and pid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            prepareSt.setTimestamp(1, date);
            prepareSt.setString(2, phase);
            prepareSt.setInt(3, pId);
            prepareSt.executeUpdate();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (prepareSt != null) {
                try {
                    prepareSt.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
    }
    
    public static void updateTargetCount(ApmTargetIssueCount atc) {
        long id = 0l;
        ApmTargetIssueCount fau = getTargetCount(atc.getPid());
        if (fau != null) {
            id = fau.getTid();
        }
        if (id == 0l) {
            DAOFactory.addTargetCount(atc);
        } else {
            atc.setTid(id);
            DAOFactory.updateTargetCount(atc);
        }
    }
    
    public static ApmTargetIssueCount getTargetCount(int pid) {
        ApmTargetIssueCount atic = new ApmTargetIssueCount();
        Calendar cal = new GregorianCalendar();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        String months = leadingZeros(2, month + "");
        String monthYear = months + "-" + year;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = "select * from APM_TARGET_ISSUE_COUNT where pid=" + pid + " and to_char(TARGET_DATE, 'MM-yyyy') = '" + monthYear + "'";
        logger.info(" Query :" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            resultset = statement.executeQuery(sql);
            
            while (resultset.next()) {
                atic.setTid(resultset.getLong("TID"));
                atic.setPid(resultset.getInt("PID"));
                atic.setCount(resultset.getInt("COUNT"));
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
        return atic;
    }
    
    public static String leadingZeros(int digits, String num) {
        String format = String.format("%%0%dd", digits);
        String result = String.format(format, Integer.parseInt(num));
        return result;
    }
    
    public static int getOpenIssues(int pid) {
        int count = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = "select count(*) as count  from issue i,issuestatus s, project p where i.issueid = s.issueid and i.pid = p.pid  and s.status!='Closed' and p.pid = " + pid;
        logger.info(" Query :" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                count = resultset.getInt("count");
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
        return count;
    }

    public static HashMap<String, String> getWorkingInProgressProjects() {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        String version = null;
        String idversion = null;
        
        HashMap<String, String> projectdetails = new HashMap<String, String>();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select PID,PNAME,VERSION from project where status ='Work in progress' order by VERSION desc ");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                version = resultset.getString(3);
                idversion = id + ":" + version;
                projectdetails.put(name, idversion);
                
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
    
    public static List<Project> getPMandDMForWorkingInProgressProjects() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        List<Project> projectdetails = new ArrayList<>();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid,p.pname,p.version,pmanager as pmid,u.FIRSTNAME||' '||u.LASTNAME as pmname,u.EMAIL as pmmail,dmanager as dmid,ue.FIRSTNAME||' '||ue.LASTNAME as dmname,ue.EMAIL as dmmail from project p,USERs u,users ue where u.userid=pmanager and ue.userid=dmanager and status='Work in progress' and pmanager!=104 order by enddate");
            
            while (resultset.next()) {
                Project p = new Project();
                p.setPid(resultset.getInt(1));
                p.setPname(resultset.getString(2));
                p.setVerion(resultset.getString(3));
                p.setPmId(resultset.getInt(4));
                p.setPmName(resultset.getString(5));
                p.setPmEMail(resultset.getString(6));
                p.setDmId(resultset.getInt(7));
                p.setDmName(resultset.getString(8));
                p.setDmEMail(resultset.getString(9));
                projectdetails.add(p);
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
}
