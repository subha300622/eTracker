/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.appraisal;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import com.eminent.hibernate.HibernateUtil;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class Appraisal {
 static Logger logger=Logger.getLogger("Appraisal Util");
 public static void createProcess(){
     Session session                =   null;
     SessionFactory sessionFactory  =   null;
     try{
            sessionFactory  =   HibernateUtil.getSessionFactory();
            session         =   sessionFactory.openSession();
            ErmAppraisal app    =   new ErmAppraisal();
            
     }catch(Exception e){
         logger.error(e.getMessage());
     }
     finally{
         if(session!=null)
             session.close();
     }
 }
}
