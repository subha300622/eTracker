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
 * @author vanithaalliraj
 */
@Entity
@Table(name = "SAP_SERVER_TYPE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SapServerType.findAll", query = "SELECT s FROM SapServerType s ORDER BY s.id")
    , @NamedQuery(name = "SapServerType.findBySId", query = "SELECT s FROM SapServerType s WHERE s.sId = :sId")
    , @NamedQuery(name = "SapServerType.findByServerName", query = "SELECT s FROM SapServerType s WHERE s.serverName = :serverName")
    , @NamedQuery(name = "SapServerType.findByAddedon", query = "SELECT s FROM SapServerType s WHERE s.addedon = :addedon")
    , @NamedQuery(name = "SapServerType.findByAddedby", query = "SELECT s FROM SapServerType s WHERE s.addedby = :addedby")})
public class SapServerType implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "S_ID")
    private int sId;
    @Size(max = 30)
    @Column(name = "SERVER_NAME")
    private String serverName;
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    private Integer addedby;
    
    public SapServerType() {
    }

    public SapServerType(int sId) {
        this.sId = sId;
    }

    public int getSId() {
        return sId;
    }

    public void setSId(int sId) {
        this.sId = sId;
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
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

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 71 * hash + this.sId;
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
        final SapServerType other = (SapServerType) obj;
        if (this.sId != other.sId) {
            return false;
        }
        return true;
    }

   
    @Override
    public String toString() {
        return "com.eminent.server.SapServerType[ sId=" + sId + " ]";
    }
    
}
