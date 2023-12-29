/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.issue;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.Objects;
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
@Table(name = "APM_MODULE_ATTACHMENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmModuleAttachment.findAll", query = "SELECT a FROM ApmModuleAttachment a"),
    @NamedQuery(name = "ApmModuleAttachment.findById", query = "SELECT a FROM ApmModuleAttachment a WHERE a.id = :id"),
    @NamedQuery(name = "ApmModuleAttachment.findByProjectId", query = "SELECT a FROM ApmModuleAttachment a WHERE a.projectId = :projectId"),
    @NamedQuery(name = "ApmModuleAttachment.findByModuleid", query = "SELECT a FROM ApmModuleAttachment a WHERE a.moduleid = :moduleid"),
    @NamedQuery(name = "ApmModuleAttachment.findByFilename", query = "SELECT a FROM ApmModuleAttachment a WHERE a.filename = :filename"),
    @NamedQuery(name = "ApmModuleAttachment.findByAttacheddate", query = "SELECT a FROM ApmModuleAttachment a WHERE a.attacheddate = :attacheddate"),
    @NamedQuery(name = "ApmModuleAttachment.findByOwner", query = "SELECT a FROM ApmModuleAttachment a WHERE a.owner = :owner")})
public class ApmModuleAttachment implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODULEID")
    private int moduleid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PROJECTID")
    private long projectId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
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

    public ApmModuleAttachment() {
    }

    public ApmModuleAttachment(int moduleid, String filename, Date attacheddate, int owner) {
        this.moduleid = moduleid;
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

    public int getModuleid() {
        return moduleid;
    }

    public void setModuleid(int moduleid) {
        this.moduleid = moduleid;
    }

    public long getProjectId() {
        return projectId;
    }

    public void setProjectId(long projectId) {
        this.projectId = projectId;
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
        int hash = 7;
        hash = 37 * hash + this.moduleid;
        hash = 37 * hash + Objects.hashCode(this.filename);
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
        final ApmModuleAttachment other = (ApmModuleAttachment) obj;
        if (this.moduleid != other.moduleid) {
            return false;
        }
        if (!Objects.equals(this.filename, other.filename)) {
            return false;
        }
        return true;
    }

    
    
}
