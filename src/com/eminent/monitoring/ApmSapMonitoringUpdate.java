/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.monitoring;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "APM_SAP_MONITORING_UPDATE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapMonitoringUpdate.findAll", query = "SELECT a FROM ApmSapMonitoringUpdate a")
    , @NamedQuery(name = "ApmSapMonitoringUpdate.findById", query = "SELECT a FROM ApmSapMonitoringUpdate a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapMonitoringUpdate.findByRemarks", query = "SELECT a FROM ApmSapMonitoringUpdate a WHERE a.remarks = :remarks")
    , @NamedQuery(name = "ApmSapMonitoringUpdate.findByPid", query = "SELECT a FROM ApmSapMonitoringUpdate a WHERE a.pid = :pid")
    , @NamedQuery(name = "ApmSapMonitoringUpdate.findByAddedOn", query = "SELECT a FROM ApmSapMonitoringUpdate a WHERE a.addedOn = :addedOn")
    , @NamedQuery(name = "ApmSapMonitoringUpdate.findByAddedBy", query = "SELECT a FROM ApmSapMonitoringUpdate a WHERE a.addedBy = :addedBy")})
public class ApmSapMonitoringUpdate implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private BigDecimal id;
    @Size(max = 1000)
    @Column(name = "REMARKS")
    private String remarks;
    @Column(name = "PID")
    private int pid;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "ADDED_BY")
    private int addedBy;
    @JoinColumn(name = "SAP_MO_ID", referencedColumnName = "ID")
    @ManyToOne(fetch = FetchType.EAGER)
    private SapSystemMonitoring sapMoId;

    public ApmSapMonitoringUpdate() {
    }

    public ApmSapMonitoringUpdate(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public Date getAddedOn() {
        return addedOn;
    }

    public void setAddedOn(Date addedOn) {
        this.addedOn = addedOn;
    }

    public int getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(int addedBy) {
        this.addedBy = addedBy;
    }

    public SapSystemMonitoring getSapMoId() {
        return sapMoId;
    }

    public void setSapMoId(SapSystemMonitoring sapMoId) {
        this.sapMoId = sapMoId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ApmSapMonitoringUpdate)) {
            return false;
        }
        ApmSapMonitoringUpdate other = (ApmSapMonitoringUpdate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.monitoring.ApmSapMonitoringUpdate[ id=" + id + " ]";
    }
    
}
