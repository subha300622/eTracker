/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement.dao;

import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.reimbursement.ReimbursementBill;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class ReimbursementBillDAOImpl implements ReimbursementBillDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ReimbursementBillDAOImpl");
    }

    @Override
    public void saveReimbursementBill(ReimbursementBill reimbursementBill) {
        ModelDAO.save(DAOConstants.ENTITY_REIMBURSEMENT_BILL, reimbursementBill);
    }

    @Override
    public boolean deleteReimbursementBill(ReimbursementBill reimbursementBill) {
        boolean flag = false;
        try {
            ModelDAO.delete(DAOConstants.ENTITY_REIMBURSEMENT_BILL, reimbursementBill);
            flag = true;
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        }
        return flag;
    }

    @Override
    public ReimbursementBill findReimbursementBillByrbId(Long rbId) {
        Session session = null;
        ReimbursementBill reimbursementBill = new ReimbursementBill();
        try {

            session = HibernateFactory.getCurrentSession();
            reimbursementBill = (ReimbursementBill) session.get(ReimbursementBill.class, rbId);

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
        return reimbursementBill;
    }
    
    @Override
    public Integer monthlyFileCount(String countKeyWord, Long rvId) {
        Session session = null;
        Integer count = 0;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementBill.findByMonthlyCount");
            query.setParameter("rvid", rvId);
            query.setParameter("fileName", "%" + countKeyWord + "%");
            Object ob = query.uniqueResult();
            if (ob == null) {

            } else {
                count = ((Long) ob).intValue();
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
        return count;
    }
    
    @Override
    public ReimbursementBill findByFileName(String fileName) {
       Session session = null;
        ReimbursementBill reimbursementBill = new ReimbursementBill();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementBill.findByFileName");
            query.setParameter("fileName", fileName);
            Object ob = query.uniqueResult();
            if (ob == null) {

            } else {
                reimbursementBill = (ReimbursementBill) ob;
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
        return reimbursementBill;
    }
}
