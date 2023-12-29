/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.notification;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Muthu
 */
@Entity
@Table(name = "NOTIFICATION")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Notification.findAll", query = "SELECT n FROM Notification n"),
    @NamedQuery(name = "Notification.findByNotificationId", query = "SELECT n FROM Notification n WHERE n.notificationId = :notificationId"),
    @NamedQuery(name = "Notification.findByNotification", query = "SELECT n FROM Notification n WHERE n.notification = :notification"),
    @NamedQuery(name = "Notification.findByNotificationType", query = "SELECT n FROM Notification n WHERE  n.expiryDate >= :expiryDate and (n.notificationType = :notificationType or n.notificationType='Both') order by n.notificationId DESC"),
    @NamedQuery(name = "Notification.findByExpiryDate", query = "SELECT n FROM Notification n WHERE n.expiryDate = :expiryDate"),
    @NamedQuery(name = "Notification.findByAddedBy", query = "SELECT n FROM Notification n WHERE n.addedBy = :addedBy"),
    @NamedQuery(name = "Notification.findByAddedOn", query = "SELECT n FROM Notification n WHERE n.addedOn = :addedOn"),
    @NamedQuery(name = "Notification.findByNotificationTypeOnly", query = "SELECT n FROM Notification n WHERE n.notificationType = :notificationType")})
public class Notification implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "NOTIFICATION_ID")
    private long notificationId;
    @Size(max = 1000)
    @Column(name = "NOTIFICATION")
    private String notification;
    @Column(name = "EXPIRY_DATE")
    @Temporal(TemporalType.DATE)
    private Date expiryDate;
    @Column(name = "ADDED_BY")
    private int addedBy;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Size(max = 20)
    @Column(name = "NOTIFICATION_TYPE")
    private String notificationType;

    public Notification() {
    }

    public Notification(long notificationId) {
        this.notificationId = notificationId;
    }

    public Notification(long notificationId, String notification, Date expiryDate, int addedBy, Date addedOn, String notificationType) {
        this.notificationId = notificationId;
        this.notification = notification;
        this.expiryDate = expiryDate;
        this.addedBy = addedBy;
        this.addedOn = addedOn;
        this.notificationType = notificationType;
    }

    public long getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(long notificationId) {
        this.notificationId = notificationId;
    }

    public String getNotification() {
        return notification;
    }

    public void setNotification(String notification) {
        this.notification = notification;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public int getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(int addedBy) {
        this.addedBy = addedBy;
    }

    public Date getAddedOn() {
        return addedOn;
    }

    public void setAddedOn(Date addedOn) {
        this.addedOn = addedOn;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 79 * hash + (int) (this.notificationId ^ (this.notificationId >>> 32));
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Notification other = (Notification) obj;
        if (this.notificationId != other.notificationId) {
            return false;
        }
        return true;
    }


    @Override
    public String toString() {
        return "com.eminent.notification.Notification[ notificationId=" + notificationId + " ]";
    }
    
}
