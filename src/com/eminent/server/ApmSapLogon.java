/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
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
@Table(name = "APM_SAP_LOGON")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapLogon.findAll", query = "SELECT a FROM ApmSapLogon a")
    , @NamedQuery(name = "ApmSapLogon.findById", query = "SELECT a FROM ApmSapLogon a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapLogon.findByMId", query = "SELECT a FROM ApmSapLogon a WHERE a.mId = :mId")
    , @NamedQuery(name = "ApmSapLogon.findByAppServer", query = "SELECT a FROM ApmSapLogon a WHERE a.appServer = :appServer")
    , @NamedQuery(name = "ApmSapLogon.findByInstNo", query = "SELECT a FROM ApmSapLogon a WHERE a.instNo = :instNo")
    , @NamedQuery(name = "ApmSapLogon.findBySId", query = "SELECT a FROM ApmSapLogon a WHERE a.sId = :sId")
    , @NamedQuery(name = "ApmSapLogon.findByRoutStr", query = "SELECT a FROM ApmSapLogon a WHERE a.routStr = :routStr")
    , @NamedQuery(name = "ApmSapLogon.findByAddedOn", query = "SELECT a FROM ApmSapLogon a WHERE a.addedOn = :addedOn")
    , @NamedQuery(name = "ApmSapLogon.findByAddedBy", query = "SELECT a FROM ApmSapLogon a WHERE a.addedBy = :addedBy")})
public class ApmSapLogon implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Column(name = "M_ID")
    private int mId;
    @Column(name = "APP_SERVER")
    private String appServer;
    @Column(name = "INST_NO")
    private int instNo;
    @Column(name = "S_ID")
    private String sId;
    @Column(name = "ROUT_STR")
    private String routStr;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "ADDED_BY")
    private int addedBy;
    @Column(name = "COMPANY_CODE")
    private Integer companyCode;

    public ApmSapLogon() {
    }

    public ApmSapLogon(int id) {
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

    public String getAppServer() {
        return appServer;
    }

    public void setAppServer(String appServer) {
        this.appServer = appServer;
    }

    public int getInstNo() {
        return instNo;
    }

    public void setInstNo(int instNo) {
        this.instNo = instNo;
    }

    public String getSId() {
        return sId;
    }

    public void setSId(String sId) {
        this.sId = sId;
    }

    public String getRoutStr() {
        return routStr;
    }

    public void setRoutStr(String routStr) {
        this.routStr = routStr;
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

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 37 * hash + this.id;
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
        final ApmSapLogon other = (ApmSapLogon) obj;
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
        return "com.eminent.server.ApmSapLogon[ id=" + id + " ]";
    }
    
}
