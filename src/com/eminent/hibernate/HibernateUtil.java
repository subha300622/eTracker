/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.hibernate;

/**
 *
 * @author Administrator
 */
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            // Create the SessionFactory from hibernate.cfg.xml
            return new Configuration().configure().buildSessionFactory();
        }
        catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
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

}