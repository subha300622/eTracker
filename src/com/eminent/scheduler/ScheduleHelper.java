package com.eminent.scheduler;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.text.SimpleDateFormat;

import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;
import com.eminent.util.GetDate;

/**
 *
 * @author Tamilvelan
 */
public class ScheduleHelper {

    private static HashMap<Integer, String> hm = new HashMap<Integer, String>();

    static {

        hm.put(0, "Jan");
        hm.put(1, "Feb");
        hm.put(2, "Mar");
        hm.put(3, "Apr");
        hm.put(4, "May");
        hm.put(5, "Jun");
        hm.put(6, "Jul");
        hm.put(7, "Aug");
        hm.put(8, "Sep");
        hm.put(9, "Oct");
        hm.put(10, "Nov");
        hm.put(11, "Dec");

    }

    static Logger logger = null;

    static {
        logger = Logger.getLogger("Schedule Helper");

    }

    public static ArrayList getVerifiedUser() {

        Connection connection = null;
        ResultSet verifiedUserRS = null;
        PreparedStatement verifiedUserPS = null;

        ArrayList al = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            verifiedUserPS = connection.prepareStatement("select distinct assignedto from issue,issuestatus where issue.issueid=issuestatus.issueid and issuestatus.status='Verified'");
            verifiedUserRS = verifiedUserPS.executeQuery();

            while (verifiedUserRS.next()) {
                al.add(verifiedUserRS.getString("assignedto"));
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (verifiedUserRS != null) {
                    verifiedUserRS.close();
                }
                if (verifiedUserPS != null) {
                    verifiedUserPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ ex.getMessage());
            }
        }

        return al;
    }

    public static ArrayList getNonCommentedUser() {

        Connection connection = null;
        ResultSet verifiedUserRS = null;
        PreparedStatement verifiedUserPS = null;

        ArrayList al = new ArrayList<String>();
        Date date = GetDate.getDate();
        String today = GetDate.getStringDate();
        try {
            connection = MakeConnection.getConnection();
            verifiedUserPS = connection.prepareStatement("select email from users where roleid>0 and userid not in (select distinct commentedby from issuecomments where trunc(comment_date)='" + today + "')");
            verifiedUserRS = verifiedUserPS.executeQuery();

            while (verifiedUserRS.next()) {
                al.add(verifiedUserRS.getString(1));
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (verifiedUserRS != null) {
                    verifiedUserRS.close();
                }
                if (verifiedUserPS != null) {
                    verifiedUserPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ ex.getMessage());
            }

        }

        return al;
    }

    public static int getAssignmentCount(String email) {

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;

        logger.info("User Email id" + email);

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs = st.executeQuery("select count(*) count from issue i, issuestatus s where i.issueid = s.issueid and status != 'Closed' and assignedto = (select userid from users where email='" + email + "') ");
            if (rs.next()) {
                count = rs.getInt("count");

            }

        } catch (Exception e) {
            logger.error("Error while finding the count"+e.getMessage());
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
                logger.error("Error while finding the flag"+ex.getMessage());
            }

        }
        logger.info("Issue Count" + count);

        return count;

    }

    public static ArrayList getDueDateExceededUsers() {

        Connection connection = null;
        ResultSet verifiedUserRS = null;
        PreparedStatement verifiedUserPS = null;

        ArrayList al = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            verifiedUserPS = connection.prepareStatement("Select distinct assignedto from issue i,issuestatus s where i.issueid = s.issueid and s.status != 'Closed' and i.due_date< to_date((select to_char(sysdate,'DD-Mon-YYYY') from dual),'DD-Mon-YY') order by assignedto asc");
            verifiedUserRS = verifiedUserPS.executeQuery();

            while (verifiedUserRS.next()) {
                al.add(verifiedUserRS.getString(1));
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (verifiedUserRS != null) {
                    verifiedUserRS.close();
                }
                if (verifiedUserPS != null) {
                    verifiedUserPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return al;
    }

    public static ArrayList getDueDateAboutToExceed() {

        Connection connection = null;
        ResultSet verifiedUserRS = null;
        PreparedStatement verifiedUserPS = null;

        ArrayList al = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            verifiedUserPS = connection.prepareStatement("Select distinct assignedto from issue i,issuestatus s,project p where  i.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid = s.issueid and s.status != 'Closed' and (select i.DUE_DATE - trunc(sysdate)  from dual) <=3 order by assignedto asc");
            verifiedUserRS = verifiedUserPS.executeQuery();

            while (verifiedUserRS.next()) {
                al.add(verifiedUserRS.getString(1));
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (verifiedUserRS != null) {
                    verifiedUserRS.close();
                }
                if (verifiedUserPS != null) {
                    verifiedUserPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return al;
    }

    public static ArrayList getEminentlabsUser() {

        Connection connection = null;
        ResultSet eminentlabsUserRS = null;
        PreparedStatement eminentlabsUserPS = null;

        ArrayList al = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            eminentlabsUserPS = connection.prepareStatement("select userid from users where roleid>0 and email like '%@eminentlabs.net'");
            eminentlabsUserRS = eminentlabsUserPS.executeQuery();

            while (eminentlabsUserRS.next()) {
                al.add(eminentlabsUserRS.getString("userid"));
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (eminentlabsUserRS != null) {
                    eminentlabsUserRS.close();
                }
                if (eminentlabsUserPS != null) {
                    eminentlabsUserPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting eminentlabs users"+ex.getMessage());
            }
        }

        return al;
    }

    public static String[][] getProjectDetails() {
        Connection connection = null;
        ResultSet projectDetailsRS = null;
        PreparedStatement projectDetailsPS = null;
        String projectDetails[][] = null;

        try {
            connection = MakeConnection.getConnection();
            projectDetailsPS = connection.prepareStatement("select pid,pname,version,email from project p,users u where upper(status) =upper('Work in progress') and pmanager=userid", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            projectDetailsRS = projectDetailsPS.executeQuery();
            projectDetailsRS.last();
            int noOfProject = projectDetailsRS.getRow();
            projectDetails = new String[noOfProject][4];
            projectDetailsRS.beforeFirst();
            int i = 0;

            while (projectDetailsRS.next()) {
                projectDetails[i][0] = projectDetailsRS.getString("pid");
                projectDetails[i][1] = projectDetailsRS.getString("email");
                projectDetails[i][2] = projectDetailsRS.getString("pname");
                projectDetails[i][3] = projectDetailsRS.getString("version");
                i++;
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (projectDetailsRS != null) {
                    projectDetailsRS.close();
                }
                if (projectDetailsPS != null) {
                    projectDetailsPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting Active Projects"+ex.getMessage());
            }

            return projectDetails;
        }
    }

    public static String[][] getProjectMembers(String pid) {
        Connection connection = null;
        ResultSet projectMemberDetailsRS = null;
        PreparedStatement projectMemberDetailsPS = null;
        String memberDetails[][] = null;
        int projectId = Integer.parseInt(pid);

        try {
            connection = MakeConnection.getConnection();
            projectMemberDetailsPS = connection.prepareStatement("select up.userid,u.firstname||' '||u.lastname as Name,email,substr(email,instr(email,'@')+1,LENGTH(email)) as domain from userproject up,users u where up.pid=" + projectId + " and u.userid=up.userid and u.roleid>0 order by domain, u.firstname", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            projectMemberDetailsRS = projectMemberDetailsPS.executeQuery();
            projectMemberDetailsRS.last();
            int noOfMembers = projectMemberDetailsRS.getRow();
            //           System.out.println("Project id"+projectId+"No Of Members"+noOfMembers);
            memberDetails = new String[noOfMembers][3];
            projectMemberDetailsRS.beforeFirst();
            int i = 0;

            while (projectMemberDetailsRS.next()) {
                memberDetails[i][0] = projectMemberDetailsRS.getString(1);
                memberDetails[i][1] = projectMemberDetailsRS.getString(2);
                memberDetails[i][2] = projectMemberDetailsRS.getString(3);
                i++;
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (projectMemberDetailsRS != null) {
                    projectMemberDetailsRS.close();
                }
                if (projectMemberDetailsPS != null) {
                    projectMemberDetailsPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting Project Members"+ex.getMessage());
            }

            return memberDetails;
        }
    }

    public static String[][] getProjectStatus(String pid) {
        Connection connection = null;
        ResultSet projectStatusRS = null;
        PreparedStatement projectStatusPS = null;
        String moduleDetails[][] = null;

        try {
            connection = MakeConnection.getConnection();
            projectStatusPS = connection.prepareStatement("select moduleid,module from modules m,project p where p.pid=m.pid and p.pid='" + pid + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            projectStatusRS = projectStatusPS.executeQuery();
            projectStatusRS.last();
            int noOfMembers = projectStatusRS.getRow();
            moduleDetails = new String[noOfMembers][6];
            projectStatusRS.beforeFirst();
            int i = 0;
            //          projectStatusRS.next();
            while (projectStatusRS.next()) {
                moduleDetails[i][0] = projectStatusRS.getString("Module");
                int issueDetails[] = ScheduleHelper.getModuleDetails(pid, projectStatusRS.getString("moduleid"));
                moduleDetails[i][1] = ((Integer) issueDetails[0]).toString();
                moduleDetails[i][2] = ((Integer) issueDetails[1]).toString();
                moduleDetails[i][3] = ((Integer) issueDetails[2]).toString();
                moduleDetails[i][4] = ((Integer) issueDetails[3]).toString();
                moduleDetails[i][5] = ((Integer) issueDetails[4]).toString();
                i++;
            }

        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (projectStatusRS != null) {
                    projectStatusRS.close();
                }
                if (projectStatusPS != null) {
                    projectStatusPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting Project Members"+ex.getMessage());
            }

            return moduleDetails;
        }
    }

    public static int[] getModuleDetails(String pid, String moduleid) {
        Connection connection = null;
        ResultSet moduleClosedIssuesRS = null, moduleOpenIssuesRS = null, moduleWeeklyClosedIssuesRS = null, moduleWeeklyOpenIssuesRS = null, moduleWeeklyWorkedIssuesRS = null;
        Statement moduleClosedIssuesPS = null, moduleOpenIssuesPS = null, moduleWeeklyClosedIssuesPS = null, moduleWeeklyOpenIssuesPS = null, moduleWeeklyWorkedIssuesPS = null;
        int issueNoDetails[] = new int[5];
        int noOfClosedIssues = 0;
        int noOfOpenIssues = 0;
        int noOfWeeklyClosedIssues = 0;
        int noOfWeeklyWorkedIssues = 0;
        int noOfWeeklyOpenIssues = 0;
        int mod = Integer.parseInt(moduleid);

        try {
            connection = MakeConnection.getConnection();
            moduleClosedIssuesPS = connection.createStatement();
            moduleClosedIssuesRS = moduleClosedIssuesPS.executeQuery("select count(*) as count from issue i,issuestatus s where module_id='" + mod + "' and i.issueid=s.issueid and status='Closed'");
            moduleClosedIssuesRS.next();
            noOfClosedIssues = moduleClosedIssuesRS.getInt("count");

            moduleOpenIssuesPS = connection.createStatement();
            moduleOpenIssuesRS = moduleOpenIssuesPS.executeQuery("select count(*) as count from issue i,issuestatus s where module_id='" + mod + "' and i.issueid=s.issueid and status!='Closed'");
            moduleOpenIssuesRS.next();
            noOfOpenIssues = moduleOpenIssuesRS.getInt("count");

            Calendar cal = Calendar.getInstance();

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

            String end = dateFormat.format(cal.getTime());

            cal.add(Calendar.DATE, -6);

            String start = dateFormat.format(cal.getTime());

            String closedsql = "select count(*)  from issue i, issuestatus s where i.issueid = s.issueid and pid='" + pid + "' and  module_id='" + mod + "' and s.status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "'";
            logger.info(closedsql);
            moduleWeeklyClosedIssuesPS = connection.createStatement();
            moduleWeeklyClosedIssuesRS = moduleWeeklyClosedIssuesPS.executeQuery(closedsql);
            while (moduleWeeklyClosedIssuesRS.next()) {
                noOfWeeklyClosedIssues = moduleWeeklyClosedIssuesRS.getInt(1);
            }
            moduleWeeklyWorkedIssuesPS = connection.createStatement();
            moduleWeeklyWorkedIssuesRS = moduleWeeklyWorkedIssuesPS.executeQuery("select count(*)  from issue where pid='" + pid + "' and module_id=" + mod + " and modifiedon between '" + start + "' and '" + end + "'");
            while (moduleWeeklyWorkedIssuesRS.next()) {
                noOfWeeklyWorkedIssues = moduleWeeklyWorkedIssuesRS.getInt(1);
            }
            moduleWeeklyOpenIssuesPS = connection.createStatement();
            moduleWeeklyOpenIssuesRS = moduleWeeklyOpenIssuesPS.executeQuery("select count(*) as count from issue where pid='" + pid + "' and module_id=" + mod + " and createdon between '" + start + "' and '" + end + "'");
            while (moduleWeeklyOpenIssuesRS.next()) {
                noOfWeeklyOpenIssues = moduleWeeklyOpenIssuesRS.getInt("count");
            }

            issueNoDetails[0] = noOfWeeklyOpenIssues;
            issueNoDetails[1] = noOfWeeklyWorkedIssues;
            issueNoDetails[2] = noOfWeeklyClosedIssues;
            issueNoDetails[3] = noOfOpenIssues;
            issueNoDetails[4] = noOfClosedIssues;

        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (moduleClosedIssuesRS != null) {
                    moduleClosedIssuesRS.close();
                }
                if (moduleClosedIssuesPS != null) {
                    moduleClosedIssuesPS.close();
                }
                if (moduleOpenIssuesRS != null) {
                    moduleOpenIssuesRS.close();
                }
                if (moduleOpenIssuesPS != null) {
                    moduleOpenIssuesPS.close();
                }
                if (moduleWeeklyClosedIssuesRS != null) {
                    moduleWeeklyClosedIssuesRS.close();
                }
                if (moduleWeeklyClosedIssuesPS != null) {
                    moduleWeeklyClosedIssuesPS.close();
                }
                if (moduleWeeklyWorkedIssuesRS != null) {
                    moduleWeeklyWorkedIssuesRS.close();
                }
                if (moduleWeeklyWorkedIssuesPS != null) {
                    moduleWeeklyWorkedIssuesPS.close();
                }
                if (moduleWeeklyOpenIssuesRS != null) {
                    moduleWeeklyOpenIssuesRS.close();
                }
                if (moduleWeeklyOpenIssuesPS != null) {
                    moduleWeeklyOpenIssuesPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting Project Members"+ex.getMessage());
            }

            return issueNoDetails;
        }
    }

    public static int WeeklyTotalWorkedIssue(String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int workedIssues = 0;
        try {
            Calendar cal = Calendar.getInstance();

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

            String end = dateFormat.format(cal.getTime());

            cal.add(Calendar.DATE, -6);

            String start = dateFormat.format(cal.getTime());

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*)  from issue where pid='" + pid + "' and modifiedon between '" + start + "' and '" + end + "'");
            while (resultset.next()) {

                workedIssues = resultset.getInt(1);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
//                    logger.info("Connection closed");
                    if (connection.isClosed()) {
//                        logger.info("Closed");
                    } else {
//                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            return workedIssues;
        }
    }

    public static int WeeklyTotalCreatedIssue(String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int createdIssues = 0;
        try {
            Calendar cal = Calendar.getInstance();

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

            String end = dateFormat.format(cal.getTime());

            cal.add(Calendar.DATE, -6);

            String start = dateFormat.format(cal.getTime());

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*)  from issue where pid='" + pid + "' and createdon between '" + start + "' and '" + end + "'");
            while (resultset.next()) {

                createdIssues = resultset.getInt(1);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
//                    logger.info("Connection closed");
                    if (connection.isClosed()) {
//                        logger.info("Closed");
                    } else {
//                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            return createdIssues;
        }
    }

    public static int WeeklyTotalClosedIssue(String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int closedIssues = 0;
        try {
            Calendar cal = Calendar.getInstance();

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

            String end = dateFormat.format(cal.getTime());

            cal.add(Calendar.DATE, -6);

            String start = dateFormat.format(cal.getTime());

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*)  from issue i, issuestatus s where i.issueid = s.issueid and pid='" + pid + "'  and s.status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "'");
            while (resultset.next()) {

                closedIssues = resultset.getInt(1);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
//                    logger.info("Connection closed");
                    if (connection.isClosed()) {
//                        logger.info("Closed");
                    } else {
//                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
      logger.error(ex.getMessage());
            }
            return closedIssues;
        }
    }

    public static boolean isTimesheetCreated(int userid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        boolean flag = false;
        try {
            Calendar cal = Calendar.getInstance();

            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);
            String start = "1" + "-" + hm.get(month) + "-" + year;
            String end = day + "-" + hm.get(month) + "-" + year;
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select timesheetid  from timesheet where owner='" + userid + "'  and to_date(to_char(requestedon,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "'";
            resultset = statement.executeQuery(sql);
            logger.info("Query" + sql);
            while (resultset.next()) {

                flag = true;

            }
        } catch (Exception e) {
            logger.error("Error while Auto Reassignment of Issue"+e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
            } catch (Exception rs) {
                logger.error("Error while closing ResultSet"+rs.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception st) {
                logger.error("Error while closing Statement"+st.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception cn) {
                logger.error("Error while closing Connection"+ cn.getMessage());
            }
        }
        return flag;
    }
    public static ArrayList getDueDateAboutToExceedByPM() {

        Connection connection = null;
        ResultSet verifiedUserRS = null;
        PreparedStatement verifiedUserPS = null;

        ArrayList al = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            verifiedUserPS = connection.prepareStatement("Select distinct p.pmanager from issue i,issuestatus s,project p where  i.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid and s.status != 'Closed' and (select i.DUE_DATE - trunc(sysdate)  from dual) <=3 order by pmanager asc");
            verifiedUserRS = verifiedUserPS.executeQuery();

            while (verifiedUserRS.next()) {
                al.add(verifiedUserRS.getString(1));
            }
        } catch (Exception s) {
           logger.error(s.getMessage());
        } finally {
            try {
                if (verifiedUserRS != null) {
                    verifiedUserRS.close();
                }
                if (verifiedUserPS != null) {
                    verifiedUserPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return al;
    }
}
