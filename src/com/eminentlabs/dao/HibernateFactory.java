/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.dao;

/**
 *
 * @author Tamilvelan
 */
import java.util.ArrayList;

import javax.management.MBeanServer;
import javax.management.MBeanServerFactory;
import javax.management.ObjectName;
/**
 * Hibernate Utility class with a convenient method to get Session Factory object.
 *
 *
 */

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.jmx.StatisticsService;
import org.apache.log4j.Logger;
/**
 * Hibernate Utility class with a convenient method to get Session Factory object.
 *
 *
 */
public class HibernateFactory {
    private static final SessionFactory sessionFactory;
    static Logger logger	=	Logger.getLogger("HibernateFactory");
    static {
        try {
            // Create the SessionFactory from standard (hibernate.cfg.xml)
            // config file.
        	logger.info("Inside creating the session Factory");
            Configuration config = new Configuration().configure();
            sessionFactory = config.buildSessionFactory();
//          //get the available MBean servers
//            ArrayList list = MBeanServerFactory.findMBeanServer(null);
//            //take the first one
//            MBeanServer server = (MBeanServer) list.get(0);
//
//            //build the MBean name
//            ObjectName on = new ObjectName("Hibernate:type=statistics,application=sample");
//            StatisticsService mBean = new StatisticsService();
//            mBean.setSessionFactory(sessionFactory);
//            server.registerMBean(mBean, on);
        } catch (Throwable ex) {
            // Log the exception.
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static Session getCurrentSession(){

        Session session = getSessionFactory().getCurrentSession();
        if(session !=null && !session.getTransaction().isActive()){
            Transaction transaction = session.beginTransaction();

        }
        return session;
    }

  /**
   *
   * @TODO need to implement commit;
   *
   */
    public static void commitAndClose(){
        Session session = getSessionFactory().getCurrentSession();
        if(session !=null && session.getTransaction()!=null){
            Transaction transaction = session.getTransaction();
            transaction.commit();
            if(session.isOpen()){
            	session.close();
            }
        }
    }

   /**
   *
   * @TODO need to implement rollback;
   *
   */

    public static void rollbackAndClose(){
        Session session = getSessionFactory().getCurrentSession();
        if(session !=null && session.getTransaction()!=null){
            Transaction transaction = session.getTransaction();
            transaction.rollback();
            session.close();
        }
    }

}

