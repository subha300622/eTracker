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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author DhanVa CompuTers
 */
@Entity
@Table(name = "APM_SAP_LOGON_MAINTAIN")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapLogonMaintain.findAll", query = "SELECT a FROM ApmSapLogonMaintain a")
    , @NamedQuery(name = "ApmSapLogonMaintain.findByPid", query = "SELECT a FROM ApmSapLogonMaintain a WHERE a.pid = :pid")
    , @NamedQuery(name = "ApmSapLogonMaintain.findByUserid", query = "SELECT a FROM ApmSapLogonMaintain a WHERE a.userid = :userid")})
public class ApmSapLogonMaintain implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private int pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "USERID")
    private int userid;

    public ApmSapLogonMaintain() {
    }

    public ApmSapLogonMaintain(int pid) {
        this.pid = pid;
    }

    public ApmSapLogonMaintain(int pid, int userid) {
        this.pid = pid;
        this.userid = userid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 11 * hash + this.pid;
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
        final ApmSapLogonMaintain other = (ApmSapLogonMaintain) obj;
        if (this.pid != other.pid) {
            return false;
        }
        return true;
    }

    
    
    @Override
    public String toString() {
        return "com.eminent.server.ApmSapLogonMaintain[ pid=" + pid + " ]";
    }
    
}
