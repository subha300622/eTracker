/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.timesheet;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "TIMESHEET_ISSUE")
@NamedQueries({
    @NamedQuery(name = "TimesheetIssue.findAll", query = "SELECT t FROM TimesheetIssue t"),
    @NamedQuery(name = "TimesheetIssue.findById", query = "SELECT t FROM TimesheetIssue t WHERE t.id = :id"),
    @NamedQuery(name = "TimesheetIssue.findByIssueid", query = "SELECT t FROM TimesheetIssue t WHERE t.issueid = :issueid"),
    @NamedQuery(name = "TimesheetIssue.findByTimeSheetId", query = "SELECT t FROM TimesheetIssue t WHERE t.timeSheetId = :timeSheetId"),
    @NamedQuery(name = "TimesheetIssue.findByWorkstatus", query = "SELECT t FROM TimesheetIssue t WHERE t.workstatus = :workstatus")})
public class TimesheetIssue implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 12)
    @Column(name = "ISSUEID")
    private String issueid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "WORKSTATUS")
    private Integer workstatus;
    @NotNull
    @Column(name = "TIMESHEETID")
    private String timeSheetId;
    
    
    public TimesheetIssue() {
    }

    public TimesheetIssue(Long id) {
        this.id = id;
    }

    public TimesheetIssue(String issueid, Integer workstatus,String timeSheetId) {
        this.issueid = issueid;
        this.workstatus = workstatus;
        this.timeSheetId=timeSheetId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIssueid() {
        return issueid;
    }

    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }

    public Integer getWorkstatus() {
        return workstatus;
    }

    public void setWorkstatus(Integer workstatus) {
        this.workstatus = workstatus;
    }

    public String getTimeSheetId() {
        return timeSheetId;
    }

    public void setTimeSheetId(String timeSheetId) {
        this.timeSheetId = timeSheetId;
    }

    

    @Override
    public String toString() {
        return "com.eminent.timesheet.TimesheetIssue[ id=" + id + " ]";
    }
    
}
