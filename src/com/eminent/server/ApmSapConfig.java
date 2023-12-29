/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author DhanVa CompuTers
 */
@Entity
@Table(name = "APM_SAP_CONFIG")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapConfig.findAll", query = "SELECT a FROM ApmSapConfig a")
    , @NamedQuery(name = "ApmSapConfig.findById", query = "SELECT a FROM ApmSapConfig a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapConfig.findByMId", query = "SELECT a FROM ApmSapConfig a WHERE a.mId = :mId")
    , @NamedQuery(name = "ApmSapConfig.findByOsName", query = "SELECT a FROM ApmSapConfig a WHERE a.osName = :osName")
    , @NamedQuery(name = "ApmSapConfig.findByErpVersion", query = "SELECT a FROM ApmSapConfig a WHERE a.erpVersion = :erpVersion")
    , @NamedQuery(name = "ApmSapConfig.findByEhpVersion", query = "SELECT a FROM ApmSapConfig a WHERE a.ehpVersion = :ehpVersion")
    , @NamedQuery(name = "ApmSapConfig.findByDbVersion", query = "SELECT a FROM ApmSapConfig a WHERE a.dbVersion = :dbVersion")})
public class ApmSapConfig implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Column(name = "M_ID")
    private int mId;
    @Size(max = 100)
    @Column(name = "OS_NAME")
    private String osName;
    @Size(max = 100)
    @Column(name = "ERP_VERSION")
    private String erpVersion;
    @Size(max = 100)
    @Column(name = "EHP_VERSION")
    private String ehpVersion;
    @Size(max = 100)
    @Column(name = "DB_VERSION")
    private String dbVersion;
    @Column(name = "COMPANY_CODE")
    private Integer companyCode;

    public ApmSapConfig() {
    }

    public ApmSapConfig(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMId() {
        return mId;
    }

    public void setMId(int mId) {
        this.mId = mId;
    }

    public String getOsName() {
        return osName;
    }

    public void setOsName(String osName) {
        this.osName = osName;
    }

    public String getErpVersion() {
        return erpVersion;
    }

    public void setErpVersion(String erpVersion) {
        this.erpVersion = erpVersion;
    }

    public String getEhpVersion() {
        return ehpVersion;
    }

    public void setEhpVersion(String ehpVersion) {
        this.ehpVersion = ehpVersion;
    }

    public String getDbVersion() {
        return dbVersion;
    }

    public void setDbVersion(String dbVersion) {
        this.dbVersion = dbVersion;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + this.id;
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
        final ApmSapConfig other = (ApmSapConfig) obj;
        if (this.id != other.id) {
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
        return "com.eminent.server.ApmSapConfig[ id=" + id + " ]";
    }
    
}
