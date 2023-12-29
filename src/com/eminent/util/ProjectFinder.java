package com.eminent.util;

import com.eminent.issue.controller.MaintainWRMDay;
import com.eminent.server.MonitoringLog;
import com.eminent.server.SapServerType;
import com.eminent.server.ServerDAO;
import com.eminent.server.ServerDAOImpl;
import com.eminent.server.ServerSystem;
import com.eminent.util.bean.ModuleWaiseCountBean;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Balaguru Ramasamy
 */
public class ProjectFinder {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ProjectFinder");

    }

    public static String findProject(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null, rs = null;
//		String pid            = null;
        String project = "NA";
        String version = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Finding most of the assigned issues belong to which single project for the current user  
            resultset = statement.executeQuery("select i.pid, count(*) count from issue i, issuestatus s where s.status != 'Closed' and i.assignedto = " + userId + " and i.issueid = s.issueid and i.pid in (select distinct up.pid from project p, userproject up  where userid = " + userId + " and p.pid=up.pid ) group by i.pid order by count desc");
            if (resultset.next()) {
                rs = statement.executeQuery("select pname as project, version as fix_version from project where pid = " + resultset.getString("pid"));
                if (rs.next()) {
                    project = rs.getString("project");
                    version = rs.getString("fix_version");
                    project = project + ":" + version;
                }

            } else {

                rs = statement.executeQuery("select pname as project, version as fix_version from project where pid in (select distinct up.pid from project p, userproject up  where userid = " + userId + " and p.pid=up.pid ) order by upper(pname)");
                if (rs.next()) {
                    project = rs.getString("project");
                    version = rs.getString("fix_version");
                    project = project + ":" + version;
                }
            }

        } catch (Exception e) {
            logger.error("Error while finding the project" + e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while finding the project" + e.getMessage());
            }
        }

        return project;

    }

    public static String findProjectWorkin(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null, rs = null;
//		String pid            = null;
        String project = "NA";
        String version = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Finding most of the assigned issues belong to which single project for the current user  
            resultset = statement.executeQuery("select i.pid, count(*) count from issue i, issuestatus s where s.status != 'Closed' and i.assignedto = " + userId + " and i.issueid = s.issueid and i.pid in (select distinct up.pid from project p, userproject up  where userid = " + userId + " and status in('Work in progress','To be started') and pmanager!=104 and p.pid=up.pid ) group by i.pid order by count desc");
            if (resultset.next()) {
                rs = statement.executeQuery("select pname as project, version as fix_version from project where pid = " + resultset.getString("pid"));
                if (rs.next()) {
                    project = rs.getString("project");
                    version = rs.getString("fix_version");
                    project = project + ":" + version;
                }

            } else {

                rs = statement.executeQuery("select pname as project, version as fix_version from project where pid in (select distinct up.pid from project p, userproject up  where userid = " + userId + " and status in('Work in progress','To be started') and pmanager!=104  and p.pid=up.pid ) order by upper(pname)");
                if (rs.next()) {
                    project = rs.getString("project");
                    version = rs.getString("fix_version");
                    project = project + ":" + version;
                }
            }

        } catch (Exception e) {
            logger.error("Error while finding the project" + e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while finding the project" + e.getMessage());
            }
        }

        return project;

    }

    public static Long findProjectId(int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null, rs = null;
        long pid = 0l;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Finding most of the assigned issues belong to which single project for the current user  
            resultset = statement.executeQuery("select pid, count(*) count from issue i, issuestatus s where s.status != 'Closed' and assignedto = " + userId + " and i.issueid = s.issueid group by i.pid order by count desc");
            if (resultset.next()) {
                pid = resultset.getLong("pid");

            } else {

                rs = statement.executeQuery("select pid from project where pid in (select distinct up.pid from project p, userproject up  where userid = " + userId + " and p.pid=up.pid ) order by upper(pname)");
                if (rs.next()) {
                    pid = rs.getLong("pid");
                }
            }

        } catch (Exception e) {
            logger.error("Error while finding the project" + e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while finding the project" + e.getMessage());
            }
        }

        return pid;

    }

    public static String isProjectExist(String project, String version) {

        String flag = "no";
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select pid from project where upper(pname) = '" + project.toUpperCase() + "' and upper(version) = '" + version.toUpperCase() + "'");
            rs = st.executeQuery("select pid from project where upper(pname) = '" + project.toUpperCase() + "' and upper(version) = '" + version.toUpperCase() + "'");

            if (rs != null) {
                if (rs.next()) {
                    flag = "yes";
                }
            }

        } catch (Exception Ex) {
            logger.error("Exception in Project Exist Method:" + Ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Exception in Project Exist Method" + ex.getMessage());
            }
        }
        return flag;

    }

    public static String getProjectEndDate(String project, String version) {

        String flag = "";
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select to_char(Max(EndDate),'dd-mm-yyyy') as endDate from project where upper(pname) = '" + project.toUpperCase() + "' and upper(version) <= '" + version.toUpperCase() + "'");
            rs = st.executeQuery("select to_char(Max(EndDate),'dd-mm-yyyy') as endDate from project where upper(pname) = '" + project.toUpperCase() + "' and upper(version) <= '" + version.toUpperCase() + "'");
            while (rs.next()) {
                flag = rs.getString("endDate");
            }

        } catch (Exception Ex) {
            logger.error("Exception in Project Exist Method:" + Ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Exception in Project Exist Method" + e.getMessage());
            }
        }
        return flag;

    }

    public static String isModuleExist(String module, String project, String version) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String available = "no";

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Checking whether the module is available in the project or not
            rs = statement.executeQuery("select  moduleid from modules m, project p where pname = '" + project + "' and version = '" + version + "' and p.pid = m.pid and module = '" + module + "'");

            if (rs.next()) {
                available = "yes";

            }

        } catch (Exception e) {
            logger.error("Error while checking the module" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while finding the project" + e.getMessage());
            }
        }

        return available;

    }

    public static String isDuedateCorrect(String dueDate, String project, String version) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String due = "correct";

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Checking whether the Due Date is exceeding project end date
            rs = statement.executeQuery("select to_char(enddate,'dd-mm-yy') as end from project where pname='" + project + "' and version='" + version + "' and enddate <= to_date('" + dueDate + "','dd-mm-yyyy')");

            if (rs.next()) {
                due = rs.getString("end");

            }

        } catch (Exception e) {
            logger.error("Error while checking the Due Date" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while checking the Due Date" + e.getMessage());
            }
        }

        return due;

    }

    public static String getModuleId(String project, String fixVersion, String module) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String moduleId = null;

        if (project != null) {
            project = project.trim();
        }
        if (fixVersion != null) {
            fixVersion = fixVersion.trim();
        }
        if (module != null) {
            module = module.trim();
        }

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting the module Id
            rs = statement.executeQuery("select moduleid from project p, modules m where pname = '" + project + "' and version = '" + fixVersion + "' and p.pid = m.pid and module = '" + module + "'");

            if (rs.next()) {
                moduleId = rs.getString("moduleid");
            }
        } catch (Exception e) {
            logger.error("Error while checking the module" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the module id" + e.getMessage());
            }
        }

        return moduleId;

    }

    public static String getProjectId(String project, String fixVersion) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String projectId = null;

        if (project != null) {
            project = project.trim();
        }
        if (fixVersion != null) {
            fixVersion = fixVersion.trim();
        }

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting the project Id
            rs = statement.executeQuery("select pid from project where pname = '" + project + "' and version = '" + fixVersion + "'");

            if (rs.next()) {
                projectId = rs.getString("pid");

            }

        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return projectId;

    }

    public static String getProjectType(String project) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String projectType = null;

        if (project != null) {
            project = project.trim();
        }

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting the project Id
            rs = statement.executeQuery("select type from project_type where pid = '" + project + "'");

            if (rs.next()) {
                projectType = rs.getString("type");

            }

        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return projectType;

    }

    public static String[][] getProjectWRM() {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String projectType = null;
        String[][] wrmDetails = new String[14][8];
        int time = 0;
        int day = 0;
        String project = "", existingValue = "";

        // Time Mapping should be same as Project where we are maintaining WRM Timing
        HashMap hm = new HashMap<Integer, Integer>();
        hm.put(new Integer(7), new Integer(0));
        hm.put(new Integer(8), new Integer(1));
        hm.put(new Integer(9), new Integer(2));
        hm.put(new Integer(10), new Integer(3));
        hm.put(new Integer(11), new Integer(4));
        hm.put(new Integer(12), new Integer(5));
        hm.put(new Integer(13), new Integer(6));
        hm.put(new Integer(14), new Integer(7));
        hm.put(new Integer(15), new Integer(8));
        hm.put(new Integer(16), new Integer(9));
        hm.put(new Integer(17), new Integer(10));
        hm.put(new Integer(18), new Integer(11));
        hm.put(new Integer(19), new Integer(12));
        hm.put(new Integer(20), new Integer(13));
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery("SELECT STARTTIMEH,WRM_DAY,PNAME|| ' v'||VERSION AS PROJECT FROM PROJECT WHERE WRM_DAY IS NOT NULL AND STATUS='Work in progress' ORDER BY WRM_DAY,STARTTIMEH");

            while (rs.next()) {
                time = rs.getInt(1);
                day = rs.getInt(2);
                project = rs.getString(3);
                logger.info("Time" + time + "  day" + day + "  project" + project);
                logger.info("Time Value" + (Integer) hm.get(time));
                try {
                    existingValue = wrmDetails[(Integer) hm.get(time)][day - 1];
                } catch (Exception e) {
                    logger.error("Error while getting the project id" + e.getMessage());
                }
                if (existingValue == null || existingValue == "") {
                    wrmDetails[(Integer) hm.get(time)][day - 1] = project;
                } else {
                    wrmDetails[(Integer) hm.get(time)][day - 1] = existingValue + ",<br> " + project;
                }
                existingValue = "";

            }

        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return wrmDetails;

    }

    public static int getProjectWRMDay(int pId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int day = 0;

        // Time Mapping should be same as Project where we are maintaining WRM Timing
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery("SELECT WRM_DAY from project where pid=" + pId);

            while (rs.next()) {
                day = rs.getInt(1);

            }

        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return day;

    }

    public String[][] getModuleSplit() {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        LinkedHashSet projectSet = new LinkedHashSet<String>();
        LinkedHashSet moduleSet = new LinkedHashSet<String>();
        int issueCount = 0, modRowCount = 0;
        String project = "", module = "", projSplit = "";
        HashMap hm = new HashMap<Integer, Integer>();
        String[][] finalVal = new String[1][1];

        //Adding firsrow for module which is empty cell
        //       moduleSet.add("");
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project Issue Details and add it to Map
            rs = statement.executeQuery("select  regexp_substr(PNAME,'\\w+') as project, module,count(*) as count,pname,version from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and i.pid = p.pid and m.moduleid=i.module_id and s.status!='Closed' and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname,version, module,enddate order by enddate,project,count");
            while (rs.next()) {
                project = rs.getString(1);
                module = rs.getString(2);
                issueCount = rs.getInt(3);
                projectSet.add(project + "***" + rs.getString(4) + " v" + rs.getString(5));
                moduleSet.add(module);
                hm.put(module + "-" + project, (Integer) issueCount);
            }
            modRowCount = moduleSet.size();

            hm.putAll(getClosedIssues("Closed"));

            moduleSet.add("With Client");
            hm.putAll(getClientIssues("With Client"));
            moduleSet.add("With ESPL");
            hm.putAll(getClientIssues("With ESPL"));

//            moduleSet.add("Deviation Today");
            // Formatting Array based on output format with one more size added in colum for Module and one size for column header
            //       int extraRows   = 1;
            int modSize = moduleSet.size() + 2;
            int projSize = projectSet.size() + 2;
            //           logger.info("Column Size" + projSize);
            //         logger.info("Row Size" + modSize);
            finalVal = new String[modSize][projSize];

            finalVal[modRowCount + 1][0] = "Total";
            finalVal[0][projectSet.size() + 1] = "Total***Total no of Issues";

            int col = 1, row = 1, cnt = 0;
            int total = 0, preValue = 0, cumulative = 0;

            try {
                for (Object moduleName : moduleSet) {
                    for (Object prjName : projectSet) {
                        if (row <= modRowCount) {
                            // Start of column Value
                            projSplit = (String) prjName;
                            projSplit = projSplit.substring(0, projSplit.indexOf("***"));
                            try {
                                cnt = (Integer) hm.get((String) moduleName + "-" + (String) projSplit);
                            } catch (Exception e) {
                                cnt = 0;
//                                logger.error(e.getMessage());
                            }
                            finalVal[0][col] = (String) prjName;
                            finalVal[row][0] = "<b>" + (String) moduleName + "</b>";

                            // setting values for each project
                            finalVal[row][col] = ((Integer) cnt).toString();

                            try {
                                if (row > 1) {
                                    preValue = Integer.parseInt(finalVal[modRowCount + 1][col]);
                                }
                            } catch (Exception e) {
                                preValue = 0;
                                logger.error(e.getMessage());
                            }
                            // setting total project issue count
                            finalVal[modRowCount + 1][col] = ((Integer) (cnt + preValue)).toString();

                            total = total + cnt;
                            col++;

                            // End of Column Value Set
                        } else {

                            projSplit = (String) prjName;
                            projSplit = projSplit.substring(0, projSplit.indexOf("***"));
                            try {
                                cnt = (Integer) hm.get(moduleName + "-" + (String) projSplit);
                            } catch (Exception e) {
                                cnt = 0;
                                logger.error(e.getMessage());
                            }
                            // finalVal[0][col]=(String)prjName;
                            finalVal[row][0] = "<b>" + (String) moduleName + "</b>";
                            // setting values for each project
                            finalVal[row][col] = ((Integer) cnt).toString();
                            total = total + cnt;
                            col++;
                            //
                        }
                    }
                    if (row <= modRowCount) {
                        finalVal[row][col] = ((Integer) total).toString();

                        if (row > 1) {
                            cumulative = Integer.parseInt(finalVal[modRowCount + 1][col]);
                        } else {
                            cumulative = 0;
                        }
                        // setting total module issue count

                        //             logger.info("Complete Total Co-ordinated"+(modRowCount)+","+col+","+row);
                        finalVal[modRowCount + 1][col] = ((Integer) (total + cumulative)).toString();
                    } else {
                        finalVal[row][col] = ((Integer) total).toString();
                    }
                    if (modRowCount == row) {
                        row++;
                    }
                    col = 1;
                    row++;
                    //                  logger.info("Row No" + row);
                    total = 0;
                    preValue = 0;
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }
        return finalVal;
    }

    public static String[][] getYearlyValue(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        LinkedHashSet projectSet = new LinkedHashSet<String>();
        LinkedHashSet moduleSet = new LinkedHashSet<String>();
        int issueCount = 0, modRowCount = 0;
        String project = "", module = "", projSplit = "";
        HashMap hm = new HashMap<Integer, Integer>();
        String[][] finalVal = new String[1][1];

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project Issue Details and add it to Map
            rs = statement.executeQuery("select  regexp_substr(PNAME,'\\w+') as project, module,count(*) as count,pname,version from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and i.pid = p.pid and m.moduleid=i.module_id and s.status!='Closed' and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname,version, module,enddate order by enddate,project,count");
            while (rs.next()) {
                project = rs.getString(1);
                module = rs.getString(2);
                issueCount = rs.getInt(3);
                projectSet.add(project + "***" + rs.getString(4) + " v" + rs.getString(5));

            }
            modRowCount = moduleSet.size();

            if ("Yearly".equals(type)) {

                moduleSet.add("Created");
                hm.putAll(getCreatedIssues("Yearly-Created"));
                moduleSet.add("WRM");
                hm.putAll(getWRMIssues("Yearly-WRM"));
                moduleSet.add("Planned");
                hm.putAll(getPlannedIssues("Yearly-Planned"));
                moduleSet.add("Worked");
                hm.putAll(getWorkedIssue("Yearly-Worked"));
                moduleSet.add("Adhoc");
                hm.putAll(getAdhocIssues("Yearly-Adhoc"));
                moduleSet.add("To Client");
                hm.putAll(getClientAssignmentToday("Yearly-To Client"));
                moduleSet.add("Closed");
                hm.putAll(getClosedIssues("Yearly-Closed"));
            } else if ("Quarterly".equals(type)) {

                moduleSet.add("Created");
                hm.putAll(getCreatedIssues("Quarterly-Created"));
                moduleSet.add("WRM");
                hm.putAll(getWRMIssues("Quarterly-WRM"));
                moduleSet.add("Planned");
                hm.putAll(getPlannedIssues("Quarterly-Planned"));
                moduleSet.add("Worked");
                hm.putAll(getWorkedIssue("Quarterly-Worked"));
                moduleSet.add("Adhoc");
                hm.putAll(getAdhocIssues("Quarterly-Adhoc"));
                moduleSet.add("To Client");
                hm.putAll(getClientAssignmentToday("Quarterly-To Client"));
                moduleSet.add("Closed");
                hm.putAll(getClosedIssues("Quarterly-Closed"));
            } else if ("Monthly".equals(type)) {

                moduleSet.add("Target");
                //  hm.putAll(getTargetCount());
                hm.putAll(getMontlyTargetCount());
                moduleSet.add("Created");
                hm.putAll(getCreatedIssues("Monthly-Created"));
                moduleSet.add("WRM");
                hm.putAll(getWRMIssues("Monthly-WRM"));
                moduleSet.add("Planned");
                hm.putAll(getPlannedIssues("Monthly-Planned"));
                moduleSet.add("Worked");
                hm.putAll(getWorkedIssue("Monthly-Worked"));
                moduleSet.add("Adhoc");
                hm.putAll(getAdhocIssues("Monthly-Adhoc"));
                moduleSet.add("To Client");
                hm.putAll(getClientAssignmentToday("Monthly-To Client"));
                moduleSet.add("Closed");
                hm.putAll(getClosedIssues("Monthly-Closed"));
            } else if ("Weekly".equals(type)) {

                moduleSet.add("Created");
                hm.putAll(getCreatedIssues("Weekly-Created"));
                moduleSet.add("WRM");
                hm.putAll(getWRMIssues("Weekly-WRM"));
                moduleSet.add("Planned");
                hm.putAll(getPlannedIssues("Weekly-Planned"));
                moduleSet.add("Worked");
                hm.putAll(getWorkedIssue("Weekly-Worked"));
                moduleSet.add("Adhoc");
                hm.putAll(getAdhocIssues("Weekly-Adhoc"));
                moduleSet.add("To Client");
                hm.putAll(getClientAssignmentToday("Weekly-To Client"));
                moduleSet.add("Closed");
                hm.putAll(getClosedIssues("Weekly-Closed"));
            } else {

                moduleSet.add("Created");
                hm.putAll(getCreatedIssues("Daily-Created"));
                moduleSet.add("Planned");
                hm.putAll(getPlannedIssues("Daily-Planned"));
                moduleSet.add("Worked");
                hm.putAll(getWorkedIssue("Daily-Worked"));
                moduleSet.add("Adhoc");
                hm.putAll(getAdhocIssues("Daily-Adhoc"));
                moduleSet.add("To Client");
                hm.putAll(getClientAssignmentToday("Daily-To Client"));
                moduleSet.add("Closed");
                hm.putAll(getClosedIssues("Daily-Closed"));
            }

//            moduleSet.add("Deviation Today");
            // Formatting Array based on output format with one more size added in colum for Module and one size for column header
            //       int extraRows   = 1;
            int modSize = moduleSet.size() + 1;
            int projSize = projectSet.size() + 2;
            logger.info("Column Size" + projSize);
            logger.info("Row Size" + modSize);
            finalVal = new String[modSize][projSize];

            finalVal[modRowCount + 1][0] = "Total";
            finalVal[0][projectSet.size() + 1] = "Total***Total no of Issues";

            int col = 1, row = 1, cnt = 0;
            int total = 0;

            try {
                for (Object moduleName : moduleSet) {
                    for (Object prjName : projectSet) {
                        projSplit = (String) prjName;
                        projSplit = projSplit.substring(0, projSplit.indexOf("***"));
                        try {
                            cnt = (Integer) hm.get(moduleName + "-" + (String) projSplit);
                        } catch (Exception e) {
                            cnt = 0;
                            logger.info(e.getMessage());
                        }
                        // finalVal[0][col]=(String)prjName;
                        finalVal[row][0] = "<b>" + (String) moduleName + "</b>";
                        // setting values for each project
                        finalVal[row][col] = ((Integer) cnt).toString();
                        total = total + cnt;
                        col++;
                    }
                    finalVal[row][col] = ((Integer) total).toString();

                    col = 1;
                    row++;
                    logger.info("Row No" + row);
                    total = 0;
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id", ex);
            }
        }
        return finalVal;
    }

    public static HashMap getCreatedIssues(String type) {
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();

        // Getting last 30 day created issue count for all active project
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            switch (type) {
                case "Yearly-Created":
                    sql = "select regexp_substr(pname,'\\w+') project,issue.pid,count(*) as count from issue,project where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-366 FROM DUAL))  and issue.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and issue.pid=project.pid group by pname,issue.pid,enddate order by enddate,pname";
                    break;
                case "Quarterly-Created":
                    sql = "select regexp_substr(pname,'\\w+') project,issue.pid,count(*) as count from issue,project where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-91 FROM DUAL))  and issue.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and issue.pid=project.pid group by pname,issue.pid,enddate order by enddate,pname";
                    break;
                case "Monthly-Created":
                    sql = "select regexp_substr(pname,'\\w+') project,issue.pid,count(*) as count from issue,project where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL))  and issue.pid in (select pid from project where status='Work in progress' and category='SAP Project'and pmanager!=104) and issue.pid=project.pid group by pname,issue.pid,enddate order by enddate,pname";
                    break;
                case "Weekly-Created":
                    sql = "select regexp_substr(pname,'\\w+') project,issue.pid,count(*) as count from issue,project where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT SYSDATE-8 FROM DUAL))  and issue.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and issue.pid=project.pid group by pname,issue.pid,enddate order by enddate,pname";
                    break;
                case "Daily-Created":
                    sql = "select regexp_substr(pname,'\\w+') project,issue.pid,count(*) as count from issue,project where to_char(createdon,'DD-MM-YYYY') = ((SELECT to_char(SYSDATE,'DD-MM-YYYY') FROM DUAL))  and issue.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and issue.pid=project.pid group by pname,issue.pid,enddate order by enddate,pname";
                    break;
                default:
                    sql = "select regexp_substr(pname,'\\w+') project,issue.pid,count(*) as count from issue,project where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT SYSDATE-31 FROM DUAL))  and issue.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.pid=project.pid group by pname,issue.pid,enddate order by enddate,pname";
                    break;
            }
            logger.info("created sql :" + sql);

            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(3);
                hm.put("Created-" + project, (Integer) count);
            }
            logger.info("Map Value" + hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getClosedIssues(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();

        switch (type) {
            case "Yearly-Closed":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-366 FROM DUAL)) and to_date(to_char(issue.modifiedon,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT SYSDATE-366 FROM DUAL)) order by issue.pid) group by project";
                break;
            case "Quarterly-Closed":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-91 FROM DUAL)) and to_date(to_char(issue.modifiedon,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT SYSDATE-91 FROM DUAL)) order by issue.pid) group by project";
                break;
            case "Monthly-Closed":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and to_date(to_char(issue.modifiedon,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT SYSDATE-31 FROM DUAL)) order by issue.pid) group by project";
                break;
            case "Weekly-Closed":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT SYSDATE-8 FROM DUAL)) and to_date(to_char(issue.modifiedon,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT SYSDATE-8 FROM DUAL)) order by issue.pid) group by project";
                break;
            case "Daily-Closed":
                sql = "select project,count(*) from (select distinct issue.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and issuestatus.status='Closed' and to_char(issue.modifiedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE,'DD-Mon-YY') FROM DUAL)) order by issue.pid) group by project";
                break;
            default:
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and to_date(to_char(issue.modifiedon,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT SYSDATE FROM DUAL)) order by issue.pid) group by project";
                break;
        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(2);
                hm.put("Closed-" + project, (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getWRMIssues(String type) {
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();

        // Getting last 30 day created issue count for all active project
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            switch (type) {
                case "Yearly-WRM":
                    sql = "select regexp_substr(pname,'\\w+') project,count(*) from APM_WRM_PLAN pl ,project p where pl.pid=p.pid and pl.pid in (select pid from project where status='Work in progress' and category='SAP Project') and to_date(to_char(PLANNEDON,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT sysdate-366 FROM DUAL)) group by pname, pl.pid";
                    break;
                case "Quarterly-WRM":
                    sql = "select regexp_substr(pname,'\\w+') project,count(*) from APM_WRM_PLAN pl ,project p where pl.pid=p.pid and pl.pid in (select pid from project where status='Work in progress' and category='SAP Project') and to_date(to_char(PLANNEDON,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT sysdate-181 FROM DUAL)) group by pname, pl.pid";
                    break;
                case "Monthly-WRM":
                    sql = "select regexp_substr(pname,'\\w+') project,count(*) from APM_WRM_PLAN pl ,project p where pl.pid=p.pid and pl.pid in (select pid from project where status='Work in progress' and category='SAP Project') and to_date(to_char(PLANNEDON,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT sysdate-31 FROM DUAL)) group by pname, pl.pid";
                    break;
                case "Weekly-WRM":
                    sql = "select regexp_substr(pname,'\\w+') project,count(*) from APM_WRM_PLAN pl ,project p where pl.pid=p.pid and pl.pid in (select pid from project where status='Work in progress' and category='SAP Project') and to_date(to_char(PLANNEDON,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT sysdate-8 FROM DUAL)) group by pname, pl.pid";
                    break;
                case "Daily-WRM":
                    sql = "select regexp_substr(pname,'\\\\w+') project,count(*) from APM_WRM_PLAN pl ,project p where pl.pid=p.pid and pl.pid in (select pid from project where status='Work in progress' and category='SAP Project') and to_char(PLANNEDON,'DD-Mon-YY')= ((SELECT to_char(SYSDATE,'DD-Mon-YY')FROM DUAL)) group by pname, pl.pid";
                    break;

                default:
                    sql = "select regexp_substr(pname,'\\w+') project,count(*) from APM_WRM_PLAN pl ,project p where pl.pid=p.pid and pl.pid in (select pid from project where status='Work in progress' and category='SAP Project') and to_date(to_char(PLANNEDON,'DD-Mon-YY'), 'DD-Mon-YY')> ((SELECT sysdate-31 FROM DUAL)) group by pname, pl.pid";
                    break;
            }
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(2);
                hm.put("WRM-" + project, (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getClientIssues(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();
        if (type.equals("With Client")) {
            sql = "select regexp_substr(PNAME,'\\w+') as project, count(*) from issue i, issuestatus s, project p,users u where i.issueid=s.issueid and i.pid=p.pid and s.status!='Closed' and i.assignedto=u.userid and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and email not like '%eminentlabs.net' group by pname,enddate order by enddate,pname";
        } else if (type.equals("With ESPL")) {
            sql = "select regexp_substr(PNAME,'\\w+') as project, count(*) from issue i, issuestatus s, project p,users u where i.issueid=s.issueid and i.pid=p.pid and s.status!='Closed' and i.assignedto=u.userid and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and email like '%eminentlabs.net' group by pname,enddate order by enddate,pname";
        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(2);
                hm.put(type + "-" + project, (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getPlannedIssues(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();
        switch (type) {
            case "Yearly-Planned":
                sql = "select project,count(*) from (select distinct issueid,pl.pid,regexp_substr(PNAME,'\\w+') as project from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-366 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104) ) group by project";
                break;
            case "Quarterly-Planned":
                sql = "select project,count(*) from (select distinct issueid,pl.pid,regexp_substr(PNAME,'\\w+') as project from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-91 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104) ) group by project";
                break;
            case "Monthly-Planned":
                sql = "select project,count(*) from (select distinct issueid,pl.pid,regexp_substr(PNAME,'\\w+') as project from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104) ) group by project";
                break;
            case "Weekly-Planned":
                sql = "select project,count(*) from (select distinct issueid,pl.pid,regexp_substr(PNAME,'\\w+') as project from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-8 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104) ) group by project";
                break;
            case "Daily-Planned":
                sql = "select NVL(substr(pname,1,instr(pname, ' ')),pname) as project, count(Distinct(issue))  from (select Distinct(SUBSTR(task,0,12)) as issue  from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') =  to_char(sysdate,'dd-Mon-yyyy')),PROJECT_PLANNED_ISSUE pl,Project p where p.pid=pl.pid and p.status='Work in progress' and category='SAP Project' and p.pmanager!=104 and pl.issueid=issue and pl.status='Active' and to_char(pl.plannedon,'dd-MM-yyyy') =  to_char(sysdate,'dd-MM-yyyy') group by pname";
                break;

            default:
                sql = "select project,count(*) from (select distinct issueid,pl.pid,regexp_substr(PNAME,'\\w+') as project from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104) ) group by project";
                break;
        }

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(2);
                hm.put("Planned-" + project.trim(), (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getClientAssignmentToday(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();
        switch (type) {
            case "Yearly-To Client":
                sql = "select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')>(SELECT SYSDATE-366 FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
                break;
            case "Quarterly-To Client":
                sql = "select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')>(SELECT SYSDATE-91 FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
                break;
            case "Monthly-To Client":
                sql = "select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')>(SELECT SYSDATE-31 FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
                break;
            case "Weekly-To Client":
                sql = "select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')>(SELECT SYSDATE-8 FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
                break;
            case "Daily-To Client":
                sql = "select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
                break;
            default:
                sql = "select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT SYSDATE-8 FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
                break;
        }
//        if(type.equals("To Client Today")){
//            sql="select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
//        }else if(type.equals("With ESPL")){
//            sql="select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
//        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(2);
                hm.put("To Client-" + project, (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getWorkedIssue(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();
        switch (type) {
            case "Yearly-Worked":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid  and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-366 FROM DUAL))  and issuecomments.issueid in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-366 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
                break;
            case "Quarterly-Worked":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid  and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-181 FROM DUAL))  and issuecomments.issueid in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-91 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
                break;
            case "Monthly-Worked":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid  and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL))  and issuecomments.issueid in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
                break;
            case "Weekly-Worked":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid  and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-8 FROM DUAL))  and issuecomments.issueid in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-8 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
                break;
            case "Daily-Worked":
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid  and to_char(comment_date,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL))  and issuecomments.issueid in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
                break;

            default:
                sql = "select project,count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL))  and issuecomments.issueid in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
                break;
        }
//        if(type.equals("Worked")){
//            sql="select project, count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status!='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL))  and issuecomments.issueid in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
//        }else if(type.equals("With ESPL")){
//            sql="select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
//        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(2);
                hm.put("Worked-" + project, (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getAdhocIssues(String type) {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();
        switch (type) {
            case "Yearly-Adhoc":
                sql = "select project, count(*) from (select issueid,regexp_substr(pname,'\\w+') project, issue.pid, issue.modifiedon from issue,project where issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and  to_char(modifiedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and issue.issueid not in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE-366,'DD-Mon-YY') FROM DUAL)))) group by project";
                break;
            case "Quarterly-Adhoc":
                sql = "select project, count(*) from (select issueid,regexp_substr(pname,'\\w+') project, issue.pid, issue.modifiedon from issue,project where issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and  to_char(modifiedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and issue.issueid not in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE-91,'DD-Mon-YY') FROM DUAL)))) group by project";
                break;
            case "Monthly-Adhoc":
                sql = "select project, count(*) from (select issueid,regexp_substr(pname,'\\w+') project, issue.pid, issue.modifiedon from issue,project where issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and  to_char(modifiedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and issue.issueid not in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE-31,'DD-Mon-YY') FROM DUAL)))) group by project";
                break;
            case "Weekly-Adhoc":
                sql = "select project, count(*) from (select issueid,regexp_substr(pname,'\\w+') project, issue.pid, issue.modifiedon from issue,project where issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and  to_char(modifiedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and issue.issueid not in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE-8,'DD-Mon-YY') FROM DUAL)))) group by project";
                break;
            case "Daily-Adhoc":
                sql = "select project, count(*) from (select issueid,regexp_substr(pname,'\\w+') project, issue.pid, issue.modifiedon from issue,project where issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and  to_char(modifiedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and issue.issueid not in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE,'DD-Mon-YY') FROM DUAL)))) group by project";
                break;

            default:
                sql = "select project, count(*) from (select issueid,regexp_substr(pname,'\\w+') project, issue.pid, issue.modifiedon from issue,project where issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)  and  to_char(modifiedon,'DD-Mon-YY') = ((SELECT to_char(sysdate,'DD-Mon-YY') FROM DUAL)) and issue.issueid not in (select distinct issueid from PROJECT_PLANNED_ISSUE pl , project p where pl.pid=p.pid and pl.status='Active' and to_char(plannedon,'DD-Mon-YY') = ((SELECT to_char(SYSDATE,'DD-Mon-YY') FROM DUAL)))) group by project";
                break;
        }
//        if(type.equals("Adhoc")){
//            sql="select project, count(*) from (select distinct issuecomments.issueid,regexp_substr(pname,'\\w+') project, issue.pid from issuecomments,issue,issuestatus,project where issue.issueid=issuestatus.issueid and issue.pid=project.pid and project.pid in (select pid from project where status='Work in progress' and category='SAP Project') and issue.issueid=issuecomments.issueid and issuestatus.status!='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL))  and issuecomments.issueid not in (select distinct issueid from APM_WRM_PLAN pl , project p where pl.pid=p.pid and pl.status='Active' and to_date(to_char(plannedon,'DD-Mon-YY'), 'DD-Mon-YY') > ((SELECT sysdate-31 FROM DUAL)) and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)) order by issue.pid) group by project";
//        }else if(type.equals("With ESPL")){
//            sql="select regexp_substr(PNAME,'\\w+') as project,count(*) from issue i,issuestatus s, project p,users u where i.issueid = s.issueid and i.pid = p.pid  and u.userid=i.assignedto and u.EMAIL not like '%eminentlabs.net' and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL)) and i.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname";
//        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //Getting Project WRMs
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                project = rs.getString(1);
                logger.info("project id : " + project);
                count = rs.getInt(2);
                hm.put("Adhoc-" + project, (Integer) count);
            }
            //   logger.info("Map Value"+hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getTargetCount() {
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        int count = 0;
        String project = "", sql = "";
        HashMap hm = new HashMap<Integer, Integer>();
        Calendar cal = new GregorianCalendar();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        String months = GetProjects.leadingZeros(2, month + "");
        String monthYear = months + "-" + year;
        // Getting last 30 day created issue count for all active project

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            sql = "select regexp_substr(pname, '[^ ]+', 1, 1) project,a.pid,a.count from project,APM_TARGET_ISSUE_COUNT a where to_char(a.TARGET_DATE,'MM-yyyy') = '" + monthYear + "'  and a.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and a.pid=project.pid group by pname,a.pid,enddate,a.count order by enddate,pname";
            logger.info("taregt sql :" + sql);
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                project = rs.getString(1);
                count = rs.getInt(3);
                hm.put("Target-" + project, (Integer) count);
            }
            logger.info("Map Value" + hm);
        } catch (Exception e) {
            logger.error("Error while getting the project id" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error("Error while getting the project id" + e.getMessage());
            }
        }

        return hm;

    }

    public static HashMap getMontlyTargetCount() {
        DateFormat sdf = new SimpleDateFormat("MMMM yyyy");

        HashMap hm = new HashMap<String, Integer>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String targetMonth = sdf.format(new Date());
            String sql = " SELECT p.pname , m.pid,mt.TARGET,mt.TARGETID from modules m inner join (select pid, regexp_substr(pname, '[^ ]+', 1, 1) as pname from project where status='Work in progress' and category='SAP Project' and pmanager!=104) p on p.pid=m.pid   LEFT JOIN  MODULETARGET mt on  m.moduleid =mt.MODULEID and   mt.MONTH='" + targetMonth + "' where p.pid=m.pid order by p.pid";
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            int pid = 0;
            String project = "";
            int i = 0;
            int count = 0;
            int size = query.list().size();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                if (pid == 0 || MoMUtil.parseInteger(row[1].toString(), 0) == pid) {
                    pid = MoMUtil.parseInteger(row[1].toString(), 0);
                    project = row[0].toString();
                    if (row[2] == null) {
                        count = count + 0;
                    } else {
                        count = count + MoMUtil.parseInteger(row[2].toString(), 0);
                    }
                } else {
                    hm.put("Target-" + project, count);
                    pid = MoMUtil.parseInteger(row[1].toString(), 0);
                    project = row[0].toString();
                    count = 0;
                    if (row[2] == null) {
                        count = count + 0;
                    } else {
                        count = count + MoMUtil.parseInteger(row[2].toString(), 0);
                    }
                }
                i++;
                if (i == size) {
                    hm.put("Target-" + project, count);
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return hm;
    }

    public static List<ModuleWaiseCountBean> getModuleSplitMonth() {
        List<ModuleWaiseCountBean> mwcblist = new ArrayList<ModuleWaiseCountBean>();
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        HashMap<String, Integer> closedMap = new HashMap<String, Integer>();
        HashMap<String, Integer> moduletarget = new HashMap<String, Integer>();
        HashMap<String, Integer> allWorkedIssue = new HashMap<String, Integer>();
        HashMap<String, Integer> allPlancount = new HashMap<String, Integer>();
        HashMap<String, Integer> allwrm = new HashMap<String, Integer>();
        HashMap<String, Integer> allCreatedIssue = new HashMap<String, Integer>();
        ModuleWaiseCountBean mwcb = null;
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "Select  MODULE,sum(count) from (select  upper(module) as MODULE,count(*) as count,pname,version from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and i.pid = p.pid and m.moduleid=i.module_id and s.status!='Closed' and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) group by pname,version, module,enddate order by module) group by MODULE order by MODULE";
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

            closedMap = getAllModuleClosedIssuesMonthly();
            moduletarget = getAllMonthlyTargetByModule();
            allWorkedIssue = getAllModuleWorkedIssueMonthWise();
            allPlancount = getAllModuleByPlanIssue();
            allwrm = getAllWrmIssueByMOduleMonthly();
            allCreatedIssue = getAllCreateIssueByMOduleMonthly();

            for (Map.Entry<String, Integer> entrySet : hm.entrySet()) {
                mwcb = new ModuleWaiseCountBean();
                mwcb.setModuleName(entrySet.getKey());
                mwcb.setOpenIssue(entrySet.getValue());

                if (moduletarget.get(entrySet.getKey()) == null) {
                    mwcb.setTargetCount(0);
                } else {
                    mwcb.setTargetCount(moduletarget.get(entrySet.getKey()));
                }
                if (closedMap.get(entrySet.getKey()) == null) {
                    mwcb.setCloseCount(0);
                } else {
                    mwcb.setCloseCount(closedMap.get(entrySet.getKey()));
                }
                if (allPlancount.get(entrySet.getKey()) == null) {
                    mwcb.setPlanCount(0);
                } else {
                    mwcb.setPlanCount(allPlancount.get(entrySet.getKey()));
                }
                if (allWorkedIssue.get(entrySet.getKey()) == null) {
                    mwcb.setWorkedCount(0);
                } else {
                    mwcb.setWorkedCount(allWorkedIssue.get(entrySet.getKey()));
                }
                if (allwrm.get(entrySet.getKey()) == null) {
                    mwcb.setWrmCount(0);
                } else {
                    mwcb.setWrmCount(allwrm.get(entrySet.getKey()));
                }
                if (allCreatedIssue.get(entrySet.getKey()) == null) {
                    mwcb.setCreatedCount(0);
                } else {
                    mwcb.setCreatedCount(allCreatedIssue.get(entrySet.getKey()));
                }
                mwcblist.add(mwcb);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return mwcblist;
    }

    public static HashMap<String, Integer> getAllModuleClosedIssuesMonthly() {
        String sql = "";
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        SimpleDateFormat sdf = new SimpleDateFormat("MMM-yy");
        try {
            String monthlydate = sdf.format(new Date());
            sql = "Select  MODULE,count(*) from ( select  upper(module) as MODULE,i.issueid,pname,version from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and i.pid = p.pid and m.moduleid=i.module_id and s.status='Closed' and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and to_char(i.modifiedon,'Mon-YY')='" + monthlydate + "'    order by upper(module) ) group  by  MODULE order by MODULE";

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return hm;

    }

    public static HashMap<String, Integer> getAllMonthlyTargetByModule() {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        try {
            DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
            String targetMonth = sdf.format(new Date());
            String sql = "select module ,sum(TARGET) from (select  upper(mds.module) as MODULE ,mt.TARGET,mt.MODULEID from modules mds,MODULETARGET mt where mt.MODULEID=mds.MODULEID and mt.MONTH='" + targetMonth + "' and mds.MODULEID in  (select m.MODULEID from modules m,project p where m.pid=p.pid and p.pid in(select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104)) order by upper(mds.module)) group by MODULE order by MODULE";

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return hm;

    }

    public static HashMap<String, Integer> getAllModuleWorkedIssueMonthWise() {

        SimpleDateFormat sdf = new SimpleDateFormat("MMM-yy");

        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        try {
            String monthlydate = sdf.format(new Date());
            String sql = "Select MODULE,count(*) from ( select  upper(module) as MODULE,i.issueid,pname,version from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and i.pid = p.pid and m.moduleid=i.module_id and s.status!='Closed' and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and to_char(i.modifiedon,'Mon-YY')='" + monthlydate + "'  order by upper(module) ) group  by  MODULE";

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return hm;

    }

    public static HashMap<String, Integer> getAllModuleByPlanIssue() {
        SimpleDateFormat sdf = new SimpleDateFormat("MMM-yy");

        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;

        try {
            String monthlydate = sdf.format(new Date());
            String sql = "select MODULE ,count(*) as count from (select distinct pl.issueid,upper(module) as MODULE  from PROJECT_PLANNED_ISSUE pl , project p,issue i,modules m where m.moduleid=i.module_id and i.issueid=pl.issueid and pl.pid=p.pid and pl.status='Active' and  to_char(plannedon,'Mon-YY') = '" + monthlydate + "' and pl.pid in(select pid from project where status='Work in progress' and category='SAP Project' and p.pmanager!=104)  order by upper(MODULE)) group by MODULE";

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return hm;
    }

    public static HashMap<String, Integer> getAllWrmIssueByMOduleMonthly() {
        Session session = null;

        SimpleDateFormat sdf = new SimpleDateFormat("MMM-yy");
        String sql = "";
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        try {
            String monthlydate = sdf.format(new Date());
            sql = "select MODULE ,count(*) as count from (select distinct awp.ISSUEID,awp.PID,upper(module) as MODULE from APM_WRM_PLAN awp,Issue i,Modules m where  m.moduleid=i.module_id and i.issueid=awp.issueid and to_char(WRMDAY,'Mon-YY')='" + monthlydate + "' order by upper(module)) group by MODULE";

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return hm;
    }

    public static HashMap<String, Integer> getAllCreateIssueByMOduleMonthly() {
        Session session = null;

        SimpleDateFormat sdf = new SimpleDateFormat("MMM-yy");
        String sql = "";
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        try {
            String monthlydate = sdf.format(new Date());
            sql = "select MODULE,count(MODULE) from (select  upper(module) as MODULE,i.issueid,CREATEDON from issue i, project p, modules m where i.pid = p.pid and m.moduleid=i.module_id   and p.pid in (select pid from project where status='Work in progress' and category='SAP Project' and pmanager!=104) and to_char(i.CREATEDON,'Mon-YY')='" + monthlydate + "'  order by upper(module) ) group by MODULE order by MODULE";
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String module = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        module = row[col].toString();
                    }
                }
                hm.put(module, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }

        return hm;
    }

    public String[][] getWRMRatings() {

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null, rs1 = null;
        LinkedHashSet projectSet = new LinkedHashSet<String>();
        LinkedHashSet weekSet = new LinkedHashSet<String>();
        String project = "", week = "", projSplit = "", rating = "N/A";
        HashMap hm = new HashMap<Integer, Integer>();
        String[][] finalVal = new String[1][1];
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String currWeek = "";
        Map<String, Integer> wrmDaysForProject = new HashMap<>();
        MaintainWRMDay maintainWRMDay = new MaintainWRMDay();
        int noofweek = 0, curryear = 0;
        try {
            Calendar now = Calendar.getInstance();
            String toDate = sdf.format(now.getTime());
            now = Calendar.getInstance();
            now.add(Calendar.WEEK_OF_YEAR, -52);

            String fromDate = sdf.format(now.getTime());
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select regexp_substr(p.PNAME,'\\w+') as projects,i.HELD_ON,rating,p.pname,p.version,i.MOM_CLIENT_ID  from MOM_FOR_CLIENT i,project p  where p.pid=i.pid and TO_DATE(TO_CHAR(i.HELD_ON,'DD-MM-YYYY'),'DD-MM-YYYY') BETWEEN  '" + fromDate + "' and '" + toDate + "' order by HELD_ON ";
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                project = rs.getString(1);
                now.setTime(rs.getDate(2));
                noofweek = now.get(Calendar.WEEK_OF_YEAR);
                now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
                now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
                curryear = now.get(Calendar.YEAR);
                week = noofweek + "/" + curryear;
                rating = rs.getString(3);
                if (hm.containsKey(week + "-" + project)) {
                    hm.put(week + "-" + project, hm.get(week + "-" + project) + "," + rating + "&&&" + sdf.format(rs.getDate(2)));
                } else {
                    hm.put(week + "-" + project, rating + "&&&" + sdf.format(rs.getDate(2)) + "@@@@" + rs.getString(6));
                }
            }
            //getting all active SAP projects
            rs1 = statement.executeQuery("select regexp_substr(p.PNAME,'\\w+') as projects,p.pname,p.version,p.WRM_DAY  from project p where status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate,projects");
            while (rs1.next()) {
                wrmDaysForProject.put(rs1.getString(1), rs1.getInt(4));
                projectSet.add(rs1.getString(1) + "***" + rs1.getString(2) + " v" + rs1.getString(3));
            }
            now = Calendar.getInstance();
            noofweek = now.get(Calendar.WEEK_OF_YEAR);
            now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
            now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            curryear = now.get(Calendar.YEAR);
            currWeek = noofweek + "/" + curryear;
            weekSet.add(currWeek + "&&&" + dateRangeByWeekNumberAndYear(curryear, noofweek));
            now = Calendar.getInstance();
            for (int i = 1; i < 52; i++) {
                now.add(Calendar.WEEK_OF_YEAR, -1);
                noofweek = now.get(Calendar.WEEK_OF_YEAR);
                now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
                now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
                curryear = now.get(Calendar.YEAR);
                weekSet.add(noofweek + "/" + curryear + "&&&" + dateRangeByWeekNumberAndYear(curryear, noofweek));
                now.add(Calendar.WEEK_OF_YEAR, -1);
            }
            int modSize = weekSet.size() + 1;
            int projSize = projectSet.size() + 1;
            finalVal = new String[modSize][projSize];
            int col = 1, row = 1, wrmDay = 1;
            now = Calendar.getInstance();
            int currDay = now.get(Calendar.DAY_OF_WEEK);
            String rat = "Not Done";
            try {
                for (Object noOfweek : weekSet) {
                    for (Object prjName : projectSet) {
                        projSplit = (String) prjName;
                        projSplit = projSplit.substring(0, projSplit.indexOf("***"));
                        try {

                            week = (String) noOfweek;
                            week = week.substring(0, week.indexOf("&&&"));
                            if (currWeek.equals(week)) {
                                if (hm.containsKey(week + "-" + (String) projSplit)) {
                                    rat = (String) hm.get(week + "-" + (String) projSplit);
                                } else {
                                    wrmDay = wrmDaysForProject.get(projSplit);
                                    if (currDay > wrmDay) {
                                        rat = "Not Done";
                                    } else {
                                        rat = maintainWRMDay.days().get(wrmDay).toUpperCase();
                                    }
                                }
                            } else {
                                if (hm.containsKey(week + "-" + (String) projSplit)) {
                                    rat = (String) hm.get(week + "-" + (String) projSplit);
                                } else {
                                    rat = "Not Done";
                                }
                            }

                        } catch (Exception e) {
                            rat = "Not Done";
                        }
                        finalVal[0][col] = (String) prjName;
                        finalVal[row][0] = (String) noOfweek;
                        finalVal[row][col] = rat;
                        col++;
                    }
                    col = 1;
                    row++;
                }
            } catch (Exception e) {
                e.printStackTrace();
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            logger.error("Error while getting the WRM Rating" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (rs1 != null) {
                    rs1.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return finalVal;
    }

    public String dateRangeByWeekNumberAndYear(int year, int week) {
        String date = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            Calendar now = Calendar.getInstance();
            now.set(Calendar.YEAR, year);
            now.set(Calendar.WEEK_OF_YEAR, week);
            now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            Date yourDate = now.getTime();
            now.setTime(yourDate);//Set specific Date of which start and end you want
            date = sdf.format(now.getTime());//Date of Monday of current week
            now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
            now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            date = date + " to " + sdf.format(now.getTime());//Date of Sunday of current week
        } catch (Exception e) {
            date = "";
        }
        return date;
    }

    public String[][] getBasisMonitoring(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null, rs1 = null;
        LinkedHashMap<Integer, String> projectSet = new LinkedHashMap<>();
        Set<Integer> projSet = new HashSet<>();
        String project = "", week = "", projSplit = "", rating = "N/A";
        String[][] finalVal = new String[1][1];
        List<MonitoringLog> monitoringLog = new ArrayList<>();
        ServerDAO serverDAO = new ServerDAOImpl();
        List<SapServerType> serverTypes = null;
        Integer role = (Integer) session.getAttribute("Role");
        Integer uid = (Integer) session.getAttribute("userid_curr");
        String sql = "";
        try {
            serverTypes = serverDAO.getServerTypes();
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //getting all active SAP projects
            if (role == 1) {
                sql = "select m.projectid,m.serverId,NVL(param, 0) as paramCount,NVL(stacount, 0) as stascount,NVL((param-NVL(stacount, 0)),0)as yetupdcount from\n"
                        + "(select ss.PID as projectid,ss.SERVER_ID as serverId,sum(counat1) param from SERVER_SYSTEM ss left join(\n"
                        + "select MATRIX_ID,count(*) as counat1 from SAP_MATRIX_PARAMETER where IS_ACTIVE=1 group by MATRIX_ID) aa  on  ss.M_ID=aa.MATRIX_ID \n"
                        + "where ss.IS_ACTIVE=1\n"
                        + "group by  ss.PID , ss.SERVER_ID\n"
                        + "order by ss.PID , ss.SERVER_ID) m \n"
                        + " left join (\n"
                        + "select ss.PID as projectid,ss.SERVER_ID as serverId,count(mpu.PARAM_STATUS) as stacount from SAP_MATRIX_PARAM_UPDATES mpu right join SAP_MATRIX_PARAMETER mp\n"
                        + "on mpu.MATRIX_PARAM_ID=mp.ID\n"
                        + "right join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID\n"
                        + "where ss.IS_ACTIVE=1 and mp.IS_ACTIVE=1  and mpu.STATUS_DATE=to_char(sysdate,'dd-Mon-yyyy')\n"
                        + "group by  ss.PID , ss.SERVER_ID\n"
                        + "order by ss.PID , ss.SERVER_ID) s\n"
                        + " on m.projectid=s.projectid and m.serverId=s.serverId\n"
                        + "order by m.projectid,m.serverId";
            } else {
                sql = "select m.projectid,m.serverId,param,NVL(stacount, 0) ,(param-NVL(stacount, 0)) from\n"
                        + "(select ss.PID as projectid,ss.SERVER_ID as serverId,sum(counat1) param from SERVER_SYSTEM ss left join(\n"
                        + "select MATRIX_ID,count(*) as counat1 from SAP_MATRIX_PARAMETER where IS_ACTIVE=1 group by MATRIX_ID) aa  on  ss.M_ID=aa.MATRIX_ID \n"
                        + "where ss.IS_ACTIVE=1 and ss.pid in(SELECT P.PID  FROM PROJECT P, USERPROJECT U where USERID = " + uid + " AND P.PID = U.PID AND status in('Work in progress') and category='SAP Project' and pmanager!=104)  \n"
                        + "group by  ss.PID , ss.SERVER_ID\n"
                        + "order by ss.PID , ss.SERVER_ID) m \n"
                        + " left join (\n"
                        + "select ss.PID as projectid,ss.SERVER_ID as serverId,count(mpu.PARAM_STATUS) as stacount from SAP_MATRIX_PARAM_UPDATES mpu right join SAP_MATRIX_PARAMETER mp\n"
                        + "on mpu.MATRIX_PARAM_ID=mp.ID\n"
                        + "right join SERVER_SYSTEM ss on mp.MATRIX_ID=ss.M_ID\n"
                        + "right join SAP_MONITORING_PARAMATERS p\n"
                        + "on mp.PARAMETER_ID=p.PARAMETER_ID and mp.MATRIX_ID=ss.M_ID where ss.IS_ACTIVE=1 and mp.IS_ACTIVE=1 and ss.pid in(SELECT P.PID  FROM PROJECT P, USERPROJECT U where USERID = " + uid + " AND P.PID = U.PID AND status in('Work in progress') and category='SAP Project' and pmanager!=104)  and mpu.STATUS_DATE=to_char(sysdate,'dd-Mon-yyyy')\n"
                        + "group by  ss.PID , ss.SERVER_ID\n"
                        + "order by ss.PID , ss.SERVER_ID) s\n"
                        + " on m.projectid=s.projectid and m.serverId=s.serverId\n"
                        + "order by m.projectid,m.serverId";
            }
            logger.info(sql);
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                MonitoringLog ml = new MonitoringLog();
                projSet.add(rs.getInt(1));
                ml.setPid(rs.getInt(1));
                ml.setServerId(rs.getInt(2));
                ml.setParamCount(rs.getInt(3));
                ml.setStaCount(rs.getInt(4));
                monitoringLog.add(ml);

            }
            if (role == 1) {
                rs1 = statement.executeQuery("select regexp_substr(p.PNAME,'\\w+') as projects,p.pname,p.version,p.pid  from project p where status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate,projects");
            } else {
                rs1 = statement.executeQuery("select regexp_substr(p.PNAME,'\\w+') as projects,p.pname,p.version,p.pid  from project p, USERPROJECT U where USERID = " + uid + " AND P.PID = U.PID and status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate,projects");

            }
            while (rs1.next()) {
                projectSet.put(rs1.getInt(4), rs1.getString(1) + "***" + rs1.getString(2) + " v" + rs1.getString(3));
            }

            int modSize = serverTypes.size() + 1;
            int projSize = projectSet.size() + 1;
            finalVal = new String[modSize][projSize];
            int col = 1, row = 1;
            String rat = "Not Done";
            for (SapServerType st : serverTypes) {
                for (Map.Entry<Integer, String> pro : projectSet.entrySet()) {
                    if (projSet.contains(pro.getKey())) {
                        MonitoringLog mi = getLog(pro.getKey(), st.getSId(), monitoringLog);
                        if (mi != null) {
                            if (st.getSId() == mi.getServerId() && pro.getKey() == mi.getPid()) {
                                if (mi.getParamCount() == 0) {
                                    rat = "Parameter Not Maintained";
                                } else {
                                    if (mi.getStaCount() == 0) {
                                        rat = "Not Monitored";
                                    } else {
                                        if (mi.getParamCount() - mi.getStaCount() == 0) {
                                            rat = "Monitored";
                                        } else if (mi.getParamCount() - mi.getStaCount() > 0) {
                                            rat = "Partially Monitored";
                                        }
                                    }
                                }
                            }
                        } else {
                            rat = "N/A";
                        }
                    } else {
                        rat = "Matrix Not Maintained";
                    }
                    finalVal[0][col] = pro.getValue();
                    finalVal[row][0] = st.getServerName();
                    finalVal[row][col] = pro.getKey() + "@@@" + st.getSId() + "@@@" + rat;
                    col++;
                }
                col = 1;
                row++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (rs1 != null) {
                    rs1.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }

        return finalVal;

    }

    MonitoringLog getLog(int pid, int serverId, List<MonitoringLog> logs) {
        MonitoringLog log = null;
        for (MonitoringLog mi : logs) {
            if (serverId == mi.getServerId() && pid == mi.getPid()) {
                log = mi;
                break;
            }
        }
        return log;
    }

}
