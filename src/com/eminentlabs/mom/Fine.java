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
@Table(name = "FINE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Fine.findAll", query = "SELECT f FROM Fine f"),
    @NamedQuery(name = "Fine.findById", query = "SELECT f FROM Fine f WHERE f.id = :id"),
    @NamedQuery(name = "Fine.findByReason", query = "SELECT f FROM Fine f WHERE f.reason = :reason"),
    @NamedQuery(name = "Fine.findByAmount", query = "SELECT f FROM Fine f WHERE f.amount = :amount"),
    @NamedQuery(name = "Fine.findByAddedon", query = "SELECT f FROM Fine f WHERE f.addedon = :addedon"),
    @NamedQuery(name = "Fine.findByAddedby", query = "SELECT f FROM Fine f WHERE f.addedby = :addedby")})
public class Fine implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "REASON")
    private String reason;
    @Basic(optional = false)
    @NotNull
    @Column(name = "AMOUNT")
    private int amount;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDEDBY")
    private int addedby;

    public Fine() {
    }

    public Fine(long id) {
        this.id = id;
    }

    public Fine(long id, String reason, int amount, Date addedon, int addedby) {
        this.id = id;
        this.reason = reason;
        this.amount = amount;
        this.addedon = addedon;
        this.addedby = addedby;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public int getAddedby() {
        return addedby;
    }

    public void setAddedby(int addedby) {
        this.addedby = addedby;
    }


    @Override
    public String toString() {
        return "com.eminentlabs.mom.Fine[ id=" + id + " ]";
    }
    
}
