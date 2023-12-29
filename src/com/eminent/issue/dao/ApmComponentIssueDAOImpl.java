/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.ApmComponentIssues;
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

public class ApmComponentIssueDAOImpl implements ApmComponentIssuesDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ApmComponentIssueDAOImpl");
    }

    @Override
    public void addIssue(ApmComponentIssues apmComponentIssues) {
        ModelDAO.save(DAOConstants.ENTITY_APM_COMPONENT_ISSUES, apmComponentIssues);
    }

    @Override
    public void update(ApmComponentIssues apmComponentIssues) {
        ModelDAO.update(DAOConstants.ENTITY_APM_COMPONENT_ISSUES, apmComponentIssues);
    }

    @Override
    public List<ApmComponentIssues> findByIssueId(String issueId) {
        Session session = null;
        List<ApmComponentIssues> componentIssueList = new ArrayList<ApmComponentIssues>();

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmComponentIssues.findByIssueId");
            query.setString("issueId", issueId);
            componentIssueList = (List<ApmComponentIssues>) query.list();

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
        return componentIssueList;
    }

    @Override
    public List<ApmComponentIssues> findIssueByComponentId(ApmComponentIssues apmComponentIssue) {
        Session session = null;
        List<ApmComponentIssues> IssueList = new ArrayList<ApmComponentIssues>();
        BigDecimal componentId = apmComponentIssue.getComponentId().getComponentId();

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmComponentIssues.findByComponentId");
            query.setBigDecimal("componentId", componentId);

            IssueList = (List<ApmComponentIssues>) query.list();

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
        return IssueList;
    }

    @Override
    public List<ApmComponentIssues> findComponentsByIssueId(String issueId) {
        Session session = null;
        List<ApmComponentIssues> componentList = new ArrayList<>();

        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmComponentIssues.findByIssueId");
            query.setString("issueId", issueId);
            componentList = (List<ApmComponentIssues>) query.list();

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
        return componentList;
    }

    @Override
    public void delete(ApmComponentIssues apmComponentIssues) {
        ModelDAO.delete(DAOConstants.ENTITY_APM_COMPONENT_ISSUES, apmComponentIssues);
    }

    @Override
    public void deleteByIssue(String issue) {
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmComponentIssues.deleteByIssueId");
            query.setString("issueId", issue);
            query.executeUpdate();
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
    }
}
