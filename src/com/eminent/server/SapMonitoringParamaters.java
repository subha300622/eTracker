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
@Table(name = "SAP_MONITORING_PARAMATERS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SapMonitoringParamaters.findAll", query = "SELECT s FROM SapMonitoringParamaters s order by s.parameterId")
    , @NamedQuery(name = "SapMonitoringParamaters.findByServerId", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.serverId = :serverId ORDER BY s.parameterId")
    , @NamedQuery(name = "SapMonitoringParamaters.findByServerIdNParameter", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.serverId = :serverId and s.parameterName=:parameterName")
    , @NamedQuery(name = "SapMonitoringParamaters.findByParameterId", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.parameterId = :parameterId")
    , @NamedQuery(name = "SapMonitoringParamaters.findByParameterName", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.parameterName = :parameterName")
    , @NamedQuery(name = "SapMonitoringParamaters.findByParameterType", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.parameterType = :parameterType")
    , @NamedQuery(name = "SapMonitoringParamaters.findByParameterValues", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.parameterValues = :parameterValues")
    , @NamedQuery(name = "SapMonitoringParamaters.findByAddedOn", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.addedOn = :addedOn")
    , @NamedQuery(name = "SapMonitoringParamaters.findByAddedBy", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.addedBy = :addedBy")
    , @NamedQuery(name = "SapMonitoringParamaters.findByUpdateOn", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.updateOn = :updateOn")
    , @NamedQuery(name = "SapMonitoringParamaters.findByUpdateBy", query = "SELECT s FROM SapMonitoringParamaters s WHERE s.updateBy = :updateBy")})
public class SapMonitoringParamaters implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PARAMETER_ID")
    private int parameterId;
    @Size(max = 500)
    @Column(name = "PARAMETER_NAME")
    private String parameterName;
    @Size(max = 20)
    @Column(name = "PARAMETER_TYPE")
    private String parameterType;
    @Size(max = 200)
    @Column(name = "PARAMETER_VALUES")
    private String parameterValues;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "ADDED_BY")
    private Integer addedBy;
    @Column(name = "UPDATE_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateOn;
    @Column(name = "UPDATE_BY")
    private Integer updateBy;
    @Column(name = "SERVER_ID")
    private int serverId;
    

    public SapMonitoringParamaters() {
    }

    public SapMonitoringParamaters(int parameterId) {
        this.parameterId = parameterId;
    }

    public int getParameterId() {
        return parameterId;
    }

    public void setParameterId(int parameterId) {
        this.parameterId = parameterId;
    }

    public String getParameterName() {
        return parameterName;
    }

    public void setParameterName(String parameterName) {
        this.parameterName = parameterName;
    }

    public String getParameterType() {
        return parameterType;
    }

    public void setParameterType(String parameterType) {
        this.parameterType = parameterType;
    }

    public String getParameterValues() {
        return parameterValues;
    }

    public void setParameterValues(String parameterValues) {
        this.parameterValues = parameterValues;
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

    public Date getUpdateOn() {
        return updateOn;
    }

    public void setUpdateOn(Date updateOn) {
        this.updateOn = updateOn;
    }

    public int getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(int updateBy) {
        this.updateBy = updateBy;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 29 * hash + this.parameterId;
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
        final SapMonitoringParamaters other = (SapMonitoringParamaters) obj;
        if (this.parameterId != other.parameterId) {
            return false;
        }
        return true;
    }
  
    
  
    
    @Override
    public String toString() {
        return "com.eminent.server.SapMonitoringParamaters[ parameterId=" + parameterId + " ]";
    }

}
