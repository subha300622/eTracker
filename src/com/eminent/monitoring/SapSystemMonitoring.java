/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.monitoring;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author vanithaalliraj
 */
@Entity
@Table(name = "SAP_SYSTEM_MONITORING")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SapSystemMonitoring.findAll", query = "SELECT s FROM SapSystemMonitoring s")
    , @NamedQuery(name = "SapSystemMonitoring.findById", query = "SELECT s FROM SapSystemMonitoring s WHERE s.id = :id")
    , @NamedQuery(name = "SapSystemMonitoring.findByTaskName", query = "SELECT s FROM SapSystemMonitoring s WHERE s.taskName = :taskName")
    , @NamedQuery(name = "SapSystemMonitoring.findByTranscation", query = "SELECT s FROM SapSystemMonitoring s WHERE s.transcation = :transcation")
    , @NamedQuery(name = "SapSystemMonitoring.findByProcedureName", query = "SELECT s FROM SapSystemMonitoring s WHERE s.procedureName = :procedureName")
    , @NamedQuery(name = "SapSystemMonitoring.findByAddedOn", query = "SELECT s FROM SapSystemMonitoring s WHERE s.addedOn = :addedOn")
    , @NamedQuery(name = "SapSystemMonitoring.findByAddedBy", query = "SELECT s FROM SapSystemMonitoring s WHERE s.addedBy = :addedBy")})
public class SapSystemMonitoring implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private BigDecimal id;
    @Size(max = 100)
    @Column(name = "TASK_NAME")
    private String taskName;
    @Size(max = 500)
    @Column(name = "TRANSCATION")
    private String transcation;
    @Size(max = 1000)
    @Column(name = "PROCEDURE_NAME")
    private String procedureName;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "ADDED_BY")
    private int addedBy;
    @OneToMany(mappedBy = "sapMoId", fetch = FetchType.EAGER)
    private List<ApmSapMonitoringUpdate> apmSapMonitoringUpdateList;

    public SapSystemMonitoring() {
    }

    public SapSystemMonitoring(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTranscation() {
        return transcation;
    }

    public void setTranscation(String transcation) {
        this.transcation = transcation;
    }

    public String getProcedureName() {
        return procedureName;
    }

    public void setProcedureName(String procedureName) {
        this.procedureName = procedureName;
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

    @XmlTransient
    public List<ApmSapMonitoringUpdate> getApmSapMonitoringUpdateList() {
        return apmSapMonitoringUpdateList;
    }

    public void setApmSapMonitoringUpdateList(List<ApmSapMonitoringUpdate> apmSapMonitoringUpdateList) {
        this.apmSapMonitoringUpdateList = apmSapMonitoringUpdateList;
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
        if (!(object instanceof SapSystemMonitoring)) {
            return false;
        }
        SapSystemMonitoring other = (SapSystemMonitoring) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.monitoring.SapSystemMonitoring[ id=" + id + " ]";
    }
    
}
