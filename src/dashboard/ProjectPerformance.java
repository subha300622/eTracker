/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dashboard;

import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import pack.eminent.encryption.MakeConnection;
import java.util.HashMap;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author ADAL
 */
public class ProjectPerformance {

    static Logger logger = Logger.getLogger("ProjectPerformance");
    private static HashMap<Integer, String> monthSelect = new HashMap<Integer, String>();

    static {

        monthSelect.put(0, "Jan");
        monthSelect.put(1, "Feb");
        monthSelect.put(2, "Mar");
        monthSelect.put(3, "Apr");
        monthSelect.put(4, "May");
        monthSelect.put(5, "Jun");
        monthSelect.put(6, "Jul");
        monthSelect.put(7, "Aug");
        monthSelect.put(8, "Sep");
        monthSelect.put(9, "Oct");
        monthSelect.put(10, "Nov");
        monthSelect.put(11, "Dec");

    }

    public static String[][] getValue(String pid) {
        Calendar c = new GregorianCalendar();
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        c.add(Calendar.MONTH, -11);
        String monthValue[][] = new String[12][6];
        for (int i = 0; i <= 11; i++) {
            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);
            String mon = monthSelect.get(month) + "-" + year;
//            logger.info("Time Sheet Month"+month);

            Calendar cale = Calendar.getInstance();
            cale.set(year, month, 1);
            int maxday = cale.getActualMaximum(Calendar.DATE);
            String start = "1" + "-" + monthSelect.get(month) + "-" + year;
            String end = maxday + "-" + monthSelect.get(month) + "-" + year;
            int workedIssues = getWorkedIssues(start, end, pid);
            int closedIssues = getClosedIssues(start, end, pid);
            int createdIssues = getCreatedIssues(start, end, pid);
            int openIssues = getOpenIssues(start, end, pid);
            logger.info("Total Open Issues" + openIssues);
            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();
            monthValue[i][5] = ((Integer) openIssues).toString();

        }
        return monthValue;
    }

    public static int getOpenIssues(String start, String end, String pid) {
        int noOfOpenIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select i.issueid,status from issue i , issuestatus s where i.issueid=s.issueid and pid='" + pid + "' and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY')<'" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and pid='" + pid + "' and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY')<'" + start + "') ";
            logger.info("Open Query" + query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfOpenIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return noOfOpenIssues;
    }

    public static int getWorkedIssues(String start, String end, String pid) {
        int noOfWorkedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and pid='" + pid + "' and comments!='Assigning to PM as due date exceeded' and to_date(to_char(comment_date, 'DD-Mon-YY '),'DD-Mon-YY ') between '" + start + "' and '" + end + "'  order by modifiedon desc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfWorkedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return noOfWorkedIssues;
    }

    public static int getClosedIssues(String start, String end, String pid) {
        int noOfClosedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            String query = "select distinct issuecomments.issueid, modifiedon  from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and pid='" + pid + "' and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "' and to_date(to_char(modifiedon,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "'  order by modifiedon desc";
            //               logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfClosedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfClosedIssues;
    }

    public static int getCreatedIssues(String start, String end, String pid) {
        int noOfCreatedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            String query = "select distinct issueid, modifiedon  from issue where pid='" + pid + "' and to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "' order by modifiedon desc";
//                logger.info("Created Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfCreatedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfCreatedIssues;
    }

    /*edit by Mukesh*/
    public static String[][] getValueList(String pid) {
        Calendar c = new GregorianCalendar();
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        int max = c.getActualMaximum(Calendar.DAY_OF_MONTH);
        String endDate = max + "-" + monthSelect.get(month) + "-" + year;

        c.add(Calendar.MONTH, -11);

        int montha = c.get(Calendar.MONTH);
        int yeara = c.get(Calendar.YEAR);

        String startDate = 01 + "-" + monthSelect.get(montha) + "-" + yeara;

        Calendar cl = Calendar.getInstance();
        cl.setTime(new Date());
        Long startt = cl.getTimeInMillis();

        Map<String, Integer> createdIssuesCount = getCreatedIssuesList(startDate, endDate, pid);

        cl.setTime(new Date());
        Long endt = cl.getTimeInMillis();
        System.out.println("getCreatedIssuesList--->" + (endt - startt));
        startt = endt;

        Map<String, Integer> closedIssuseCount = getClosedIssuesList(startDate, endDate, pid);

        cl.setTime(new Date());
        endt = cl.getTimeInMillis();
        System.out.println("getClosedIssuesList--->" + (endt - startt));
        startt = endt;

        Map<String, Integer> workedIssueCount = getWorkedIssuesList(startDate, endDate, pid);

        cl.setTime(new Date());
        endt = cl.getTimeInMillis();
        System.out.println("getWorkedIssuesList--->" + (endt - startt));

        cl.setTime(new Date());
        startt = cl.getTimeInMillis();

        Map<String, Integer> openIssue = getOpenIssueList(pid);

        cl.setTime(new Date());
        endt = cl.getTimeInMillis();
        System.out.println("getOpenIssues--->" + (endt - startt));

        String monthValue[][] = new String[12][6];
        for (int i = 0; i <= 11; i++) {
            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);
            String mon = monthSelect.get(month) + "-" + year;

            monthValue[i][0] = mon;
            String monYear = monthSelect.get(month) + "-" + year;

            if (workedIssueCount.containsKey(monYear)) {
                if (workedIssueCount.get(monYear) != null) {
                    monthValue[i][1] = (workedIssueCount.get(monYear)).toString();
                } else {
                    monthValue[i][1] = "0";
                }
            } else {
                monthValue[i][1] = "0";
            }

            if (closedIssuseCount.containsKey(monYear)) {
                if (closedIssuseCount.get(monYear) != null) {
                    monthValue[i][2] = (closedIssuseCount.get(monYear)).toString();
                } else {
                    monthValue[i][2] = "0";
                }
            } else {
                monthValue[i][2] = "0";
            }

            if (createdIssuesCount.containsKey(monYear)) {
                if (createdIssuesCount.get(monYear) != null) {
                    monthValue[i][3] = (createdIssuesCount.get(monYear)).toString();
                } else {
                    monthValue[i][3] = "0";
                }
            } else {
                monthValue[i][3] = "0";
            }

            if (openIssue.containsKey(monYear)) {
                if (openIssue.get(monYear) != null) {
                    monthValue[i][5] = (openIssue.get(monYear)).toString();
                } else {
                    monthValue[i][5] = "0";
                }
            } else {
                monthValue[i][5] = "0";
            }

            monthValue[i][4] = ((Integer) month).toString();
        }
        return monthValue;
    }

    public static Map<String, Integer> getWorkedIssuesList(String start, String end, String pid) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        String sql = "";
        try {
            /*Use one extra Date if not using to_date function in between cluse*/
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            Date ext = sdf.parse(end);
            Calendar calender = Calendar.getInstance();
            calender.setTime(ext);
            calender.add(Calendar.DATE, 1);
            String enddated = sdf.format(calender.getTime());

            sql = "Select month,count(issueid) from ( select  issuecomments.issueid,to_char(comment_date, 'Mon-YYYY') as month  from issuecomments,issue where issue.issueid=issuecomments.issueid and pid='" + pid + "' and comments!='Assigning to PM as due date exceeded' and comment_date between '" + start + "' and '" + enddated + "'  group by issuecomments.issueid,to_char(comment_date, 'Mon-YYYY') order by month  desc) group by month";

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        month = row[col].toString();
                    }
                }
                hm.put(month, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }

        return hm;
    }

    public static Map<String, Integer> getClosedIssuesList(String start, String end, String pid) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        String sql = "";
        try {
            sql = "Select month,count(issueid) from(select distinct issuecomments.issueid,to_char(modifiedon , 'Mon-YYYY') as month from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and pid='" + pid + "' and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and  comment_date between   '" + start + "' and '" + end + "' and modifiedon between '" + start + "' and '" + end + "' order by month desc) group by month";
            System.out.println(sql);
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        month = row[col].toString();
                    }
                }
                hm.put(month, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }

        return hm;
    }

    public static Map<String, Integer> getCreatedIssuesList(String start, String end, String pid) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        String sql = "";
        try {
            sql = "Select month,count(issueid) from(select distinct issueid, to_char(createdon,'Mon-YYYY') as month from issue where pid='" + pid + "' and  createdon between  '" + start + "' and '" + end + "' order by month desc) group by month";
            System.out.println(sql);
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        month = row[col].toString();
                    }
                }
                hm.put(month, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }
        return hm;
    }

    public static Map<String, Integer> getOpenIssueList(String pid) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        String sql = "";
        Calendar c = new GregorianCalendar();
        c.setTime(new Date());
        c.add(Calendar.MONTH, -11);
        try {
            session = HibernateFactory.getCurrentSession();

            for (int i = 0; i <= 11; i++) {
                int month = c.get(Calendar.MONTH);
                int year = c.get(Calendar.YEAR);
                c.add(Calendar.MONTH, 1);
                String mon = monthSelect.get(month) + "-" + year;
                Calendar cale = Calendar.getInstance();
                cale.set(year, month, 1);
                int maxday = cale.getActualMaximum(Calendar.DATE);
                String start = "1" + "-" + monthSelect.get(month) + "-" + year;
                String end = maxday + "-" + monthSelect.get(month) + "-" + year;
                sql = "select totalcount,closeCount from (Select count(i.issueid) as totalcount,pid from issue i where pid='" + pid + "' and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY')<'" + end + "'  group by pid) s,(Select count(i.issueid) as closeCount,pid from issue i , issuestatus s where i.issueid=s.issueid and pid='" + pid + "' and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY')<'" + start + "' group by pid) a where s.pid =a.pid";
                Query query = session.createSQLQuery(sql);
                Iterator iterator = query.list().iterator();
                while (iterator.hasNext()) {
                    Integer totalcount = 0;
                    Integer closecount = 0;
                    Object[] row = (Object[]) iterator.next();
                    for (int col = 0; col < row.length; col++) {
                        if (col == 0) {
                            totalcount = MoMUtil.parseInteger(row[col].toString(), 0);
                        } else if (col == 1) {
                            closecount = MoMUtil.parseInteger(row[col].toString(), 0);
                        }
                    }
                    Integer count = totalcount - closecount;
                    hm.put(mon, count);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            e.printStackTrace();
        } finally {
            getCloseConnection(session);
        }

        return hm;
    }

    public static void getCloseConnection(Session session) {
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
}
