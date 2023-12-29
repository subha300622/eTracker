/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

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
 * @author RN.Khans
 */
@Entity
@Table(name = "FINE_AMOUNT_USERS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FineAmountUsers.findAll", query = "SELECT f FROM FineAmountUsers f"),
    @NamedQuery(name = "FineAmountUsers.findById", query = "SELECT f FROM FineAmountUsers f WHERE f.id = :id"),
    @NamedQuery(name = "FineAmountUsers.findByUserid", query = "SELECT f FROM FineAmountUsers f WHERE f.userid = :userid"),
    @NamedQuery(name = "FineAmountUsers.findByReasonid", query = "SELECT f FROM FineAmountUsers f WHERE f.reasonid = :reasonid"),
    @NamedQuery(name = "FineAmountUsers.findByAmount", query = "SELECT f FROM FineAmountUsers f WHERE f.amount = :amount"),
    @NamedQuery(name = "FineAmountUsers.findByFineDate", query = "SELECT f FROM FineAmountUsers f WHERE f.fineDate = :fineDate"),
    @NamedQuery(name = "FineAmountUsers.findByAddedby", query = "SELECT f FROM FineAmountUsers f WHERE f.addedby = :addedby"),
    @NamedQuery(name = "FineAmountUsers.findByAddedon", query = "SELECT f FROM FineAmountUsers f WHERE f.addedon = :addedon"),
    @NamedQuery(name = "FineAmountUsers.findByUniuqeReasonID", query = "SELECT f FROM FineAmountUsers f WHERE f.userid = :userid and f.reasonid = :reasonid and f.fineDate = :fineDate")})
public class FineAmountUsers implements Serializable {

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
    @Column(name = "REASONID")
    private int reasonid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "AMOUNT")
    private int amount;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FINE_DATE")
    @Temporal(TemporalType.DATE)
    private Date fineDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDEDBY")
    private int addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;

    @Size(max = 50)
    @Column(name = "STATUS")
    private String status;
    @Size(max = 200)
    @Column(name = "COMMENTS")
    private String comments;

    public FineAmountUsers() {
    }

    public FineAmountUsers(int id) {
        this.id = id;
    }

    public FineAmountUsers(long id, int userid, int reasonid, int amount, Date fineDate, int addedby, Date addedon) {
        this.id = id;
        this.userid = userid;
        this.reasonid = reasonid;
        this.amount = amount;
        this.fineDate = fineDate;
        this.addedby = addedby;
        this.addedon = addedon;
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

    public int getReasonid() {
        return reasonid;
    }

    public void setReasonid(int reasonid) {
        this.reasonid = reasonid;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getFineDate() {
        return fineDate;
    }

    public void setFineDate(Date fineDate) {
        this.fineDate = fineDate;
    }

    public int getAddedby() {
        return addedby;
    }

    public void setAddedby(int addedby) {
        this.addedby = addedby;
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

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.FineAmountUsers[ id=" + id + " ]";
    }

}
