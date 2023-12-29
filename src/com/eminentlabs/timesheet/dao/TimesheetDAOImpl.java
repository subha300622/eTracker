/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.timesheet.dao;

import com.eminent.timesheet.TimesheetMaintanance;
import com.eminentlabs.dao.HibernateFactory;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class TimesheetDAOImpl implements TimesheetDAO {

    private static final Logger LOG = Logger.getLogger(TimesheetDAOImpl.class.getName());

    @Override
    public List<TimesheetMaintanance> findAll() {
        Session session = null;
        List<TimesheetMaintanance> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TimesheetMaintanance.findAll");
            l = query.list();
            if (l == null) {
                l = new ArrayList<TimesheetMaintanance>();
            }
        } catch (Exception e) {
            LOG.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        LOG.error(e.getMessage());

                    }
                }
            }
        }
        return l;
    }

    @Override
    public TimesheetMaintanance findByRequester(int requesterId) {
        Session session = null;
        TimesheetMaintanance tm = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TimesheetMaintanance.findByRequester");
            query.setParameter("requester", requesterId);
            tm = (TimesheetMaintanance) query.uniqueResult();
            if (tm == null) {
                tm = new TimesheetMaintanance();
            } 
        } catch (Exception e) {
            LOG.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        LOG.error(e.getMessage());

                    }
                }
            }
        }
        return tm;
    }

    @Override
    public List<Integer> findRoleByUserId(Integer userId) {
        Session session = null;
        List<Integer> roleId = roleId = new ArrayList<Integer>();
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TimesheetMaintanance.findByUserid");
            query.setParameter("userid", userId);
            List<TimesheetMaintanance> maintanances = (List<TimesheetMaintanance>) query.list();
            for (TimesheetMaintanance tm : maintanances) {
                if (tm.getAccountsApprover().intValue() == userId) {
                    roleId.add(2);
                } else if (tm.getReimbursementApprover().intValue() == userId) {
                    roleId.add(3);
                }
            }
            if (maintanances == null) {
                roleId = new ArrayList<Integer>(0);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        LOG.error(e.getMessage());

                    }
                }
            }
        }
        return roleId;
    }

    @Override
    public TimesheetMaintanance findById(Long id) {
        Session session = null;
        TimesheetMaintanance tm = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TimesheetMaintanance.findById");
            query.setParameter("id", id);
            tm = (TimesheetMaintanance) query.uniqueResult();
            if (tm == null) {
                tm = new TimesheetMaintanance();
            } 
        } catch (Exception e) {
            LOG.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        LOG.error(e.getMessage());

                    }
                }
            }
        }
        return tm;
    }

}
