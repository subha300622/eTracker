/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

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
public class LeaveApproverDAO {
    
    private static final Logger LOG = Logger.getLogger(LeaveApproverDAO.class.getName());

    public static  List<LeaveApproverMaintenance> findAll() {
        Session session = null;
                List<LeaveApproverMaintenance> l = null;

        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("LeaveApproverMaintenance.findAll");
            l = query.list();
            if (l == null) {
                l = new ArrayList<LeaveApproverMaintenance>();
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

    public static List<LeaveApproverMaintenance> findByRequester(int requesterId) {
        Session session = null;
        List<LeaveApproverMaintenance>  tm = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("LeaveApproverMaintenance.findByRequester");
            query.setParameter("requester", requesterId);
            tm = (List<LeaveApproverMaintenance> ) query.list();
            if (tm == null) {
                tm = new ArrayList<LeaveApproverMaintenance> ();
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
      public static String deleteByRequester(int requesterId) {
        Session session = null;
        String message="failure";
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("LeaveApproverMaintenance.deleteByRequester");
            query.setParameter("requester", requesterId);
            query.executeUpdate();
           message="success";
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
        return message;
    }
      
      public static String deleteById(long id) {
        Session session = null;
        String message="failure";
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("LeaveApproverMaintenance.deleteByApprovalId");
            query.setParameter("approvalId", id);
            query.executeUpdate();
           message="success";
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
        return message;
    }
    
     public static List<LeavApprovalHistory> findByLeaveid(long leaveId) {
        Session session = null;
        List<LeavApprovalHistory>  tm = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("LeavApprovalHistory.findByLeaveId");
            query.setParameter("leaveid", leaveId);
            tm = (List<LeavApprovalHistory> ) query.list();
            if (tm == null) {
                tm = new ArrayList<LeavApprovalHistory> ();
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
       public static LeaveApproverMaintenance findByApprovalId(long id) {
        Session session = null;
      LeaveApproverMaintenance lam = new LeaveApproverMaintenance();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("LeaveApproverMaintenance.findByApprovalId");
            query.setParameter("approvalId", id);
          lam = (LeaveApproverMaintenance)query.uniqueResult();
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
        return lam;
    }
}
