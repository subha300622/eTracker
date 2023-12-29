/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.mom;

import java.io.Serializable;
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
 * @author RN.Khans
 */
@Entity
@Table(name = "ERM_FINE_PAYMENT_HISTORY", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErmFinePaymentHistory.findAll", query = "SELECT e FROM ErmFinePaymentHistory e"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByPaymentid", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.paymentid = :paymentid"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByUserid", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.userid = :userid"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByAmount", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.amount = :amount"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByPaymentDate", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.paymentDate = :paymentDate"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByCollectedby", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.collectedby = :collectedby"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByComments", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.comments = :comments"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByAddedon", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.addedon = :addedon"),
    @NamedQuery(name = "ErmFinePaymentHistory.findByStatus", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.status = :status"),
    @NamedQuery(name = "ErmFinePaymentHistory.findById", query = "SELECT e FROM ErmFinePaymentHistory e WHERE e.id = :id")})
public class ErmFinePaymentHistory implements Serializable {
    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PAYMENTID")
    private long paymentid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "USERID")
    private int userid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "AMOUNT")
    private int amount;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PAYMENT_DATE")
    @Temporal(TemporalType.DATE)
    private Date paymentDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COLLECTEDBY")
    private int collectedby;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "COMMENTS")
    private String comments;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "STATUS")
    private String status;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;

    public ErmFinePaymentHistory() {
    }

    public ErmFinePaymentHistory(long id) {
        this.id = id;
    }

    public ErmFinePaymentHistory(long id, long paymentid, int userid, int amount, Date paymentDate, int collectedby, String comments, Date addedon, String status) {
        this.id = id;
        this.paymentid = paymentid;
        this.userid = userid;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.collectedby = collectedby;
        this.comments = comments;
        this.addedon = addedon;
        this.status = status;
    }

    public long getPaymentid() {
        return paymentid;
    }

    public void setPaymentid(long paymentid) {
        this.paymentid = paymentid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public int getCollectedby() {
        return collectedby;
    }

    public void setCollectedby(int collectedby) {
        this.collectedby = collectedby;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

  
    @Override
    public String toString() {
        return "com.eminentlabs.mom.ErmFinePaymentHistory[ id=" + id + " ]";
    }
    
}
