/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.holidays;

import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author E0288
 */
public class HolidaysUtil {
    
    static Logger logger = null;

    static {
        logger = Logger.getLogger("HolidaysUtil");
    }
    
    public static void addHoliday(Holidays holidays){
        DAOFactory.addHoliday(holidays);
    }
    public static void updateHoliday(Holidays holidays){
        DAOFactory.updateHoliday(holidays);
    }
     public static void deleteHoliday(long holidayId){
         Holidays holidays=findByHolidayId(holidayId);
         DAOFactory.deleteHoliday(holidays);
    }
    public static List<Holidays> findCalendarYearHolidays(Date start, Date end){
        List<Holidays> holidaysList=new ArrayList<Holidays>();
       Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findCalendarYearHolidays");
            query.setParameter("startDate", start);
            query.setParameter("endDate", end);
            holidaysList=(List<Holidays>)query.list();
            
        }catch (Exception e) {
            
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
            return holidaysList;
    }
    public static List<Holidays> findCalendarYearHolidaysByBranch(Date start, Date end,int branchId){
        List<Holidays> holidaysList=new ArrayList<Holidays>();
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findCalendarYearHolidaysByBranch");
            query.setParameter("startDate", start);
            query.setParameter("endDate", end);
            query.setParameter("branchId", branchId);
            holidaysList=(List<Holidays>)query.list();
            
        }catch (Exception e) {
            
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
            return holidaysList;
    }
    public static Holidays findUniqueHoliday(Date holidayDate ,String holidayName,int branch){
        Holidays holiday=null;
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findByUniqueHoliday");
            query.setParameter("holidayDate", holidayDate);
            query.setParameter("holidayName", holidayName);
            query.setParameter("branchId", branch);
            holiday=(Holidays)query.uniqueResult();
            
        }catch (Exception e) {
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
            return holiday;
    }
    
    public static Holidays findByHolidayId(long holidayId){
        Holidays holiday=null;
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findByHolidayId");
            query.setParameter("holidayId", holidayId);
            holiday=(Holidays)query.uniqueResult();
            
        }catch (Exception e) {
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
            return holiday;
    }
    public static List<Holidays> findByHolidayDate(Date fromDate,Date toDate){
        List<Holidays> holidaysList=new ArrayList<Holidays>();
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findBetweenHolidayDate");
            query.setParameter("start", fromDate);
            query.setParameter("end", toDate);
            holidaysList=(List<Holidays>)query.list();
            
        }catch (Exception e) {
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
            return holidaysList;
    }
    public static List<Holidays> findByHolidayDateByBranch(Date fromDate,Date toDate,int branch){
        List<Holidays> holidaysList=new ArrayList<Holidays>();
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findBetweenHolidayDateByBranch");
            query.setParameter("start", fromDate);
            query.setParameter("end", toDate);
            query.setParameter("branch", branch);
            holidaysList=(List<Holidays>)query.list();
            
        }catch (Exception e) {
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
            return holidaysList;
    }
    public static List<Holidays> findByHolidayDate(Date holidayDate){
        List<Holidays> holidaysList=new ArrayList<Holidays>();
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findByHolidayDate");
            query.setParameter("holidayDate", holidayDate);
            holidaysList=(List<Holidays>)query.list();
            
        }catch (Exception e) {
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
            return holidaysList;
    }
      public static List<Holidays> findByHolidayDateByBranch(Date holidayDate,int branch){
        List<Holidays> holidaysList=new ArrayList<Holidays>();
       Session session = null;
        long id=0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Holidays.findByHolidayDateByBranch");
            query.setParameter("holidayDate", holidayDate);
            query.setParameter("branch", branch);
            holidaysList=(List<Holidays>)query.list();
            
        }catch (Exception e) {
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
            return holidaysList;
    }
}
