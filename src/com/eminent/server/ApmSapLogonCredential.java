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
 * @author DhanVa CompuTers
 */
@Entity
@Table(name = "APM_SAP_LOGON_CREDENTIAL")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapLogonCredential.findAll", query = "SELECT a FROM ApmSapLogonCredential a")
    , @NamedQuery(name = "ApmSapLogonCredential.findById", query = "SELECT a FROM ApmSapLogonCredential a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapLogonCredential.findByMId", query = "SELECT a FROM ApmSapLogonCredential a WHERE a.mId = :mId")
    , @NamedQuery(name = "ApmSapLogonCredential.findByMIdComp", query = "SELECT a FROM ApmSapLogonCredential a WHERE a.mId = :mId and a.companyCode=:companyCode")
    , @NamedQuery(name = "ApmSapLogonCredential.findByModuleIdNMId", query = "SELECT a FROM ApmSapLogonCredential a WHERE a.mId = :mId and a.moduleId = :moduleId")
})
public class ApmSapLogonCredential implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Column(name = "M_ID")
    private int mId;
    @Column(name = "CLINET_NO")
    private int clinetNo;
    @Column(name = "MODULE_ID")
    private int moduleId;
    @Size(max = 30)
    @Column(name = "UNAME")
    private String uname;
    @Size(max = 30)
    @Column(name = "PWD")
    private String pwd;
    @Column(name = "ADDED_BY")
    private int addedBy;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "COMPANY_CODE")
    private Integer companyCode;


    public ApmSapLogonCredential() {
    }

    public ApmSapLogonCredential(int id) {
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

    public int getClinetNo() {
        return clinetNo;
    }

    public void setClinetNo(int clinetNo) {
        this.clinetNo = clinetNo;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public int getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(int addedBy) {
        this.addedBy = addedBy;
    }

    public Date getAddedOn() {
        return addedOn;
    }

    public void setAddedOn(Date addedOn) {
        this.addedOn = addedOn;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 89 * hash + this.id;
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
        final ApmSapLogonCredential other = (ApmSapLogonCredential) obj;
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
        return "com.eminent.server.ApmSapLogonCredential[ id=" + id + " ]";
    }
    
}
