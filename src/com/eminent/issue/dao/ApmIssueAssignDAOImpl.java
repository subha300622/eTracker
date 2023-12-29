/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.ApmIssueAssignment;
import com.eminentlabs.dao.HibernateFactory;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author DhanVa CompuTers
 */
public class ApmIssueAssignDAOImpl implements ApmIssueAssignDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ApmIssueAssignDAOImpl");
    }

    @Override
    public ApmIssueAssignment getApmIssueAssignmentByPid(int pid) {
        ApmIssueAssignment assignment = null;
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmIssueAssignment.findByPid");
            query.setParameter("pid", pid);
            assignment = (ApmIssueAssignment) query.uniqueResult();

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
        return assignment;
    }

    @Override
    public List<ApmIssueAssignment> getAll() {
        List<ApmIssueAssignment> assignment = null;
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmIssueAssignment.findByAll");
            assignment = (List<ApmIssueAssignment>) query.list();
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
        return assignment;
    }
}
