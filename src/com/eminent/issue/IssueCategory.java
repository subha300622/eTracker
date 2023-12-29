/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

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
@Table(name = "ISSUE_CATEGORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "IssueCategory.findAll", query = "SELECT i FROM IssueCategory i")
    , @NamedQuery(name = "IssueCategory.findById", query = "SELECT i FROM IssueCategory i WHERE i.id = :id")
    , @NamedQuery(name = "IssueCategory.findByCategoryName", query = "SELECT i FROM IssueCategory i WHERE i.categoryName = :categoryName")
    , @NamedQuery(name = "IssueCategory.findByPIDCategoryName", query = "SELECT i FROM IssueCategory i WHERE i.pid = :pid AND i.categoryName = :categoryName")
    , @NamedQuery(name = "IssueCategory.findByPid", query = "SELECT i FROM IssueCategory i WHERE i.pid = :pid")
    , @NamedQuery(name = "IssueCategory.findByAddedon", query = "SELECT i FROM IssueCategory i WHERE i.addedon = :addedon")
    , @NamedQuery(name = "IssueCategory.findByAddedby", query = "SELECT i FROM IssueCategory i WHERE i.addedby = :addedby")})
public class IssueCategory implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private int id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "CATEGORY_NAME")
    private String categoryName;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private int pid;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "ADDEDBY")
    private int addedby;

    public IssueCategory() {
    }

    public IssueCategory(int id) {
        this.id = id;
    }

    public IssueCategory(int id, String categoryName, int pid) {
        this.id = id;
        this.categoryName = categoryName;
        this.pid = pid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
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
        hash = 47 * hash + this.id;
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
        final IssueCategory other = (IssueCategory) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

   
    
    @Override
    public String toString() {
        return "com.eminent.issue.IssueCategory[ id=" + id + " ]";
    }
    
}
