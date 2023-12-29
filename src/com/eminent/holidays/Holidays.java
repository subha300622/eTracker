/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.holidays;

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
 * @author E0288
 */
@Entity
@Table(name = "HOLIDAYS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Holidays.findAll", query = "SELECT h FROM Holidays h"),
    @NamedQuery(name = "Holidays.findByHolidayId", query = "SELECT h FROM Holidays h WHERE h.holidayId = :holidayId"),
    @NamedQuery(name = "Holidays.findByHolidayName", query = "SELECT h FROM Holidays h WHERE h.holidayName = :holidayName"),
    @NamedQuery(name = "Holidays.findByHolidayDate", query = "SELECT h FROM Holidays h WHERE h.holidayDate = :holidayDate"),
    @NamedQuery(name = "Holidays.findByHolidayDateByBranch", query = "SELECT h FROM Holidays h WHERE h.holidayDate = :holidayDate and h.branchId=:branch"),
    @NamedQuery(name = "Holidays.findBetweenHolidayDate", query = "SELECT h FROM Holidays h WHERE h.holidayDate = :start OR h.holidayDate = :end"),
    @NamedQuery(name = "Holidays.findBetweenHolidayDateByBranch", query = "SELECT h FROM Holidays h WHERE h.holidayDate = :start OR h.holidayDate = :end and h.branchId=:branch"),
    @NamedQuery(name = "Holidays.findByUniqueHoliday", query = "SELECT h FROM Holidays h WHERE h.holidayDate = :holidayDate and UPPER(h.holidayName) =:holidayName and h.branchId = :branchId"),
    @NamedQuery(name = "Holidays.findCalendarYearHolidays", query = "SELECT h FROM Holidays h WHERE h.holidayDate between :startDate and :endDate order by h.branchId,h.holidayDate"),
    @NamedQuery(name = "Holidays.findCalendarYearHolidaysByBranch", query = "SELECT h FROM Holidays h WHERE h.holidayDate between :startDate and :endDate and h.branchId = :branchId order by h.holidayDate"),
    @NamedQuery(name = "Holidays.findByCreatedon", query = "SELECT h FROM Holidays h WHERE h.createdon = :createdon"),
    @NamedQuery(name = "Holidays.findByModifiedon", query = "SELECT h FROM Holidays h WHERE h.modifiedon = :modifiedon")})
public class Holidays implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "HOLIDAY_ID")
    private long holidayId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "HOLIDAY_NAME")
    private String holidayName;
    @Basic(optional = false)
    @NotNull
    @Column(name = "HOLIDAY_DATE")
    @Temporal(TemporalType.DATE)
    private Date holidayDate;
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
  @Column(name = "BRANCH_ID")
    private Integer branchId;
  
    public Holidays() {
    }

    public Holidays(long holidayId) {
        this.holidayId = holidayId;
    }

    public Holidays( String holidayName, Date holidayDate, Date createdon, Date modifiedon,int branchId) {
        this.holidayName = holidayName;
        this.holidayDate = holidayDate;
        this.createdon = createdon;
        this.modifiedon = modifiedon;
        this.branchId   =   branchId;
    }
  
    public long getHolidayId() {
        return holidayId;
    }

    public void setHolidayId(long holidayId) {
        this.holidayId = holidayId;
    }

    public String getHolidayName() {
        return holidayName;
    }

    public void setHolidayName(String holidayName) {
        this.holidayName = holidayName;
    }

    public Date getHolidayDate() {
        return holidayDate;
    }

    public void setHolidayDate(Date holidayDate) {
        this.holidayDate = holidayDate;
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

    public Integer getBranchId() {
        return branchId;
    }

    public void setBranchId(Integer branchId) {
        this.branchId = branchId;
    }

   
    @Override
    public String toString() {
        return "com.eminent.holidays.Holidays[ holidayId=" + holidayId + " ]";
    }
    
}
