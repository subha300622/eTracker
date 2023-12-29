/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.sapserver;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author vanithaalliraj
 */
@Entity
@Table(name = "APM_SAP_SYSTEM_TYPE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapSystemType.findAll", query = "SELECT a FROM ApmSapSystemType a")
    , @NamedQuery(name = "ApmSapSystemType.findById", query = "SELECT a FROM ApmSapSystemType a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapSystemType.findByServerName", query = "SELECT a FROM ApmSapSystemType a WHERE a.serverName = :serverName")
    , @NamedQuery(name = "ApmSapSystemType.findByAppSer", query = "SELECT a FROM ApmSapSystemType a WHERE a.appSer = :appSer")
    , @NamedQuery(name = "ApmSapSystemType.findByInstanceId", query = "SELECT a FROM ApmSapSystemType a WHERE a.instanceId = :instanceId")
    , @NamedQuery(name = "ApmSapSystemType.findBySId", query = "SELECT a FROM ApmSapSystemType a WHERE a.sId = :sId")
    , @NamedQuery(name = "ApmSapSystemType.findBySapString", query = "SELECT a FROM ApmSapSystemType a WHERE a.sapString = :sapString")})
public class ApmSapSystemType implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "SERVER_NAME")
    private String serverName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "APP_SER")
    private String appSer;
    @Column(name = "INSTANCE_ID")
    private Integer instanceId;
    @Size(max = 3)
    @Column(name = "S_ID")
    private String sId;
    @Size(max = 50)
    @Column(name = "SAP_STRING")
    private String sapString;
    @OneToMany(mappedBy = "typeId", fetch = FetchType.EAGER)
    private List<ApmSapClients> apmSapClientsList;
    @JoinColumn(name = "SERVER_ID", referencedColumnName = "SERVER_ID")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ApmSapServer serverId;

    public ApmSapSystemType() {
    }

    public ApmSapSystemType(Integer id) {
        this.id = id;
    }

    public ApmSapSystemType(Integer id, String serverName, String appSer) {
        this.id = id;
        this.serverName = serverName;
        this.appSer = appSer;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getAppSer() {
        return appSer;
    }

    public void setAppSer(String appSer) {
        this.appSer = appSer;
    }

    public Integer getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(Integer instanceId) {
        this.instanceId = instanceId;
    }

    public String getSId() {
        return sId;
    }

    public void setSId(String sId) {
        this.sId = sId;
    }

    public String getSapString() {
        return sapString;
    }

    public void setSapString(String sapString) {
        this.sapString = sapString;
    }

    @XmlTransient
    public List<ApmSapClients> getApmSapClientsList() {
        return apmSapClientsList;
    }

    public void setApmSapClientsList(List<ApmSapClients> apmSapClientsList) {
        this.apmSapClientsList = apmSapClientsList;
    }

    public ApmSapServer getServerId() {
        return serverId;
    }

    public void setServerId(ApmSapServer serverId) {
        this.serverId = serverId;
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
        if (!(object instanceof ApmSapSystemType)) {
            return false;
        }
        ApmSapSystemType other = (ApmSapSystemType) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.sapserver.ApmSapSystemType[ id=" + id + " ]";
    }
    
}
