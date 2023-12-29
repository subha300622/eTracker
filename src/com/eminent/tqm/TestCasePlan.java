/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tqm;

import java.sql.SQLException;
import java.util.List;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Iterator;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;
import java.text.SimpleDateFormat;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Restrictions;
import org.apache.log4j.Logger;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.timesheet.Users;
import com.eminent.timesheet.CreateTimeSheet;
import pack.eminent.encryption.MakeConnection;
import com.pack.ChangeFormat;
import dashboard.TestCases;
import com.eminent.util.GetProjectManager;
import java.sql.PreparedStatement;
import java.util.Arrays;

/**
 *
 * @author Tamilvelan
 */
public class TestCasePlan {

    static Logger logger = null;
    private static int PARAMETER_LIMIT = 999;

    static {
        logger = logger.getLogger("TestCasePlan");
    }

    public static List getProjects() {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Criteria c = session.createCriteria("project");
            c.add(Restrictions.eq("status", "Work in progress"));
            list = c.list();
        } catch (Exception e) {
            logger.error("Error while retriving Projects" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public static HashMap<Integer, String> getActiveProjects() {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id;
        String name = null;
        String version = null;
        String pnameversion = null;

        HashMap<Integer, String> projectdetails = new HashMap<Integer, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid,pname,version from project where status='Work in progress' order by UPPER(PNAME) ASC");

            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(2);
                version = resultset.getString(3);
                pnameversion = name + " v" + version;
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

    public static HashMap getCategoryProjects() {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id;
        String name = null;
        HashMap<Integer, String> member = new HashMap<Integer, String>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();

            resultset = statement.executeQuery("SELECT P.PID,pname,p.Category FROM PROJECT P where status='Work in progress' order by upper(pname) asc,version asc");
            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(3);
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

    public static HashMap getTPProjects(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id;
        String name = null;
        HashMap<Integer, String> member = new HashMap<Integer, String>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();

            resultset = statement.executeQuery("SELECT P.PID,P.PNAME as project,P.VERSION FROM PROJECT P, userproject up where p.pid = up.pid and up.userid = " + userId + "  and STATUS != 'Finished' order by upper(project) asc,version asc");
            while (resultset.next()) {
                id = resultset.getInt(1);
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

    public static HashMap getCategoryProjects(int userId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id;
        String name = null;
        HashMap<Integer, String> member = new HashMap<Integer, String>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();

            resultset = statement.executeQuery("SELECT P.PID,p.pname,p.Category FROM PROJECT P, userproject up where p.pid = up.pid and up.userid = " + userId + "  and STATUS != 'Finished' order by upper(p.pname) asc,version asc");
            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(3);
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

    public static HashMap<Integer, String> getAssignedModules(String pId, String tepId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id;
        String name = null;
        String version = null;

        HashMap<Integer, String> projectdetails = new HashMap<Integer, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select moduleid,module from modules m ,tqm_moduleplan p where p.mid=m.moduleid and tepid='" + tepId + "' and m.pid='" + pId + "'");

            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(2);
                logger.info("id" + id + "Name-->" + name);
                projectdetails.put(id, name);

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

    public static HashMap<Integer, String> getNonAssignedModules(String pId, String tepId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id;
        String name = null;
        HashMap<Integer, String> projectdetails = new HashMap<Integer, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select moduleid,module from modules m  where m.moduleid not in (select mid from tqm_moduleplan where tepid='" + tepId + "') and pid='" + pId + "'");

            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(2);

                projectdetails.put(id, name);

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

    public static void createplan(String name, int pid, String buildno, int qmanager, String startdate, String enddate, int userId, String[] modules) {
        SessionFactory sf = null;
        Session session = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            int i = 0;
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmTestcaseexecutionplan plan = new TqmTestcaseexecutionplan();
            logger.info("Plan Name" + name);
            Users user = CreateTimeSheet.GetUser(qmanager);
            logger.info("Start date" + startdate);
            logger.info("End date" + enddate);
            plan.setPid(pid);
            plan.setPlanname(name);
            plan.setBuildno(buildno);
            plan.setQualitymanager(user);
            plan.setPlannedstart(java.sql.Date.valueOf(ChangeFormat.getDateFormat(startdate)));
            plan.setPlannedend(java.sql.Date.valueOf(ChangeFormat.getDateFormat(enddate)));
            plan.setCreatedon(date);
            plan.setModifiedon(date);
            plan.setCreatedby(CreateTimeSheet.GetUser(userId));
            plan.setTqmTestcaseplanstatus(viewStatus(i));
            session.save("executionplan", plan);

            for (String s : modules) {
                TqmModuleplan module = new TqmModuleplan();
                module.setTepid(plan);
                module.setMid(Integer.parseInt(s));
                session.save("moduleplan", module);
            }

            session.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
            if (sf != null) {
                sf.close();
            }
        }
    }

    public static void createSAPplan(String name, int pid, String buildno, int qmanager, String startdate, String enddate, int userId, String[] modules, String mainProcess, String sub_process, String scenario, String variant) {
        SessionFactory sf = null;
        Session session = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            int i = 0;
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmTestcaseexecutionplan plan = new TqmTestcaseexecutionplan();
            logger.info("Plan Name" + name);
            Users user = CreateTimeSheet.GetUser(qmanager);
            logger.info("Start date" + startdate);
            logger.info("End date" + enddate);
            plan.setPid(pid);
            plan.setPlanname(name);
            plan.setBuildno(buildno);
            plan.setSubprocess(sub_process);
            plan.setScenario(scenario);
            plan.setVariant(variant);
            plan.setQualitymanager(user);
            plan.setPlannedstart(java.sql.Date.valueOf(ChangeFormat.getDateFormat(startdate)));
            plan.setPlannedend(java.sql.Date.valueOf(ChangeFormat.getDateFormat(enddate)));
            plan.setCreatedon(date);
            plan.setModifiedon(date);
            plan.setCreatedby(CreateTimeSheet.GetUser(userId));
            plan.setTqmTestcaseplanstatus(viewStatus(i));
            session.save("executionplan", plan);

            for (String s : modules) {
                TqmModuleplan module = new TqmModuleplan();
                module.setTepid(plan);
                module.setMid(Integer.parseInt(s));
                session.save("moduleplan", module);
            }

            session.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
            if (sf != null) {
                sf.close();
            }
        }
    }

    public static void updatePlan(int planId, String name, int qmanager, int status, String[] modules) {
        SessionFactory sf = null;
        Session session = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmTestcaseexecutionplan plan = (TqmTestcaseexecutionplan) session.get("executionplan", (Integer) planId);

            logger.info("Plan Name" + name);
            Users user = CreateTimeSheet.GetUser(qmanager);
            logger.info("User" + user.getUserid());
            plan.setPlanname(name);

            plan.setQualitymanager(user);
            plan.setModifiedon(date);
            plan.setTqmTestcaseplanstatus(viewStatus(status));
            session.update(plan);
            if (modules != null) {
                for (String s : modules) {
                    if (checkModule(planId, s)) {
                        TqmModuleplan module = new TqmModuleplan();
                        module.setTepid(plan);
                        module.setMid(Integer.parseInt(s));
                        session.save("moduleplan", module);
                    }
                }
            }

            session.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
            if (sf != null) {
                sf.close();
            }
        }
    }

    public static List listPlan() {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Query c = session.createQuery("from executionplan order by plannedend asc");
            list = c.list();
        } catch (Exception e) {
            logger.error("Error while retriving Projects" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public static TqmTestcaseexecutionplan editPlan(String tepId) {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        TqmTestcaseexecutionplan tep = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Query c = session.createQuery("executionplan where tepid=:tepid");
            c.setParameter("tepid", tepId);

            list = c.list();
            if (list.size() > 0) {
                tep = (TqmTestcaseexecutionplan) list.get(0);
            }
        } catch (Exception e) {
            logger.error("Error while retriving Projects" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return tep;
    }

    public static List listUserPlan(int userId) {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Criteria c = session.createCriteria("executionplan");
            c.addOrder(Order.asc("plannedend"));
            List managers = GetProjectManager.getManagingProjects(userId);
            if (managers.size() > 0) {
                c.add(Expression.in("pid", managers));
            } else {
                c.add(Expression.in("pid", GetProjectManager.getAssignedProjects(userId)));
            }
            list = c.list();
        } catch (Exception e) {
            logger.error("Error while retriving Projects" + e);
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public static List listProjectPlan(String pId) {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        List project = new ArrayList();
        project.add(Integer.parseInt(pId));
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Query c = session.createQuery("from executionplan where pid=" + pId + " order by plannedend asc");

            list = c.list();
        } catch (Exception e) {
            logger.error("Error while retriving Projects" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public static BigDecimal projectPlanCount(String pId) {
        Session session = null;
        SessionFactory sf = null;
        BigDecimal count = null;
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Query c = session.createSQLQuery("select count(*) from TQM_TESTCASEEXECUTIONPLAN where pid=" + pId);

            count = (BigDecimal) c.uniqueResult();
            logger.info("count" + count);
        } catch (Exception e) {
            logger.error("Error while retriving Projects" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return count;
    }

    public static TqmTestcaseexecutionplan viewPlan(String planID) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        TqmTestcaseexecutionplan tqmPlan = null;
        Query query = session.createQuery("from executionplan where tepid='" + planID + "'");
        List l = query.list();
        int size = l.size();
        if (size > 0) {
            int i = 0;
            tqmPlan = (TqmTestcaseexecutionplan) l.get(i);
        }
        session.close();

        return tqmPlan;
    }

    public static List listModulePTC(int pId, String tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;

        try {
            sess.beginTransaction();
            String hql = "from producttestcases where pid='" + pId + "' and mid in (:modList) and  ptcid not in (select ptcid from testcaseexecution where tepid='" + tepId + "') order by createdon";
            Query query = sess.createQuery(hql);
            query.setParameterList("modList", listModule(tepId));
            l = query.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return l;
    }

    public static List listModulePTCforSAP(int pId, String tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;

        List vatriants = variantPTC(pId, tepId);
        logger.info("vatriants" + vatriants);
        try {
            sess.beginTransaction();
            if (!vatriants.isEmpty()) {

                String hql = "from producttestcases where pid='" + pId + "' and ptcid in (:ptcList)  order by createdon";
                Query query = sess.createQuery(hql);
                query.setParameterList("ptcList", vatriants);
                l = query.list();
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return l;
    }

    public static List listModulePTCforSAP(int pId, List vatriants) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;

        logger.info("vatriants" + vatriants);
        try {
            sess.beginTransaction();
            if (!vatriants.isEmpty()) {

                String hql = "from producttestcases where pid='" + pId + "' and ptcid in (:ptcList)  order by createdon";
                Query query = sess.createQuery(hql);
                query.setParameterList("ptcList", vatriants);
                l = query.list();

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return l;
    }

    public static List listModulePTCforSAPUser(int pId, String tepId, String createdby) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;

        logger.info("variantPTCforUser(pId,tepId,createdby)" + variantPTCforUser(pId, tepId, createdby));
        try {
            sess.beginTransaction();
            String hql = "from producttestcases where pid='" + pId + "' and ptcid in (:ptcList)  order by createdon";
            Query query = sess.createQuery(hql);
            query.setParameterList("ptcList", variantPTCforUser(pId, tepId, createdby));
            l = query.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return l;
    }

    public static int listNoModulePTC(int pId, int tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;
        int noOfCases = 0;

        try {
            sess.beginTransaction();
            Query query = sess.createSQLQuery("select count(*) from tqm_ptcm where pid='" + pId + "' and mid in (select mid from TQM_MODULEPLAN where tepid='" + tepId + "') and  ptcid not in (select ptcid from TQM_TESTCASEEXECUTION where tepid='" + tepId + "') order by createdon");
            //Query query =   sess.createSQLQuery("select count(*) from tqm_testcaseexecution where tepid="+tepId+" and ptcid in(select ptcid from tqm_ptcm where pid="+pId+" and mid="+mId+")");
            l = query.list();
            Iterator iter = l.iterator();
            while (iter.hasNext()) {
                noOfCases = ((BigDecimal) iter.next()).intValue();

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return noOfCases;
    }

    public static int listNoModulePTCForSAP(int pId, int tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List l = null;
        int noOfCases = 0;
        HashMap bpmDetails = getBPMDetails(tepId);
        String sqlQuery = "select count(*) from tqm_ptcm where pid='" + pId + "' and mid in (select mid from TQM_MODULEPLAN where tepid='" + tepId + "') and  ptcid not in (select ptcid from TQM_TESTCASEEXECUTION where tepid='" + tepId + "') order by createdon";
        if (bpmDetails.get("vt") != null) {
            int vtId = Integer.parseInt((String) bpmDetails.get("vt"));
            sqlQuery = "SELECT count(*) FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.VARIANT_ID=" + vtId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Variant Available");
        } else if (bpmDetails.get("sc") != null) {
            int scId = Integer.parseInt((String) bpmDetails.get("sc"));
            sqlQuery = "SELECT count(*) FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SCENARIO_ID=" + scId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Scenario Available..");
        } else if (bpmDetails.get("sp") != null) {
            int spId = Integer.parseInt((String) bpmDetails.get("sp"));
            sqlQuery = "SELECT count(*) FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC,BPM_SUB_PROCESS SP WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SP_ID=SP.SP_ID AND SP.SP_ID=" + spId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Sub Process Available..");
        } else {
            int mpId = Integer.parseInt((String) bpmDetails.get("mp"));
            sqlQuery = "SELECT count(*) FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC,BPM_SUB_PROCESS SP,BPM_MAIN_PROCESS MP WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SP_ID=SP.SP_ID AND SP.MP_ID=MP.MP_ID AND MP.MP_ID=" + mpId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";

        }
        if (bpmDetails.get("mp") == null && bpmDetails.get("sp") == null && bpmDetails.get("sc") == null && bpmDetails.get("vt") == null) {
            try {
                sess.beginTransaction();
                Query query = sess.createSQLQuery(sqlQuery);
                logger.info("BP Based Query for tepid :" + tepId + " is " + sqlQuery);
                //Query query =   sess.createSQLQuery("select count(*) from tqm_testcaseexecution where tepid="+tepId+" and ptcid in(select ptcid from tqm_ptcm where pid="+pId+" and mid="+mId+")");
                l = query.list();
                Iterator iter = l.iterator();
                while (iter.hasNext()) {
                    noOfCases = ((BigDecimal) iter.next()).intValue();

                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                sess.getTransaction().commit();
                if (sess != null) {
                    sess.close();
                }
            }
        } else {
            try {
                connection = MakeConnection.getConnection();

                statement = connection.createStatement();

                resultset = statement.executeQuery(sqlQuery);
                while (resultset.next()) {
                    noOfCases = resultset.getInt(1);
                    logger.info("Executing BPM Details....");
                    logger.info("BP Based Query for tepid :" + tepId + " is " + sqlQuery);
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
        }
        return noOfCases;
    }

    public static List listModuleUserPTC(int pId, String tepId, String userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;

        try {
            sess.beginTransaction();
            /*                 DetachedCriteria  dc= DetachedCriteria.forClass(TqmTestcaseexecution.class, "executionplan");
             dc.add(Property.forName("tepid").eq(tepId));

             Criteria query =   sess.createCriteria("producttestcases");
             query.add(Expression.in("mid", listModule(tepId)));
             query.add(Property.forName("ptcid").notIn(dc));
             */
            String hql = "from producttestcases where pid='" + pId + "' and createdby='" + userId + "' and mid in (:modList) and  ptcid not in (select ptcid from testcaseexecution where tepid='" + tepId + "') order by createdon";
            Query query = sess.createQuery(hql);
            query.setParameterList("modList", listModule(tepId));
            l = query.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return l;
    }

    public static List listModule(String tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = new ArrayList<Integer>();
        TqmModuleplan modPlan = null;
        int i = 0;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from moduleplan where tepid='" + tepId + "'");
            List k = query.list();
            for (Iterator it = k.iterator(); it.hasNext();) {
                modPlan = (TqmModuleplan) it.next();
                l.add((Integer) modPlan.getMid());
                logger.info("MID-->" + modPlan.getMid());
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return l;
    }

    public static List variantPTC(int pId, String tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List l = new ArrayList<String>();
        String ptcId = "";
        HashMap bpmDetails = getBPMDetails(Integer.parseInt(tepId));
        String sqlQuery = "select ptcid from tqm_ptcm where pid='" + pId + "' and mid in (select mid from TQM_MODULEPLAN where tepid='" + tepId + "') and  ptcid not in (select ptcid from TQM_TESTCASEEXECUTION where tepid='" + tepId + "') order by createdon";
        if (bpmDetails.get("vt") != null) {
            int vtId = Integer.parseInt((String) bpmDetails.get("vt"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.VARIANT_ID=" + vtId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Variant Available");
        } else if (bpmDetails.get("sc") != null) {
            int scId = Integer.parseInt((String) bpmDetails.get("sc"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SCENARIO_ID=" + scId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Scenario Available..");
        } else if (bpmDetails.get("sp") != null) {
            int spId = Integer.parseInt((String) bpmDetails.get("sp"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC,BPM_SUB_PROCESS SP WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SP_ID=SP.SP_ID AND SP.SP_ID=" + spId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Sub Process Available..");
        } else {
            int mpId = Integer.parseInt((String) bpmDetails.get("mp"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC,BPM_SUB_PROCESS SP,BPM_MAIN_PROCESS MP WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SP_ID=SP.SP_ID AND SP.MP_ID=MP.MP_ID AND MP.MP_ID=" + mpId + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";

        }

        if (bpmDetails.get("mp") == null && bpmDetails.get("sp") == null && bpmDetails.get("sc") == null && bpmDetails.get("vt") == null) {
            try {
                sess.beginTransaction();
                Query query = sess.createSQLQuery(sqlQuery);
                logger.info("BP Based Query for tepid :" + tepId + " is " + sqlQuery);
                //Query query =   sess.createSQLQuery("select count(*) from tqm_testcaseexecution where tepid="+tepId+" and ptcid in(select ptcid from tqm_ptcm where pid="+pId+" and mid="+mId+")");
                l = query.list();
                Iterator iter = l.iterator();
                while (iter.hasNext()) {
                    //     ptcId   =   ((BigDecimal)iter.next()).intValue();

                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                sess.getTransaction().commit();
                if (sess != null) {
                    sess.close();
                }
            }
        } else {
            try {
                connection = MakeConnection.getConnection();

                statement = connection.createStatement();

                resultset = statement.executeQuery(sqlQuery);
                while (resultset.next()) {
                    ptcId = resultset.getString(1);
                    l.add(ptcId);
                    logger.info("Executing BPM Details....");
                    logger.info("BP Based Query for tepid :" + tepId + " is " + sqlQuery);
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
        }
        return l;
    }

    public static List variantPTCforUser(int pId, String tepId, String createdby) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List l = new ArrayList<String>();
        String ptcId = "";
        logger.info("TPLAN" + tepId);
        HashMap bpmDetails = getBPMDetails(Integer.parseInt(tepId));
        logger.info("BPM Details" + bpmDetails);
        String sqlQuery = "select count(*) from tqm_ptcm where pid='" + pId + "' and mid in (select mid from TQM_MODULEPLAN where tepid='" + tepId + "') and  ptcid not in (select ptcid from TQM_TESTCASEEXECUTION where tepid='" + tepId + "') order by createdon";
        if (bpmDetails.get("vt") != null) {
            int vtId = Integer.parseInt((String) bpmDetails.get("vt"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.VARIANT_ID=" + vtId + " AND TS.CREATEDBY=" + createdby + " AND TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Variant Available");
        } else if (bpmDetails.get("sc") != null) {
            int scId = Integer.parseInt((String) bpmDetails.get("sc"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SCENARIO_ID=" + scId + " AND TS.CREATEDBY=" + createdby + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Scenario Available..");
        } else if (bpmDetails.get("sp") != null) {
            int spId = Integer.parseInt((String) bpmDetails.get("sp"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC,BPM_SUB_PROCESS SP WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SP_ID=SP.SP_ID AND SP.SP_ID=" + spId + " AND TS.CREATEDBY=" + createdby + " AND  TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";
            logger.info("Sub Process Available..");
        } else {
            int mpId = Integer.parseInt((String) bpmDetails.get("mp"));
            sqlQuery = "SELECT ptcid FROM BPM_TESTSCRIPT TS,BPM_TESTCASE TC,BPM_TESTSTEP ST, BPM_VARIANT VT,BPM_SCENARIO SC,BPM_SUB_PROCESS SP,BPM_MAIN_PROCESS MP WHERE VT.VARIANT_ID=TC.VARIANT_ID AND TC.TESTCASE_ID=ST.TESTCASE_ID AND ST.TESTSTEP_ID=TS.TESTSTEP_ID AND VT.SCENARIO_ID=SC.SCENARIO_ID AND SC.SP_ID=SP.SP_ID AND SP.MP_ID=MP.MP_ID AND MP.MP_ID=" + mpId + " AND  TS.CREATEDBY=" + createdby + " AND TS.PTCID NOT IN (SELECT TE.PTCID FROM TQM_TESTCASEEXECUTION TE WHERE TE.TEPID=" + tepId + ")";

        }
        if (bpmDetails.get("mp") == null && bpmDetails.get("sp") == null && bpmDetails.get("sc") == null && bpmDetails.get("vt") == null) {
            try {
                sess.beginTransaction();
                Query query = sess.createSQLQuery(sqlQuery);
                logger.info("BP Based Query for tepid :" + tepId + " is " + sqlQuery);
                //Query query =   sess.createSQLQuery("select count(*) from tqm_testcaseexecution where tepid="+tepId+" and ptcid in(select ptcid from tqm_ptcm where pid="+pId+" and mid="+mId+")");
                l = query.list();
                Iterator iter = l.iterator();
                while (iter.hasNext()) {
                    //     ptcId   =   ((BigDecimal)iter.next()).intValue();

                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                sess.getTransaction().commit();
                if (sess != null) {
                    sess.close();
                }
            }
        } else {
            try {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery(sqlQuery);
                while (resultset.next()) {
                    ptcId = resultset.getString(1);
                    l.add(ptcId);
                    logger.info("Executing BPM Details....");
                    logger.info("BP Based Query for tepid :" + tepId + " is " + sqlQuery);
                }
                if (l.isEmpty()) {
                    l.add(null);
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
        }
        return l;
    }

    public static int checkModulePTC(int pId, String tepId, int mId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List l = null;
        int noOfCases = 0;

        try {
            sess.beginTransaction();
            Query query = sess.createSQLQuery("select count(*) from tqm_testcaseexecution where tepid=" + tepId + " and ptcid in(select ptcid from tqm_ptcm where pid=" + pId + " and mid=" + mId + ")");
            l = query.list();
            Iterator iter = l.iterator();
            while (iter.hasNext()) {
                noOfCases = ((BigDecimal) iter.next()).intValue();

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return noOfCases;
    }

    public static TqmTestcaseexecution viewExecution(int tceId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        TqmTestcaseexecution execution = null;

        int i = 0;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from testcaseexecution where tceid=" + tceId);
            List l = query.list();
            int size = l.size();
            if (size > 0) {

                execution = (TqmTestcaseexecution) l.get(i);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return execution;
    }

    public static TqmTestcaseplanstatus viewStatus(int statusId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        TqmTestcaseplanstatus status = null;

        int i = 0;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from planstatus where STATUSID=" + statusId);
            List l = query.list();
            int size = l.size();
            if (size > 0) {

                status = (TqmTestcaseplanstatus) l.get(i);
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

    public static HashMap viewAllStatus() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List status = null;
        HashMap<Integer, String> statList = new HashMap<Integer, String>();
        TqmTestcaseplanstatus planStatus = null;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from planstatus");
            status = query.list();
            for (Iterator it = status.iterator(); it.hasNext();) {
                planStatus = (TqmTestcaseplanstatus) it.next();
                int k = (planStatus.getStatusid());

                statList.put((Integer) k, planStatus.getStatus());

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return statList;
    }

    public static TqmTestcasestatus viewTestcaseStatus(int statusId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        TqmTestcasestatus status = null;

        int i = 0;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from testcasestatus where STATUSID=" + statusId);
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

    public static List viewAllTestcaseStatus() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();

        List status = null;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from testcasestatus");
            status = query.list();

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

    public static List listTestcases(String tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List testCases = null;
        try {
            sess.beginTransaction();
            //              String hql="Select e from testcaseexecution e,producttestcases t,executionplan p where e.ptcid=t.ptcid and e.tepid='"+tepId+"'";
            //              Query query =   sess.createQuery("from testcaseexecution where tepid='"+tepId+"'");
            //               testCases  =   query.list();
            Criteria crit = sess.createCriteria(TqmTestcaseexecution.class, "exec").createAlias("producttestcases", "ptcm").add(Expression.eqProperty("ptcm.ptcid", "exec.ptcid"));
            crit.add(Expression.eqProperty("exec.tepid", tepId));
            testCases = crit.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return testCases;
    }

    public static List viewExecutionTestcases(String tepId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        List testCases = null;
        try {
            sess.beginTransaction();
            Query query = sess.createQuery("from testcaseexecution where tepid=" + tepId + " order by testorder,modifiedon");
            testCases = query.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return testCases;
    }

    public static TqmTestcaseexecution viewExecutionTestcase(String tceId, String ptcId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        TqmTestcaseexecution testCase = null;
        try {
            sess.beginTransaction();

            Query query = sess.createQuery("from testcaseexecution where tceid='" + tceId + "' and ptcid='" + ptcId + "'");
            List testCases = query.list();
            if (testCases.size() > 0) {
                testCase = (TqmTestcaseexecution) testCases.get(0);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            sess.getTransaction().commit();
            if (sess != null) {
                sess.close();
            }
        }
        return testCase;
    }

    public static void updateActualStartDate(String tceId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();
        try {
            long startTime = System.currentTimeMillis();
            Query query = sess.createSQLQuery("Select p.tepid,p.actualstart from Tqm_testcaseexecutionplan p,Tqm_testcaseexecution e where p.tepid=e.tepid and tceid='" + tceId + "'");
            List l = query.list();
            if (l.size() > 0) {
                Iterator iter = l.iterator();
                Object[] obj = (Object[]) iter.next();
                int tepId = ((BigDecimal) obj[0]).intValue();
                java.util.Date actualStartDate = ((java.util.Date) obj[1]);
                logger.info("Actual start date" + actualStartDate);
                logger.info("Actual start date Plan Id" + tepId);
                if (actualStartDate == null) {
                    sess.clear();
                    String hql = "update executionplan set actualstart = :startdate where tepid = :testplanid";
                    Query update = sess.createQuery(hql);
                    Timestamp date = new Timestamp(new java.util.Date().getTime());

                    update.setDate("startdate", date);
                    update.setInteger("testplanid", tepId);

                    int rowCount = update.executeUpdate();
                    logger.info("Actual start dateUpdated" + rowCount);
                    sess.getTransaction().commit();

                }
            }
            long endTime = System.currentTimeMillis();
            logger.info("Time taken for actual start date update" + (endTime - startTime) / 1000);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }
        }

    }

    public static void updateActualEndDate(int planId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();
        try {

            String hql = "update executionplan set actualend = :enddate where tepid = :testplanid";
            Query update = sess.createQuery(hql);
            Timestamp date = new Timestamp(new java.util.Date().getTime());

            update.setDate("enddate", date);
            update.setInteger("testplanid", planId);

            int rowCount = update.executeUpdate();
            logger.info("Actual end dateUpdated" + rowCount);
            sess.getTransaction().commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }
        }

    }

    public static void updateTestCase(String ptcid, int status, int tecId, int assignedTo, String issueId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();

        try {

            String hql = "update testcaseexecution set statusid = :statid,assignedto=:assigned,issuereference=:issueid where ptcid = :testcaseid and tceid= :tecid";
            Query query = sess.createQuery(hql);

            query.setInteger("statid", status);
            query.setString("testcaseid", ptcid);
            query.setInteger("tecid", tecId);
            query.setInteger("assigned", assignedTo);
            query.setString("issueid", issueId);
            int rowCount = query.executeUpdate();
            sess.getTransaction().commit();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }

        }
    }

    public static void updateTestCase(String ptcid, int status, int tecId, int assignedTo) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session sess = sessionFactory.openSession();
        sess.beginTransaction();

        try {

            String hql = "update testcaseexecution set statusid = :statid,assignedto=:assigned where ptcid = :testcaseid and tceid= :tecid";
            Query query = sess.createQuery(hql);

            query.setInteger("statid", status);
            query.setString("testcaseid", ptcid);
            query.setInteger("tecid", tecId);
            query.setInteger("assigned", assignedTo);
            int rowCount = query.executeUpdate();
            sess.getTransaction().commit();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }

        }
    }

    public static void updateTestCaseResult(String comments, String ptcid, int statusid, int userId, int tceId, int assignedTo) {

        Connection connection = null;
        PreparedStatement st = null;
        Statement seqStatement = null;
        ResultSet seqResultSet = null;

        try {

            Timestamp date = new Timestamp(new java.util.Date().getTime());
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("insert into TQM_TESTCASEEXECUTIONRESULT(comments,ptcid,commentedby,commentedto,commentedon,statusid,tceid,terid) values(?,?,?,?,?,?,?,?)");

            seqStatement = connection.createStatement();
            seqResultSet = seqStatement.executeQuery("select TERID_SEQ.nextval as nextvalue from dual");

            seqResultSet.next();
            int nextValue = seqResultSet.getInt("nextvalue");

            st.setString(1, comments);
            st.setString(2, ptcid);
            st.setInt(3, userId);
            st.setInt(4, assignedTo);
            st.setTimestamp(5, date);
            st.setInt(6, statusid);
            st.setInt(7, tceId);
            st.setInt(8, nextValue);
            st.executeUpdate();

            logger.info("TCE ID" + tceId);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
                if (seqStatement != null) {
                    seqStatement.close();
                }
                if (seqResultSet != null) {
                    seqResultSet.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
    }

    public static List getExecutionResults(String ptcID, String tceId) {
        long startTime = System.currentTimeMillis();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from executionresult where ptcid='" + ptcID + "' and tceid='" + tceId + "' order by COMMENTEDON desc");
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        long finishTime = System.currentTimeMillis();
        logger.info("Time take for executing getExecutionResults" + (finishTime - startTime) / 1000);
        return l;
    }

    public static String[][] getExecutionResultBYpidmid(String pid, String mid) {

        String[][] moduleTestCases = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select distinct r.tceid,e.tepid,p.planname,r.ptcid,r.statusid from tqm_testcaseexecutionresult r, tqm_testcaseexecution e,tqm_testcaseexecutionplan p where r.ptcid in(select ptcid from tqm_ptcm,modules,project,users where tqm_ptcm.pid='" + pid + "' and tqm_ptcm.mid='" + mid + "' and tqm_ptcm.mid=modules.moduleid and tqm_ptcm.pid=project.pid and users.userid=tqm_ptcm.createdby) and r.tceid=e.tceid and e.tepid=p.tepid ");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String module[][] = new String[rowcount][3];
            int i = 0;
            String project = null;
            while (resultset.next()) {
                module[i][0] = resultset.getString(3);
                module[i][1] = resultset.getString(4);
                module[i][2] = resultset.getString(5);

                i++;
            }
            moduleTestCases = module;
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
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return moduleTestCases;
    }

    public static HashMap getTescaseStatus() {
        long startTime = System.currentTimeMillis();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        HashMap statusMap = new HashMap();
        try {
            session.beginTransaction();
            Query query = session.createQuery("from testcasestatus");
            l = query.list();
            for (Iterator i = l.iterator(); i.hasNext();) {
                TqmTestcasestatus t = (TqmTestcasestatus) i.next();
                statusMap.put(t.getStatusid(), t.getStatus());
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        long finishTime = System.currentTimeMillis();
        logger.info("Time take for executing getExecutionResults" + (finishTime - startTime) / 1000);
        return statusMap;
    }

    public static List getExecutionResult(String ptcID, String tceId) {
        long startTime = System.currentTimeMillis();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("select new com.eminent.tqm.TqmTestcaseexecutionresult(comments, commentedby, commentedon,statusid) from executionresult where ptcid='" + ptcID + "' and tceid='" + tceId + "' order by COMMENTEDON desc");
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        long finishTime = System.currentTimeMillis();
        logger.info("Time take for executing getExecutionResults" + (finishTime - startTime) / 1000);
        return l;
    }

    public static List getTestCases(int userId, Date startDate, Date endDate) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Criteria query = session.createCriteria("executionresult");
            query.add(Expression.between("commentedon", startDate, endDate));
            query.add(Restrictions.eq("commentedby", userId));
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

    public static List getResults(String ptcID) {
        long startTime = System.currentTimeMillis();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            String sql = "select distinct r.tceid,e.tepid,p.planname from tqm_testcaseexecutionresult r, tqm_testcaseexecution e,tqm_testcaseexecutionplan p where r.ptcid='" + ptcID + "' and r.tceid=e.tceid and e.tepid=p.tepid order by r.tceid";
            Query query = session.createSQLQuery(sql);
            l = query.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        long finishTime = System.currentTimeMillis();
        logger.info("Time take for executing getResults" + (finishTime - startTime) / 1000);
        return l;
    }

    public static List listActiveStatus() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
//             List activeTestCases  =   new ArrayList<Integer>();
//             activeTestCases.add((Integer)0);
//             activeTestCases.add((Integer)2);
//             activeTestCases.add((Integer)3);
            session.beginTransaction();

            String hql = "from testcasestatus where statusid in (0,2,3) order by statusid";
            Query query = session.createQuery(hql);

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

    public static List listUserExecution(int userId) {

        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            long startTime = System.currentTimeMillis();
            String hql = "from testcaseexecution where statusid not in (1,4) and assignedto=" + userId + " order by duedate";
            Query query = session.createQuery(hql);

            l = query.list();

            long endTime = System.currentTimeMillis();
            logger.info("Total time taken for retirving" + (endTime - startTime) / 1000);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static int listUserExecutionCountJDBC(int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int l = 0;
        try {

            long startTime = System.currentTimeMillis();
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select count(*) from tqm_testcaseexecution te, tqm_testcaseexecutionplan tep, tqm_testcasestatus tcs where te.tepid=tep.tepid and te.statusid=tcs.statusid and te.assignedto=" + userId + " and status!='Passed' and status!='Not Applicable'";
            logger.info(sql);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                l = resultset.getInt(1);

            }

            long endTime = System.currentTimeMillis();
            logger.info("Total time taken for retirving" + (endTime - startTime));
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
                logger.error("Error while getting the status list", ex);
            }
        }
        return l;
    }

    public static String[][] listUserExecutionJDBC(int userId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultset = null;
        int i = 0;
        String testCases[][] = null;
        try {

            long startTime = System.currentTimeMillis();
            connection = MakeConnection.getConnection();

            String sql = "select te.tceid,tc.ptcid,p.pname,p.version,m.module,tep.PLANNAME,tc.functionality,tc.description,tc.expectedresult,firstname||' '||SUBSTR(lastname, 1, 1) as Name,tcs.status,tcs.statusid,te.duedate from tqm_testcaseexecution te, tqm_testcaseexecutionplan tep, tqm_testcasestatus tcs,tqm_ptcm tc,project p,modules m,users u where te.tepid=tep.tepid and te.statusid=tcs.statusid and te.assignedto=? and tcs.status!='Passed' and tcs.status!='Not Applicable' and te.ptcid=tc.ptcid and p.pid=tc.pid and tc.mid=m.moduleid and u.userid=tc.createdby";
            logger.info(sql);
            statement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            statement.setInt(1, userId);
            resultset = statement.executeQuery();
            resultset.last();
            int rows = resultset.getRow();
            resultset.beforeFirst();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            logger.info("No of rows" + rows);
            testCases = new String[rows][13];
            while (resultset.next()) {
                testCases[i][0] = resultset.getString(1);
                testCases[i][1] = resultset.getString(2);
                testCases[i][2] = resultset.getString(3);
                testCases[i][3] = resultset.getString(4);
                testCases[i][4] = resultset.getString(5);
                testCases[i][5] = resultset.getString(6);
                testCases[i][6] = resultset.getString(7);
                testCases[i][7] = resultset.getString(8);
                testCases[i][8] = resultset.getString(9);
                testCases[i][9] = resultset.getString(10);
                testCases[i][10] = resultset.getString(11);
                testCases[i][11] = resultset.getString(12);
                testCases[i][12] = sdf.format(resultset.getDate(13));
                i++;
                logger.info("No of rows" + i);
            }

            long endTime = System.currentTimeMillis();
            logger.info("Total time taken for retirving" + (endTime - startTime) / 1000);
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
                logger.error("Error while getting the status list" + ex.getMessage());
            }
        }
        return testCases;
    }

    public static List listStatusTestcases(String planId, String status) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();

            TqmTestcasestatus stat = TqmUtil.viewStatus(status);
            logger.info("Plan " + planId + "Status" + stat.getStatusid());
            Query query = session.createQuery("from testcaseexecution where tepid='" + planId + "' and statusid='" + stat.getStatusid() + "' order by createdon asc");
            l = query.list();

            logger.info("No of Test cases in status-->" + l.size());
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static HashMap listAdminExecutionPlan() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        HashMap planList = new HashMap<String, String>();
        try {
            session.beginTransaction();
            Criteria c = session.createCriteria("executionplan");
            //         c.add(Restrictions.eq("assignedto",user));
            l = c.list();
            TqmTestcaseexecutionplan plan = null;
            for (Iterator i = l.iterator(); i.hasNext();) {
                plan = (TqmTestcaseexecutionplan) i.next();
                int planId = plan.getTepid();
                String planName = plan.getPlanname();
                planList.put(((Integer) planId).toString(), planName);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return planList;
    }

    public static HashMap listProjectExecutionPlan(String pId) {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        HashMap planList = new HashMap<String, String>();
        List project = new ArrayList();
        project.add(Integer.parseInt(pId));
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Criteria c = session.createCriteria("executionplan");
            c.add(Expression.in("pid", project));
            list = c.list();
            TqmTestcaseexecutionplan plan = null;
            for (Iterator i = list.iterator(); i.hasNext();) {
                plan = (TqmTestcaseexecutionplan) i.next();
                int planId = plan.getTepid();
                String planName = plan.getPlanname();
                planList.put(((Integer) planId).toString(), planName);
            }
        } catch (Exception e) {
            logger.error("Error while retriving listUserExecutionPlan" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return planList;
    }

    public static HashMap listUserExecutionPlan(int userId) {
        List list = null;
        Session session = null;
        SessionFactory sf = null;
        HashMap planList = new HashMap<String, String>();
        try {
            sf = HibernateUtil.getSessionFactory();
            session = sf.openSession();
            session.beginTransaction();
            Criteria c = session.createCriteria("executionplan");
            c.add(Expression.in("pid", GetProjectManager.getAssignedProjects(userId)));
            list = c.list();
            TqmTestcaseexecutionplan plan = null;
            for (Iterator i = list.iterator(); i.hasNext();) {
                plan = (TqmTestcaseexecutionplan) i.next();
                int planId = plan.getTepid();
                String planName = plan.getPlanname();
                planList.put(((Integer) planId).toString(), planName);
            }
        } catch (Exception e) {
            logger.error("Error while retriving listUserExecutionPlan" + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return planList;
    }

    public static List listTestExecutionPlan(int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Users user = CreateTimeSheet.GetUser(userId);
            Criteria c = session.createCriteria("executionplan");
            c.add(Restrictions.eq("assignedto", user));

            l = c.list();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public static String getIssueID(String ptcId) {
        String issueId = null;
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        TqmIssuetestcases iss = null;
        TqmPtcm ptc = null;
        try {

//            ptc =TqmUtil.viewPTC(ptcId);
            Query c = session.createQuery("from isstestcases where ptcid='" + ptcId + "'");
            List l = c.list();
            logger.info("Test case id" + ptcId);
            if (l.size() > 0) {
                iss = (TqmIssuetestcases) l.get(0);
                issueId = iss.getIssueid();
            }
            logger.info("Test case issue--->" + issueId);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
                sessionFactory.close();
            }
        }
        return issueId;
    }

    public static org.hibernate.criterion.Criterion buildInCriterion(String propertyName, List values) {
        org.hibernate.criterion.Criterion criterion = null;
        int PARAMETER_LIMIT = 999;

        int listSize = values.size();
        for (int i = 0; i < listSize; i += PARAMETER_LIMIT) {
            List subList;
            if (listSize > i + PARAMETER_LIMIT) {
                subList = values.subList(i, (i + PARAMETER_LIMIT));
            } else {
                subList = values.subList(i, listSize);
            }
            if (criterion != null) {
                criterion = Restrictions.or(criterion, Restrictions.in(propertyName, subList));
            } else {
                criterion = Restrictions.in(propertyName, subList);
            }
        }
        return criterion;
    }

    public static HashMap getAllIssueId(List<String> ptcids) {
        HashMap testCaseIssues = new HashMap();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        TqmIssuetestcases iss = null;
        TqmPtcm ptc = null;
        try {
            int listSize = ptcids.size();

//            ptc =TqmUtil.viewPTC(ptcId);
            Criteria c = session.createCriteria(TqmIssuetestcases.class, "tq")
                    .createAlias("tq.tqmPtcm", "tp");
            c.add(buildInCriterion("tp.ptcid", ptcids));
            List<TqmIssuetestcases> l = new ArrayList<TqmIssuetestcases>();
            l = (List<TqmIssuetestcases>) c.list();
            if (l.size() > 0) {
                for (TqmIssuetestcases tqmissue : l) {
                    String issueid = tqmissue.getIssueid();
                    String ptcId = tqmissue.getTqmPtcm().getPtcid();
                    testCaseIssues.put(ptcId, issueid);
                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return testCaseIssues;
    }

    public static boolean isIssueClosed(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String status = null;
        boolean flag = false;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select status from issuestatus where issueid='" + issueId.trim() + "'");
            while (resultset.next()) {

                status = resultset.getString("status");

                if (status.equalsIgnoreCase("Closed")) {
                    flag = true;

                } else {
                    flag = selectProjectType(status, issueId);

                }
            }

        } catch (Exception e) {
            logger.error("Exception issue Closture test" + e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
        }
        return flag;
    }

    public static int selectStatusId(String status, String category) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int statusid = 1;
        boolean flag = false;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            if (category.equalsIgnoreCase("SAP Project")) {
                resultset = statement.executeQuery("select status_id from SAP_SUPPORT_STATUS_MASTER where status='" + status + "'");
            } else {
                resultset = statement.executeQuery("select status_id from STATUS_MASTER where status='" + status + "'");
            }
            while (resultset.next()) {
                statusid = resultset.getInt("status_id");

            }
        } catch (Exception e) {
            logger.error("Exception in Status ID Selection" + e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
        }
        return statusid;
    }

    public static boolean selectProjectType(String status, String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String category = null;
        boolean flag = false;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select category from project p,issue i where i.pid=p.pid  and i.issueid='" + issueId + "'");
            while (resultset.next()) {
                category = resultset.getString("category");
                logger.info("Project Category" + category);
                int statusid = selectStatusId(status, category);
                logger.info("Status Id" + statusid);
                if (category.equalsIgnoreCase("SAP Project")) {
                    if (statusid > 13) {
                        flag = true;
                    }
                } else {
                    if (statusid > 12) {
                        flag = true;
                    }
                }

            }
        } catch (Exception e) {
            logger.error("Exception issue Closture test" + e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
        }
        return flag;
    }

    public static float calculatePercentage(String planId) {
        float percentage = 0.0f;
        long startTime = System.currentTimeMillis();
        List testCase = TestCases.executionPlanChart(planId);
        Iterator iter = testCase.iterator();
        int totalTestCases = 0;
        int completedCases = 0;
        while (iter.hasNext()) {

            Object[] obj = (Object[]) iter.next();

            String status = ((String) obj[2]);
            int noOfCases = ((BigDecimal) obj[0]).intValue();
            totalTestCases = totalTestCases + noOfCases;
            if (status.equalsIgnoreCase("Passed") || status.equalsIgnoreCase("Not Applicable")) {
                completedCases = completedCases + noOfCases;
            }
            //              logger.info("Status-->"+((TqmTestcasestatus)obj[1]).getStatus());

        }
        if (totalTestCases > 0) {
            percentage = ((completedCases * 100) / totalTestCases);
        }
        long endTime = System.currentTimeMillis();
        logger.info("Percentage Calculation Time" + ((endTime - startTime) / 1));
        return percentage;
    }

    public static int removeModule(String[] moduleId, String tepid) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        int row = 0, i = 0;
        try {
            session.beginTransaction();
            logger.info("No Of Modules to Remove" + moduleId.length);
            while (i < moduleId.length) {
                String hql = "delete from moduleplan where mid = " + moduleId[i] + " and tepid=" + tepid;
                logger.info("HQL-->" + hql);
                Query query = session.createQuery(hql);
                row = query.executeUpdate();
                session.getTransaction().commit();
                logger.info("Module Removed from plan-->" + row);
                i++;
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return row;
    }

    public static boolean checkModule(int planId, String moduleid) {
        Session session = null;
        SessionFactory factory = null;
        boolean flag = true;
        try {
            factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            Query query = session.createQuery("from moduleplan where mid='" + moduleid + "' and tepid='" + planId + "'");
            List l = query.list();
            if (l.size() > 0) {
                flag = false;
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return flag;
    }

    public static HashMap getBPMDetails(int tepId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String mp = null;
        String sp = null;
        String sc = null;
        String vt = null;
        HashMap<String, String> bpmDetails = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();

            statement = connection.createStatement();

            resultset = statement.executeQuery("SELECT MAINPROCESS,SUBPROCESS,SCENARIO,VARIANT FROM TQM_TESTCASEEXECUTIONPLAN WHERE TEPID=" + tepId);
            while (resultset.next()) {
                mp = resultset.getString(1);
                sp = resultset.getString(2);
                sc = resultset.getString(3);
                vt = resultset.getString(4);

            }
            bpmDetails.put("mp", mp);
            bpmDetails.put("sp", sp);
            bpmDetails.put("sc", sc);
            bpmDetails.put("vt", vt);

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

        return bpmDetails;

    }

    public static String getFinalizedStatus(String statuses) {
        String st[] = statuses.split(",");
        String status = "";
        List<String> statusList = Arrays.asList(st);
        List newStatusList = new ArrayList();
        for (String sta : statusList) {
            if (!newStatusList.contains(sta)) {
                newStatusList.add(sta);
            }
        }
        if (newStatusList.size() == 1) {
            status = statusList.get(0);
        } else if (newStatusList.contains("Failed") || newStatusList.contains("failed")) {
            status = "Failed";
        } else if (newStatusList.contains("Yet to Test")) {
            status = "Yet to Test";
        } else if (newStatusList.contains("Could Not Run") || newStatusList.contains("Not Run")) {
            status = "Could Not Run";
        } else if (newStatusList.contains("Not Applicable") && newStatusList.contains("Passed")) {
            status = "Passed";
        } else {
            status = "Yet to Test";
        }

        return status;
    }
    
     public static String getTestStepByPTC(String ptcid) {
        String status = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTSTEP from BPM_TESTSTEP ts,BPM_TESTSCRIPT bts where ts.TESTSTEP_ID=bts.TESTSTEP_ID and PTCID='" + ptcid+ "'");
            while (resultset.next()) {
                status = resultset.getString("TESTSTEP");
            }

        } catch (Exception e) {
            logger.error("Exception getTestStepByPTC" + e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    logger.error("Exception getTestStepByPTC" + ex.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    logger.error("Exception getTestStepByPTC" + ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error("Exception issue Closture test" + ex.getMessage());
                }
            }
        }
        return status;
    }
}
