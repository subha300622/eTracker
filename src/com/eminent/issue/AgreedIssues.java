/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author DhanVa CompuTers
 */
@Entity
@Table(name = "AGREED_ISSUES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AgreedIssues.findAll", query = "SELECT a FROM AgreedIssues a")
    , @NamedQuery(name = "AgreedIssues.findByIssueId", query = "SELECT a FROM AgreedIssues a WHERE a.agreedIssuesPK.issueId = :issueId")
    , @NamedQuery(name = "AgreedIssues.findByProjectId", query = "SELECT a FROM AgreedIssues a WHERE a.projectId = :projectId")
    , @NamedQuery(name = "AgreedIssues.findByAddedby", query = "SELECT a FROM AgreedIssues a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "AgreedIssues.findByAddedon", query = "SELECT a FROM AgreedIssues a WHERE a.addedon = :addedon")
    , @NamedQuery(name = "AgreedIssues.findByStatus", query = "SELECT a FROM AgreedIssues a WHERE a.status = :status")
    , @NamedQuery(name = "AgreedIssues.findByIssueType", query = "SELECT a FROM AgreedIssues a WHERE a.agreedIssuesPK.issueType = :issueType")})
public class AgreedIssues implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected AgreedIssuesPK agreedIssuesPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PROJECT_ID")
    private long projectId;
    @Column(name = "ADDEDBY")
    private int addedby;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "STATUS")
    private int status;

    public AgreedIssues() {
    }

    public AgreedIssues(AgreedIssuesPK agreedIssuesPK) {
        this.agreedIssuesPK = agreedIssuesPK;
    }

    public AgreedIssues(AgreedIssuesPK agreedIssuesPK, long projectId) {
        this.agreedIssuesPK = agreedIssuesPK;
        this.projectId = projectId;
    }

    public AgreedIssues(String issueId, String issueType) {
        this.agreedIssuesPK = new AgreedIssuesPK(issueId, issueType);
    }

    public AgreedIssuesPK getAgreedIssuesPK() {
        return agreedIssuesPK;
    }

    public void setAgreedIssuesPK(AgreedIssuesPK agreedIssuesPK) {
        this.agreedIssuesPK = agreedIssuesPK;
    }

    public long getProjectId() {
        return projectId;
    }

    public void setProjectId(long projectId) {
        this.projectId = projectId;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (agreedIssuesPK != null ? agreedIssuesPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AgreedIssues)) {
            return false;
        }
        AgreedIssues other = (AgreedIssues) object;
        if ((this.agreedIssuesPK == null && other.agreedIssuesPK != null) || (this.agreedIssuesPK != null && !this.agreedIssuesPK.equals(other.agreedIssuesPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.AgreedIssues[ agreedIssuesPK=" + agreedIssuesPK + " ]";
    }
    
}
