/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import java.io.Serializable;
import java.math.BigDecimal;
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
 * @author RN.Khans
 */
@Entity
@Table(name = "PM_PERFORMANCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PmPerformance.findAll", query = "SELECT p FROM PmPerformance p"),
    @NamedQuery(name = "PmPerformance.findByDateRangeByBranch", query = "SELECT p FROM PmPerformance p WHERE p.startdate = :startdate and p.enddate = :enddate and p.branchId=:branchId"),
    @NamedQuery(name = "PmPerformance.findByDateRange", query = "SELECT p FROM PmPerformance p WHERE p.startdate = :startdate and p.enddate = :enddate")})
public class PmPerformance implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private Integer pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PMID")
    private Integer pmid;
    @Column(name = "BRANCH_ID")
    private Integer branchId;

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "STARTDATE")
    @Temporal(TemporalType.DATE)
    private Date startdate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ENDDATE")
    @Temporal(TemporalType.DATE)
    private Date enddate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdon;
    public PmPerformance() {
    }

    public PmPerformance(Integer id) {
        this.id = id;
    }

    public PmPerformance(long id, Date startdate, Date enddate, Integer pid, Integer pmid, Date createdon) {
        this.id = id;
        this.startdate = startdate;
        this.enddate = enddate;
        this.pid = pid;
        this.pmid = pmid;
        this.createdon = createdon;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }


    public Date getCreatedon() {
        return createdon;
    }

    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }

    @Override
    public String toString() {
        return "PmPerformance{" + "id=" + id + ",  startdate=" + startdate + ", enddate=" + enddate + ", pid=" + pid + ", pmid=" + pmid + ", createdOn=" + createdon + '}';
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getPmid() {
        return pmid;
    }

    public void setPmid(Integer pmid) {
        this.pmid = pmid;
    }

    public Integer getBranchId() {
        return branchId;
    }

    public void setBranchId(Integer branchId) {
        this.branchId = branchId;
    }

}
