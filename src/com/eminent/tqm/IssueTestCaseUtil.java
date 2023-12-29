/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tqm;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import com.eminent.hibernate.HibernateUtil;
import com.eminentlabs.dao.HibernateFactory;
import java.sql.Timestamp;
import java.util.List;
import java.util.HashMap;
import java.sql.*;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Administrator
 */
public class IssueTestCaseUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("Issue Test Case Util");
    }

    public static List viewIssueTestCase(String issueID) {
        Session session = null;
        List l = null;
        try {

            session = HibernateFactory.getCurrentSession();

            Criteria c = session.createCriteria("isstestcases");
            c.add(Restrictions.eq("issueid", issueID));
             l = c.list();
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

    public static List issueTestCase() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from isstestcases");
        List l = query.list();
        session.close();
        return l;

    }

    public static List issueTestCaseComments(String ptcId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from testcaseresult where ptcid='" + ptcId + "' order by ptcid");
        List l = query.list();
        session.close();
        return l;

    }

    public static HashMap<String, String> getStatus() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;

        HashMap<String, String> status = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from TQM_TESTCASESTATUS ORDERBY STATUSID");

            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);

                status.put(id, name);

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
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return status;

    }

    public static String getProjectType(int pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String type = null;

        HashMap<String, String> status = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select type from project_type where pid = " + pid);

            while (resultset.next()) {
                type = resultset.getString(1);

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
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return type;

    }

}
