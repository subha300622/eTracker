/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.issue;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
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
 * @author Eminent
 */
@Entity
@Table(name = "ISSUE_CATEGORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "IssueCategory_1.findAll", query = "SELECT i FROM IssueCategory_1 i"),
    @NamedQuery(name = "IssueCategory_1.findById", query = "SELECT i FROM IssueCategory_1 i WHERE i.id = :id"),
    @NamedQuery(name = "IssueCategory_1.findByCategoryName", query = "SELECT i FROM IssueCategory_1 i WHERE i.categoryName = :categoryName"),
    @NamedQuery(name = "IssueCategory_1.findByPid", query = "SELECT i FROM IssueCategory_1 i WHERE i.pid = :pid"),
    @NamedQuery(name = "IssueCategory_1.findByAddedon", query = "SELECT i FROM IssueCategory_1 i WHERE i.addedon = :addedon"),
    @NamedQuery(name = "IssueCategory_1.findByAddedby", query = "SELECT i FROM IssueCategory_1 i WHERE i.addedby = :addedby")})
public class IssueCategory_1 implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private BigDecimal id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "CATEGORY_NAME")
    private String categoryName;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private BigInteger pid;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "ADDEDBY")
    private BigInteger addedby;

    public IssueCategory_1() {
    }

    public IssueCategory_1(BigDecimal id) {
        this.id = id;
    }

    public IssueCategory_1(BigDecimal id, String categoryName, BigInteger pid) {
        this.id = id;
        this.categoryName = categoryName;
        this.pid = pid;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public BigInteger getPid() {
        return pid;
    }

    public void setPid(BigInteger pid) {
        this.pid = pid;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
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
        if (!(object instanceof IssueCategory_1)) {
            return false;
        }
        IssueCategory_1 other = (IssueCategory_1) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.IssueCategory_1[ id=" + id + " ]";
    }
    
}
