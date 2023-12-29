/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.branch;

import com.eminentlabs.dao.HibernateFactory;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Muthu
 */
public class BranchDAOImpl implements BranchDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("BranchDAOImpl");
    }

    @Override
    public List<Branches> findAll() {
        Session session = null;
        List<Branches> branches = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Branches.findAll");

            branches = (List<Branches>) query.list();
            if (branches == null) {
                branches = new ArrayList<Branches>();
            }
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
        return branches;
    }

    @Override
    public Branches findByBranchId(int branchId) {
        Session session = null;
        Branches branch = new Branches();
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Branches.findByBranchId");
            query.setParameter("branchId", branchId);
            branch = (Branches) query.uniqueResult();

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
        return branch;
    }

    @Override
    public Branches findByLocation(String location) {
        Session session = null;
        Branches branch = new Branches();
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Branches.findByLocation");
            query.setParameter("location", location);
            branch = (Branches) query.uniqueResult();

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
        return branch;
    }

}
