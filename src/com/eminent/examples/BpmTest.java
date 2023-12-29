/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.examples;

import com.eminent.hibernate.HibernateUtil;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author Tamilvelan
 */
public class BpmTest {
     static Logger logger = Logger.getLogger("BpmTest");
        public static void hiberQuery(){
          long startTime  =   System.currentTimeMillis();
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            Session session =sessionFactory.openSession();
            List l  =   null;
            try{
                session.beginTransaction();
                Query query =   session.createQuery("select new com.eminent.tqm.TqmTestcaseexecutionresult(comments, commentedby, commentedon,statusid) from executionresult where ptcid='Q30052010009' and tceid='1' order by COMMENTEDON desc");
                l  =   query.list();
            }
            catch(Exception e){
               logger.error(e.getMessage());
            }finally{
                if(session!=null){
                    session.close();
                }
            }
    }
}
