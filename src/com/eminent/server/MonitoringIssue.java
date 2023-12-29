/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

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
 * @author vanithaalliraj
 */
@Entity
@Table(name = "MONITORING_ISSUE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MonitoringIssue.findAll", query = "SELECT m FROM MonitoringIssue m")
    , @NamedQuery(name = "MonitoringIssue.findByMId", query = "SELECT m FROM MonitoringIssue m WHERE m.mId = :mId")
    , @NamedQuery(name = "MonitoringIssue.findByPid", query = "SELECT m FROM MonitoringIssue m WHERE m.pid = :pid")
    , @NamedQuery(name = "MonitoringIssue.findByPidNCompCode", query = "SELECT m FROM MonitoringIssue m WHERE m.pid = :pid and m.companyCode=:companyCode")
    , @NamedQuery(name = "MonitoringIssue.findByIssueid", query = "SELECT m FROM MonitoringIssue m WHERE m.issueid = :issueid and m.companyCode IS NOT NULL")
    , @NamedQuery(name = "MonitoringIssue.findByAddedon", query = "SELECT m FROM MonitoringIssue m WHERE m.addedon = :addedon")
    , @NamedQuery(name = "MonitoringIssue.findByAddedBy", query = "SELECT m FROM MonitoringIssue m WHERE m.addedBy = :addedBy")})
public class MonitoringIssue implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "M_ID")
    private int mId;
    @Column(name = "PID")
    private Integer pid;
    @Size(max = 20)
    @Column(name = "ISSUEID")
    private String issueid;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "ADDED_BY")
    private Integer addedBy;
    @Column(name = "COMPANY_CODE")
    private Integer companyCode;

    public MonitoringIssue() {
    }

    public MonitoringIssue(int mId) {
        this.mId = mId;
    }

    public int getMId() {
        return mId;
    }

    public void setMId(int mId) {
        this.mId = mId;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getIssueid() {
        return issueid;
    }

    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public Integer getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(Integer addedBy) {
        this.addedBy = addedBy;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 89 * hash + this.mId;
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
        final MonitoringIssue other = (MonitoringIssue) obj;
        if (this.mId != other.mId) {
            return false;
        }
        return true;
    }

    public Integer getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(Integer companyCode) {
        this.companyCode = companyCode;
    }

    @Override
    public String toString() {
        return "com.eminent.server.MonitoringIssue[ mId=" + mId + " ]";
    }

}
