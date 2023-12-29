/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.ApmComponent;
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


public class ApmComponentDAOImpl implements ApmComponentDAO{
    static Logger logger = null;
     static {
        logger = Logger.getLogger("ApmComponentDAOImpl");
    }
    private int teamid;
    @Override
    public void addComponent(ApmComponent apmComponent) {
     
        ModelDAO.save(DAOConstants.ENTITY_APM_COMPONENT, apmComponent);
    }


 //   @Override
    /*  public List<ApmComponent> findAllComponents(ApmComponent apmComponent) {
        List<ApmComponent> componentList = null;
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
         

           // Query query = session.getNamedQuery("ApmComponent.findAll");
                    componentList=session.createQuery("from ApmComponent ac").list();
           // componentList = (List<ApmComponent>) query.list();
            
                componentList = new ArrayList<ApmComponent>();
                            
            
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
        return componentList;
    }*/

    
    
    
    
     @Override
      public List<ApmComponent> findAllComponents(BigDecimal teamId) {
        List<ApmComponent> componentList = new ArrayList<>();
        Session session = null;
         Transaction trns = null;
          
        try {
            session = HibernateFactory.getCurrentSession();
            trns = session.beginTransaction();
            String queryString = "from ApmComponent where team_id = ?";
            Query query = session.createQuery(queryString);
            query.setBigDecimal(teamid, teamId);
            componentList = (List<ApmComponent>) query.list();
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
        return componentList;
    }

      
    @Override
    public void update(ApmComponent apmComponent) {
         ModelDAO.update(DAOConstants.ENTITY_APM_COMPONENT, apmComponent);
         
    }

    @Override
    public void delete(ApmComponent apmComponent) {
           
               
        ModelDAO.delete(DAOConstants.ENTITY_APM_COMPONENT, apmComponent);
                
            
    }

    @Override
    public ApmComponent findByComponentId(BigDecimal componentId) {
        ApmComponent apmComponent = new ApmComponent();
         Session session = null;
        try {

             session = HibernateFactory.getCurrentSession();
            apmComponent = (ApmComponent) session.get(ApmComponent.class, componentId);


        } catch (HibernateException e) {
           logger.error(e.getMessage());
        }finally {
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
        return apmComponent;
    }
@Override
 public List<ApmComponent> findAllComponentNames() {
        List<ApmComponent> componentList = new ArrayList<>();
        Session session = null;
           try {
            session = HibernateFactory.getCurrentSession();
          Query query = session.getNamedQuery("ApmComponent.findAll"); 
            componentList = (List<ApmComponent>) query.list();
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
        return componentList;
    }
}