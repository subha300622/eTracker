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
 * @author DhanVa CompuTers
 */
@Entity
@Table(name = "APM_TS_ATTACHMENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmTsAttachment.findAll", query = "SELECT a FROM ApmTsAttachment a")
    , @NamedQuery(name = "ApmTsAttachment.findById", query = "SELECT a FROM ApmTsAttachment a WHERE a.id = :id")
    , @NamedQuery(name = "ApmTsAttachment.findByTsId", query = "SELECT a FROM ApmTsAttachment a WHERE a.tsId = :tsId")
    , @NamedQuery(name = "ApmTsAttachment.findByFilename", query = "SELECT a FROM ApmTsAttachment a WHERE a.filename = :filename")
    , @NamedQuery(name = "ApmTsAttachment.findByAttacheddate", query = "SELECT a FROM ApmTsAttachment a WHERE a.attacheddate = :attacheddate")
    , @NamedQuery(name = "ApmTsAttachment.findByOwner", query = "SELECT a FROM ApmTsAttachment a WHERE a.owner = :owner")})
public class ApmTsAttachment implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TS_ID")
    private long tsId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "FILENAME")
    private String filename;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ATTACHEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date attacheddate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "OWNER")
    private int owner;

    public ApmTsAttachment() {
    }

    public ApmTsAttachment(long id) {
        this.id = id;
    }

    public ApmTsAttachment(long id, long tsId, String filename, Date attacheddate, int owner) {
        this.id = id;
        this.tsId = tsId;
        this.filename = filename;
        this.attacheddate = attacheddate;
        this.owner = owner;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getTsId() {
        return tsId;
    }

    public void setTsId(long tsId) {
        this.tsId = tsId;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Date getAttacheddate() {
        return attacheddate;
    }

    public void setAttacheddate(Date attacheddate) {
        this.attacheddate = attacheddate;
    }

    public int getOwner() {
        return owner;
    }

    public void setOwner(int owner) {
        this.owner = owner;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 79 * hash + (int) (this.id ^ (this.id >>> 32));
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ApmTsAttachment other = (ApmTsAttachment) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

   
    @Override
    public String toString() {
        return "com.eminent.issue.ApmTsAttachment[ id=" + id + " ]";
    }
    
}
