/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dashboard;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author ADAL
 */
public class ProjectIssues {

    static Logger logger = Logger.getLogger("ProjectIssues");

    public static String[][] totalOpenIssues(String startDate, String endDate) {
        String openIssues[][] = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("Select i.pid,p.pname,version,count(*) from issue i , issuestatus s,project p where p.status!='Finished' and p.phase!='Closed' and p.phase!='Suspended' and p.pid=i.pid and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY')<'" + endDate + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY')<'" + startDate + "') group by i.pid,p.pname,version");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String project[][] = new String[rowcount][3];
            int i = 0;
            while (resultset.next()) {
                project[i][0] = resultset.getString(1);
                project[i][1] = resultset.getString(2) + " v" + resultset.getString(3);
                project[i][2] = resultset.getString(4);

                i++;
            }
            openIssues = project;
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
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return openIssues;
    }

    public static String[][] totalClosedIssues(String startDate, String endDate) {
        String closedIssues[][] = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("Select i.pid,p.pname,version,count(*) from issue i , issuestatus s,project p where p.pid=i.pid and i.issueid=s.issueid and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + startDate + "' and '" + endDate + "' and s.status='Closed' group by i.pid,p.pname,version");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String project[][] = new String[rowcount][3];
            int i = 0;
            while (resultset.next()) {
                project[i][0] = resultset.getString(1);
                project[i][1] = resultset.getString(2) + " v" + resultset.getString(3);
                project[i][2] = resultset.getString(4);

                i++;
            }
            closedIssues = project;
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
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return closedIssues;
    }

    public static String[][] totalClosedRatings(String startDate, String endDate) {
        String closedIssues[][] = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("Select rating,count(*) from issue i , issuestatus s,project p where p.status!='Finished' and p.phase!='Closed' and p.phase!='Suspended' and p.pid=i.pid and i.issueid=s.issueid and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and s.status='Closed' group by rating");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String project[][] = new String[rowcount][2];
            int i = 0;
            while (resultset.next()) {
                project[i][0] = resultset.getString(1);
                project[i][1] = resultset.getString(2);

                i++;
            }
            closedIssues = project;
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
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return closedIssues;
    }

    public static String[][] totalCreatedIssues(String startDate, String endDate) {
        String createdIssues[][] = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("Select i.pid,p.pname,version,count(*) from issue i , issuestatus s,project p where p.status!='Finished' and p.phase!='Closed' and p.phase!='Suspended' and p.pid=i.pid and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' group by i.pid,p.pname,version");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String project[][] = new String[rowcount][3];
            int i = 0;
            while (resultset.next()) {
                project[i][0] = resultset.getString(1);
                project[i][1] = resultset.getString(2) + " v" + resultset.getString(3);
                project[i][2] = resultset.getString(4);

                i++;
            }
            createdIssues = project;
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
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return createdIssues;
    }

    public static String[][] totalWorkedIssues(String startDate, String endDate) {
        String workedIssues[][] = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("Select i.pid,p.pname,version,count(*) from issue i , issuestatus s,project p where p.status!='Finished' and p.phase!='Closed' and p.phase!='Suspended' and p.pid=i.pid and i.issueid=s.issueid and i.issueid in (select distinct issueid  from issuecomments where to_date(to_char(comment_date,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + startDate + "' and '" + endDate + "' and comments!='Assigning to PM as due date exceeded') group by i.pid,p.pname,version");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String project[][] = new String[rowcount][3];
            int i = 0;
            while (resultset.next()) {
                project[i][0] = resultset.getString(1);
                project[i][1] = resultset.getString(2) + " v" + resultset.getString(3);
                project[i][2] = resultset.getString(4);

                i++;
            }
            workedIssues = project;
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
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return workedIssues;
    }
}
