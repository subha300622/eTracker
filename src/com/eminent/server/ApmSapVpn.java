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
@Table(name = "APM_SAP_VPN")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapVpn.findAll", query = "SELECT a FROM ApmSapVpn a")
    , @NamedQuery(name = "ApmSapVpn.findById", query = "SELECT a FROM ApmSapVpn a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapVpn.findByPid", query = "SELECT a FROM ApmSapVpn a WHERE a.pid = :pid")
  })
public class ApmSapVpn implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Column(name = "PID")
    private int pid;
    @Size(max = 50)
    @Column(name = "V_IP_ADD")
    private String vIpAdd;
    @Column(name = "V_PORT")
    private int vPort;
    @Size(max = 30)
    @Column(name = "V_UNAME")
    private String vUname;
    @Size(max = 30)
    @Column(name = "V_PWD")
    private String vPwd;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "ADDED_BY")
    private int addedBy;
    @Size(max = 1000)
    @Column(name = "V_NAME")
    private String vName;

    public ApmSapVpn() {
    }

    public ApmSapVpn(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getVIpAdd() {
        return vIpAdd;
    }

    public void setVIpAdd(String vIpAdd) {
        this.vIpAdd = vIpAdd;
    }

    public int getVPort() {
        return vPort;
    }

    public void setVPort(int vPort) {
        this.vPort = vPort;
    }

    public String getVUname() {
        return vUname;
    }

    public void setVUname(String vUname) {
        this.vUname = vUname;
    }

    public String getVPwd() {
        return vPwd;
    }

    public void setVPwd(String vPwd) {
        this.vPwd = vPwd;
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

    public String getVName() {
        return vName;
    }

    public void setVName(String vName) {
        this.vName = vName;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 53 * hash + this.id;
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
        final ApmSapVpn other = (ApmSapVpn) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }


    @Override
    public String toString() {
        return "com.eminent.server.ApmSapVpn[ id=" + id + " ]";
    }
    
}
