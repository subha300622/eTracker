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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author vanithaalliraj
 */
@Entity
@Table(name = "SERVER_SYSTEM")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ServerSystem.findAll", query = "SELECT s FROM ServerSystem s ")
    , @NamedQuery(name = "ServerSystem.findAllByPId", query = "SELECT s FROM ServerSystem s WHERE s.pid = :pid ORDER BY s.mId")
    , @NamedQuery(name = "ServerSystem.findByPIdServerNSystem", query = "SELECT s FROM ServerSystem s WHERE s.pid =:pid and s.serverId=:serverId and s.syId=:syId")
    , @NamedQuery(name = "ServerSystem.findByPIdServer", query = "SELECT s FROM ServerSystem s WHERE s.pid =:pid and s.serverId=:serverId and s.isActive=:isActive")
    , @NamedQuery(name = "ServerSystem.findByMId", query = "SELECT s FROM ServerSystem s WHERE s.mId = :mId")
    , @NamedQuery(name = "ServerSystem.findByAddedon", query = "SELECT s FROM ServerSystem s WHERE s.addedon = :addedon")
    , @NamedQuery(name = "ServerSystem.findByAddedby", query = "SELECT s FROM ServerSystem s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "ServerSystem.findByPid", query = "SELECT s FROM ServerSystem s WHERE s.pid = :pid and s.isActive=:isActive ORDER BY s.mId")})
public class ServerSystem implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "M_ID")
    private int mId;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "ADDEDBY")
    private Integer addedby;
    @Column(name = "PID")
    private int pid;
    @Column(name = "SERVER_ID")
    private int serverId;
    @Column(name = "SY_ID")
    private int syId;
    @Column(name = "IS_ACTIVE")
    private int isActive;

    public ServerSystem() {
    }

    public ServerSystem(int mId) {
        this.mId = mId;
    }

    public int getMId() {
        return mId;
    }

    public void setMId(int mId) {
        this.mId = mId;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public int getAddedby() {
        return addedby;
    }

    public void setAddedby(int addedby) {
        this.addedby = addedby;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public int getSyId() {
        return syId;
    }

    public void setSyId(int syId) {
        this.syId = syId;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "ServerSystem{" + "mId=" + mId + ", addedon=" + addedon + ", addedby=" + addedby + ", pid=" + pid + ", serverId=" + serverId + ", syId=" + syId + ", isActive=" + isActive + '}';
    }

   
   
    
}
