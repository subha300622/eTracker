/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.notification;

import com.eminentlabs.dao.HibernateFactory;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class NotificationDAO {

    public Notification findByNotificationId(long notificationId) {
        Notification notification = new Notification();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            notification = (Notification) session.get(Notification.class, notificationId);
            if (notification == null) {
                notification = new Notification();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notification;
    }

    public List<Notification> findAll() {
        Session session = null;
        List<Notification> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("Notification.findAll");
            notifications = (List<Notification>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<Notification>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }
     public List<Notification> findValid() {
        Session session = null;
        List<Notification> notifications = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("Notification.findValid");
            query.setParameter("expiryDate", new Date());
            notifications = (List<Notification>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<Notification>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }

    public Notification findByNotification(String notification) {
        Notification newsTicker = new Notification();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Notification.findByNotification");
            query.setParameter("notification", notification);
            List<Notification> newsTickers = query.list();
            if (newsTickers != null) {
                for (Notification newsTicker1 : newsTickers) {
                    newsTicker = newsTicker1;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return newsTicker;
    }
    
    public static List<Notification> findByNotificationType(String type) {
        Session session = null;
        List<Notification> notifications = null;
        try {
            Date d = new Date();
            session = HibernateFactory.getCurrentSession();
            Query query = (Query) session.getNamedQuery("Notification.findByNotificationType");
            query.setParameter("notificationType", type);
            query.setParameter("expiryDate", d);
            notifications = (List<Notification>) query.list();
            if (notifications == null) {
                notifications = new ArrayList<Notification>();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        e.printStackTrace();

                    }
                }
            }
        }
        return notifications;
    }
}
