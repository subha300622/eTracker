/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.timesheet;

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
@Table(name = "TIMESHEET_MAINTANANCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TimesheetMaintanance.findAll", query = "SELECT t FROM TimesheetMaintanance t ORDER BY t.requester")
    , @NamedQuery(name = "TimesheetMaintanance.findById", query = "SELECT t FROM TimesheetMaintanance t WHERE t.id = :id")
    , @NamedQuery(name = "TimesheetMaintanance.findByRequester", query = "SELECT t FROM TimesheetMaintanance t WHERE t.requester = :requester")
    , @NamedQuery(name = "TimesheetMaintanance.findByUserid", query = "SELECT t FROM TimesheetMaintanance t WHERE t.accountsApprover = :userid or t.reimbursementApprover = :userid")
    , @NamedQuery(name = "TimesheetMaintanance.findByNeedinfoApprover", query = "SELECT t FROM TimesheetMaintanance t WHERE t.needinfoApprover = :needinfoApprover")
    , @NamedQuery(name = "TimesheetMaintanance.findByTimesheetApprover", query = "SELECT t FROM TimesheetMaintanance t WHERE t.timesheetApprover = :timesheetApprover")
    , @NamedQuery(name = "TimesheetMaintanance.findByAttendanceApprover", query = "SELECT t FROM TimesheetMaintanance t WHERE t.attendanceApprover = :attendanceApprover")
    , @NamedQuery(name = "TimesheetMaintanance.findByAccountsApprover", query = "SELECT t FROM TimesheetMaintanance t WHERE t.accountsApprover = :accountsApprover")
    , @NamedQuery(name = "TimesheetMaintanance.findByReimbursementApprover", query = "SELECT t FROM TimesheetMaintanance t WHERE t.reimbursementApprover = :reimbursementApprover")
    , @NamedQuery(name = "TimesheetMaintanance.findByCreatedon", query = "SELECT t FROM TimesheetMaintanance t WHERE t.createdon = :createdon")
    , @NamedQuery(name = "TimesheetMaintanance.findByModifiedon", query = "SELECT t FROM TimesheetMaintanance t WHERE t.modifiedon = :modifiedon")})
public class TimesheetMaintanance implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "REQUESTER")
    private Integer requester;
    @Column(name = "NEEDINFO_APPROVER")
    private Integer needinfoApprover;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TIMESHEET_APPROVER")
    private Integer timesheetApprover;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ATTENDANCE_APPROVER")
    private Integer attendanceApprover;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ACCOUNTS_APPROVER")
    private Integer accountsApprover;
    @Basic(optional = false)
    @NotNull
    @Column(name = "REIMBURSEMENT_APPROVER")
    private Integer reimbursementApprover;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdon;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODIFIEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedon;

    public TimesheetMaintanance() {
    }

    public TimesheetMaintanance(long id) {
        this.id = id;
    }

    public TimesheetMaintanance(long id, Integer requester, Integer timesheetApprover, Integer attendanceApprover, Integer accountsApprover, Integer reimbursementApprover, Date createdon, Date modifiedon) {
        this.id = id;
        this.requester = requester;
        this.timesheetApprover = timesheetApprover;
        this.attendanceApprover = attendanceApprover;
        this.accountsApprover = accountsApprover;
        this.reimbursementApprover = reimbursementApprover;
        this.createdon = createdon;
        this.modifiedon = modifiedon;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Integer getRequester() {
        return requester;
    }

    public void setRequester(Integer requester) {
        this.requester = requester;
    }

    public Integer getNeedinfoApprover() {
        return needinfoApprover;
    }

    public void setNeedinfoApprover(Integer needinfoApprover) {
        this.needinfoApprover = needinfoApprover;
    }

    public Integer getTimesheetApprover() {
        return timesheetApprover;
    }

    public void setTimesheetApprover(Integer timesheetApprover) {
        this.timesheetApprover = timesheetApprover;
    }

    public Integer getAttendanceApprover() {
        return attendanceApprover;
    }

    public void setAttendanceApprover(Integer attendanceApprover) {
        this.attendanceApprover = attendanceApprover;
    }

    public Integer getAccountsApprover() {
        return accountsApprover;
    }

    public void setAccountsApprover(Integer accountsApprover) {
        this.accountsApprover = accountsApprover;
    }

    public Integer getReimbursementApprover() {
        return reimbursementApprover;
    }

    public void setReimbursementApprover(Integer reimbursementApprover) {
        this.reimbursementApprover = reimbursementApprover;
    }

    public Date getCreatedon() {
        return createdon;
    }

    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }

    public Date getModifiedon() {
        return modifiedon;
    }

    public void setModifiedon(Date modifiedon) {
        this.modifiedon = modifiedon;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 37 * hash + (int) (this.id ^ (this.id >>> 32));
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
        final TimesheetMaintanance other = (TimesheetMaintanance) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "TimesheetMaintanance{" + "id=" + id + ", requester=" + requester + ", needinfoApprover=" + needinfoApprover + ", timesheetApprover=" + timesheetApprover + ", attendanceApprover=" + attendanceApprover + ", accountsApprover=" + accountsApprover + ", reimbursementApprover=" + reimbursementApprover + ", createdon=" + createdon + ", modifiedon=" + modifiedon + '}';
    }

  
}
