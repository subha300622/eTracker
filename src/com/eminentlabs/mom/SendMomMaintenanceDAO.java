/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminentlabs.dao.HibernateFactory;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author vanithaalliraj
 */
public class SendMomMaintenanceDAO {

    public static List<SendMomMaintenance> findAll() {
        Session session = null;
        List<SendMomMaintenance> l = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendMomMaintenance.findAll");
            l = query.list();
            if (l == null) {
                l = new ArrayList<SendMomMaintenance>();
            }
        } catch (Exception e) {
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {

                    }
                }
            }
        }
        return l;
    }
    
        public static SendMomMaintenance findByRequester(int requesterId) {
        Session session = null;
        SendMomMaintenance  tm = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendMomMaintenance.findByUserId");
            query.setParameter("userId", requesterId);
            tm = (SendMomMaintenance) query.uniqueResult();
            if (tm == null) {
                tm = new SendMomMaintenance();
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                    }
                }
            }
        }
        return tm;
    }

    public static String deleteById(int id) {
        Session session = null;
        String message = "failure";
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("SendMomMaintenance.deleteById");
            query.setParameter("id", id);
            query.executeUpdate();
            message = "success";
        } catch (Exception e) {
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {

                    }
                }
            }
        }
        return message;
    }
}
