/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.meeting;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author vanithaalliraj
 */
@Entity
@Table(name = "APM_MEETING_PARTICIPANTS", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmMeetingParticipants.findAll", query = "SELECT a FROM ApmMeetingParticipants a")
    , @NamedQuery(name = "ApmMeetingParticipants.findById", query = "SELECT a FROM ApmMeetingParticipants a WHERE a.id = :id")
    , @NamedQuery(name = "ApmMeetingParticipants.deleteMeetingId", query = "DELETE FROM ApmMeetingParticipants a WHERE a.meetingId.meetingId = :meetingId")
    , @NamedQuery(name = "ApmMeetingParticipants.findByParticipant", query = "SELECT a FROM ApmMeetingParticipants a WHERE a.participant = :participant")})
public class ApmMeetingParticipants implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PARTICIPANT")
    private Integer participant;
    @JoinColumn(name = "MEETING_ID", referencedColumnName = "MEETING_ID")
    @ManyToOne(optional = false)
    private ApmMeetings meetingId;

    public ApmMeetingParticipants() {
    }

    public ApmMeetingParticipants(Integer id) {
        this.id = id;
    }

    public ApmMeetingParticipants(Integer id, Integer participant) {
        this.id = id;
        this.participant = participant;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParticipant() {
        return participant;
    }

    public void setParticipant(Integer participant) {
        this.participant = participant;
    }

    public ApmMeetings getMeetingId() {
        return meetingId;
    }

    public void setMeetingId(ApmMeetings meetingId) {
        this.meetingId = meetingId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ApmMeetingParticipants)) {
            return false;
        }
        ApmMeetingParticipants other = (ApmMeetingParticipants) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

   
   
}
