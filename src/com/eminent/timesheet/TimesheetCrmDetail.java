/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.timesheet;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
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
 * @author QSERVER
 */
@Entity
@Table(name = "TIMESHEET_CRM_DETAIL")
@NamedQueries({
    @NamedQuery(name = "TimesheetCrmDetail.findAll", query = "SELECT t FROM TimesheetCrmDetail t")
    , @NamedQuery(name = "TimesheetCrmDetail.findByTimeCrmId", query = "SELECT t FROM TimesheetCrmDetail t WHERE t.timeCrmId = :timeCrmId")
    , @NamedQuery(name = "TimesheetCrmDetail.findByTimesheetid", query = "SELECT t FROM TimesheetCrmDetail t WHERE t.timesheetid = :timesheetid")
    , @NamedQuery(name = "TimesheetCrmDetail.findByReferenceid", query = "SELECT t FROM TimesheetCrmDetail t WHERE t.referenceid = :referenceid")
    , @NamedQuery(name = "TimesheetCrmDetail.findByCrmType", query = "SELECT t FROM TimesheetCrmDetail t WHERE t.crmType = :crmType")})
public class TimesheetCrmDetail implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "TIME_CRM_ID")
    private BigDecimal timeCrmId;
    @Column(name = "TIMESHEETID")
    private String timesheetid;
    @Column(name = "REFERENCEID")
    private Integer referenceid;
    @Size(max = 20)
    @Column(name = "CRM_TYPE")
    private String crmType;

    public TimesheetCrmDetail() {
    }

    public TimesheetCrmDetail(BigDecimal timeCrmId) {
        this.timeCrmId = timeCrmId;
    }

    public BigDecimal getTimeCrmId() {
        return timeCrmId;
    }

    public void setTimeCrmId(BigDecimal timeCrmId) {
        this.timeCrmId = timeCrmId;
    }

    public String getTimesheetid() {
        return timesheetid;
    }

    public void setTimesheetid(String timesheetid) {
        this.timesheetid = timesheetid;
    }

    public Integer getReferenceid() {
        return referenceid;
    }

    public void setReferenceid(Integer referenceid) {
        this.referenceid = referenceid;
    }

    public String getCrmType() {
        return crmType;
    }

    public void setCrmType(String crmType) {
        this.crmType = crmType;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (timeCrmId != null ? timeCrmId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TimesheetCrmDetail)) {
            return false;
        }
        TimesheetCrmDetail other = (TimesheetCrmDetail) object;
        if ((this.timeCrmId == null && other.timeCrmId != null) || (this.timeCrmId != null && !this.timeCrmId.equals(other.timeCrmId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.timesheet.TimesheetCrmDetail[ timeCrmId=" + timeCrmId + " ]";
    }
    
}
