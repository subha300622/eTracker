/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.sapserver;

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
 * @author vanithaalliraj
 */
@Entity
@Table(name = "APM_SAP_VPN_DETAIL")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapVpnDetail.findAll", query = "SELECT a FROM ApmSapVpnDetail a")
    , @NamedQuery(name = "ApmSapVpnDetail.findById", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapVpnDetail.findByPid", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.pid = :pid")
    , @NamedQuery(name = "ApmSapVpnDetail.findByVpnUrl", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.vpnUrl = :vpnUrl")
    , @NamedQuery(name = "ApmSapVpnDetail.findByVpnServer", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.vpnServer = :vpnServer")
    , @NamedQuery(name = "ApmSapVpnDetail.findByVpnPort", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.vpnPort = :vpnPort")
    , @NamedQuery(name = "ApmSapVpnDetail.findByVpnUname", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.vpnUname = :vpnUname")
    , @NamedQuery(name = "ApmSapVpnDetail.findByVpnPwd", query = "SELECT a FROM ApmSapVpnDetail a WHERE a.vpnPwd = :vpnPwd")})
public class ApmSapVpnDetail implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Integer id;
    @Column(name = "PID")
    private Integer pid;
    @Size(max = 100)
    @Column(name = "VPN_URL")
    private String vpnUrl;
    @Size(max = 50)
    @Column(name = "VPN_SERVER")
    private String vpnServer;
    @Column(name = "VPN_PORT")
    private Integer vpnPort;
    @Size(max = 30)
    @Column(name = "VPN_UNAME")
    private String vpnUname;
    @Size(max = 30)
    @Column(name = "VPN_PWD")
    private String vpnPwd;

    public ApmSapVpnDetail() {
    }

    public ApmSapVpnDetail(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getVpnUrl() {
        return vpnUrl;
    }

    public void setVpnUrl(String vpnUrl) {
        this.vpnUrl = vpnUrl;
    }

    public String getVpnServer() {
        return vpnServer;
    }

    public void setVpnServer(String vpnServer) {
        this.vpnServer = vpnServer;
    }

    public Integer getVpnPort() {
        return vpnPort;
    }

    public void setVpnPort(Integer vpnPort) {
        this.vpnPort = vpnPort;
    }

    public String getVpnUname() {
        return vpnUname;
    }

    public void setVpnUname(String vpnUname) {
        this.vpnUname = vpnUname;
    }

    public String getVpnPwd() {
        return vpnPwd;
    }

    public void setVpnPwd(String vpnPwd) {
        this.vpnPwd = vpnPwd;
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
        if (!(object instanceof ApmSapVpnDetail)) {
            return false;
        }
        ApmSapVpnDetail other = (ApmSapVpnDetail) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.sapserver.ApmSapVpnDetail[ id=" + id + " ]";
    }
    
}
