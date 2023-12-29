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
@Table(name = "SAP_SYSTEM_TYPE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SapSystemType.findAll", query = "SELECT s FROM SapSystemType s order by s.sId")
    , @NamedQuery(name = "SapSystemType.findBySId", query = "SELECT s FROM SapSystemType s WHERE s.sId = :sId")
    , @NamedQuery(name = "SapSystemType.findBySName", query = "SELECT s FROM SapSystemType s WHERE s.sName = :sName")
    , @NamedQuery(name = "SapSystemType.findByAddedon", query = "SELECT s FROM SapSystemType s WHERE s.addedon = :addedon")
    , @NamedQuery(name = "SapSystemType.findByAddedby", query = "SELECT s FROM SapSystemType s WHERE s.addedby = :addedby")})
public class SapSystemType implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "S_ID")
    private int sId;
    @Size(max = 50)
    @Column(name = "S_NAME")
    private String sName;
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    private Integer addedby;


    public SapSystemType() {
    }

    public SapSystemType(int sId) {
        this.sId = sId;
    }

    public int getSId() {
        return sId;
    }

    public void setSId(int sId) {
        this.sId = sId;
    }

    public String getSName() {
        return sName;
    }

    public void setSName(String sName) {
        this.sName = sName;
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
        int hash = 7;
        hash = 23 * hash + this.sId;
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
        final SapSystemType other = (SapSystemType) obj;
        if (this.sId != other.sId) {
            return false;
        }
        return true;
    }

   
    @Override
    public String toString() {
        return "com.eminent.server.SapSystemType[ sId=" + sId + " ]";
    }
    
}
