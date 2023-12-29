/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.notification;

import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author EMINENT
 */
public class NotificationController {

    private String message;
    Notification notification = new Notification();
    List<Notification> notifications = new ArrayList<Notification>();
    NotificationDAO ndao = new NotificationDAO();

    public void setAll(HttpServletRequest request) {
        DateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        String notificationName = request.getParameter("notification");
        String notificationType = request.getParameter("notificationType");
        String notificationIda = request.getParameter("notificationId");
        String expiryDate = request.getParameter("expiryDate");
        message = request.getParameter("message");
        long newsId = MoMUtil.parseLong(notificationIda, 0l);
        if (newsId == 0l) {
            if (request.getMethod().equalsIgnoreCase("post")) {
                if (notificationName != null) {
                    Notification notificationa = new Notification();
                    notificationa.setNotificationType(notificationType);
                    notificationa.setNotification(notificationName);
                    notificationa.setAddedOn(new Date());
                    try {
                        notificationa.setExpiryDate(sdf.parse(expiryDate));
                    } catch (ParseException ex) {

                    }
                    ModelDAO.save("Notification", notificationa);
                    message = "Notification added successfully";
                }
            } else {
            }

        } else {
            notification = ndao.findByNotificationId(newsId);
            if (request.getMethod().equalsIgnoreCase("post")) {
                notification.setNotification(notificationName);
                notification.setNotificationType(notificationType);
                notification.setAddedOn(new Date());

                try {
                    notification.setExpiryDate(sdf.parse(expiryDate));
                } catch (ParseException ex) {
                }
                ModelDAO.Update("Notification", notification);
                message = "Notification Updated successfully";
                notification = new Notification();
            } else {
            }
        }
        if (notification.getNotification() == null) {
            notification = new Notification();
            notification.setNotificationType("");
            notification.setExpiryDate(new Date());
            notification.setNotification("");

        }
        if (message == null) {
            message = "";
        }
        notifications = ndao.findAll();

    }

    public String converDateToString(Date sDate) {
        DateFormat sdfs = new SimpleDateFormat("dd-MM-YYYY");
        String formatDate = "";
        try {
            formatDate = sdfs.format(sDate);
        } catch (Exception ex) {
            formatDate = "";
        }
        return formatDate;
    }

    public List<String> getNotificationType() {
        List<String> list = new ArrayList<>();
        list.add("Internal");
        list.add("External");
        list.add("Both");
        return list;
    }

    public void news() {
        notifications = ndao.findAll();
    }

    public String notificationDup(HttpServletRequest request) {
        String res = "";
        String notificationIda = request.getParameter("notificationId");
        String notificationa = request.getParameter("notification");
        Notification news = ndao.findByNotification(notificationa);
        if (news.getNotification() != null) {

            long notificationId = MoMUtil.parseLong(notificationIda, 0l);
            if (notificationId != 0l) {
                if (notificationId == news.getNotificationId()) {
                    res = "true";
                } else {
                    res = "false";
                }
            } else {
                res = "false";
            }
        } else {
            res = "true";
        }
        return res;

    }

    public static List<Notification> getNotificationList(HttpServletRequest request) {
        String mail = (String) request.getSession().getAttribute("theName");
        String type = "Both";
        if (mail != null) {
            if (mail.endsWith("@eminentlabs.net")) {
                type = "Internal";
            } else {
                type = "External";
            }
        }
        return NotificationDAO.findByNotificationType(type);
    }

    public static int todayCount(List<Notification> notifications) {
        int count = 0;
        try {
            SimpleDateFormat ddmmyy = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat yyyy = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date now = new java.util.Date();
            now = ddmmyy.parse(yyyy.format(now));
            for (Notification n : notifications) {
                if ((ddmmyy.parse(yyyy.format(n.getAddedOn()))).compareTo(now) == 0) {
                    count++;
                }
            }
        } catch (ParseException ex) {
            Logger.getLogger(NotificationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Notification getNotification() {
        return notification;
    }

    public void setNotification(Notification notification) {
        this.notification = notification;
    }

    public List<Notification> getNotifications() {
        return notifications;
    }

    public void setNotifications(List<Notification> notifications) {
        this.notifications = notifications;
    }

}
