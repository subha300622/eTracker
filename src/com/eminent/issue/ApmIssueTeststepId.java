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
 * @author Muthu
 */
@Entity
@Table(name = "APM_ISSUE_TESTSTEP_ID", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmIssueTeststepId.findAll", query = "SELECT a FROM ApmIssueTeststepId a"),
    @NamedQuery(name = "ApmIssueTeststepId.findBySno", query = "SELECT a FROM ApmIssueTeststepId a WHERE a.sno = :sno"),
    @NamedQuery(name = "ApmIssueTeststepId.findByPid", query = "SELECT a FROM ApmIssueTeststepId a WHERE a.pid = :pid"),
    @NamedQuery(name = "ApmIssueTeststepId.findByTeststepId", query = "SELECT a FROM ApmIssueTeststepId a WHERE a.teststepId = :teststepId"),
    @NamedQuery(name = "ApmIssueTeststepId.findByIssueId", query = "SELECT a FROM ApmIssueTeststepId a WHERE a.issueId = :issueId"),
    @NamedQuery(name = "ApmIssueTeststepId.findByCreatedon", query = "SELECT a FROM ApmIssueTeststepId a WHERE a.createdon = :createdon"),
    @NamedQuery(name = "ApmIssueTeststepId.findByCreatedby", query = "SELECT a FROM ApmIssueTeststepId a WHERE a.createdby = :createdby")})
public class ApmIssueTeststepId implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "SNO")
    private long sno;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private int pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TESTSTEP_ID")
    private int teststepId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "ISSUE_ID")
    private String issueId;
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdon;
    @Column(name = "CREATEDBY")
    private int createdby;

    public ApmIssueTeststepId() {
    }

    public ApmIssueTeststepId(long sno) {
        this.sno = sno;
    }

    public ApmIssueTeststepId(long sno, int pid, int teststepId, String issueId) {
        this.sno = sno;
        this.pid = pid;
        this.teststepId = teststepId;
        this.issueId = issueId;
    }

    public long getSno() {
        return sno;
    }

    public void setSno(long sno) {
        this.sno = sno;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getTeststepId() {
        return teststepId;
    }

    public void setTeststepId(int teststepId) {
        this.teststepId = teststepId;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public Date getCreatedon() {
        return createdon;
    }

    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }

    public int getCreatedby() {
        return createdby;
    }

    public void setCreatedby(int createdby) {
        this.createdby = createdby;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.ApmIssueTeststepId[ sno=" + sno + " ]";
    }
    
}
