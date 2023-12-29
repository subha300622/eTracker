/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tqm;

import pack.eminent.encryption.MakeConnection;
import com.eminent.timesheet.CreateTimeSheet;
import com.eminent.timesheet.Users;
import com.eminent.util.GetProjectManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.GetProjects;
import com.eminent.util.SendMail;
import java.sql.Date;
import java.sql.PreparedStatement;
import oracle.jdbc.driver.OraclePreparedStatement;
import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Collection;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Administrator
 */
public class TqmUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("TQM Util");
    }
    public static String getID() throws Exception {
        String testCaseIdFormat = null;
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
                testCaseIdFormat = "Q0" + day;
            } else {
                testCaseIdFormat = "Q" + day;
            }
            if (month < 10) {
                testCaseIdFormat = testCaseIdFormat + "0" + month + year;
            } else {
                testCaseIdFormat = testCaseIdFormat + month + year;
            }

            dateCheck = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dateCheckRs = statement.executeQuery("select PTCID from TQM_PTCM where to_char(createdon,'dd-mm-yyyy') like (select to_char(sysdate,'dd-mm-yyyy') from dual)");

            if (dateCheckRs.next()) {
                seqStatement = connection.createStatement();
                seqResultSet = seqStatement.executeQuery("select PTCID_SEQ.nextval as nextvalue from dual");

                seqResultSet.next();
                int nextValue = seqResultSet.getInt("nextvalue");
                if (nextValue < 10) {
                    testCaseIdFormat = testCaseIdFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    testCaseIdFormat = testCaseIdFormat + "0" + nextValue;
                } else {
                    testCaseIdFormat = testCaseIdFormat + nextValue;
                }
                logger.info("Test case ID:\t" + testCaseIdFormat);

            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence PTCID_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("create sequence PTCID_SEQ start with 1 increment by 1 nocache nocycle");
                dropSequence = dropSeqeunceSt.executeQuery("select PTCID_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                int nextValue = dropSequence.getInt("nextvalue");
                if (nextValue < 10) {
                    testCaseIdFormat = testCaseIdFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    testCaseIdFormat = testCaseIdFormat + "0" + nextValue;
                } else {
                    testCaseIdFormat = testCaseIdFormat + nextValue;
                }
                logger.info("dropped PTC ID:\t" + testCaseIdFormat);

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

        return testCaseIdFormat;
    }

    public static String getCtcID() throws Exception {
        String testCaseIdFormat = null;
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
                testCaseIdFormat = "Q0" + day;
            } else {
                testCaseIdFormat = "Q" + day;
            }
            if (month < 10) {
                testCaseIdFormat = testCaseIdFormat + "0" + month + year;
            } else {
                testCaseIdFormat = testCaseIdFormat + month + year;
            }

            dateCheck = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dateCheckRs = statement.executeQuery("select CTCID from TQM_CTCM where to_char(createdon,'dd-mm-yyyy') like (select to_char(sysdate,'dd-mm-yyyy') from dual)");

            if (dateCheckRs.next()) {
                seqStatement = connection.createStatement();
                seqResultSet = seqStatement.executeQuery("select CTCID_SEQ.nextval as nextvalue from dual");

                seqResultSet.next();
                int nextValue = seqResultSet.getInt("nextvalue");
                if (nextValue < 10) {
                    testCaseIdFormat = testCaseIdFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    testCaseIdFormat = testCaseIdFormat + "0" + nextValue;
                } else {
                    testCaseIdFormat = testCaseIdFormat + nextValue;
                }
                logger.info("Test case ID:\t" + testCaseIdFormat);

            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence CTCID_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("create sequence CTCID_SEQ start with 1 increment by 1 nocache nocycle");
                dropSequence = dropSeqeunceSt.executeQuery("select CTCID_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                int nextValue = dropSequence.getInt("nextvalue");
                if (nextValue < 10) {
                    testCaseIdFormat = testCaseIdFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    testCaseIdFormat = testCaseIdFormat + "0" + nextValue;
                } else {
                    testCaseIdFormat = testCaseIdFormat + nextValue;
                }
                logger.info("dropped PTC ID:\t" + testCaseIdFormat);

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

        return testCaseIdFormat;
    }

    public static void createPTC(int pid, int mid, String functionality, String description, String expectedresult, int userId, String tepId, String addPlan) {

        SessionFactory sessionFactory = null;
        Session sess = null;
        try {
            String ptcid = getID();
            logger.info("ID" + ptcid);
            sessionFactory = HibernateUtil.getSessionFactory();
            sess = sessionFactory.openSession();
            sess.beginTransaction();
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmPtcm tc = new TqmPtcm();
            tc.setPtcid(ptcid);
            tc.setPid(pid);
            tc.setMid(mid);
            tc.setFunctionality(functionality);
            tc.setDescription(description);
            tc.setExpectedresult(expectedresult);
            tc.setCreatedby(userId);
            tc.setCreatedon(date);
            tc.setModifiedon(date);
            sess.save("producttestcases", tc);
            sess.getTransaction().commit();

            sess.flush();
            sess.clear();
            if (addPlan != null) {
                addUserTestCase(tepId, ptcid, userId);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }
        }

    }

    public static void createIssuePTC(int pid, int mid, String functionality, String description, String expectedresult, int userId, String issueId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        Session sess1 = sessionFactory.openSession();
        Session sess2 = sessionFactory.openSession();
        try {
            String ptcid = getID();
            logger.info("ID" + ptcid);
            sess.beginTransaction();
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmPtcm tc = new TqmPtcm();
            TqmTestcasestatus status = null;
            tc.setPtcid(ptcid);
            tc.setPid(pid);
            tc.setMid(mid);
            tc.setFunctionality(functionality);
            tc.setDescription(description);
            tc.setExpectedresult(expectedresult);
            tc.setCreatedby(userId);
            tc.setCreatedon(date);
            tc.setModifiedon(date);
            sess.save("producttestcases", tc);
            sess.getTransaction().commit();

            Criteria c = sess2.createCriteria("testcasestatus");
            c.add(Restrictions.eq("status", "Yet to Test"));
            List l = c.list();
            if (l.size() > 0) {
                status = (TqmTestcasestatus) l.get(0);
            }

            TqmPtcm ptcm = viewPTC(ptcid);

            sess1.beginTransaction();
            TqmIssuetestcases titc = new TqmIssuetestcases();
            logger.info("Issue Id-->" + issueId);
            titc.setIssueid(issueId.trim());
            titc.setTqmPtcm(ptcm);
            titc.setTqmtestcasestatus(status);
            sess1.save("isstestcases", titc);
            sess1.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }
            if (sess1 != null) {
                sess1.close();
            }
            if (sess2 != null) {
                sess2.close();
            }
        }

    }

    public static void updateTestCase(String ptcid, int status) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();

        try {
            String hql = "update isstestcases set statusid = :statid where ptcid = :testcaseid";
            Query query = sess.createQuery(hql);

            query.setInteger("statid", status);
            query.setString("testcaseid", ptcid);
            int rowCount = query.executeUpdate();
            //       System.out.println("Updated"+rowCount);
            sess.getTransaction().commit();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }

        }
    }

    public static void updateTestCaseResult(String comments, String issueid, String ptcid, int statusid, int userId) {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.openSession();

        try {
            session.beginTransaction();
            TqmPtcm ptc = new TqmPtcm();
            Users user = CreateTimeSheet.GetUser(userId);
            ptc.setPtcid(ptcid);
            TqmTestcaseresult result = new TqmTestcaseresult();
            TqmTestcasestatus t = new TqmTestcasestatus();
            t.setStatusid(statusid);
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            result.setIssueid(issueid);
            result.setTqmptcm(ptc);
            result.setTestcomments(comments);
            result.setTqmtestcasestatus(t);
            result.setCommentedon(date);
            result.setCommentedby(user);
            session.save("testcaseresult", result);
            session.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public static List listPTC() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from producttestcases order by createdon desc");
        List l = query.list();
        session.close();
        return l;
    }

    public static List listProjectTC(int pid) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from producttestcases where pid=" + pid + " order by createdon desc");
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static int countUserTestcases(int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        int size = 0;
        try {
            session.beginTransaction();
            Query query = session.createQuery("select count(*) from producttestcases where createdby=" + userId + " and pid in (:projects) order by createdon desc");
            query.setParameterList("projects", GetProjectManager.getAssignedProjects(userId));
            size = ((Long) query.iterate().next()).intValue();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return size;
    }

    public static List listUserPTC(int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from producttestcases where createdby=" + userId + " and pid in (:projects) order by createdon desc");
            query.setParameterList("projects", GetProjectManager.getAssignedProjects(userId));
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static List listUserPTCTest(int userId, int pageNo) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        int pageSize = 15;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from producttestcases where createdby=" + userId + " and pid in (:projects) order by createdon desc");
            query.setParameterList("projects", GetProjectManager.getAssignedProjects(userId));
            query = query.setFirstResult(pageSize * (pageNo - 1));
            query.setMaxResults(pageSize);
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static List listUserPTCTest(int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from producttestcases where createdby=" + userId + " and pid in (:projects) order by createdon desc");
            query.setParameterList("projects", GetProjectManager.getAssignedProjects(userId));
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static List listMonthlyPTC(String start, String end) {

        //       System.out.println("Start Date:"+start+" Endate:"+end);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from producttestcases where to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '" + start + "' and '" + end + "'  order by createdon desc");
        List l = query.list();
        session.close();
        return l;
    }

    public static List listProductTC(String pid) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from producttestcases where pid='" + pid + "' order by createdon desc");
        List l = query.list();
        session.close();
        return l;
    }

    public static List listMonthlyTEP(String start, String end) {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from executionplan where to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '" + start + "' and '" + end + "'  order by createdon desc");
            l = query.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static TqmPtcm searchPTC(String ptcID) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        TqmPtcm tqmPtcm = null;
        Query query = session.createQuery("from producttestcases where ptcid='" + ptcID + "'");
        List l = query.list();
        int size = l.size();
        if (size > 0) {
            int i = 0;
            tqmPtcm = (TqmPtcm) l.get(i);
        }
        session.close();

        return tqmPtcm;
    }

    public static TqmPtcm viewPTC(String ptcID) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        TqmPtcm tqmPtcm = null;
        Query query = session.createQuery("from producttestcases where ptcid='" + ptcID + "'");
        List l = query.list();
        int size = l.size();
        if (size > 0) {
            int i = 0;
            tqmPtcm = (TqmPtcm) l.get(i);
        }
        session.close();

        return tqmPtcm;
    }

    public static boolean isPtcExist(String ptcID) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        TqmCtcm tqmCtcm = null;
        boolean flag = true;
        Query query = session.createQuery("from commontcm where ptcid='" + ptcID + "'");
        List l = query.list();
        int size = l.size();
        if (size > 0) {
            int i = 0;
            tqmCtcm = (TqmCtcm) l.get(i);
            flag = false;
        }
        session.close();

        return flag;
    }

    public static void createCTC(String ptcid, String functionality, String description, String expectedresult, int orginator, int userId) {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.openSession();

        try {
            session.beginTransaction();
            TqmCtcm ctc = new TqmCtcm();

            Timestamp date = new Timestamp(new java.util.Date().getTime());
            ctc.setCtcid(getCtcID());
            ctc.setPtcid(ptcid);
            ctc.setCreatedby(orginator);
            ctc.setApprovedby(userId);
            ctc.setFunctionality(functionality);
            ctc.setDescription(description);
            ctc.setExpectedresult(expectedresult);
            ctc.setCreatedon(date);
            ctc.setModifiedon(date);
            session.save("commontcm", ctc);
            session.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }

    }

    public static List listCTC() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from commontcm order by createdon asc");
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static List listMonthlyCTC(String start, String end) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from commontcm where to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY') between '" + start + "' and '" + end + "' order by createdon asc");
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static TqmCtcm viewCTC(String ctcID) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        TqmCtcm tqmCtcm = null;
        Query query = session.createQuery("from commontcm where ctcid='" + ctcID + "'");
        List l = query.list();
        int size = l.size();
        if (size > 0) {
            int i = 0;
            tqmCtcm = (TqmCtcm) l.get(i);
        }
        session.close();

        return tqmCtcm;
    }

    public static List getPtcResults(String ptcID, String issueId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from testcaseresult where ptcid='" + ptcID + "' and issueid='" + issueId + "'");
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static void addExecutionTestCase(int executionId, String ptcids[], int userId, ArrayList assignedto, String dueDate) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();
        TqmTestcaseexecution execution = null;

        int i = 0;
        try {

            Timestamp date = new Timestamp(new java.util.Date().getTime());

            String storeDate = null;
            java.sql.Date dbDate = null;
            if (dueDate != null) {
                if (!dueDate.equalsIgnoreCase("NA")) {
                    dueDate = dueDate.trim();
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                    dueDate = com.pack.ChangeFormat.getNumberDate(dueDate);

                    storeDate = com.pack.ChangeFormat.getDateFormat(dueDate);
                    logger.info("Date Check" + storeDate);
                    dbDate = java.sql.Date.valueOf(storeDate);
                }
            }

            while (i < ptcids.length) {

                Users user = CreateTimeSheet.GetUser(Integer.parseInt((String) assignedto.get(i)));
                execution = new TqmTestcaseexecution();
                String ptcid = ptcids[i];
                execution.setPtcid(viewPTC(ptcid));
                execution.setTqmTestcaseexecutionplan(TestCasePlan.viewPlan(((Integer) executionId).toString()));
                execution.setAssignedto(user);
                execution.setCreatedby(CreateTimeSheet.GetUser(userId));
                execution.setCreatedon(date);
                execution.setModifiedon(date);
                execution.setDuedate(dbDate);
                execution.setStatusid(i);
                sess.save("testcaseexecution", execution);

                if (i++ % 20 == 0) {
                    sess.flush();
                    sess.clear();
                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
    }

    public static void addUserTestCase(String tepId, String ptcid, int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();
        TqmTestcaseexecution execution = null;

        int i = 0;
        try {

            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmTestcaseexecutionplan plan = TestCasePlan.viewPlan(tepId);
            String storeDate = null;
            java.sql.Date dbDate = null;

            Users user = CreateTimeSheet.GetUser(userId);
            TqmPtcm tqmPtcm = viewPTC(ptcid);
            execution = new TqmTestcaseexecution();

            execution.setPtcid(tqmPtcm);
            execution.setTqmTestcaseexecutionplan(plan);
            execution.setAssignedto(plan.getQualitymanager());
            execution.setCreatedby(user);
            execution.setCreatedon(date);
            execution.setModifiedon(date);
            execution.setDuedate(plan.getPlannedend());
            execution.setStatusid(i);
            sess.save("testcaseexecution", execution);
            String orgName = user.getFirstname() + user.getLastname().substring(0, 1);
            String qmName = plan.getQualitymanager().getFirstname() + plan.getQualitymanager().getLastname().substring(0, 1);
            String planName = plan.getPlanname();
            String pId = String.valueOf(plan.getPid());
            String mId = String.valueOf(tqmPtcm.getMid());
            String project = GetProjects.getProjectName(pId);
            ArrayList<String> al = dashboard.Project.getDetails(project);
            int index = 0;
            if (project != null) {
                index = project.lastIndexOf(":");
            }
            String qmid = String.valueOf(plan.getQualitymanager().getUserid());
            String projectname = project.substring(0, index);
            String version = project.substring((index + 1));

            String mname = GetProjects.getModuleName(mId);
            String subject = "eTracker Yet to Test TestCase : " + tqmPtcm.getFunctionality();
            String htmlContent = "";
            htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% > <font face=Verdana, Arial, Helvetica, sans-serif size=2 >"
                    + "<tr bgcolor=#E8EEF7 ><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Project</b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + projectname + "</font></td>"
                    + "<td width = 18% ><b> <font face=Verdana, Arial, Helvetica, sans-serif size=2 >Customer </b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(5) + "</td>"
                    + "</tr>"
                    + "<tr><td width   = 18% ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 > Version </b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + version + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Manager</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(al.get(0)) + "</td> "
                    + "</tr>"
                    + "<tr  bgcolor=#E8EEF7><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b> Status </b></td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(4) + "</td>"
                    + "<td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Phase</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(1) + "</td> "
                    + "</tr>"
                    + "<tr><td width   = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Start Date</b> </td>"
                    + "<td width  = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(2) + "</td>"
                    + "<td width  = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>End Date</b> </td>"
                    + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + al.get(3) + "</td>"
                    + "</tr></table><br/>";
            htmlContent = htmlContent + "<font color=blue><b>Test Case details</b></font><table  width=\"100%\"><tr bgcolor=\"#E8EEF7\"><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Plan Name</b></font></td><td colspan=\"3\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + planName + "</font></td></tr><tr >"
                    + "<td width=\"20%\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Test Case ID</b></font></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + ptcid + "</font></td><td width=\"7%\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Module</b></font></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + mname + "</font></td></tr>"
                    + "<tr bgcolor=\"#E8EEF7\"><td ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Created By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + orgName + "</td><td width=\"13%\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Assigned To</b></font></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + qmName + "</font></td></tr>"
                    + "<tr ><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Functionality</b></font></td><td colspan=\"3\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + tqmPtcm.getFunctionality() + "</font></td></tr>"
                    + "<tr bgcolor=\"#E8EEF7\"><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Description</b></font></td><td colspan=\"3\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + tqmPtcm.getDescription() + "</font></td></tr>"
                    + "<tr ><td><b>Expected Result</font></b></td><td colspan=\"3\"><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + tqmPtcm.getExpectedresult() + "</font></td></tr>";
            String endLine = "</table><br>Thanks,";
            String signature = "<br>eTracker&trade;<br>";
            String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak = "<br>";
            String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
            htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;
            SendMail.testCaseMail(subject, htmlContent, orgName, qmid);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
    }

    public static int getTceTestcases(int executionId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        int size = 0;
        try {
            session.beginTransaction();
            Query query = session.createQuery("Select count(*) from testcaseexecution where tepid='" + executionId + "'");
            size = ((Long) query.iterate().next()).intValue();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return size;
    }

    public static TqmTestcasestatus viewStatus(String stat) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        TqmTestcasestatus status = null;

        int i = 0;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from testcasestatus where STATUS='" + stat + "'");
            List l = query.list();
            int size = l.size();
            if (size > 0) {

                status = (TqmTestcasestatus) l.get(i);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return status;
    }

    public static String validateIssue(String issueId, String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String project = null, status = null;

        String msg = "Not a valid Issue";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("Select i.issueid,i.pid,s.status from issue i,issuestatus s where i.issueid=s.issueid and i.issueid='" + issueId + "'");
            while (resultset.next()) {
                project = resultset.getString(2);
                status = resultset.getString(3);

                logger.info("PID" + project);
            }
            if (project == null) {

            } else if (project.equalsIgnoreCase(pid) && !status.equalsIgnoreCase("Closed")) {
                msg = "Valid Issue";
            } else if (status.equalsIgnoreCase("Closed")) {
                msg = "Issue is already Closed";
            } else {
                msg = "Issue not available in this project";
            }

        } catch (Exception e) {
            logger.error("Exception while validating issue" + e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (Exception e) {
                    logger.error("Exception while closing resultset" + e.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (Exception e) {
                    logger.error("Exception while closing statement" + e.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    logger.error("Exception while closing connection" + e.getMessage());
                }
            }
        }
        return msg;
    }

    public static void addTestPlanTestCase(int executionId, String ptcids[], int userId, ArrayList assignedto, String dueDate) {
        Connection connection = null;
        PreparedStatement add = null;
        OraclePreparedStatement pre = null;
        int i = 0, statusid = 0;
        int nextValue = 0;
        try {
            connection = MakeConnection.getConnection();
            add = connection.prepareStatement("INSERT INTO TQM_TESTCASEEXECUTION(TCEID,TEPID,PTCID,STATUSID,CREATEDBY,ASSIGNEDTO,CREATEDON,MODIFIEDON,DUEDATE,TESTCASE_ORDER) VALUES(?,?,?,?,?,?,?,?,?,?)");

            Timestamp date = new Timestamp(new java.util.Date().getTime());
            String storeDate = null;
            java.sql.Date dbDate = null;
            Timestamp dat = new Timestamp(new java.util.Date().getTime());
            long startTime = System.currentTimeMillis();
            if (dueDate != null) {
                if (!dueDate.equalsIgnoreCase("NA")) {
                    dueDate = dueDate.trim();
                    logger.info("Date Check before" + dueDate);
                    SimpleDateFormat sdf    =   new SimpleDateFormat("dd-MMM-yy");
                     java.util.Date datea = sdf.parse(dueDate);
                     
//                    dbDate = java.sql.Date.valueOf(dueDate);// sdf.parse(dueDate);
//                    dueDate =com.pack.ChangeFormat.getNumberDate(dueDate);
//
//                    storeDate        = com.pack.ChangeFormat.getDateFormat(dueDate);
//                    logger.info("Date Check after"+storeDate);
                    dbDate = new Date(datea.getTime());
                }
                while (i < ptcids.length) {

                    add.setInt(1, getTCEID());
                    add.setInt(2, executionId);
                    add.setString(3, ptcids[i]);
                    add.setInt(4, statusid);
                    add.setInt(5, userId);
                    add.setInt(6, Integer.parseInt((String) assignedto.get(i)));
                    add.setTimestamp(7, dat);
                    add.setTimestamp(8, date);
                    add.setDate(9, dbDate);
                    add.setInt(10, nextValue);

                    add.executeUpdate();

                    i++;
                }
                long endTime = System.currentTimeMillis();
                logger.info("Total time taken for test plan test case addition" + (endTime - startTime));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (add != null) {
                    add.close();
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

    }

    public static int getTCEID() {
        Connection connection = null;
        Statement seqStatement = null;
        ResultSet seqResultSet = null;

        int i = 0;
        int nextValue = 0;
        try {
            connection = MakeConnection.getConnection();
            seqStatement = connection.createStatement();
            seqResultSet = seqStatement.executeQuery("select TCEID_SEQ.nextval as nextvalue from dual");
            seqResultSet.next();
            nextValue = seqResultSet.getInt("nextvalue");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (seqStatement != null) {
                    seqStatement.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (seqResultSet != null) {
                    seqResultSet.close();
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
        return nextValue;
    }

    public static void updateOrder(HashMap map) {
        Connection connection = null;
        PreparedStatement add = null;

        int i = 0;
        int nextValue = 0;
        try {
            connection = MakeConnection.getConnection();
            add = connection.prepareStatement("UPDATE TQM_TESTCASEEXECUTION SET TESTCASE_ORDER=? WHERE PTCID=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            Collection set = map.keySet();
            Iterator iter = set.iterator();
            String ptcId = "";
            while (iter.hasNext()) {
                ptcId = (String) iter.next();
                nextValue = Integer.parseInt((String) map.get(ptcId));
                logger.info("PTC ID" + ptcId);
                logger.info("Order" + nextValue);
                add.setInt(1, nextValue);
                add.setString(2, ptcId);
                add.addBatch();
            }
            int y[] = add.executeBatch();
            logger.info(y.length + "rows updated");
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (add != null) {
                    add.close();
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

    }
}
