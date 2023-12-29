/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.sapserver;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
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
@Table(name = "APM_SAP_SERVER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapServer.findAll", query = "SELECT a FROM ApmSapServer a")
    , @NamedQuery(name = "ApmSapServer.findByServerId", query = "SELECT a FROM ApmSapServer a WHERE a.serverId = :serverId")
    , @NamedQuery(name = "ApmSapServer.findByPid", query = "SELECT a FROM ApmSapServer a WHERE a.pid = :pid")
    , @NamedQuery(name = "ApmSapServer.findByServerName", query = "SELECT a FROM ApmSapServer a WHERE a.serverName = :serverName")})
public class ApmSapServer implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "SERVER_ID")
    private Integer serverId;
    @Column(name = "PID")
    private Integer pid;
    @Size(max = 30)
    @Column(name = "SERVER_NAME")
    private String serverName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "serverId", fetch = FetchType.EAGER)
    private List<ApmSapSystemType> apmSapSystemTypeList;

    public ApmSapServer() {
    }

    public ApmSapServer(Integer serverId) {
        this.serverId = serverId;
    }

    public Integer getServerId() {
        return serverId;
    }

    public void setServerId(Integer serverId) {
        this.serverId = serverId;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    @XmlTransient
    public List<ApmSapSystemType> getApmSapSystemTypeList() {
        return apmSapSystemTypeList;
    }

    public void setApmSapSystemTypeList(List<ApmSapSystemType> apmSapSystemTypeList) {
        this.apmSapSystemTypeList = apmSapSystemTypeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (serverId != null ? serverId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ApmSapServer)) {
            return false;
        }
        ApmSapServer other = (ApmSapServer) object;
        if ((this.serverId == null && other.serverId != null) || (this.serverId != null && !this.serverId.equals(other.serverId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.sapserver.ApmSapServer[ serverId=" + serverId + " ]";
    }
    
}
