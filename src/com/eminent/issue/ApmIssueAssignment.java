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
@Table(name = "APM_ISSUE_ASSIGNMENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmIssueAssignment.findAll", query = "SELECT a FROM ApmIssueAssignment a")
    , @NamedQuery(name = "ApmIssueAssignment.findByPid", query = "SELECT a FROM ApmIssueAssignment a WHERE a.pid = :pid")
    , @NamedQuery(name = "ApmIssueAssignment.findByAssignType", query = "SELECT a FROM ApmIssueAssignment a WHERE a.assignType = :assignType")
    , @NamedQuery(name = "ApmIssueAssignment.findByUserType", query = "SELECT a FROM ApmIssueAssignment a WHERE a.userType = :userType")
    , @NamedQuery(name = "ApmIssueAssignment.findByAddedby", query = "SELECT a FROM ApmIssueAssignment a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "ApmIssueAssignment.findByAddedon", query = "SELECT a FROM ApmIssueAssignment a WHERE a.addedon = :addedon")
    , @NamedQuery(name = "ApmIssueAssignment.findByDays", query = "SELECT a FROM ApmIssueAssignment a WHERE a.days = :days")})
public class ApmIssueAssignment implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private int pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ASSIGN_TYPE")
    private int assignType;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "USER_TYPE")
    private String userType;
    @Column(name = "ADDEDBY")
    private int addedby;
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Basic(optional = false)
    @NotNull
    @Column(name = "DAYS")
    private int days;

    public ApmIssueAssignment() {
    }

    public ApmIssueAssignment(int pid) {
        this.pid = pid;
    }

    public ApmIssueAssignment(int pid, int assignType, String userType, int days) {
        this.pid = pid;
        this.assignType = assignType;
        this.userType = userType;
        this.days = days;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getAssignType() {
        return assignType;
    }

    public void setAssignType(int assignType) {
        this.assignType = assignType;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public int getAddedby() {
        return addedby;
    }

    public void setAddedby(int addedby) {
        this.addedby = addedby;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public int getDays() {
        return days;
    }

    public void setDays(int days) {
        this.days = days;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + this.pid;
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
        final ApmIssueAssignment other = (ApmIssueAssignment) obj;
        if (this.pid != other.pid) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.ApmIssueAssignment[ pid=" + pid + " ]";
    }
    
}
