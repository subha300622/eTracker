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
@Table(name = "SAP_MATRIX_PARAMETER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SapMatrixParameter.findAll", query = "SELECT s FROM SapMatrixParameter s")
    , @NamedQuery(name = "SapMatrixParameter.findById", query = "SELECT s FROM SapMatrixParameter s WHERE s.id = :id")
    , @NamedQuery(name = "SapMatrixParameter.findByMatrixIdNparamId", query = "SELECT s FROM SapMatrixParameter s WHERE s.matrixId = :matrixId and s.parameterId= :parameterId and s.companyCode=:companyCode")
    , @NamedQuery(name = "SapMatrixParameter.findByIsActive", query = "SELECT s FROM SapMatrixParameter s WHERE s.isActive = :isActive")
    , @NamedQuery(name = "SapMatrixParameter.findByAddedOn", query = "SELECT s FROM SapMatrixParameter s WHERE s.addedOn = :addedOn")
    , @NamedQuery(name = "SapMatrixParameter.findByAddedBy", query = "SELECT s FROM SapMatrixParameter s WHERE s.addedBy = :addedBy")})
public class SapMatrixParameter implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Column(name = "IS_ACTIVE")
    private int isActive;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;
    @Column(name = "ADDED_BY")
    private Integer addedBy;
    @Column(name = "MATRIX_ID")
    private int matrixId;
    @Column(name = "PARAMETER_ID")
    private int parameterId;
    @Column(name = "COMPANY_CODE")
    private Integer companyCode;
    @Column(name = "UPDATED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedOn;
    @Column(name = "UPDATED_BY")
    private Integer updatedBy;

    
    public SapMatrixParameter() {
    }

    public SapMatrixParameter(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
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

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 37 * hash + this.id;
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
        final SapMatrixParameter other = (SapMatrixParameter) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    public int getMatrixId() {
        return matrixId;
    }

    public void setMatrixId(int matrixId) {
        this.matrixId = matrixId;
    }

    public int getParameterId() {
        return parameterId;
    }

    public void setParameterId(int parameterId) {
        this.parameterId = parameterId;
    }

    public Integer getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(Integer companyCode) {
        this.companyCode = companyCode;
    }

    public Date getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(Date updatedOn) {
        this.updatedOn = updatedOn;
    }

    public Integer getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(Integer updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    

    @Override
    public String toString() {
        return "com.eminent.server.SapMatrixParameter[ id=" + id + " ]";
    }

}
