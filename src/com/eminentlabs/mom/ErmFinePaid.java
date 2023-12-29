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
@Table(name = "ERM_FINE_PAID", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErmFinePaid.findAll", query = "SELECT e FROM ErmFinePaid e"),
    @NamedQuery(name = "ErmFinePaid.findById", query = "SELECT e FROM ErmFinePaid e WHERE e.id = :id"),
    @NamedQuery(name = "ErmFinePaid.findByUserid", query = "SELECT e FROM ErmFinePaid e WHERE e.userid = :userid"),
    @NamedQuery(name = "ErmFinePaid.findByAmount", query = "SELECT e FROM ErmFinePaid e WHERE e.amount = :amount"),
    @NamedQuery(name = "ErmFinePaid.findByPaidDate", query = "SELECT e FROM ErmFinePaid e WHERE e.paidDate = :paidDate"),
    @NamedQuery(name = "ErmFinePaid.findByCollectedby", query = "SELECT e FROM ErmFinePaid e WHERE e.collectedby = :collectedby"),
    @NamedQuery(name = "ErmFinePaid.findByModifiedon", query = "SELECT e FROM ErmFinePaid e WHERE e.modifiedon = :modifiedon"),
    @NamedQuery(name = "ErmFinePaid.findByModifiedby", query = "SELECT e FROM ErmFinePaid e WHERE e.modifiedby = :modifiedby"),
    @NamedQuery(name = "ErmFinePaid.findByComments", query = "SELECT e FROM ErmFinePaid e WHERE e.comments = :comments"),
    @NamedQuery(name = "ErmFinePaid.findByStatus", query = "SELECT e FROM ErmFinePaid e WHERE e.status = :status")})
public class ErmFinePaid implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
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
    @Column(name = "PAID_DATE")
    @Temporal(TemporalType.DATE)
    private Date paidDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COLLECTEDBY")
    private int collectedby;
    @Column(name = "MODIFIEDON")
    @Temporal(TemporalType.DATE)
    private Date modifiedon;
    @Column(name = "MODIFIEDBY")
    private int modifiedby;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "COMMENTS")
    private String comments;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "STATUS")
    private String status;

    public ErmFinePaid() {
    }

    public ErmFinePaid(long id) {
        this.id = id;
    }

    public ErmFinePaid(long id, int userid, int amount, Date paidDate, int collectedby, String comments, String status) {
        this.id = id;
        this.userid = userid;
        this.amount = amount;
        this.paidDate = paidDate;
        this.collectedby = collectedby;
        this.comments = comments;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public Date getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(Date paidDate) {
        this.paidDate = paidDate;
    }

    public int getCollectedby() {
        return collectedby;
    }

    public void setCollectedby(int collectedby) {
        this.collectedby = collectedby;
    }

    public Date getModifiedon() {
        return modifiedon;
    }

    public void setModifiedon(Date modifiedon) {
        this.modifiedon = modifiedon;
    }

    public int getModifiedby() {
        return modifiedby;
    }

    public void setModifiedby(int modifiedby) {
        this.modifiedby = modifiedby;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

 
  
    @Override
    public String toString() {
        return "com.eminentlabs.mom.ErmFinePaid[ id=" + id + " ]";
    }
    
}
