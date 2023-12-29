/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

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
 * @author QSERVER
 */
@Entity
@Table(name = "APM_TARGET_ISSUE_COUNT", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmTargetIssueCount.findAll", query = "SELECT a FROM ApmTargetIssueCount a"),
    @NamedQuery(name = "ApmTargetIssueCount.findByTid", query = "SELECT a FROM ApmTargetIssueCount a WHERE a.tid = :tid"),
    @NamedQuery(name = "ApmTargetIssueCount.findByPid", query = "SELECT a FROM ApmTargetIssueCount a WHERE a.pid = :pid"),
    @NamedQuery(name = "ApmTargetIssueCount.findByTargetDate", query = "SELECT a FROM ApmTargetIssueCount a WHERE a.targetDate = :targetDate"),
    @NamedQuery(name = "ApmTargetIssueCount.findByCount", query = "SELECT a FROM ApmTargetIssueCount a WHERE a.count = :count")})
public class ApmTargetIssueCount implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "TID")
    private long tid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private int pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TARGET_DATE")
    @Temporal(TemporalType.DATE)
    private Date targetDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COUNT")
    private int count;

    public ApmTargetIssueCount() {
    }

    public ApmTargetIssueCount(long tid) {
        this.tid = tid;
    }

    public ApmTargetIssueCount(long tid, int pid, Date targetDate, int count) {
        this.tid = tid;
        this.pid = pid;
        this.targetDate = targetDate;
        this.count = count;
    }

    public long getTid() {
        return tid;
    }

    public void setTid(long tid) {
        this.tid = tid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public Date getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(Date targetDate) {
        this.targetDate = targetDate;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

   
    @Override
    public String toString() {
        return "com.pack.ApmTargetIssueCount[ tid=" + tid + " ]";
    }
    
}
