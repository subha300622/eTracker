/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.tqm;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import com.eminent.hibernate.HibernateUtil;
import java.util.List;
import java.sql.Timestamp;
/**
 *
 * @author Tamilvelan
 */
public class FileAttach {
static Logger logger = null;
static {
        logger = Logger.getLogger("TQM Util");
    }
public static int getFileCount(int tceId){
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session =sessionFactory.openSession();

        int size    =   0;
        try{
               session.beginTransaction();
               Query query =   session.createQuery("Select count(*) from ptcfileattach where tceid='"+tceId+"'");
               size  =    ( (Long) query.iterate().next() ).intValue();

           }
        catch(Exception e){
          logger.error(e.getMessage());
        }finally{
            if(session!=null){
                session.close();
            }
        }
        return size;
}
public static List getFiles(int tceId){
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session =sessionFactory.openSession();
        List filesAttached   =   null;
        int size    =   0;
        try{
               session.beginTransaction();
               Query query =   session.createQuery("from ptcfileattach where tceid='"+tceId+"'");
               filesAttached    =   query.list();

           }
        catch(Exception e){
          logger.error(e.getMessage());
        }finally{
            if(session!=null){
                session.close();
            }
        }
        return filesAttached;
}
public static List getFiles(String ptcId){
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session =sessionFactory.openSession();
        List filesAttached   =   null;
        int size    =   0;
        try{
               session.beginTransaction();
               Query query =   session.createQuery("from ptcfileattach where ptcid='"+ptcId+"'");
               filesAttached    =   query.list();

           }
        catch(Exception e){
          logger.error(e.getMessage());
        }finally{
            if(session!=null){
                session.close();
            }
        }
        return filesAttached;
}
 public static void createFile(String ptcid, String fileName, int owner, String status,int tceId){
        SessionFactory sessionfactory   =   HibernateUtil.getSessionFactory();
        Session session                 =   sessionfactory.openSession();

        try{
                session.beginTransaction();
                TqmPtcfileattach attach = new  TqmPtcfileattach();

                Timestamp date=new Timestamp(new java.util.Date().getTime());
                attach.setPtcid(ptcid);
                attach.setFilename(fileName);
                attach.setOwner(owner);
                attach.setPtcstatus(status);
                attach.setTceid(tceId);
                attach.setAttacheddate(date);
                session.save("ptcfileattach",attach);
                session.getTransaction().commit();

        }catch(Exception e){
          logger.error(e.getMessage());
        }
        finally{
            if(session!=null){
                session.close();
            }
        }

    }
}
