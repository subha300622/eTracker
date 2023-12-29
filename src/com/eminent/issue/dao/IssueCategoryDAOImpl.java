/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.IssueCategory;
import static com.eminent.issue.dao.IssueCategoryDAOImpl.logger;
import com.eminentlabs.dao.HibernateFactory;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author DhanVa CompuTers
 */
public class IssueCategoryDAOImpl implements IssueCategoryDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("IssueCategoryDAOImpl");
    }

    @Override
    public List<IssueCategory> getAll() {
        List<IssueCategory> categorys = new ArrayList<IssueCategory>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("IssueCategory.findAll");
            categorys = (List<IssueCategory>) query.list();
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
        return categorys;
    }

    @Override
    public IssueCategory getByID(int categoryId) {
        IssueCategory issueCategory = new IssueCategory();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            issueCategory = (IssueCategory) session.get(IssueCategory.class, categoryId);

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
        return issueCategory;
    }

    @Override
    public List<IssueCategory> getByPid(int pid) {
        List<IssueCategory> categorys = new ArrayList<>();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("IssueCategory.findByPid");
            query.setParameter("pid", pid);
            categorys = (List<IssueCategory>) query.list();

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
        return categorys;
    }

    @Override
    public IssueCategory getByPidNCategory(int pid, String category) {
        IssueCategory issueCategory = new IssueCategory();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("IssueCategory.findByPIDCategoryName");
            query.setParameter("pid", pid);
            query.setParameter("categoryName", category);
            issueCategory = (IssueCategory) query.uniqueResult();

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
        return issueCategory;
    }

}
