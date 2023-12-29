/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

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
@Table(name = "SEND_MOM_MAINTENANCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SendMomMaintenance.findAll", query = "SELECT s FROM SendMomMaintenance s")
    , @NamedQuery(name = "SendMomMaintenance.findById", query = "SELECT s FROM SendMomMaintenance s WHERE s.id = :id")
    , @NamedQuery(name = "SendMomMaintenance.deleteById", query = "DELETE FROM SendMomMaintenance s WHERE s.id = :id")
    , @NamedQuery(name = "SendMomMaintenance.findByUserId", query = "SELECT s FROM SendMomMaintenance s WHERE s.userId = :userId")
    , @NamedQuery(name = "SendMomMaintenance.findByBranchId", query = "SELECT s FROM SendMomMaintenance s WHERE s.branchId = :branchId")
    , @NamedQuery(name = "SendMomMaintenance.findByMomType", query = "SELECT s FROM SendMomMaintenance s WHERE s.momType = :momType")
    , @NamedQuery(name = "SendMomMaintenance.findByAddedon", query = "SELECT s FROM SendMomMaintenance s WHERE s.addedon = :addedon")
    , @NamedQuery(name = "SendMomMaintenance.findByAddedby", query = "SELECT s FROM SendMomMaintenance s WHERE s.addedby = :addedby")})
public class SendMomMaintenance implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Integer id;
    @Column(name = "USER_ID")
    private Integer userId;
    @Column(name = "BRANCH_ID")
    private Integer branchId;
    @Column(name = "MOM_TYPE")
    private Integer momType;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "ADDEDBY")
    private Integer addedby;

    public SendMomMaintenance() {
    }

    public SendMomMaintenance(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getBranchId() {
        return branchId;
    }

    public void setBranchId(Integer branchId) {
        this.branchId = branchId;
    }

    public Integer getMomType() {
        return momType;
    }

    public void setMomType(Integer momType) {
        this.momType = momType;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public Integer getAddedby() {
        return addedby;
    }

    public void setAddedby(Integer addedby) {
        this.addedby = addedby;
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
        if (!(object instanceof SendMomMaintenance)) {
            return false;
        }
        SendMomMaintenance other = (SendMomMaintenance) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.SendMomMaintenance[ id=" + id + " ]";
    }
    
}
