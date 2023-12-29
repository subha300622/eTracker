/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.meeting;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author vanithaalliraj
 */
@Entity
@Table(name = "APM_MEETINGS", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmMeetings.findAll", query = "SELECT a FROM ApmMeetings a")
    , @NamedQuery(name = "ApmMeetings.findByCreatedBy", query = "SELECT a FROM ApmMeetings a WHERE a.createdBy = :createdBy")
    , @NamedQuery(name = "ApmMeetings.findByModifiedOn", query = "SELECT a FROM ApmMeetings a WHERE a.modifiedOn = :modifiedOn")
    , @NamedQuery(name = "ApmMeetings.findByCreatedOn", query = "SELECT a FROM ApmMeetings a WHERE a.createdOn = :createdOn")
    , @NamedQuery(name = "ApmMeetings.findByMeetingId", query = "SELECT a FROM ApmMeetings a WHERE a.meetingId = :meetingId")
    , @NamedQuery(name = "ApmMeetings.findByPid", query = "SELECT a FROM ApmMeetings a WHERE a.pid = :pid")
    , @NamedQuery(name = "ApmMeetings.findByHeldOn", query = "SELECT a FROM ApmMeetings a WHERE a.heldOn = :heldOn")
    , @NamedQuery(name = "ApmMeetings.findByHeldAt", query = "SELECT a FROM ApmMeetings a WHERE a.heldAt = :heldAt")
    , @NamedQuery(name = "ApmMeetings.findByStartTime", query = "SELECT a FROM ApmMeetings a WHERE a.startTime = :startTime")
    , @NamedQuery(name = "ApmMeetings.findByEndTime", query = "SELECT a FROM ApmMeetings a WHERE a.endTime = :endTime")
    , @NamedQuery(name = "ApmMeetings.findBySubject", query = "SELECT a FROM ApmMeetings a WHERE a.subject = :subject")
    , @NamedQuery(name = "ApmMeetings.findByDiscussion", query = "SELECT a FROM ApmMeetings a WHERE a.discussion = :discussion")})
public class ApmMeetings implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATED_BY")
    private Integer createdBy;
    @Column(name = "MODIFIED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "MEETING_ID")
    private Integer meetingId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private Integer pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "HELD_ON")
    @Temporal(TemporalType.DATE)
    private Date heldOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "HELD_AT")
    private Integer heldAt;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "START_TIME")
    private String startTime;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "END_TIME")
    private String endTime;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "SUBJECT")
    private String subject;
    
    @Size(min = 1, max = 4000)
    @Column(name = "DISCUSSION")
    private String discussion;
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = ApmMeetingParticipants.class,  mappedBy = "meetingId")
     List<ApmMeetingParticipants> apmMeetingParticipantsList = new ArrayList<ApmMeetingParticipants>(0);

    public ApmMeetings() {
    }

    public ApmMeetings(Integer meetingId) {
        this.meetingId = meetingId;
    }

    public ApmMeetings(Integer meetingId, Integer createdBy, Date createdOn, Integer pid, Date heldOn, Integer heldAt, String startTime, String endTime, String subject, String discussion) {
        this.meetingId = meetingId;
        this.createdBy = createdBy;
        this.createdOn = createdOn;
        this.pid = pid;
        this.heldOn = heldOn;
        this.heldAt = heldAt;
        this.startTime = startTime;
        this.endTime = endTime;
        this.subject = subject;
        this.discussion = discussion;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Date getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(Date modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Integer getMeetingId() {
        return meetingId;
    }

    public void setMeetingId(Integer meetingId) {
        this.meetingId = meetingId;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Date getHeldOn() {
        return heldOn;
    }

    public void setHeldOn(Date heldOn) {
        this.heldOn = heldOn;
    }

    public Integer getHeldAt() {
        return heldAt;
    }

    public void setHeldAt(Integer heldAt) {
        this.heldAt = heldAt;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDiscussion() {
        return discussion;
    }

    public void setDiscussion(String discussion) {
        this.discussion = discussion;
    }

    @XmlTransient
    public List<ApmMeetingParticipants> getApmMeetingParticipantsList() {
        return apmMeetingParticipantsList;
    }

    public void setApmMeetingParticipantsList(List<ApmMeetingParticipants> apmMeetingParticipantsList) {
        this.apmMeetingParticipantsList = apmMeetingParticipantsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (meetingId != null ? meetingId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ApmMeetings)) {
            return false;
        }
        ApmMeetings other = (ApmMeetings) object;
        if ((this.meetingId == null && other.meetingId != null) || (this.meetingId != null && !this.meetingId.equals(other.meetingId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ApmMeetings{" + "createdBy=" + createdBy + ", modifiedOn=" + modifiedOn + ", createdOn=" + createdOn + ", meetingId=" + meetingId + ", pid=" + pid + ", heldOn=" + heldOn + ", heldAt=" + heldAt + ", startTime=" + startTime + ", endTime=" + endTime + ", subject=" + subject + ", discussion=" + discussion + ", apmMeetingParticipantsList=" + apmMeetingParticipantsList + '}';
    }

 
}
