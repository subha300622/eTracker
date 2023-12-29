/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement.dao;

import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.reimbursement.ReimbursementVouchers;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class ReimbursementVouchersDAOImpl implements ReimbursementVouchersDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ReimbursementVouchersDAOImpl");
    }

    @Override
    public List<ReimbursementVouchers> findAll() {
        Session session = null;
        List<ReimbursementVouchers> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementVouchers.findAll");
            l = query.list();
            if (l == null) {
                l = new ArrayList<ReimbursementVouchers>();
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
        return l;
    }

    @Override
    public List<ReimbursementVouchers> findByRequestedBy(Integer requestedBy) {
        Session session = null;
        List<ReimbursementVouchers> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementVouchers.findByRequestedBy");
            query.setParameter("requestedBy", requestedBy);
            l = query.list();
            if (l == null) {
                l = new ArrayList<ReimbursementVouchers>();
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
        return l;
    }

    @Override
    public List<ReimbursementVouchers> findForAccountant(Integer requestedBy) {
        Session session = null;
        List<ReimbursementVouchers> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementVouchers.findForAccountant");
            query.setParameter("status", 5);
            query.setParameter("requestedBy", requestedBy);
            l = query.list();
            if (l == null) {
                l = new ArrayList<ReimbursementVouchers>();
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
        return l;
    }

    @Override
    public void saveReimbursementVouchers(ReimbursementVouchers reimbursementVouchers) {
        ModelDAO.save(DAOConstants.ENTITY_REIMBURSEMENT_VOUCHERS, reimbursementVouchers);
    }

    @Override
    public void updateReimbursementVouchers(ReimbursementVouchers reimbursementVouchers) {
        ModelDAO.Update(DAOConstants.ENTITY_REIMBURSEMENT_VOUCHERS, reimbursementVouchers);
    }

    @Override
    public boolean deleteReimbursementVouchers(ReimbursementVouchers reimbursementVouchers) {
        boolean flag = false;
        try {
            ModelDAO.delete(DAOConstants.ENTITY_REIMBURSEMENT_VOUCHERS, reimbursementVouchers);
            flag = true;
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        }
        return flag;
    }

    @Override
    public Integer monthlyFileCount(String countKeyWord) {
        Session session = null;
        Integer count = 0;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementVouchers.findByMonthlyCount");
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
    public ReimbursementVouchers findReimbursementVouchersByrvId(Long rvId) {
        Session session = null;
        ReimbursementVouchers reimbursementVouchers = new ReimbursementVouchers();
        try {

            session = HibernateFactory.getCurrentSession();
            reimbursementVouchers = (ReimbursementVouchers) session.get(ReimbursementVouchers.class, rvId);

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
        return reimbursementVouchers;
    }

    @Override
    public ReimbursementVouchers findByFileName(String fileName) {
        Session session = null;
        ReimbursementVouchers reimbursementVouchers = new ReimbursementVouchers();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementVouchers.findByFileName");
            query.setParameter("fileName", fileName);
            Object ob = query.uniqueResult();
            if (ob == null) {

            } else {
                reimbursementVouchers = (ReimbursementVouchers) ob;
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
        return reimbursementVouchers;
    }

    @Override
    public List<ReimbursementVouchers> findBetweenPeriod(Date startMonth, Date endMonth) {
        Session session = null;
        List<ReimbursementVouchers> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ReimbursementVouchers.findBetweenPeriod");
            query.setParameter("perioda", startMonth);
            query.setParameter("periodb", endMonth);
            l = query.list();
            if (l == null) {
                l = new ArrayList<ReimbursementVouchers>();
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
        return l;
    }

}
