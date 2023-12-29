/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.ApmComponent;
import com.eminent.issue.ApmTrFormat;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class ApmTrFormatDAOImpl implements ApmTrFormatDAO{
    static Logger logger = null;
     static {
        logger = Logger.getLogger("ApmTrFormatDAOImpl");
    }

    @Override
    public void addTrFormat(ApmTrFormat apmTrFormat) {
         ModelDAO.save(DAOConstants.ENTITY_APM_TR_FORMAT,apmTrFormat);
    }

    @Override
    public List<ApmTrFormat> findAlltrFormats() {
        List<ApmTrFormat> trFormats = new ArrayList<ApmTrFormat>();
        Session session = null;
           try {
            session = HibernateFactory.getCurrentSession();
          Query query = session.getNamedQuery("ApmTrFormat.findAll"); 
            trFormats = (List<ApmTrFormat>) query.list();
         } catch (HibernateException e) {
            e.printStackTrace();
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
        return trFormats;
    }

    @Override
    public List<ApmTrFormat> findAllTrFormatsByPid(long pid) {
         List<ApmTrFormat> trFormatList = new ArrayList<>();
          Session session = null;
         try {

            session = HibernateFactory.getCurrentSession();
              Query query = session.getNamedQuery("ApmTrFormat.findByPid");
            query.setLong("pid", pid);
             trFormatList =  query.list();
                   
        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (HibernateException e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
    return trFormatList;
    }

    @Override
    public void delete(ApmTrFormat apmTrFormat) {
    
        ModelDAO.delete(DAOConstants.ENTITY_APM_TR_FORMAT, apmTrFormat);
      
    }

    @Override
    public void update(ApmTrFormat apmTrFormat) {
        ModelDAO.update(DAOConstants.ENTITY_APM_TR_FORMAT, apmTrFormat);
     
    }
}