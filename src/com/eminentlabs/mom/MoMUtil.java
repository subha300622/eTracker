package com.eminentlabs.mom;

import com.eminent.issue.AgreedIssues;
import com.eminent.issue.AgreedIssuesPK;
import com.eminent.issue.formbean.UserPlannedIssues;
import com.eminent.leaveUtil.LeaveBlancePeriodDAO;
import com.eminent.util.IssueDetails;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import static com.eminentlabs.mom.MoMUtil.logger;
import com.eminentlabs.wrm.User;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
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
import java.util.ResourceBundle;
import java.util.Set;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import oracle.jdbc.driver.OracleTypes;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class MoMUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("MOM Util");
    }
    private static ResourceBundle rb = null;

    static {
        rb = ResourceBundle.getBundle("Resources");
    }

    public static String getTaskId() throws Exception {
        String taskId = null;
        Connection connection = null;
        Statement statement = null, dateCheck = null, dropSeqeunceSt = null, seqStatement = null;
        ResultSet resultset = null, dateCheckRs = null, dropSequence = null, seqResultSet = null;
        int day, month, year;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select extract(day from sysdate) as day,extract(month from sysdate) as month,extract(year from sysdate) as year,TO_CHAR(sysdate,'dd-mon-yyyy') as today from dual");
            resultset.next();
            day = resultset.getInt("day");
            month = resultset.getInt("month");
            year = resultset.getInt("year");

            if (day < 10) {
                taskId = "" + day;
            } else {
                taskId = "" + day;
            }
            if (month < 10) {
                taskId = taskId + "0" + month + year;
            } else {
                taskId = taskId + month + year;
            }

            dateCheck = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dateCheckRs = statement.executeQuery("select MOMTASKID from MOM_USER_TASK where to_char(createdon,'dd-mm-yyyy') like (select to_char(sysdate,'dd-mm-yyyy') from dual)");

            if (dateCheckRs.next()) {
                seqStatement = connection.createStatement();
                seqResultSet = seqStatement.executeQuery("select MOMID_SEQ.nextval as nextvalue from dual");

                seqResultSet.next();
                int nextValue = seqResultSet.getInt("nextvalue");
                logger.info("Next Id Value:\t" + nextValue);
                if (nextValue < 10) {
                    taskId = taskId + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    taskId = taskId + "0" + nextValue;
                } else {
                    taskId = taskId + nextValue;
                }
                logger.info("MOM ID:\t" + taskId);

            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence MOMID_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("create sequence MOMID_SEQ start with 1 increment by 1 nocache nocycle");
                dropSequence = dropSeqeunceSt.executeQuery("select MOMID_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                int nextValue = dropSequence.getInt("nextvalue");
                if (nextValue < 10) {
                    taskId = taskId + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    taskId = taskId + "0" + nextValue;
                } else {
                    taskId = taskId + nextValue;
                }
                logger.info("dropped PTC ID:\t" + taskId);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }

            if (statement != null) {
                statement.close();
            }
            if (dateCheckRs != null) {
                dateCheckRs.close();
            }

            if (dateCheck != null) {
                dateCheck.close();
            }
            if (dropSequence != null) {
                dropSequence.close();
            }

            if (dropSeqeunceSt != null) {
                dropSeqeunceSt.close();
            }
            if (seqResultSet != null) {
                seqResultSet.close();
            }

            if (seqStatement != null) {
                seqStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return taskId;
    }

    public static String getUserId() throws Exception {
        String taskId = null;
        Connection connection = null;
        Statement statement = null, dateCheck = null, dropSeqeunceSt = null, seqStatement = null;
        ResultSet resultset = null, dateCheckRs = null, dropSequence = null, seqResultSet = null;
        int day, month, year;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select extract(day from sysdate) as day,extract(month from sysdate) as month,extract(year from sysdate) as year,TO_CHAR(sysdate,'dd-mon-yyyy') as today from dual");
            resultset.next();
            day = resultset.getInt("day");
            month = resultset.getInt("month");
            year = resultset.getInt("year");

            if (day < 10) {
                taskId = "" + day;
            } else {
                taskId = "" + day;
            }
            if (month < 10) {
                taskId = taskId + "0" + month + year;
            } else {
                taskId = taskId + month + year;
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }

            if (statement != null) {
                statement.close();
            }
            if (dateCheckRs != null) {
                dateCheckRs.close();
            }

            if (dateCheck != null) {
                dateCheck.close();
            }
            if (dropSequence != null) {
                dropSequence.close();
            }

            if (dropSeqeunceSt != null) {
                dropSeqeunceSt.close();
            }
            if (seqResultSet != null) {
                seqResultSet.close();
            }

            if (seqStatement != null) {
                seqStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return taskId;
    }

    public static void createTask(int userId, String task, int createdBy, String type, String taskTime) {
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        String issueno = "";
        String prevIssues = "";
        if (type.equalsIgnoreCase("Count") || type.equalsIgnoreCase("Task")) {
        } else {
            prevIssues = getPrevIssues(userId, dateFor);
        }
        List pIssueList = new ArrayList();
        if (!prevIssues.isEmpty() || prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        MomUserTask usertask = new MomUserTask();
        try {
            if (type.equalsIgnoreCase("issue")) {
                issueno = task;
                HashMap issue = IssueDetails.getIssue(task);
                String sub = (String) issue.get("subject");
                String status = (String) issue.get("status");
                String duedate = (String) issue.get("Formatduedate");
                String pName = (String) issue.get("projectname") + " v" + (String) issue.get("fixversion");
                Date duDate = sdf.parse(duedate);
                Date currentDate = new Date();
                String statusColor = "";
                String subjectColor = "";
                currentDate = subtractDay(currentDate);
                if (duDate.compareTo(currentDate) < 0) {
                    statusColor = "Red";
                }
                if (pIssueList.contains(task.trim())) {

                    subjectColor = "#D2691E";

                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : <font color='" + subjectColor + "'>" + sub + "</font>";
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : <font color='" + subjectColor + "'>" + sub + "</font>";
                    }
                } else {
                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : " + sub;
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : " + sub + "</font>";
                    }

                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        try {
            usertask.setMomtaskid(getTaskId());
            usertask.setUserid(userId);
            logger.info(task);
            usertask.setTask(task);
            usertask.setCreatedby(createdBy);
            usertask.setCreatedon(date);
            usertask.setModifiedon(date);
            usertask.setMomdate(date);
            usertask.setType(type);
            usertask.setTasktime(taskTime);
            boolean flag = true;

            if (type.equalsIgnoreCase("Issue")) {

                String momtaskid = uniqueIssueTask(userId, dateFor, issueno, taskTime);
                if (momtaskid != null) {
                    usertask.setMomtaskid(momtaskid.split("&&")[0]);
                    if (!momtaskid.split("&&")[1].equalsIgnoreCase("") && !momtaskid.split("&&")[1].equalsIgnoreCase("null")) {
                        usertask.setSino(parseInteger(momtaskid.split("&&")[1],99));
                    }
                    DAOFactory.updateTask(usertask);
                } else {
                    flag = false;
                }
            } else {
                flag = uniqueTask(userId, dateFor, task, taskTime);

            }

            if (flag == false) {
                DAOFactory.createTask(usertask);
            } else {
                logger.info("Same task already added by the user");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static void createTask(int userId, String task, int createdBy, String type, String taskTime, Date momDate) {

        Timestamp currentDateTim = new Timestamp(new java.util.Date().getTime());

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(momDate);
        Date date = null;
        try {
            date = sdf.parse(dateFor);
        } catch (ParseException e) {
            logger.error(e.getMessage());
        }
        if (date == null) {
            date = momDate;
        }
        String issueno = "";
        String prevIssues = getPrevIssues(userId, dateFor);
        List pIssueList = new ArrayList();
        if (prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        MomUserTask usertask = new MomUserTask();
        try {
            if (type.equalsIgnoreCase("issue")) {
                issueno = task;
                HashMap issue = IssueDetails.getIssue(task);
                String sub = (String) issue.get("subject");
                String status = (String) issue.get("status");
                String duedate = (String) issue.get("Formatduedate");
                String pName = (String) issue.get("projectname") + " v" + (String) issue.get("fixversion");
                Date duDate = sdf.parse(duedate);
                Date currentDate = new Date();
                String statusColor = "";
                String subjectColor = "";
                currentDate = subtractDay(currentDate);
                if (duDate.compareTo(currentDate) < 0) {
                    statusColor = "Red";
                }
                if (pIssueList.contains(task.trim())) {

                    subjectColor = "#D2691E";

                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : <font color='" + subjectColor + "'>" + sub + "</font>";
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : <font color='" + subjectColor + "'>" + sub + "</font>";
                    }
                } else {
                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : " + sub;
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : " + sub + "</font>";
                    }

                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        try {
            usertask.setMomtaskid(getTaskId());
            usertask.setUserid(userId);
            logger.info(task);
            usertask.setTask(task);
            usertask.setCreatedby(createdBy);
            usertask.setCreatedon(currentDateTim);
            usertask.setModifiedon(currentDateTim);
            usertask.setMomdate(date);
            usertask.setType(type);
            usertask.setTasktime(taskTime);
            boolean flag = true;

            if (type.equalsIgnoreCase("Issue")) {

                String momtaskid = uniqueIssueTask(userId, dateFor, issueno, taskTime);
                if (momtaskid != null) {
                    usertask.setMomtaskid(momtaskid.split("&&")[0]);
                                        if (!momtaskid.split("&&")[1].equalsIgnoreCase("") && !momtaskid.split("&&")[1].equalsIgnoreCase("null")) {
                        usertask.setSino(parseInteger(momtaskid.split("&&")[1],99));
                    }
                    DAOFactory.updateTask(usertask);
                } else {
                    flag = false;
                }
            } else {
                flag = uniqueTask(userId, dateFor, task, taskTime);

            }

            if (flag == false) {
                DAOFactory.createTask(usertask);
            } else {
                logger.info("Same task already added by the user");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static void createTaskOnDate(int userId, String task, int createdBy, String type, String taskTime, Date planDate) {
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        String planFor = sdf.format(planDate);
        String issueno = "";
        String prevIssues = getPrevIssues(userId, dateFor);
        List pIssueList = new ArrayList();
        if (prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        MomUserTask usertask = new MomUserTask();
        try {
            if (type.equalsIgnoreCase("issue")) {
                issueno = task;
                HashMap issue = IssueDetails.getIssue(task);
                String sub = (String) issue.get("subject");
                String status = (String) issue.get("status");
                String duedate = (String) issue.get("Formatduedate");
                String pName = (String) issue.get("projectname") + " v" + (String) issue.get("fixversion");
                Date duDate = sdf.parse(duedate);
                String statusColor = "";
                String subjectColor = "";
                Date currentDate = subtractDay(planDate);
                if (duDate.compareTo(currentDate) < 0) {
                    statusColor = "Red";
                }
                if (pIssueList.contains(task.trim())) {

                    subjectColor = "#D2691E";

                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : <font color='" + subjectColor + "'>" + sub + "</font>";
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : <font color='" + subjectColor + "'>" + sub + "</font>";
                    }
                } else {
                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : " + sub;
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : " + sub + "</font>";
                    }

                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        try {
            usertask.setMomtaskid(getTaskId());
            usertask.setUserid(userId);
            logger.info(task);
            usertask.setTask(task);
            usertask.setCreatedby(createdBy);
            usertask.setCreatedon(date);
            usertask.setModifiedon(date);
            usertask.setMomdate(planDate);
            usertask.setType(type);
            usertask.setTasktime(taskTime);
            boolean flag = true;

            if (type.equalsIgnoreCase("Issue")) {

                String momtaskid = uniqueIssueTask(userId, planFor, issueno, taskTime);
                if (momtaskid != null) {
                    usertask.setMomtaskid(momtaskid.split("&&")[0]);
                    if (!momtaskid.split("&&")[1].equalsIgnoreCase("") && !momtaskid.split("&&")[1].equalsIgnoreCase("null")) {
                        usertask.setSino(parseInteger(momtaskid.split("&&")[1],99));
                    }
                    DAOFactory.updateTask(usertask);
                } else {
                    flag = false;
                }
            } else {
                flag = uniqueTask(userId, planFor, task, taskTime);

            }

            if (flag == false) {
                DAOFactory.createTask(usertask);
            } else {
                logger.info("Same task already added by the user");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static List issueORTask() throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List updatedUsers = new ArrayList();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select userid from Mom_User_Task where to_char(momdate,'dd-Mon-yyyy')=to_char(sysdate,'dd-Mon-yyyy') and tasktime='Actual' and type<>'Count'");
            while (resultset.next()) {
                int user = resultset.getInt("userId");
                updatedUsers.add(user);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }

            if (connection != null) {
                connection.close();
            }
        }

        return updatedUsers;
    }

    public static List viewTask(int pageNumber, int userId) {
        int pagesize = 15;
        Session session = null;
        List l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.createQuery("from MomUserTask where userid=" + userId + " order by MOMDATE desc");
            query.setFirstResult(pagesize * (pageNumber - 1));
            query.setMaxResults(pagesize);
            l = query.list();
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
        return l;
    }

    public static List viewTaskSize(int userId) {
        Session session = null;
        int tasklistsize = 0;
        List<Date> l = new ArrayList<Date>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createQuery("select Distinct(momdate) from MomUserTask  where userid=" + userId + " ORDER BY momdate desc");
            l = query.list();
            logger.info(l);
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
        return l;
    }

    public static List viewTask(int userId, String date) {
        Session session = null;
        List l = null;
        List lFinal = new ArrayList();
        List<String> issues = new ArrayList<String>(0);
        try {
            logger.info("Passed Date  :" + date);
            String id = date.replaceAll("-", "");
            logger.info("Passed id  :" + id);
            session = HibernateFactory.getCurrentSession();
            Query query = session.createQuery("from MomUserTask where userId=" + userId + " and to_date(to_char(momdate,'dd-Mon-yyyy'),'dd-Mon-yyyy')='" + date + "' order by userId,sino,tasktime desc,type,momtaskid");

            l = query.list();
            MomUserTask userTask = null;
            int i = 0;
            for (Iterator reqIterator = l.iterator(); reqIterator.hasNext();) {

                userTask = (MomUserTask) reqIterator.next();
                if (userTask.getTasktime().equalsIgnoreCase("Actual")) {
                    if (i == 0) {
                        i++;
                        issues.removeAll(issues);
                    }

                }
                if (userTask.getType().equalsIgnoreCase("Issue")) {
                    IssuesTask iTask = MoMUtil.getIssueDetails(userTask.getTask());
                    if (userTask.getTasktime().equalsIgnoreCase("Planned")) {

                        if (issues.contains(iTask.getIssueno())) {

                        } else {
                            issues.add(iTask.getIssueno());
                            lFinal.add(userTask);
                        }
                    } else {
                        issues.add(iTask.getIssueno());
                        lFinal.add(userTask);
                    }
                } else {
                    lFinal.add(userTask);

                }
            }
            logger.info("No of Tasks" + l.size() + "for User :" + userId);
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
        return lFinal;
    }

    public static List viewTaskBetweenTwoDates(int userId, String date1, String date2) {
        Session session = null;
        List l = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createQuery("from MomUserTask where (userId=" + userId + ") And (Momdate>='" + date2 + "' And Momdate<='" + date1 + "') order by momdate desc,type,taskTime,momtaskid");

            l = query.list();
            logger.info("No of Tasks" + l.size() + "for User :" + userId);
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
        return l;
    }

    public static int uniqueMOM(int userId, Date momDate, String momTime) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
        String mdate = df.format(momDate);
        int momuserdetailid = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select momuserdetailid from Mom_user_detail where (momtime='" + momTime + "' And userId=" + userId + ") And (momdate='" + df.format(momDate) + "') ");
            while (resultset.next()) {
                momuserdetailid = resultset.getInt("momuserdetailid");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }

            if (connection != null) {
                connection.close();
            }
        }
        return momuserdetailid;
    }

    public static void createMOMDetails(int createdby, int userId, String status, String momTime, String comment) {
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        MomUserDetail userdetail = new MomUserDetail();
        int momuserdetailId = 0;
        try {
            userdetail.setUserid(userId);
            userdetail.setCreatedby(createdby);
            userdetail.setCreatedon(date);
            userdetail.setModifiedon(date);
            userdetail.setMomdate(new java.util.Date());
            userdetail.setStatus(status);
            userdetail.setMomtime(momTime);
            userdetail.setComment(comment);
            momuserdetailId = uniqueMOM(userId, date, momTime);

            if (momuserdetailId != 0) {
                userdetail.setMomuserdetailid(momuserdetailId);
            }
            DAOFactory.createMOMUser(userdetail);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static void createMOMFeedBack(int feedBackby, int chairPerson, String momTime, Date startTime, Date endTime, String feedBack, int momTeamType, int branchId) {
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        MomFeedback momFeedback = null;
        try {
//            momFeedback = uniqueMomFeedBack(momTime, date, momTeamType);
            if (momFeedback != null) {
                momFeedback.setChairperson(chairPerson);
                momFeedback.setModifiedon(date);
                momFeedback.setFeedback(feedBack);
                momFeedback.setFeedbackby(feedBackby);
                momFeedback.setStarttime(startTime);
                momFeedback.setEndtime(endTime);
                momFeedback.setMomTeamType(momTeamType);
                momFeedback.setBranchId(branchId);
            } else {
                momFeedback = new MomFeedback();
                momFeedback.setChairperson(chairPerson);
                momFeedback.setCreatedon(date);
                momFeedback.setStarttime(startTime);
                momFeedback.setEndtime(endTime);
                momFeedback.setModifiedon(date);
                momFeedback.setFeedbackby(feedBackby);
                momFeedback.setMomdate(date);
                momFeedback.setFeedback(feedBack);
                momFeedback.setMomTime(momTime);
                momFeedback.setMomTeamType(momTeamType);
                momFeedback.setBranchId(branchId);

            }
            DAOFactory.createMOMFeedBack(momFeedback);

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static String[][] getMOMDetail(String dateFor) {
        String momusers = rb.getString("mom-users");
        String noOfIds[] = momusers.split(",");
        String extendedQuery = "";
        for (int j = 0; j < noOfIds.length; j++) {
            extendedQuery = extendedQuery + " WHEN " + noOfIds[j] + " THEN " + j;
        }
        logger.info(extendedQuery);
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String name = null, task = null;
        String projectDetails[][] = null;
        int rowcount = 0, count = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select Distinct(t.momtaskid) as momtaskId ,s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid  from mom_user_task t,users s where   t.momdate = '" + dateFor + "' and s.userid=t.userid and t.userid in (" + momusers + ")order by CASE t.userid " + extendedQuery + " END, t.tasktime desc,t.type,t.momtaskid");
            resultset.last();
            logger.info("select Distinct(t.momtaskid) as momtaskId ,s.firstname ||' ' ||s.lastname as name,t.task,t.tasktime,t.type,t.createdBy,t.userid  from mom_user_task t,users s where   t.momdate = '" + dateFor + "' and s.userid=t.userid and t.userid in (" + momusers + ")order by CASE t.userid " + extendedQuery + " END, t.tasktime desc,t.type,t.momtaskid");
            rowcount = resultset.getRow();
            projectDetails = new String[rowcount][7];
            resultset.beforeFirst();
            while (resultset.next()) {
                name = resultset.getString(2);
                task = resultset.getString(3);
                projectDetails[count][0] = name;
                projectDetails[count][1] = task;
                projectDetails[count][2] = resultset.getString(4);
                projectDetails[count][3] = resultset.getString(5);
                projectDetails[count][4] = resultset.getString(6);
                projectDetails[count][5] = resultset.getString(7);
                projectDetails[count][6] = resultset.getString(7);
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
        return projectDetails;

    }

    public static String[][] getTodayMOMDetail(String dateFor, String teamType) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String projectDetails[][] = null;
        int rowcount = 0, count = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select t.task, t.type,t.userid,MOMTASKID  from mom_user_task t,users s,mom_maintanance m where m.userid=t.userid and m.team in(" + teamType + ") and s.userid=t.userid and t.momdate = '" + dateFor + "' and t.tasktime='Planned'  order by  t.userid");
            resultset = statement.executeQuery("select t.task, t.type,t.userid,MOMTASKID  from mom_user_task t,users s,mom_maintanance m where m.userid=t.userid and m.team in(" + teamType + ") and s.userid=t.userid and t.momdate = '" + dateFor + "' and t.tasktime='Planned'  order by  t.userid");
            resultset.last();
            rowcount = resultset.getRow();
            projectDetails = new String[rowcount][4];
            resultset.beforeFirst();
            while (resultset.next()) {
                projectDetails[count][0] = resultset.getString(3);
                projectDetails[count][1] = resultset.getString(2);
                projectDetails[count][2] = resultset.getString(1);
                projectDetails[count][3] = resultset.getString(4);
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
        return projectDetails;

    }

    public static String[][] getMOMAttendance(String dateFor, String momTime, String teamType, int branch) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String name = null, status = null, userid = null, comment = "", namecol = "", attMomTime = "";
        String projectDetails[][] = null;
        int rowcount = 0, count = 0;
        String query = "";

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (branch == 0) {
                query = "select d.userid,s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,d.status,d.momcomment,momtime,createdon from mom_user_detail d,users s, MOM_Maintanance mm where  mm.userid=s.userid and mm.team in(" + teamType + ") and d.userid=s.userid  and to_char(d.momdate,'dd-Mon-YYYY') = '" + dateFor + "' and s.userid=d.userid and MOMTIME in (" + momTime + ") order by momtime,status desc,createdOn";
            } else {
                query = "select d.userid,s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,d.status,d.momcomment,momtime,createdon from mom_user_detail d,users s, MOM_Maintanance mm where  mm.userid=s.userid and mm.team in(" + teamType + ") and d.userid=s.userid  and to_char(d.momdate,'dd-Mon-YYYY') = '" + dateFor + "' and s.userid=d.userid and MOMTIME in (" + momTime + ") and s.branch_id=" + branch + " order by momtime,status desc,createdOn";
            }
            logger.info("query" + query);

            resultset = statement.executeQuery(query);
            resultset.last();

            rowcount = resultset.getRow();
            logger.info("rowcount" + rowcount);
            projectDetails = new String[rowcount][5];
            resultset.beforeFirst();
            while (resultset.next()) {
                userid = resultset.getString(1);
                if (userid == null) {
                    userid = "0";
                }
                name = resultset.getString(2);
                status = resultset.getString(3);
                comment = resultset.getString(4);
                attMomTime = resultset.getString(5);
                projectDetails[count][0] = status;
                projectDetails[count][1] = name;
                projectDetails[count][2] = comment;
                projectDetails[count][3] = attMomTime;
                projectDetails[count][4] = userid;
                count++;

            }

        } catch (Exception e) {
            e.printStackTrace();
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

        return projectDetails;

    }

    public static MomFeedback uniqueMomFeedBack(String momTime, Date date, int momTeamType, int branchId) {
        Session session = null;
        MomFeedback momFeedback = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomFeedback.findUniqueMomFeedback");
            query.setParameter("momdate", date);
            query.setParameter("momTime", momTime);
            query.setParameter("momTeamType", momTeamType);
            query.setParameter("branchId", branchId);
            momFeedback = (MomFeedback) query.uniqueResult();

        } catch (Exception e) {
            logger.error("uniqueMomFeedBack" + e.getMessage());
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
        return momFeedback;
    }

    public static void deleteTaskByIssueAndUserId(String dateFor, String issueId, int userId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

            logger.info("momDate" + dateFor + ", issueId=" + issueId + "userId=" + userId);
            conn = MakeConnection.getConnection();
            String query = "Delete from mom_user_task m where m.momdate = ? and type=? and task like ? and USERID= ?";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, dateFor);
            pstmt.setString(2, "Issue");
            pstmt.setString(3, "%" + issueId + "%");
            pstmt.setInt(4, userId);
            rs = pstmt.executeQuery();
        } catch (Exception e) {
            logger.error("getRating" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

    }

    public boolean getMorningMOMStatus(String dateFor) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowCount = 0;
        boolean flag = false;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select * from mom_user_detail where to_char(momdate,'dd-Mon-yyyy HH:mm')='01-Apr-2013'");
            resultset.last();
            rowCount = resultset.getRow();
            if (rowCount > 1) {
                flag = true;
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
        return flag;

    }

    public static String getPrevIssues(int userId, String momdate) {
        List l = new ArrayList();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String issues = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select task from Mom_User_Task  where userid=" + userId + " and tasktime='Planned' and type='Issue' and momdate=(select TO_CHAR(Max(momdate),'DD-Mon-YY') from Mom_user_detail where (userId=" + userId + " And momdate<'" + momdate + "') And (status  not like '%Leave%')) order by userId,tasktime desc,type,momtaskid");

            while (resultset.next()) {
                String task = resultset.getString("task");
                issues = issues + "'" + task.substring(0, 12) + "',";
            }
            if (issues.length() > 12) {
                issues = issues.substring(0, issues.length() - 1);
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
        return issues;
    }

    public static String checkAssign(int userId, String issues) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String totalissues = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select i.issueid from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = '" + userId + "' and i.issueid in(" + issues + ")");
            while (resultset.next()) {
                totalissues = totalissues + resultset.getString("issueid") + ",";

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
        if (totalissues.length() > 11) {
            totalissues = totalissues.substring(0, totalissues.length() - 1);
        }
        return totalissues;
    }

    public static List checkAssignIssues(int userId, String issues) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String totalissues = "";
        List previousDayIssue = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select i.issueid,i.subject,s.status from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = '" + userId + "' and i.issueid in(" + issues + ")");
            while (resultset.next()) {
                String issue = resultset.getString("issueid");
                String subject = resultset.getString("subject");
                String status = resultset.getString("status");
                String task = issue + " # " + status + " : " + subject;
                previousDayIssue.add(task);
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

        return previousDayIssue;
    }

    public static List prevDayIssueList(int userId, String issues) {
        List previousDayIssue = new ArrayList();
        String totalIssues = checkAssign(userId, issues);
        if (totalIssues.length() > 11) {
            String totalIssuesSP[] = totalIssues.split(",");
            for (int i = 0; i < totalIssuesSP.length; i++) {
                previousDayIssue.add(totalIssuesSP[i]);
            }

        }
        return previousDayIssue;

    }

    public static String getIssueSubject(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String subject = "";
        String status = "";

        try {
            if (issueId != null) {
                issueId = issueId.trim();
            }
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select i.subject,ist.status from issue i,issuestatus ist where i.issueid='" + issueId + "'  and ist.issueid=i.issueid ");
            if (resultset.next()) {
                subject = resultset.getString("subject");

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
        return subject;

    }

    public static String getIssueDueDate(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String duedate = "";

        try {
            if (issueId != null) {
                issueId = issueId.trim();
            }
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select to_char(i.due_date,'dd-Mon-yyyy') as duedate,ist.status from issue i,issuestatus ist where i.issueid='" + issueId + "'  and ist.issueid=i.issueid ");
            if (resultset.next()) {
                duedate = resultset.getString("duedate");

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
        return duedate;

    }

    public static String getIssueStatus(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String status = "";

        try {
            if (issueId != null) {
                issueId = issueId.trim();
            }
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select ist.status from issue i,issuestatus ist where i.issueid='" + issueId + "'  and ist.issueid=i.issueid ");
            if (resultset.next()) {
                status = resultset.getString("status");
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
        return status;

    }

    public static String firstMomUserDay(int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        String lasmomdate = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select TO_CHAR(MIN(momdate),'dd-MON-yyyy') from Mom_user_detail where (userId=" + userId + ")");
            if (resultset.next()) {
                if (resultset.getString(1) != null) {
                    lasmomdate = resultset.getString(1);
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
        return lasmomdate;
    }

    public static String[][] previousDayTask(int userId, String mdate) {
        List l = new ArrayList();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        String lasmomdate = "";
        int rowcount = 0;
        String previousTask[][] = new String[0][0];
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select task,type,TASKTIME,to_char(momdate,'dd-Mon-yyyy') as momdate from Mom_User_Task  where userid=" + userId + " and momdate=(select TO_CHAR(Max(momdate),'dd-MON-yy') from Mom_user_detail where (userId=" + userId + " And momdate<'" + mdate + "') And (status='Present')) order by userId,tasktime desc,type,momtaskid");
            resultset.last();

            rowcount = resultset.getRow();
            previousTask = new String[rowcount][4];
            resultset.beforeFirst();
            for (int i = 0; i < rowcount; i++) {
                resultset.next();
                previousTask[i][0] = resultset.getString("task");
                previousTask[i][1] = resultset.getString("TYPE");
                previousTask[i][2] = resultset.getString("TASKTIME");
                previousTask[i][3] = resultset.getString("momdate");
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
        return previousTask;
    }

    public static String[][] nextDayTask(int userId, String mdate) {
        List l = new ArrayList();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        String lasmomdate = "";
        int rowcount = 0;
        String previousTask[][] = new String[0][0];

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select task,type,TASKTIME,to_char(momdate,'dd-Mon-yyyy') as momdate from Mom_User_Task  where userid=" + userId + " and momdate=(select TO_CHAR(MIN(momdate),'dd-MON-yy') from Mom_user_Task where userId=" + userId + " And momdate >'" + mdate + "' ) order by userId,tasktime desc,type,momtaskid");
            resultset.last();

            rowcount = resultset.getRow();
            previousTask = new String[rowcount][4];
            resultset.beforeFirst();
            for (int i = 0; i < rowcount; i++) {
                resultset.next();
                previousTask[i][0] = resultset.getString("task");
                previousTask[i][1] = resultset.getString("TYPE");
                previousTask[i][2] = resultset.getString("TASKTIME");
                previousTask[i][3] = resultset.getString("momdate");
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
        return previousTask;
    }

    public static String lastMomUserDay(int userId, String mdate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        String lasmomdate = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select TO_CHAR(Max(momdate),'dd-MON-yy') from Mom_user_detail where (userId=" + userId + " And momdate<'" + mdate + "') And (status='Present')");
            if (resultset.next()) {
                if (resultset.getString(1) != null) {
                    lasmomdate = resultset.getString(1);
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
        return lasmomdate;
    }

    public static int getDays(String date1, String date2) {
        Connection connection = null;
        Statement statement = null;
        int days = 0;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select to_date('" + date2 + "','dd-MM-yyyy')-to_date('" + date1 + "','dd-mm-yyyy') from dual");
            if (resultset.next()) {
                if (resultset.getString(1) != null) {
                    days = resultset.getInt(1);
                    int num = MoMUtil.sign(days);
                    if (num == -1) {
                        days = days * (-1);
                    }
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
        return days;
    }

    public static String createIssueCountTask(int userId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        int issueCount = 0;
        String pname;
        String version;
        String issueCountTask = "";
        int total = 0;
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as issueCount, p.pname as pname,p.version as version from issue i,issuestatus s ,project p where i.pId in(select PID from userproject where userid=?) and assignedto= ? and i.issueid=s.issueid and i.pid=p.pid and s.status <> ? group by i.pid,p.pname,p.version";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, userId);
            pstmt.setString(3, "Closed");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                issueCount = rs.getInt("issueCount");
                pname = rs.getString("pname");
                version = rs.getString("version");
                total = total + issueCount;
                if (issueCount > 0) {
                    issueCountTask = pname + " v" + version + "=" + issueCount + ", " + issueCountTask;

                }
            }
            issueCountTask = "Total=" + total + ", " + issueCountTask;
            issueCountTask = issueCountTask.substring(0, issueCountTask.length() - 2);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueCountTask;
    }

    public static int getPMAndAssign(int pId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;

        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        int withPm = 0;
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as pmcount from issue i,issuestatus ist,  project p where i.pid = ?  and i.pid = p.pid and ((i.due_date < sysdate and i.assignedto=p.pmanager) OR (ist.status in('Code Review','Solution Review','Unconfirmed')) Or (i.assignedto=p.pmanager)) and ist.status <> ? and ist.issueid=i.issueid";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, pId);
            pstmt.setString(2, "Closed");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                withPm = rs.getInt("pmcount");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return withPm;
    }

    public static int getWithCustomerUsers(int pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        int withPm = 0;
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as customercount from issue i,project p,issuestatus ist where i.assignedto in (select up.userid from userproject up ,users u where (up.userid=u.userid and up.pid= ? and u.email not like ?)) and i.pid=p.pid and i.pid=? and ist.status not in ('Verified','Closed','Review','QA-TCE','Transport to PS','Performance QA') and ist.issueid=i.issueid and i.assignedto <> p.pmanager";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, pid);
            pstmt.setString(2, "%@eminentlabs.net%");
            pstmt.setInt(3, pid);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                withPm = rs.getInt("customercount");

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return withPm;
    }

    private static int getWithCustomerForUAT(int pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        int withCustomerUAT = 0;
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as customeruat from issue i,project p,issuestatus ist where i.assignedto in (select up.userid from userproject up ,users u where (up.userid=u.userid and up.pid= ? and u.email not like ?)) and i.pid=p.pid and i.pid=? and ist.status <> ? and ist.status in ('Verified','Review','QA-TCE','Transport to PS','Performance QA') and ist.issueid=i.issueid ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, pid);
            pstmt.setString(2, "%@eminentlabs.net%");
            pstmt.setInt(3, pid);
            pstmt.setString(4, "Closed");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                withCustomerUAT = rs.getInt("customeruat");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return withCustomerUAT;
    }

    public static int getWithFc(int pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        int withPm = 0;
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*)as count from issue i, issuestatus ist where i.assignedto in (select up.userid from userproject up ,users u where (up.userid=u.userid and up.pid=? and up.userid=u.userid and u.team in('SD','FI','HR','QA','MM','PP','BASIS','ADMIN'))) and  i.pid=? and ist.issueid=i.issueid and ist.status <> ?";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, pid);
            pstmt.setString(3, "Closed");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                withPm = rs.getInt("count");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return withPm;
    }

    public static int getWithABAP(int pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        int withPm = 0;
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*)as count from issue i, issuestatus ist where i.assignedto in (select up.userid from userproject up ,users u where (up.userid=u.userid and up.pid=? and up.userid=u.userid and u.team in('ABAP'))) and  i.pid=? and ist.issueid=i.issueid and ist.status <> ?";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, pid);
            pstmt.setString(3, "Closed");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                withPm = rs.getInt("count");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return withPm;
    }

    public static String[][] getProjectsFornewMOM() {
        String status = "Work in progress";
        Integer adminid = 104;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pname = null, projects = null, version = null, project;
        String projectDetails[][] = null;
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select pid,pname,version,customer from project where STATUS='Work in progress' And pmanager <>" + adminid + "  GROUP BY customer,pid,pname,version,enddate order by enddate");
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();

            projectDetails = new String[rowcount][12];
            while (resultset.next()) {

                int pid = resultset.getInt(1);

                pname = resultset.getString(2);
                version = resultset.getString(3);
                project = pname + ":" + version;

                HashMap<String, Integer> hm = dashboard.MaxIssue.getIssueCount(project);

                HashMap<String, Integer> hmMom = dashboard.MOMMaxIssues.getIssueCountForMOM(pid);
                projectDetails[count][0] = pname + " v" + version;
                projectDetails[count][1] = hm.get("altogether") + "";
                projectDetails[count][2] = getPMAndAssign(pid) + "";
                projectDetails[count][3] = getWithCustomerUsers(pid) + "";
                projectDetails[count][4] = hmMom.get("withfc") + "";
                projectDetails[count][5] = hmMom.get("qa-btc") + "";
                projectDetails[count][6] = hmMom.get("withabap") + "";
                projectDetails[count][7] = hmMom.get("qa-tce") + "";
                projectDetails[count][8] = getWithCustomerForUAT(pid) + "";
                projectDetails[count][9] = String.valueOf(parseInteger(projectDetails[count][2], 0) + parseInteger(projectDetails[count][3], 0) + parseInteger(projectDetails[count][4], 0) + parseInteger(projectDetails[count][5], 0) + parseInteger(projectDetails[count][6], 0) + parseInteger(projectDetails[count][7], 0) + parseInteger(projectDetails[count][8], 0));

                if (!projectDetails[count][9].equals(projectDetails[count][1])) {
                    projectDetails[count][10] = "red";
                } else {
                    projectDetails[count][10] = "white";
                }
                projectDetails[count][11] = String.valueOf(pid);
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
        return projectDetails;
    }

    public static Map<Integer, String> getProjects() {
        String status = "Work in progress";
        Integer adminid = 104;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pname = null, projects = null, version = null, project;
        String projectDetails[][] = null;
        int count = 0;
        Map<Integer, String> hm = new LinkedHashMap< Integer, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select pid,pname,version,customer from project where STATUS='Work in progress' And pmanager <>" + adminid + "  Order BY pname");
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();

            projectDetails = new String[rowcount][12];
            while (resultset.next()) {

                int pid = resultset.getInt(1);

                pname = resultset.getString(2);
                version = resultset.getString(3);
                project = pname + " v" + version;
                hm.put(pid, project);

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
        return hm;
    }

    public static String[] getProjectIssueCounts(String pId) {
        Integer adminid = 104;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String pname = null, version = null, project;
        String projectDetails[] = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select pid,pname,version,customer from project where pid=" + pId);

            projectDetails = new String[12];
            if (resultset.next()) {

                int pid = resultset.getInt(1);

                pname = resultset.getString(2);
                version = resultset.getString(3);
                project = pname + ":" + version;

                HashMap<String, Integer> hm = dashboard.MaxIssue.getIssueCount(project);

                HashMap<String, Integer> hmMom = dashboard.MOMMaxIssues.getIssueCountForMOM(pid);
                projectDetails[0] = pname + " v" + version;
                projectDetails[1] = hm.get("altogether") + "";
                projectDetails[2] = getPMAndAssign(pid) + "";
                projectDetails[3] = getWithCustomerUsers(pid) + "";
                projectDetails[4] = hmMom.get("withfc") + "";
                projectDetails[5] = hmMom.get("qa-btc") + "";
                projectDetails[6] = hmMom.get("withabap") + "";
                projectDetails[7] = hmMom.get("qa-tce") + "";
                projectDetails[8] = getWithCustomerForUAT(pid) + "";
                projectDetails[9] = String.valueOf(parseInteger(projectDetails[2], 0) + parseInteger(projectDetails[3], 0) + parseInteger(projectDetails[4], 0) + parseInteger(projectDetails[5], 0) + parseInteger(projectDetails[6], 0) + parseInteger(projectDetails[7], 0) + parseInteger(projectDetails[8], 0));

                if (!projectDetails[9].equals(projectDetails[1])) {
                    projectDetails[10] = "red";
                } else {
                    projectDetails[10] = "white";
                }
                projectDetails[11] = String.valueOf(pid);

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
        return projectDetails;
    }

    public static String getIssuesOnProjectStatus(int pId, String projectMoMStatus) {
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt1 = null;
        String query = "";
        String extendedQuery = "";
        if (projectMoMStatus.equalsIgnoreCase("pmcount")) {
            extendedQuery = "and ((i.due_date < sysdate and i.assignedto=p.pmanager) OR (s.status in('Code Review','Solution Review','Unconfirmed')) Or (i.assignedto=p.pmanager))";
        } else if (projectMoMStatus.equalsIgnoreCase("customercount")) {
            extendedQuery = "and i.assignedto in (select up.userid from userproject up ,users u where (up.userid=u.userid and up.pid= " + pId + " and u.email not like '%eminentlabs.net%') and s.status not in ('Verified','Closed','Review','QA-TCE','Transport to PS','Performance QA'))";
        } else if (projectMoMStatus.equalsIgnoreCase("withfc")) {
            extendedQuery = "and s.status in('Documentation','Duplicate','Rejected','Training','User Error','Evaluation','Review','Customizing Request') and i.assignedto in(Select up.userid from UserProject up, users u where up.userId=u.userId and up.pid = p.pid and u.email like '%eminentlabs.net%') and i.assignedto <> p.pmanager ";
        } else if (projectMoMStatus.equalsIgnoreCase("qa-tce")) {
            extendedQuery = "and s.status in('QA-TCE','Verified','Transport to TS','Transport to PS','Performance QA','Performance Testing') and i.assignedto in(Select up.userid from UserProject up, users u where up.userId=u.userId and up.pid = p.pid and u.email like '%eminentlabs.net%') and i.assignedto <> p.pmanager ";
        } else if (projectMoMStatus.equalsIgnoreCase("withabap")) {
            extendedQuery = "and s.status in('Development','Detail Design','Workbench Request','Replicating in DS','ReadytoBuild','Code Review') and i.assignedto in(Select up.userid from UserProject up, users u where up.userId=u.userId and up.pid = p.pid and u.email like '%eminentlabs.net%') and i.assignedto <> p.pmanager ";
        } else if (projectMoMStatus.equalsIgnoreCase("qa-btc")) {
            extendedQuery = "and s.status in('QA-BTC','Investigation','Confirmed') and i.assignedto in(Select up.userid from UserProject up, users u where up.userId=u.userId and up.pid = p.pid and u.email like '%eminentlabs.net%') and i.assignedto <> p.pmanager ";
        } else if (projectMoMStatus.equalsIgnoreCase("customeruat")) {
            extendedQuery = "and i.assignedto in (select up.userid from userproject up ,users u where (up.userid=u.userid and up.pid= " + pId + " and u.email not like '%eminentlabs.net%') and s.status in ('Verified','Review','QA-TCE','Transport to PS','Performance QA')) and i.assignedto <> p.pmanager ";
        } else if (projectMoMStatus.equalsIgnoreCase("altogether")) {
        } else {
            logger.error("status parameter value is not matching please check whether status value is correct or not ");
        }
        try {
            query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and p.pid=" + pId + " and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' " + extendedQuery + "  order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            logger.info(query);
//            stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
//            rs = stmt1.executeQuery(query);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
//        finally {
//
//            try {
//                rs.close();
//                stmt1.close();
//                conn.close();
//            } catch (SQLException e) {
//                logger.error(e.getMessage());
//            }
//        }
        return query;
    }

    public static Map<Integer, String> attendanceDetails(String dateFor, String momTime) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> attendanceStatus = new HashMap<Integer, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select userid,STATUS,MOMCOMMENT from MOM_USER_DETAIL where to_char(momdate,'DD-Mon-yyyy')='" + dateFor + "' and momtime in (" + momTime + ")");
            logger.info("select userid,STATUS,MOMCOMMENT from MOM_USER_DETAIL where to_char(momdate,'DD-Mon-yyyy')='" + dateFor + "' and momtime in (" + momTime + ")");
            while (resultset.next()) {
                attendanceStatus.put(resultset.getInt("userId"), resultset.getString("STATUS") + "-" + resultset.getString("MOMCOMMENT"));
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
        return attendanceStatus;

    }

    public static Set<String> attendancsStatus() {
        Set<String> attendanceStatus = new LinkedHashSet<String>();
        attendanceStatus.add("Unintimated");
        attendanceStatus.add("Intimated");
        attendanceStatus.add("Present");
        attendanceStatus.add("Medical Leave");
        attendanceStatus.add("Approved Leave");
        attendanceStatus.add("Permission");
        attendanceStatus.add("Client Meeting");
        attendanceStatus.add("Client Call");
        attendanceStatus.add("Componsation Leave");
        attendanceStatus.add("On Duty");
//        attendanceStatus.add("Holiday");
        return attendanceStatus;

    }

    public static int sign(double f) {
        if (f != f) {
            throw new IllegalArgumentException("NaN");
        }
        if (f == 0) {
            return 0;
        }
        f *= Double.POSITIVE_INFINITY;
        if (f == Double.POSITIVE_INFINITY) {
            return +1;
        }
        if (f == Double.NEGATIVE_INFINITY) {
            return -1;
        }

        //this should never be reached, but I've been wrong before...
        throw new IllegalArgumentException("Unfathomed double");
    }

    public static int parseInteger(String sInteger, int defaultValue) {

        try {
            return Integer.parseInt(sInteger);
        } catch (NumberFormatException nfe) {
            return defaultValue;
        }
    }

    public static long parseLong(String sInteger, long defaultValue) {

        try {
            return Long.parseLong(sInteger);
        } catch (NumberFormatException nfe) {
            return defaultValue;
        }
    }

    public static Date subtractDay(Date date) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        return cal.getTime();
    }

    public static Date nextWeek(Date date, int numberofweeks) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_MONTH, numberofweeks * 7);
        return cal.getTime();
    }

    public static Date previousWeek(Date date, int numberofweeks) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_MONTH, (numberofweeks * -7));
        return cal.getTime();
    }

    public static int weeksBetweenTwodates(String date1, String date2) {

        int days = 0;
        int weeks = 0;
        int weekRemainDays = 0;
        days = getDays(date1, date2);
        weeks = days / 7;
        weekRemainDays = days % 7;
        if (weekRemainDays > 0) {
            weeks = weeks + 1;
        }

        return weeks;
    }

    public static boolean uniqueMOMIssueCount(String momDate, String type, String taskTime, int userId) {

        boolean flag = true;
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String momTaskId = "";
        try {
            conn = MakeConnection.getConnection();
            String query = "select momtaskid from mom_user_task m,users u where m.momdate=? and type=? and tasktime=? and u.userid=m.userid and m.userid=?";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, momDate);
            pstmt.setString(2, type);
            pstmt.setString(3, taskTime);
            pstmt.setString(4, String.valueOf(userId));
            rs = pstmt.executeQuery();
            while (rs.next()) {
                momTaskId = rs.getString("momtaskid");

            }
            if ("".equals(momTaskId) && momTaskId != null) {
                flag = false;
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return flag;

    }

    public static Map getActuals(int userId) {
        Map<String, String> issueList = new LinkedHashMap<String, String>();
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

        Date tommorowDate = nextDay(date);
        String today = sdf.format(date);
        String prevIssues = MoMUtil.getPrevIssues(userId, today);
        List<String> pIssueList = new ArrayList<String>();
        if (prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        String tommorow = sdf.format(tommorowDate);
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            logger.info("today" + today + ", tommomrow" + tommorow + ",userId" + userId);
            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid) as issueid ,i.subject as subject,ist.status as status, CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname ,ic.COMMENT_DATE,to_char(i.due_date,'dd-Mon-yyyy') as duedate from issuecomments ic,issue i ,issuestatus ist,project p ,users u where ic.comment_date > ? and ic.comment_date < ?  and ic.commentedby=? and comments not like 'Due date is realigned because of issue#%' and u.userid=ic.commentedby and  ic.issueid=i.issueid and ist.issueid=i.issueid and i.pid=p.pid order by ic.COMMENT_DATE";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, today);
            pstmt.setString(2, tommorow);
            pstmt.setString(3, String.valueOf(userId));
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String issueid = rs.getString("issueid");
                String pfullname = rs.getString("pfullname");
                String status = rs.getString("status");
                String subject = rs.getString("subject");
                String duedate = rs.getString("duedate");
                Date duDate = sdf.parse(duedate);
                Date currentDate = new Date();
                currentDate = subtractDay(currentDate);
                String statusSubject = "";
                String subjectColor = "";
                if (pIssueList.contains(issueid)) {
                    subjectColor = "#D2691E";
                }
                if (duDate.compareTo(currentDate) < 0) {
                    if ("".equals(subjectColor)) {
                        statusSubject = " # <font color='Red'>" + status + "</font> : " + subject;
                    } else {
                        statusSubject = " # <font color='Red'>" + status + "</font> : <font color='" + subjectColor + "'>" + subject + "</font>";
                    }
                } else {
                    if ("".equals(subjectColor)) {
                        statusSubject = " # " + status + " : " + subject;
                    } else {
                        statusSubject = " # " + status + " : <font color='" + subjectColor + "'>" + subject + "</font>";
                    }
                }
                issueList.put(issueid + ":" + pfullname, statusSubject);
            }

        } catch (Exception e) {
            logger.error("getActuals" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static Map getPreviousActuals(int userId, Date previousDate) {
        Map<String, String> issueList = new LinkedHashMap<String, String>();
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

        String today = sdf.format(previousDate);
        String prevIssues = MoMUtil.getPrevIssues(userId, today);
        List<String> pIssueList = new ArrayList<String>();
        if (prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        Date nextDay = nextDay(previousDate);
        String tommorow = sdf.format(nextDay);
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            logger.info("preDay" + today + ", today" + tommorow + ", userId" + userId);
            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid) as issueid ,i.subject as subject,ist.status as status, CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname ,ic.COMMENT_DATE,to_char(i.due_date,'dd-Mon-yyyy') as duedate from issuecomments ic,issue i ,issuestatus ist,project p ,users u where ic.comment_date > ? and ic.comment_date < ?  and ic.commentedby=? and u.userid=ic.commentedby and  ic.issueid=i.issueid and ist.issueid=i.issueid and i.pid=p.pid order by ic.COMMENT_DATE";

            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, today);
            pstmt.setString(2, tommorow);
            pstmt.setString(3, String.valueOf(userId));
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String issueid = rs.getString("issueid");
                String pfullname = rs.getString("pfullname");
                String status = rs.getString("status");
                String subject = rs.getString("subject");
                String duedate = rs.getString("duedate");
                Date duDate = sdf.parse(duedate);

                Date currentDate = sdf.parse(today);
                currentDate = subtractDay(currentDate);
                String statusSubject = "";
                String subjectColor = "";
                if (pIssueList.contains(issueid)) {
                    subjectColor = "#D2691E";
                }
                if (duDate.compareTo(currentDate) < 0) {
                    if ("".equals(subjectColor)) {
                        statusSubject = " # <font color='Red'>" + status + "</font> : " + subject;
                    } else {
                        statusSubject = " # <font color='Red'>" + status + "</font> : <font color='" + subjectColor + "'>" + subject + "</font>";
                    }
                } else {
                    if ("".equals(subjectColor)) {
                        statusSubject = " # " + status + " : " + subject;
                    } else {
                        statusSubject = " # " + status + " : <font color='" + subjectColor + "'>" + subject + "</font>";
                    }
                }
                issueList.put(issueid + ":" + pfullname, statusSubject);
            }

        } catch (Exception e) {
            logger.error("getPreviousActuals" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static String[][] getCurrentActuals(List<String> pIssueList, Date previousDate) {

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String[][] issueList = null;

        String today = sdf.format(previousDate);

        Date nextDay = nextDay(previousDate);
        String tommorow = sdf.format(nextDay);
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            logger.info("preDay" + today + ", today" + tommorow);
            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid) as issueid ,i.subject as subject,ist.status as status, CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname ,ic.COMMENT_DATE,to_char(i.due_date,'dd-Mon-yyyy') as duedate,commentedby from issuecomments ic,issue i ,issuestatus ist,project p  where ic.comment_date > ? and ic.comment_date < ?  and comments not like 'Due date is realigned because of issue#%' and  ic.issueid=i.issueid and ist.issueid=i.issueid and i.pid=p.pid order by commentedby,ic.COMMENT_DATE";

            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, today);
            pstmt.setString(2, tommorow);
            rs = pstmt.executeQuery();
            rs.last();
            int rowcount = rs.getRow();
            rs.beforeFirst();
            issueList = new String[rowcount][3];
            int k = 0;
            while (rs.next()) {
                String issueid = rs.getString("issueid");
                String pfullname = rs.getString("pfullname");
                String status = rs.getString("status");
                String subject = rs.getString("subject");
                String duedate = rs.getString("duedate");
                String commentedby = rs.getString("commentedby");
                Date duDate = sdf.parse(duedate);

                Date currentDate = sdf.parse(today);
                currentDate = subtractDay(currentDate);
                String statusSubject = "";

                if (duDate.compareTo(currentDate) < 0) {
                    statusSubject = " # <font color='Red'>" + status + "</font> : " + subject;
                } else {
                    statusSubject = " # " + status + " : " + subject;
                }
                issueList[k][0] = issueid + ":" + pfullname;
                issueList[k][1] = statusSubject;
                issueList[k][2] = commentedby;
                k++;
            }
        } catch (Exception e) {
            logger.error("getCurrentActuals" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static Map getPlannedForAddTask(int userId) {
        Map<String, String> issueList = new LinkedHashMap<String, String>();
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid),i.subject,ist.status,to_char(i.Due_date,'dd-Mon-yyyy') as duedate ,i.due_date,CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname from issue i,issuestatus ist,project p where p.pid=i.pid and ist.issueid= i.issueid and ist.status <>'Closed' and i.assignedto=?   order by i.Due_date";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String pfullName = rs.getString("pfullname");
                String issueid = rs.getString("issueid").trim();
                String subject = rs.getString("subject");
                String status = rs.getString("status");
                String duedate = rs.getString("duedate");
                Date duDate = sdf.parse(duedate);
                Date currentDate = new Date();
                String statusSubject = "";
                if (duDate.compareTo(currentDate) < 0) {
                    statusSubject = " # <font color='Red'>" + status + "</font> : " + subject;
                } else {
                    statusSubject = " # " + status + " : " + subject;
                }
                issueList.put(issueid + " : " + pfullName, statusSubject);
            }

        } catch (Exception e) {
            logger.info("getPlannedForAddTask" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static boolean uniqueTask(int userId, String momDate, String task, String tasktime) {
        boolean flag = true;
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String momtaskid = null;
        try {
            logger.info("userId" + userId + ", momDate" + momDate + ",task" + task + ",tasktime" + tasktime);
            conn = MakeConnection.getConnection();
            String query = "select Distinct(m.momtaskid) as momtaskid from mom_user_task m,users u where m.momdate = ? and m.userid= ?  and m.task=? and m.tasktime=? and  m.userid=u.userid";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, momDate);
            pstmt.setString(2, String.valueOf(userId));
            pstmt.setString(3, task);
            pstmt.setString(4, tasktime);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                momtaskid = rs.getString("momtaskid");

            }
            if (momtaskid == null) {
                flag = false;
            }

        } catch (Exception e) {
            logger.error("uniqueTask" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return flag;

    }

    public static String uniqueIssueTask(int userId, String momDate, String task, String tasktime) {
        boolean flag = true;
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String momtaskid = null;
        try {
            logger.info("userId" + userId + ", momDate" + momDate + ",task" + task + ",tasktime" + tasktime);
            conn = MakeConnection.getConnection();
            String query = "select Distinct(m.momtaskid) as momtaskid,sino from mom_user_task m,users u where m.momdate = ? and m.userid= ?  and m.task like '%" + task + "%' and m.tasktime=? and  m.type=? and m.userid=u.userid ";

            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, momDate);
            pstmt.setString(2, String.valueOf(userId));
            pstmt.setString(3, tasktime);
            pstmt.setString(4, "Issue");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                momtaskid = rs.getString("momtaskid") + "&&" + rs.getString("sino");

            }

        } catch (Exception e) {
            logger.error("uniqueIssueTask" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return momtaskid;

    }

    public static void deleteTodayTask(String momDate, int userid, String tasktime, String type) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            String extraQuery = "";
            if (!type.equalsIgnoreCase("All")) {
                extraQuery = "and type =? ";
            }
            logger.info("momDate" + momDate + ", userid" + userid + ", tasktime" + tasktime + ", type=" + type);
            conn = MakeConnection.getConnection();
            String query = "Delete from mom_user_task m where m.momdate = ? and m.userid= ? and tasktime=? " + extraQuery;
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, momDate);
            pstmt.setString(2, String.valueOf(userid));
            pstmt.setString(3, tasktime);
            if (!type.equalsIgnoreCase("All")) {
                pstmt.setString(4, type);
            }
            rs = pstmt.executeQuery();

        } catch (Exception e) {
            logger.error("getRating" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteTaskByIssue(String momDate, String issueId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

            logger.info("momDate" + momDate + ", issueId=" + issueId);
            conn = MakeConnection.getConnection();
            String query = "Delete from mom_user_task m where m.momdate = ? and type=? and task like ? ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, momDate);
            pstmt.setString(2, "Issue");
            pstmt.setString(3, "%" + issueId + "%");
            rs = pstmt.executeQuery();

        } catch (Exception e) {
            logger.error("getRating" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteTaskByTask(String taskId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

            conn = MakeConnection.getConnection();
            String query = "Delete from mom_user_task m where MOMTASKID = ? ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, taskId);
            rs = pstmt.executeQuery();

        } catch (Exception e) {
            logger.error("getRating" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static String getRating(String issueId, String dateFor) {
        String rating = "";
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid),i.rating as rating  from issue i,issuestatus ist,issuecomments ic where i.issueid=ist.issueid and i.issueid=ic.issueid  and ist.status='Closed' and i.issueid=? and to_char(i.modifiedon,'dd-Mon-yyyy')= ? ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, issueId);
            pstmt.setString(2, dateFor);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                rating = rs.getString("rating");
            }
        } catch (Exception e) {
            logger.error("getRating" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return rating;
    }

    public static String getColor(String issueId, String dateFor) {
        String color = "";
        String rating = null;
        rating = getRating(issueId, dateFor);
        if (rating != null) {
            if (rating.equalsIgnoreCase("Excellent")) {
                color = "#336600";

            } else if (rating.equalsIgnoreCase("Good")) {
                color = "#33CC66";

            } else if (rating.equalsIgnoreCase("Average")) {
                color = "#CC9900";

            } else if (rating.equalsIgnoreCase("Need Improvement")) {
                color = "#CC0000";
            }
        }
        return color;
    }

    public static boolean checkClosedIssue(String issueId) {
        boolean flag = false;
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid) from issue i,issuestatus ist where i.issueid=ist.issueid and ist.status='Closed' and i.issueid=? ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, issueId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                flag = true;
            }
        } catch (Exception e) {
            logger.error("checkClosedIssue" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return flag;
    }

    public static Map closedIssuesOnDate(String date) {
        Map<String, String> issueList = new LinkedHashMap<String, String>();
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = MakeConnection.getConnection();

            String query = "select Distinct(i.issueid),i.rating as rating  from issue i,issuestatus ist where i.issueid=ist.issueid and  ist.status='Closed'  and i.modifiedOn ='" + date + "'";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                String issueid = rs.getString("issueid");
                String rating = rs.getString("rating");
                String color = "#33CC66";
                if (rating != null) {
                    if (rating.equalsIgnoreCase("Excellent")) {
                        color = "#336600";

                    } else if (rating.equalsIgnoreCase("Good")) {
                        color = "#33CC66";

                    } else if (rating.equalsIgnoreCase("Average")) {
                        color = "#CC9900";

                    } else if (rating.equalsIgnoreCase("Need Improvement")) {
                        color = "#CC0000";
                    }
                }
                issueList.put(issueid, color);
            }
        } catch (Exception e) {
            logger.error("checkClosedIssue" + e.getMessage());
        } finally {
            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static IssuesTask getIssueDetails(String task) {

        IssuesTask issuesTask = new IssuesTask();

        String issueData[] = task.split("#");

        if (issueData.length == 2) {
            String issueProject[] = issueData[0].split(":");
            String statusSub[] = issueData[1].split(":");
            if (issueProject.length > 1) {

                issuesTask.setIssueno(issueProject[0].trim());
                issuesTask.setProjectName(issueProject[1].trim());
            } else {
                issuesTask.setIssueno(issueProject[0].trim());
                issuesTask.setProjectName("");
            }

            if (statusSub.length > 1) {
                issuesTask.setStatus(statusSub[0].trim());
                String subject = statusSub[1].trim();
                if (statusSub.length > 2) {
                    for (int i = 2; i < statusSub.length; i++) {
                        subject = subject + statusSub[i].trim();
                    }
                }
                issuesTask.setSubject(subject);
            } else {
                issuesTask.setStatus(statusSub[0].trim());
                issuesTask.setSubject("");
            }

        }
        if (issueData.length > 2) {
            String issueProject[] = issueData[0].split(":");
            String statusSub[] = issueData[1].split(":");
            String extraSubject = "";
            for (int i = 2; i < issueData.length; i++) {
                extraSubject = extraSubject + "#" + issueData[i];
            }
            if (issueProject.length > 1) {

                issuesTask.setIssueno(issueProject[0].trim());
                issuesTask.setProjectName(issueProject[1].trim());
            } else {
                issuesTask.setIssueno(issueProject[0].trim());
                issuesTask.setProjectName("");
            }

            if (statusSub.length > 1) {
                issuesTask.setStatus(statusSub[0].trim());
                String subject = statusSub[1].trim() + ":" + extraSubject.trim();

                issuesTask.setSubject(subject);
            } else {
                issuesTask.setStatus(statusSub[0].trim());
                issuesTask.setSubject("");
            }

        }

        return issuesTask;

    }

    public static List weekPlannedIssue(String start, String end) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List weekPlannedIssue = new ArrayList();
        try {
            conn = MakeConnection.getConnection();
            String query = "select  Distinct(SUBSTR(mt.task ,1 , 12)) as issue,userid  from PROJECT_PLANNED_ISSUE pi,mom_user_task mt where pi.issueid = SUBSTR(task,0,12) and  pi.status='Active' and mt.type='Issue' and tasktime='Planned' and pi.plannedon between '" + start + "' and '" + end + "' and mt.momdate between '" + start + "' and '" + end + "' order by mt.userid";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String task = rs.getString("issue");
                int userId = rs.getInt("userId");
                weekPlannedIssue.add(task + "," + userId);
            }
            logger.info("weekPlannedIssue" + weekPlannedIssue);

        } catch (Exception e) {
            logger.error("weekPlannedIssue" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return weekPlannedIssue;
    }

    public static Map weekClosedIssue(String start, String end) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        Map weekClosedIssue = new LinkedHashMap();
        try {
            conn = MakeConnection.getConnection();
            List rejNdupIssues = IssueDetails.getRejectednDuplicateIssues(start, end);
            String query = "select Distinct(i.issueid),i.rating as rating  from issue i,issuestatus ist where i.issueid=ist.issueid and ist.status='Closed'  and i.modifiedOn between '" + start + "' and '" + end + "' ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (!rejNdupIssues.contains(rs.getString("issueid"))) {
                    String issueno = rs.getString("issueid");
                    String rating = rs.getString("rating");
                    weekClosedIssue.put(issueno, rating);
                }
            }
        } catch (Exception e) {
            logger.error("weekClosedIssue" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return weekClosedIssue;
    }

    public static String[][] showIssuesDetails(String issuenos, String start, String end) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String MoMIssueDetails[][] = null;
        List<String> issueList = new ArrayList<String>();
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(ic.issueid),ic.status,comment_date,i.subject,p.pname,p.version from issuecomments ic,issue i,project p where i.pid=p.pid and ic.issueid =i.issueid and ic.issueid in(" + issuenos + ")  and to_date(to_char(comment_date,'dd-Mon-yyyy'),'dd-Mon-yyyy') between '" + start + "' and '" + end + "' group by ic.issueid,ic.status,comment_date,subject,p.pname,p.version order by ic.issueid,comment_date desc,ic.status,subject,p.pname,p.version";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            String issue[] = issuenos.split(",");

            while (rs.next()) {
                String issueno = rs.getString("issueid");
                if (!issueList.contains(issueno)) {
                    issueList.add(issueno);
                }
            }
            MoMIssueDetails = new String[issueList.size()][4];
            issueList = new ArrayList();
            rs.beforeFirst();
            int count = 0;
            while (rs.next()) {
                String issueno = rs.getString("issueid");
                String status = rs.getString("status");
                String subject = rs.getString("subject");
                String pname = rs.getString("pname");
                String version = rs.getString("version");
                if (!issueList.contains(issueno)) {
                    MoMIssueDetails[count][0] = issueno;
                    MoMIssueDetails[count][1] = status;
                    MoMIssueDetails[count][2] = subject;
                    MoMIssueDetails[count][3] = pname + " v" + version;
                    count++;
                    issueList.add(issueno);
                }

            }
        } catch (Exception e) {
            logger.error("showIssuesDetails" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return MoMIssueDetails;
    }

    public static String[] weekPerformer(String userid, List<String> weekPlannedIssue, Map weekClosedIssue) {
        String[] toalPerformers = new String[2];
        if (!weekPlannedIssue.isEmpty()) {
            int count = 0;
            int i = 0;
            for (String issueUser : weekPlannedIssue) {
                String issueuser[] = issueUser.split(",");
                String issueno = issueuser[0];
                String userId = issueuser[1];
                if (userId.equalsIgnoreCase(userid)) {
                    if (weekClosedIssue.containsKey(issueno)) {
//                        logger.info("------>" + issueno);
                        count++;
                    }
                    i++;

                }

            }
            toalPerformers[0] = String.valueOf(count);
            toalPerformers[1] = String.valueOf(i);

            logger.info("userid" + userid + ", toalPerformers[0]" + toalPerformers[0] + "," + toalPerformers[1]);
        } else {
            toalPerformers[0] = String.valueOf(0);
            toalPerformers[1] = String.valueOf(0);
        }

        return toalPerformers;

    }

    public static String getIssueByUser(List<String> weekPlanissues, String userId) {
        String issuenos = "";
        for (String issueUser : weekPlanissues) {
            String issueuser[] = issueUser.split(",");
            String issueno = issueuser[0];
            String userid = issueuser[1];
            if (userId.equalsIgnoreCase(userid)) {
                issuenos = issuenos + "'" + issueno.trim() + "',";
            }
        }
        if (issuenos.length() > 12) {
            issuenos = issuenos.substring(0, issuenos.length() - 1);
        }
        return issuenos;
    }

    public static List getKeyFromValue(Map hm, Object value) {
        List<String> issues = new ArrayList<String>();
        for (Object o : hm.keySet()) {
            if (hm.get(o).equals(value)) {
                String issueno = (String) o;
                issues.add(issueno);
            }
        }
        return issues;
    }

    public static Date nextDay(Date date) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_MONTH, 1);
        int day = cal.get(Calendar.DAY_OF_WEEK);
        if (day == 7) {
            cal.add(Calendar.DAY_OF_MONTH, 2);
        }
        if (day == 8) {
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }
        return cal.getTime();
    }

    public static Date previousDay(Date date) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        int day = cal.get(Calendar.DAY_OF_WEEK);
        if (day == 7) {
            cal.add(Calendar.DAY_OF_MONTH, -1);
        }
        if (day == 8) {
            cal.add(Calendar.DAY_OF_MONTH, -2);
        }
        return cal.getTime();
    }

    public static boolean isWorkingDay() {
        Calendar cal = new GregorianCalendar();
        Date date = cal.getTime();
        cal.setTime(date);
        boolean flag = false;
        if (cal.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY || cal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
            flag = true;
        }
        return flag;
    }

    public static void htmlAnchorORNot(String subjectString) {
        Pattern titleFinder = Pattern.compile("<a[^>]*>(.*?)</a>", Pattern.DOTALL | Pattern.CASE_INSENSITIVE);
        Matcher regexMatcher = titleFinder.matcher(subjectString);
        while (regexMatcher.find()) {
            // matched text: regexMatcher.group(1)
        }
    }

    public static Map<String, String> actalUpdatedIssues(int userId, String[][] totalissues, String today) {
        Map<String, String> issueList = new LinkedHashMap<String, String>();
        String prevIssues = MoMUtil.getPrevIssues(userId, today);
        List<String> pIssueList = new ArrayList<String>();
        if (prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        if (totalissues != null) {
            for (int i = 0; i < totalissues.length; i++) {
                int uId = Integer.valueOf(totalissues[i][2]);
                if (uId == userId) {
                    String subjectColor = "";
                    String issueid = totalissues[i][0].substring(0, 12);
                    if (pIssueList.contains(issueid)) {
                        subjectColor = "#D2691E";
                    }
                    if (!"".equals(subjectColor)) {
                        String[] statusSubject = totalissues[i][1].split(":");
                        totalissues[i][1] = statusSubject[0] + " : <font color='" + subjectColor + "'>" + statusSubject[1] + "</font>";
                    }
                    issueList.put(totalissues[i][0], totalissues[i][1]);
                }
            }
        }
        return issueList;
    }

    public static Map addClosures(String weekClosedIssue) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        Map<Integer, List<String>> closed = new HashMap<Integer, List<String>>();
        String issues[] = weekClosedIssue.split(",");
        String extendedQuery = "";
        for (int i = 0; i < issues.length; i++) {
            if (i == 0) {
                extendedQuery = extendedQuery + "and (task like '" + issues[i] + "%' OR ";
            } else {
                extendedQuery = extendedQuery + "task like '" + issues[i] + "%' OR ";
            }
        }
        if (!"".equals(extendedQuery)) {
            extendedQuery = extendedQuery.substring(0, extendedQuery.length() - 4) + " ) order by userid";
        }
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(SUBSTR(task,0,12)) as issue,userId from Mom_user_task where tasktime ='Planned' " + extendedQuery;
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            List<String> issuenos = new ArrayList<String>();
            int user = 0;
            while (rs.next()) {
                String task = rs.getString("issue");
                Integer userId = rs.getInt("userid");
                if (user == 0) {
                    user = userId;
                    issuenos.add(task);
                } else if (user == rs.getInt("userid")) {

                    issuenos.add(task);
                } else {
                    closed.put(user, issuenos);
                    issuenos = new ArrayList<String>();
                    user = userId;
                    issuenos.add(task);
                }

            }
            if (user != 0 && !issuenos.isEmpty()) {
                closed.put(user, issuenos);
            }

        } catch (Exception e) {
            logger.error("addClosures" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return closed;
    }

    public static void createUsersPerformance(UsersPerformance usersPerformance) {
        long id = uniqueUserPerformance(usersPerformance.getUserId(), usersPerformance.getStartDate(), usersPerformance.getEndDate());
        if (id != 0l) {
            usersPerformance.setId(id);
            DAOFactory.createUsersPerformance(usersPerformance);
        } else {
            DAOFactory.saveUserPerformance(usersPerformance);
        }

    }

    public static Long uniqueUserPerformance(int userId, Date startDate, Date endDate) {
        Session session = null;
        long id = 0l;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("UsersPerformance.findUniqueUserPerformance");
            query.setParameter("userId", userId);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            UsersPerformance usersPerformance = (UsersPerformance) query.uniqueResult();
            if (usersPerformance != null) {
                id = usersPerformance.getId();
            }
            logger.info(id);
        } catch (Exception e) {
            logger.error("uniqueUserPerformance" + e.getMessage());
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
        return id;

    }

    public static List findAllUsersPerformance(Date startDate, Date endDate, int branch) {
        Session session = null;
        List<UsersPerformance> findAllUsersPerformance = null;
        Query query = null;
        try {
            session = HibernateFactory.getCurrentSession();

            if (branch > 0) {
                query = session.getNamedQuery("UsersPerformance.findAllUsersPerformanceByBranch");
                query.setParameter("branchId", branch);
            } else {
                query = session.getNamedQuery("UsersPerformance.findAllUsersPerformance");
            }
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            findAllUsersPerformance = (List<UsersPerformance>) query.list();
            if (findAllUsersPerformance == null) {
                findAllUsersPerformance = new ArrayList<UsersPerformance>();
            }
        } catch (Exception e) {
            logger.error("findAllUsersPerformance" + e.getMessage());
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
        return findAllUsersPerformance;

    }

    public static List<String> todayPlannedIssues(String plannedDate) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<String> issueList = new ArrayList<String>();
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + plannedDate + "'";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("issue") != null) {
                    issueList.add(rs.getString("issue"));
                }
            }
        } catch (Exception e) {
            logger.error("todayPlannedIssues" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static Map<Integer, List<String>> todayPlannedIssuesByUser(String plannedDate) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<String> issueList = new ArrayList<String>();
        Map<Integer, List<String>> planIssueByUser = new HashMap<Integer, List<String>>();
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(SUBSTR(task,0,12)) as issue,userId from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + plannedDate + "' order by userid";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            int olduserId = 0;
            while (rs.next()) {
                int newuserId = rs.getInt("userid");
                if (olduserId == 0) {
                    if (rs.getString("issue") != null) {
                        issueList.add(rs.getString("issue"));
                    }
                    olduserId = newuserId;
                    planIssueByUser.put(newuserId, issueList);
                } else if (olduserId != newuserId) {
                    issueList = new ArrayList<String>();
                    if (rs.getString("issue") != null) {
                        issueList.add(rs.getString("issue"));
                    }
                    olduserId = newuserId;
                    planIssueByUser.put(newuserId, issueList);
                } else {
                    if (rs.getString("issue") != null) {
                        issueList.add(rs.getString("issue"));
                    }
                    planIssueByUser.put(newuserId, issueList);
                }

            }
        } catch (Exception e) {
            logger.error("todayPlannedIssuesByUser" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error("todayPlannedIssues" + e.getMessage());
            }
        }
        return planIssueByUser;
    }

    public static List<UserPlannedIssues> todayPlannedByUser(String plannedDate, int userId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<UserPlannedIssues> issueList = new ArrayList<>();
        try {
            conn = MakeConnection.getConnection();
            String query = "select issue,slno from (select Distinct(SUBSTR(task,0,12)) as issue,mut.sino as slno from mom_user_task mut  where type='Issue' and tasktime='Planned' and userid='" + userId + "' and to_char(momdate,'dd-Mon-yyyy') = '" + plannedDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + plannedDate + "'";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("issue") != null) {
                    //  issueList.add(rs.getString("issue"));
                    UserPlannedIssues upi = new UserPlannedIssues();
                    if (rs.getString("slno") != null) {
                        upi.setSino(rs.getString("slno"));
                    }
                    upi.setIssueno(rs.getString("issue"));
                    issueList.add(upi);
                }
            }
        } catch (Exception e) {
            logger.error("todayPlannedIssues" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error("todayPlannedIssues" + e.getMessage());
            }
        }
        return issueList;
    }

    public static List findAllMomFeedBacks(List<Integer> momTeamTypes, int branchId) {
        Session session = null;
        List<MomFeedback> findAllMomFeedBacks = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = null;
            if (branchId > 0) {
                query = session.getNamedQuery("MomFeedback.findAllByBranch");
                query.setParameterList("momTeamType", momTeamTypes);
                query.setParameter("branchId", branchId);
            } else {
                query = session.getNamedQuery("MomFeedback.findAll");
                query.setParameterList("momTeamType", momTeamTypes);
            }

            findAllMomFeedBacks = (List<MomFeedback>) query.list();
            if (findAllMomFeedBacks == null) {
                findAllMomFeedBacks = new ArrayList<MomFeedback>();
            }
        } catch (Exception e) {
            logger.error("findAllMomFeedBacks" + e.getMessage());
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
        return findAllMomFeedBacks;

    }

    public static int getMomCleientId() {
        Connection connection = null;
        Statement statement = null, dropSeqeunceSt = null;
        ResultSet resultset = null, dropSequence = null;

        int momclientid = 1;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select MOM_FOR_CLIENT_SEQ.nextval from dual");
            if (resultset.next()) {
                momclientid = resultset.getInt(1);
            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence MOMID_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("CREATE SEQUENCE   MOM_CLIENT_ATTENDIES_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE");
                dropSequence = dropSeqeunceSt.executeQuery("select MOM_CLIENT_ATTENDIES_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                momclientid = dropSequence.getInt("nextvalue");
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
        return momclientid;

    }

    public static int getMomCleientAttId() {
        Connection connection = null;
        Statement statement = null, dropSeqeunceSt = null;
        ResultSet resultset = null, dropSequence = null;
        int momclientid = 1;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select MOM_CLIENT_ATTENDIES_SEQ.nextval from dual");
            if (resultset.next()) {
                momclientid = resultset.getInt(1);
            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence MOMID_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("CREATE SEQUENCE   MOM_FOR_CLIENT_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE");
                dropSequence = dropSeqeunceSt.executeQuery("select MOM_FOR_CLIENT_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                momclientid = dropSequence.getInt("nextvalue");
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
        return momclientid;

    }

    public static void saveBestPM(PmPerformance pmPerformance) {
        long id = 0l;
        PmPerformance pp = findBestPMByDate(pmPerformance.getStartdate(), pmPerformance.getEnddate(), pmPerformance.getBranchId());
        if (pp != null) {
            id = pp.getId();
        }
        if (id != 0l) {
            pmPerformance.setId(id);
            DAOFactory.createPMPerformance(pmPerformance);
        } else {
            DAOFactory.savePMPerformance(pmPerformance);
        }

    }

    public static PmPerformance findBestPMByDate(Date startDate, Date endDate, int branch) {
        Session session = null;
        PmPerformance bestPM = null;
        Query query = null;
        try {
            session = HibernateFactory.getCurrentSession();
            if (branch > 0) {
                query = session.getNamedQuery("PmPerformance.findByDateRangeByBranch");
                query.setParameter("branchId", branch);
            } else {
                query = session.getNamedQuery("PmPerformance.findByDateRange");
            }
            query.setParameter("startdate", startDate);
            query.setParameter("enddate", endDate);
            bestPM = (PmPerformance) query.uniqueResult();

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
        logger.info("bestPM.size()");

        return bestPM;
    }

    public static List<BestPMTeamBean> getBestPM(String year, int branch) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<BestPMTeamBean> bestPM = new ArrayList<BestPMTeamBean>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = null;
            if (branch > 0) {
                query = "select a.startdate as startDate,a.enddate as endDate,CONCAT(b.pname ,CONCAT(' v',b.version))as projectName,c.firstname||' '||substr(c.lastname,0,1) as name from pm_performance a,project b,users c where a.pid = b.pid and a.pmid=c.USERID and a.enddate between '01-JAN-" + year + "' and '31-DEC-" + year + "' and a.branch_id=" + branch + " order by a.startdate,name";

            } else {
                query = "select a.startdate as startDate,a.enddate as endDate,CONCAT(b.pname ,CONCAT(' v',b.version))as projectName,c.firstname||' '||substr(c.lastname,0,1) as name from pm_performance a,project b,users c where a.pid = b.pid and a.pmid=c.USERID and a.enddate between '01-JAN-" + year + "' and '31-DEC-" + year + "' order by a.startdate,name";
            }
            logger.info("BEST PM QUERY : " + query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                BestPMTeamBean bean = new BestPMTeamBean();
                bean.setStartDate(sdf.format(resultset.getDate("startDate")));
                bean.setEndDate(sdf.format(resultset.getDate("endDate")));
                bean.setProjectName(resultset.getString("projectName"));
                bean.setpManager(resultset.getString("name"));
                bestPM.add(bean);
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
        return bestPM;
    }

    public static List<BestPMTeamBean> getBestTeam(String year, int branch) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String query;
        List<BestPMTeamBean> bestTeam = new ArrayList<BestPMTeamBean>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            query = null;
            if (branch > 0) {
                query = "select distinct(team),startdate,enddate from users_performance where enddate > '07-APR-2014' and enddate between '01-JAN-" + year + "' and '31-DEC-" + year + "' and branch_id=" + branch + " and PERFORMANCETYPE  = 'Winner'  order by startdate,team";
            } else {
                query = "select distinct(team),startdate,enddate from users_performance where enddate > '07-APR-2014' and enddate between '01-JAN-" + year + "' and '31-DEC-" + year + "' and PERFORMANCETYPE  = 'Winner'  order by startdate,team";
            }
            logger.info("BEST TEAM QUERY : " + query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                BestPMTeamBean bean = new BestPMTeamBean();
                bean.setStartDate(sdf.format(resultset.getDate("startdate")));
                bean.setEndDate(sdf.format(resultset.getDate("enddate")));
                bean.setTeam(resultset.getString("team"));
                bestTeam.add(bean);
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
        return bestTeam;
    }

    public static void saveApmWrmPlan(List<String> issues, long pid, int userid) {
        Date currentDay = new Date();
        for (String issue : issues) {
            ApmWrmPlan apmWrmPlan = new ApmWrmPlan();
            apmWrmPlan.setIssueid(issue);
            apmWrmPlan.setPid(pid);
            apmWrmPlan.setPlannedby(userid);
            apmWrmPlan.setPlannedon(currentDay);
            apmWrmPlan.setWrmday(currentDay);
            apmWrmPlan.setStatus("Active");
            DAOFactory.createApmWrmPlan(apmWrmPlan);
        }
    }

    public static void update(List<ApmWrmPlan> apmId) {
        for (ApmWrmPlan id : apmId) {
            id.setStatus("InActive");
            DAOFactory.upateApmWrmPlan(id);
        }
    }

    public static void updateAc(List<ApmWrmPlan> apmId) {
        for (ApmWrmPlan id : apmId) {
            id.setStatus("Active");
            DAOFactory.upateApmWrmPlan(id);
        }
    }

    public static List<String> gettAllTeam() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> allTeam = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            String query = "select team_name from apm_team";

            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                if (resultset.getString("team_name").equalsIgnoreCase("JAVA / J2EE")) {
                    allTeam.add("Java");
                } else {
                    allTeam.add(resultset.getString("team_name"));
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
        return allTeam;
    }

    public static List<String> getActiveProjectPM(int branch) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> allPM = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            String query = null;
            if (branch > 0) {
                query = " select c.firstname||' '||substr(c.lastname,0,1) as name, a.pid,a.pname,a.version from project a,users c where a.PMANAGER=c.USERID and a.status = 'Work in progress' and a.pmanager !='104' and branch_id=" + branch + "";

            } else {
                query = " select c.firstname||' '||substr(c.lastname,0,1) as name, a.pid,a.pname,a.version from project a,users c where a.PMANAGER=c.USERID and a.status = 'Work in progress' and a.pmanager !='104' ";
            }
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                if (!allPM.contains(resultset.getString("name"))) {
                    allPM.add(resultset.getString("name"));
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
        return allPM;
    }

    public static List<MoMAttendance> userAttendance(int month, int year, int roleId, int assignto) {

        List<MoMAttendance> mAttendances = new ArrayList<MoMAttendance>();
        List<MoMAttendance> mAttendancesFinal = new ArrayList<MoMAttendance>();
        String period = month + "-" + year;
        if (month < 10) {
            period = "0" + month + "-" + year;
        }

        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            if (roleId == 1) {
                sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime) from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'MM-YYYY')='" + period + "' order by u.firstname,status";
                if (month == 0) {
                    sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime) from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'YYYY')='" + year + "' order by u.firstname,status";
                }
            } else {
                sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime) from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'MM-YYYY')='" + period + "' and m.userid=" + assignto + " order by u.firstname,status";
                if (month == 0) {
                    sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime) from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'YYYY')='" + year + "' and m.userid=" + assignto + " order by u.firstname,status";
                }
            }
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                MoMAttendance mAttendance = new MoMAttendance();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        mAttendance.setUserId((BigDecimal) row[col]);
                    } else if (col == 1) {
                        mAttendance.setStatus(row[col].toString());
                    } else if (col == 3) {
                        mAttendance.setTime(row[col].toString());
                    } else if (col == 2) {
                        mAttendance.setName(row[col].toString());
                    }
                }
                mAttendances.add(mAttendance);
            }
            for (MoMAttendance mAttendance1 : mAttendances) {
                mAttendance1.setCount(getCount(mAttendance1.getUserId(), mAttendance1.getStatus(), mAttendances));
                mAttendance1.setDatesList(getDate(mAttendance1.getUserId(), mAttendance1.getStatus(), mAttendances));
                if (!mAttendancesFinal.contains(mAttendance1)) {
                    mAttendancesFinal.add(mAttendance1);
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
        return mAttendancesFinal;
    }

    public static List<IssuesTask> momWrmIssues() {
        Session session = null;
        List<IssuesTask> issues = new ArrayList<IssuesTask>();
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,assignedto,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' ";

            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                IssuesTask issuesTask = new IssuesTask();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        issuesTask.setIssueno((String) row[col]);
                    } else if (col == 1) {
                        issuesTask.setProjectName(row[col].toString());
                    } else if (col == 4) {
                        issuesTask.setStatus(row[col].toString());
                    } else if (col == 3) {
                        issuesTask.setAssignedTo(Integer.valueOf(row[col].toString()));
                    } else if (col == 2) {
                        issuesTask.setSubject(row[col].toString());
                    }

                }
                issues.add(issuesTask);
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
        return issues;
    }

    public static List<Integer> findByTechnicalHead() {

        Session session = null;
        List<Integer> maintanance = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomMaintanance.findByTEAM");
            query.setParameter("team", 3);
            maintanance = (List<Integer>) query.list();
            if (maintanance == null) {
                maintanance = new ArrayList<Integer>();
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
        return maintanance;

    }

    public static List<IssuesTask> momWrmIssuesByPlan(String pid, String dateFor) {

        Session session = null;
        List<IssuesTask> issueTasks = new ArrayList<IssuesTask>();

        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            if (pid == null) {
                // sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,m.userid,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select substr(task,0,12) as issue,userid from mom_user_task m where m.momdate='" + dateFor + "' and  type='Issue' and tasktime='Planned') m where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and m.issue=i.issueid ";
                sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,m.userid,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select substr(task,0,12) as issue,userid from mom_user_task m where m.momdate='" + dateFor + "' and  type='Issue' and tasktime='Planned') m,(select MAX(wrmday) as wrmday,pid from Apm_Wrm_Plan group by pid) apm where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.issueid=s.issueid and to_char(ap.plannedon,'DD-Mon-YYYY')=apm.wrmday and ap.pid=apm.pid  and ap.issueid=i.issueid and ap.status='Active' and m.issue=i.issueid ";
            } else {
                //   sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,m.userid,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select substr(task,0,12) as issue,userid from mom_user_task m where m.momdate='" + dateFor + "' and  type='Issue' and tasktime='Planned') m where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.issueid=s.issueid  and i.pid=" + pid + " and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and m.issue=i.issueid ";

                sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,m.userid,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select  MAX(wrmday) as maxwrmday from Apm_Wrm_Plan where pid=" + pid + "), (select substr(task,0,12) as issue,userid from mom_user_task m where m.momdate='" + dateFor + "' and  type='Issue' and tasktime='Planned') m where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.issueid=s.issueid  and i.pid=" + pid + "  and to_char(ap.plannedon,'DD-Mon-YYYY') =maxwrmday and ap.issueid=i.issueid and ap.status='Active' and m.issue=i.issueid ";

            }
            logger.info("sqlQuery-------------->" + sqlQuery);
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                IssuesTask issuesTask = new IssuesTask();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        issuesTask.setIssueno((String) row[col]);
                    } else if (col == 1) {
                        issuesTask.setProjectName(row[col].toString());
                    } else if (col == 4) {
                        issuesTask.setStatus(row[col].toString());
                    } else if (col == 3) {
                        issuesTask.setAssignedTo(Integer.valueOf(row[col].toString()));
                    } else if (col == 2) {
                        issuesTask.setSubject(row[col].toString());
                    }

                }
                issueTasks.add(issuesTask);
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
        return issueTasks;

    }

    public static List<IssuesTask> momWrmIssuesByUser(int assignedTo, List<IssuesTask> issues) {

        List<IssuesTask> returnIssueTasks = new ArrayList<IssuesTask>();

        for (IssuesTask issuesTask : issues) {
            if (issuesTask.getAssignedTo() == assignedTo) {
                returnIssueTasks.add(issuesTask);
            }
        }
        return returnIssueTasks;

    }

    public static List<String> convertIssueNo(List<IssuesTask> issues) {
        List<String> issueNos = new ArrayList<String>();
        for (IssuesTask issuesTask : issues) {
            issueNos.add(issuesTask.getIssueno());
        }
        return issueNos;

    }

    public static int getCount(BigDecimal userId, String status, List<MoMAttendance> att) {
        int count = 0;
        for (MoMAttendance mom : att) {
            if (mom.getUserId().equals(userId) && mom.getStatus().equalsIgnoreCase(status)) {
                count++;
            } else if (count > 0) {
                break;
            }
        }
        return count;

    }

    public static List<String> getDate(BigDecimal userId, String status, List<MoMAttendance> att) {
        List<String> datesList = new ArrayList<String>();
        int count = 0;
        for (MoMAttendance mom : att) {
            if (mom.getUserId().equals(userId) && mom.getStatus().equalsIgnoreCase(status)) {
                count++;
                datesList.add(mom.getTime());
            } else if (count > 0) {
                break;
            }
        }
        return datesList;

    }

    public static String getDayOfWeek(String date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        DateFormat sdfa = new SimpleDateFormat("EEEE");
        String day = "";
        try {
            Date dateFormat = sdf.parse(date);
            day = sdfa.format(dateFormat);
        } catch (ParseException e) {
            logger.error(e.getMessage());
        }
        return day;
    }

    /*Edit By mukesh for create Send mom task*/
    public static MomUserTask createTaskMomForProcuder(int userId, String task, int createdBy, String type, String taskTime) {
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        String issueno = "";
        String prevIssues = "";
        if (type.equalsIgnoreCase("Count") || type.equalsIgnoreCase("Task")) {
        } else {
            // prevIssues = getPrevIssues(userId, dateFor);
        }

        List pIssueList = new ArrayList();
        if (!prevIssues.isEmpty() || prevIssues.length() > 12) {
            // pIssueList = MoMUtil.prevDayIssueList(userId, prevIssues);
        }
        MomUserTask usertask = new MomUserTask();
        try {
            if (type.equalsIgnoreCase("issue")) {
                issueno = task;
                HashMap issue = IssueDetails.getIssue(task);
                String sub = (String) issue.get("subject");
                String status = (String) issue.get("status");
                String duedate = (String) issue.get("Formatduedate");
                String pName = (String) issue.get("projectname") + " v" + (String) issue.get("fixversion");
                Date duDate = sdf.parse(duedate);
                Date currentDate = new Date();
                String statusColor = "";
                String subjectColor = "";
                currentDate = subtractDay(currentDate);
                if (duDate.compareTo(currentDate) < 0) {
                    statusColor = "Red";
                }
                if (pIssueList.contains(task.trim())) {

                    subjectColor = "#D2691E";

                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : <font color='" + subjectColor + "'>" + sub + "</font>";
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : <font color='" + subjectColor + "'>" + sub + "</font>";
                    }
                } else {
                    if ("".equals(statusColor)) {
                        if (sub != null) {
                            task = task + ":" + pName + " # " + status + " : " + sub;
                        }
                    } else {
                        task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : " + sub + "</font>";
                    }

                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        try {

            usertask.setUserid(userId);
            usertask.setTask(task);
            usertask.setCreatedby(createdBy);
            usertask.setCreatedon(date);
            usertask.setModifiedon(date);
            usertask.setMomdate(date);
            usertask.setType(type);
            usertask.setTasktime(taskTime);

        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return usertask;
    }

    public void updateMomUserTask(List<MomUserTask> momUserTasksList) {

        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();
            String sql = "{call PROC_CREATETASK (?,?,? ,? ,? ,? ,? ,? )}";
            ps = connection.prepareStatement(sql);

            for (MomUserTask momUserTasks : momUserTasksList) {

                ps.setInt(1, momUserTasks.getUserid());
                ps.setString(2, momUserTasks.getTask());
                ps.setString(3, momUserTasks.getType());
                ps.setInt(4, momUserTasks.getCreatedby());
                ps.setTimestamp(5, new java.sql.Timestamp(new Date().getTime()));
                ps.setTimestamp(6, new java.sql.Timestamp(new Date().getTime()));
                ps.setDate(7, new java.sql.Date(new Date().getTime()));
                ps.setString(8, momUserTasks.getTasktime());
                ps.executeUpdate();
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    public void unplanTaskByIssueAndUserId(List<MomUserTask> momUserTasksList) {
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();

        PreparedStatement ps = null;
        Connection connection = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String dateFor = sdf.format(date);

            connection = MakeConnection.getConnection();
            String sql = "{call PROC_UNPLANNEFORUSER (?,?,?,?,? )}";
            ps = connection.prepareStatement(sql);

            for (MomUserTask momUserTasks : momUserTasksList) {
                logger.info(momUserTasks.toString());
                ps.setString(1, momUserTasks.getMomdate() == null ? dateFor : sdf.format(momUserTasks.getMomdate()));
                ps.setString(2, momUserTasks.getTask());
                ps.setInt(3, momUserTasks.getUserid());
                ps.setString(4, momUserTasks.getMomtaskid());
                ps.setString(5, momUserTasks.getType());

                ps.executeUpdate();
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    public void createMomDeatilsProcedure(List<MomUserDetail> momUserDetails) {
        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();
            String sql = "{call PROC_CREATMOMDETAILS (?,?,?,?,?,?,?,? )}";
            ps = connection.prepareStatement(sql);

            for (MomUserDetail momUserDetail : momUserDetails) {
                ps.setInt(1, momUserDetail.getUserid());
                ps.setDate(2, new java.sql.Date(new Date().getTime()));
                ps.setString(3, momUserDetail.getStatus());
                ps.setInt(4, momUserDetail.getCreatedby());
                ps.setTimestamp(5, new java.sql.Timestamp(new Date().getTime()));
                ps.setTimestamp(6, new java.sql.Timestamp(new Date().getTime()));
                ps.setString(7, momUserDetail.getMomtime());
                ps.setString(8, momUserDetail.getComment());
                ps.executeUpdate();
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    public Map<Integer, String> createIssueCountTaskProcedure(List<Integer> momUseridList) {
        Connection connection = null;
        CallableStatement callableStatement = null;
        ResultSet rs = null;

        Map<Integer, String> map = new HashMap<Integer, String>();
        try {
            connection = MakeConnection.getConnection();
            String sql = "{call PROC_CREATEISSUECOUNTTASK (?,?)}";
            callableStatement = connection.prepareCall(sql);
            for (Integer momUserid : momUseridList) {
                int issueCount = 0;
                String pname;
                String version;
                String issueCountTask = "";
                int total = 0;
                callableStatement.setInt(1, momUserid);
                callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
                callableStatement.executeUpdate();
                rs = (ResultSet) callableStatement.getObject(2);
                while (rs.next()) {

                    issueCount = rs.getInt("issueCount");
                    pname = rs.getString("pname");
                    version = rs.getString("version");
                    total = total + issueCount;
                    if (issueCount > 0) {
                        issueCountTask = pname + " v" + version + "=" + issueCount + ", " + issueCountTask;

                    }

                }
                issueCountTask = "Total=" + total + ", " + issueCountTask;
                issueCountTask = issueCountTask.substring(0, issueCountTask.length() - 2);
                map.put(momUserid, issueCountTask);
                try {
                    if (rs != null) {
                        rs.close();
                    }
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (callableStatement != null) {
                    callableStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return map;
    }

    public static Map<Integer, String> attendanceDetailsWithTime(String dateFor, String momTime) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> attendanceStatus = new HashMap<Integer, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select userid,STATUS from MOM_USER_DETAIL where to_char(momdate,'DD-Mon-yyyy')='" + dateFor + "' and momtime ='" + momTime + "'");
            while (resultset.next()) {
                attendanceStatus.put(resultset.getInt("userId"), resultset.getString("Status"));
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
        return attendanceStatus;

    }

    public static List<String> plannedIssuesByPidAndPlannedDate(int pid, String plannedDate) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<String> issueList = new ArrayList<String>();
        String query;
        try {

            conn = MakeConnection.getConnection();
            if (pid == 0) {
                query = "select i.issueid as issue from issue i,(select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + plannedDate + "') pi where pi.issue = i.issueid";

            } else {
                query = "select i.issueid as issue from issue i,(select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + plannedDate + "') pi where pi.issue = i.issueid and i.pid=" + pid;
            }
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("issue") != null) {
                    issueList.add(rs.getString("issue"));
                }
            }
        } catch (Exception e) {
            logger.error("plannedIssuesByPidAndPlannedDate" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static List<MoMAttendance> userAttendanceList(int month, int year, int roleId, int assignto) {

        List<MoMAttendance> mAttendances = new ArrayList<MoMAttendance>();
        String period = month + "-" + year;
        if (month < 10) {
            period = "0" + month + "-" + year;
        }

        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";

            if (roleId == 1) {
                sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime),MOMCOMMENT from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'MM-YYYY')='" + period + "' and m.userid=" + assignto + " order by u.firstname,status";
                if (month == 0) {
                    sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime),MOMCOMMENT from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'YYYY')='" + year + "'and m.userid=" + assignto + "  order by u.firstname,status";
                }
            } else {
                sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime),MOMCOMMENT from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'MM-YYYY')='" + period + "' and m.userid=" + assignto + " order by u.firstname,status";
                if (month == 0) {
                    sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1) as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime),MOMCOMMENT from mom_user_detail m, users u where m.userid=u.USERID and to_char(momdate,'YYYY')='" + year + "' and m.userid=" + assignto + " order by u.firstname,status";
                }
            }
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                MoMAttendance mAttendance = new MoMAttendance();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        mAttendance.setUserId((BigDecimal) row[col]);
                    } else if (col == 1) {
                        mAttendance.setStatus(row[col].toString());
                    } else if (col == 3) {
                        mAttendance.setTime(row[col].toString());
                    } else if (col == 2) {
                        mAttendance.setName(row[col].toString());
                    } else if (col == 4) {
                        if (row[col] == null) {
                            mAttendance.setMomComments("");
                        } else {
                            mAttendance.setMomComments(row[col].toString());

                        }
                    }
                }
                mAttendances.add(mAttendance);
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
        return mAttendances;
    }

    /*Edit end By mukesh for create Send mom task*/
    /*Edit by mukesh  for Team Performance*/
    public static Map<Integer, List<MomUserTask>> viewTaskBetweenTwoDate(String date1, String date2) {
        Session session = null;
        Map<Integer, List<MomUserTask>> map = new HashMap<Integer, List<MomUserTask>>();
        List<MomUserTask> list = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createQuery("from MomUserTask where (Momdate>='" + date2 + "' And Momdate<='" + date1 + "') order by userid,  momdate desc,type,taskTime,momtaskid");

            List<MomUserTask> listMomUserTsk = (List<MomUserTask>) query.list();
            if (listMomUserTsk == null || listMomUserTsk.isEmpty()) {

            } else {
                Integer userId = 0;
                int size = listMomUserTsk.size();
                int i = 0;
                for (MomUserTask momUserTsk : listMomUserTsk) {
                    i++;
                    if (userId == 0) {
                        list = new ArrayList<MomUserTask>();
                        userId = momUserTsk.getUserid();
                        list.add(momUserTsk);
                    } else if (userId.intValue() == momUserTsk.getUserid()) {
                        list.add(momUserTsk);
                    } else {
                        map.put(userId, list);
                        list = new ArrayList<MomUserTask>();
                        list.add(momUserTsk);
                        userId = momUserTsk.getUserid();
                    }
                    if (size == i) {
                        map.put(userId, list);
                    }
                }
            }

            //      logger.info("No of Tasks" + l.size() + "for User :" + userId);
        } catch (Exception e) {
            e.printStackTrace();
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
        return map;
    }

    public static String[][] issuesDetails(String start, String end) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String MoMIssueDetails[][] = null;
        try {
            conn = MakeConnection.getConnection();
            String query = "select Distinct(i.issueid),s.status,i.subject,p.pname,p.version from issuecomments ic,issue i,issuestatus s,project p where i.pid=p.pid and ic.issueid =i.issueid and  i.issueid =s.issueid and comment_date between '" + start + "' and '" + end + "' and ic.COMMENTS not like 'Due date is realigned because of issue#%'  group by i.issueid,s.status,subject,p.pname,p.version order by i.issueid,s.status,subject,p.pname,p.version";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();

            rs.last();
            Integer size = rs.getRow();
            rs.beforeFirst();
            MoMIssueDetails = new String[size][4];
            int count = 0;
            while (rs.next()) {
                MoMIssueDetails[count][0] = rs.getString("issueid");
                MoMIssueDetails[count][1] = rs.getString("status");
                MoMIssueDetails[count][2] = rs.getString("subject");
                MoMIssueDetails[count][3] = rs.getString("pname") + " v" + rs.getString("version");
                count++;

            }
        } catch (Exception e) {
            logger.error("showIssuesDetails" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return MoMIssueDetails;
    }

    /*Edit end By mukesh  for Team Performance*/
    public static void saveAgreedIssues(List<String> issues, long pid, int userid, String type) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String totalissuenos = "";
        try {
            conn = MakeConnection.getConnection();
            String query = "update Agreed_issues set status=1 where project_id=" + pid + " and  ISSUE_TYPE='" + type + "' ";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            pstmt.executeUpdate();
            if (issues != null) {
                for (String issue : issues) {
                    totalissuenos = totalissuenos + "'" + issue.trim() + "',";
                    AgreedIssues ai = new AgreedIssues();
                    AgreedIssuesPK agreedIssuesPK = new AgreedIssuesPK(issue, type);
                    ai.setAgreedIssuesPK(agreedIssuesPK);
                    ai.setProjectId(pid);
                    ai.setAddedby(userid);
                    ai.setAddedon(new Date());
                    ai.setStatus(0);
                    ModelDAO.saveOrUpdate("AgreedIssues", ai);
                }
                if (totalissuenos.contains(",")) {
                    totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                }
                if (!type.equalsIgnoreCase("Agreed")) {
                    query = "update Agreed_issues set status=1 where project_id=" + pid + " and  ISSUE_TYPE not in ('" + type + "','Agreed') and issue_id in(" + totalissuenos + ")";
                    pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    pstmt.executeUpdate();
                }

            }
        } catch (Exception e) {
            logger.error("saveAgreedIssues" + e.getMessage());
        } finally {
            try {
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
    }

    public static Map<Long, Integer> getProjectwisePlannedIssuesCount(Date date) {
        Map<Long, Integer> map = new HashMap<>();
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String plannedDate = sdf.format(date);
            conn = MakeConnection.getConnection();

            String query = "select pid,count(issueid) from issue i where issueid in  (SELECT p.ISSUEID FROM PROJECT_PlANNED_ISSUE p WHERE status='Active' and p.PLANNEDON='" + plannedDate + "' union select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task where  type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') ='" + plannedDate + "') group by pid";

            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                map.put(rs.getLong(1), rs.getInt(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return map;
    }

    public static Map<Integer, String> getIntimationCount() {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        Map<Integer, String> map = new HashMap();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            conn = MakeConnection.getConnection();
            String query = "select m.userid,m.status,c.count from MOM_USER_DETAIL m left join MOM_USER_STATUS_COUNT c on m.userid=c.userid and m.status=c.status where m.status in ('Intimated','Permission') and to_char(m.momdate,'dd-Mon-yyyy') ='" + sdf.format(new Date()) + "'";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt(1), rs.getString(2) + ":" + rs.getInt(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return map;

    }

    public static Map<Integer, LinkedHashMap<String, Float>> leaveDeatalis() {
        Map<Integer, LinkedHashMap<String, Float>> leaveDeatalisMontha = new HashMap();
        try {
            Calendar cal = new GregorianCalendar();
            int currentYear = cal.get(Calendar.YEAR);
            int currentMonth = cal.get(Calendar.MONTH);
            String startdate = "01-Apr-" + currentYear;
            String endDate = "31-Mar-" + (currentYear + 1);
            if (currentMonth < 3) {
                startdate = "01-Apr-" + (currentYear - 1);
                endDate = "31-Mar-" + (currentYear);
            }
            leaveDeatalisMontha = LeaveBlancePeriodDAO.leaveCountByPeriod(startdate, endDate);

        } catch (SQLException | ParseException e) {
            logger.error(e.getMessage());
        }
        return leaveDeatalisMontha;
    }

    public String getMoMStatusCount(HttpServletRequest request) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String res = "";

        try {
            String userid = request.getParameter("userid");
            String status = request.getParameter("status");

            conn = MakeConnection.getConnection();
            String query = "select status,count from MOM_USER_STATUS_COUNT  where userid=" + userid + " and status = '" + status + "'";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                res = rs.getString(1) + ":" + rs.getInt(2);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return res;

    }

    public static Map<Integer, List<String>> atcualIssuesOnDate(String date) {
        Map<Integer, List<String>> issueList = new LinkedHashMap<Integer, List<String>>();
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = MakeConnection.getConnection();

            String query = "select distinct(ic.issueid) as issue ,ic.COMMENTEDBY  from issuecomments ic,users u,(select distinct(issue) as issue from (select pp.ISSUEID as issue from PROJECT_PlANNED_ISSUE pp where pp.STATUS='Active' and to_char(PLANNEDON,'dd-Mon-yyyy') = '" + date + "' \n"
                    + "union select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + date + "'))t\n"
                    + "where t.issue=ic.issueid and u.USERID=ic.COMMENTEDBY and u.EMAIL like '%@eminentlabs.net' and to_char(ic.comment_date,'dd-Mon-yyyy') = '" + date + "' order by ic.COMMENTEDBY";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                List<String> list = issueList.get(rs.getInt(2));
                if (list == null) {
                    list = new ArrayList();
                }
                list.add(rs.getString(1));
                issueList.put(rs.getInt(2), list);

            }
        } catch (Exception e) {
            logger.error("actualupdated" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public static Set<String> getIssueListByUser(List<String> weekPlanissues, String userId) {
        Set<String> issuenos = new HashSet<>();
        for (String issueUser : weekPlanissues) {
            String issueuser[] = issueUser.split(",");
            String issueno = issueuser[0];
            String userid = issueuser[1];
            if (userId.equalsIgnoreCase(userid)) {
                issuenos.add(issueno);
            }
        }

        return issuenos;
    }

}
