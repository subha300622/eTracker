/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
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
 * @author Muthu
 */
@Entity
@Table(name = "WRM_MAIL_MAINTENANCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "WrmMailMaintenance.findAll", query = "SELECT w FROM WrmMailMaintenance w"),
    @NamedQuery(name = "WrmMailMaintenance.findByWrmMailId", query = "SELECT w FROM WrmMailMaintenance w WHERE w.wrmMailId = :wrmMailId"),
    @NamedQuery(name = "WrmMailMaintenance.findByPid", query = "SELECT w FROM WrmMailMaintenance w WHERE w.pid = :pid"),
    @NamedQuery(name = "WrmMailMaintenance.findByUserid", query = "SELECT w FROM WrmMailMaintenance w WHERE w.userid = :userid")})
public class WrmMailMaintenance implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "WRM_MAIL_ID")
    private long wrmMailId;
    @Column(name = "PID")
    private Long pid;
    @Column(name = "USERID")
    private Long userid;

    public WrmMailMaintenance() {
    }

    public WrmMailMaintenance(long wrmMailId) {
        this.wrmMailId = wrmMailId;
    }

    public WrmMailMaintenance(long wrmMailId, Long pid, Long userid) {
        this.wrmMailId = wrmMailId;
        this.pid = pid;
        this.userid = userid;
    }

    public WrmMailMaintenance(Long pid, Long userid) {
        this.pid = pid;
        this.userid = userid;
    }
    

    public long getWrmMailId() {
        return wrmMailId;
    }

    public void setWrmMailId(long wrmMailId) {
        this.wrmMailId = wrmMailId;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 43 * hash + (int) (this.wrmMailId ^ (this.wrmMailId >>> 32));
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final WrmMailMaintenance other = (WrmMailMaintenance) obj;
        if (this.wrmMailId != other.wrmMailId) {
            return false;
        }
        return true;
    }

    
}
