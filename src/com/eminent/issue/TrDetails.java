/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

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
 * @author EMINENT
 */
@Entity
@Table(name = "TR_DETAILS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TrDetails.findAll", query = "SELECT t FROM TrDetails t WHERE t.trId IS NOT NULL and t.createdOn is not null order by t.createdOn desc"),
    @NamedQuery(name = "TrDetails.findById", query = "SELECT t FROM TrDetails t WHERE t.id = :id"),
    @NamedQuery(name = "TrDetails.findByTrId", query = "SELECT t FROM TrDetails t WHERE t.trId = :trId"),
    @NamedQuery(name = "TrDetails.findByDescription", query = "SELECT t FROM TrDetails t WHERE t.description = :description"),
    @NamedQuery(name = "TrDetails.findByUserId", query = "SELECT t FROM TrDetails t WHERE t.userId = :userId"),
    @NamedQuery(name = "TrDetails.findByCreatedOn", query = "SELECT t FROM TrDetails t WHERE t.createdOn = :createdOn")})
public class TrDetails implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Size(max = 15)
    @Column(name = "TR_ID")
    private String trId;
    @Size(max = 75)
    @Column(name = "DESCRIPTION")
    private String description;
    @Size(max = 100)
    @Column(name = "USER_ID")
    private String userId;
    @Column(name = "USER_NAME")
    private String userName;
    @Column(name = "CREATED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;

    public TrDetails() {
    }

    public TrDetails(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTrId() {
        return trId;
    }

    public void setTrId(String trId) {
        this.trId = trId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + (int) (this.id ^ (this.id >>> 32));
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
        final TrDetails other = (TrDetails) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.TrDetails[ id=" + id + " ]";
    }

}
