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
@Table(name = "SAP_MATRIX_PARAM_UPDATES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SapMatrixParamUpdates.findAll", query = "SELECT s FROM SapMatrixParamUpdates s")
    , @NamedQuery(name = "SapMatrixParamUpdates.findById", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.id = :id")
    , @NamedQuery(name = "SapMatrixParamUpdates.findByStatusDate", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.statusDate = :statusDate")
    , @NamedQuery(name = "SapMatrixParamUpdates.findByAddedon", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.addedon = :addedon")
    , @NamedQuery(name = "SapMatrixParamUpdates.findByAddedby", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "SapMatrixParamUpdates.findByUpdatedon", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.updatedon = :updatedon")
    , @NamedQuery(name = "SapMatrixParamUpdates.findByUpdatedby", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "SapMatrixParamUpdates.findByParamStatus", query = "SELECT s FROM SapMatrixParamUpdates s WHERE s.paramStatus = :paramStatus")})
public class SapMatrixParamUpdates implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Column(name = "STATUS_DATE")
    @Temporal(TemporalType.DATE)
    private Date statusDate;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "ADDEDBY")
    private Integer addedby;
    @Column(name = "UPDATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedon;
    @Column(name = "UPDATEDBY")
    private Integer updatedby;
    @Size(max = 1000)
    @Column(name = "PARAM_STATUS")
    private String paramStatus;
    @Column(name = "MATRIX_PARAM_ID")
    private int matrixParamId;

    public SapMatrixParamUpdates() {
    }

    public SapMatrixParamUpdates(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(Date statusDate) {
        this.statusDate = statusDate;
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

    public Date getUpdatedon() {
        return updatedon;
    }

    public void setUpdatedon(Date updatedon) {
        this.updatedon = updatedon;
    }

    public int getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(int updatedby) {
        this.updatedby = updatedby;
    }

    public String getParamStatus() {
        return paramStatus;
    }

    public void setParamStatus(String paramStatus) {
        this.paramStatus = paramStatus;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 89 * hash + this.id;
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
        final SapMatrixParamUpdates other = (SapMatrixParamUpdates) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    public int getMatrixParamId() {
        return matrixParamId;
    }

    public void setMatrixParamId(int matrixParamId) {
        this.matrixParamId = matrixParamId;
    }

    @Override
    public String toString() {
        return "com.eminent.server.SapMatrixParamUpdates[ id=" + id + " ]";
    }

}
