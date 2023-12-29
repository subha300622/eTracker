/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

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

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "MOM_FOR_CLIENT", catalog = "", schema = "EMINENTTRACKER")
@NamedQueries({
    @NamedQuery(name = "MomForClient.findAll", query = "SELECT m FROM MomForClient m ORDER BY m.createdOn,m.modifiedOn desc"),
    @NamedQuery(name = "MomForClient.findByPid", query = "SELECT m FROM MomForClient m WHERE m.pid=:pid ORDER BY m.createdOn desc,m.modifiedOn desc"),
    @NamedQuery(name = "MomForClient.findRatingsByLastWRM", query = "select m.pid, m.rating, m.feedback, Max(m.createdOn) from MomForClient m group by m.pid,m.rating,m.feedback"),
    @NamedQuery(name = "MomForClient.findMomClientIdByPid", query = "SELECT m.momClientId FROM MomForClient m WHERE m.pid=:pid ORDER BY m.createdOn desc,m.modifiedOn desc"),
    @NamedQuery(name = "MomForClient.findMaxHeldOn", query = "SELECT MAX(m.heldOn) FROM MomForClient m WHERE m.pid=:pid")})
public class MomForClient implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "MOM_CLIENT_ID")
    private Integer momClientId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID", nullable = false)
    private Integer pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "HELD_ON", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date heldOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "HELD_AT", nullable = false)
    private Integer heldAt;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATED_BY", nullable = false)
    private Integer createdBy;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATED_ON", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODIFIED_ON", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "START_TIME", nullable = false)
    private String startTime;
    @Basic(optional = false)
    @NotNull
    @Column(name = "END_TIME", nullable = false)
    private String endTime;
    @NotNull
    @Column(name = "DISCUSSION", nullable = false)
    private String discussion;
    @Column(name = "RATING", nullable = false)
    private String rating;
    @Column(name = "FEEDBACK", nullable = false)
    private String feedback;
    @Column(name = "ESCALATION")
    private String escalation;
    @Column(name = "RESPONSIBLE_PERSON")
    private Integer responsiblePerson;

    @Column(name = "PMANAGER")
    private Integer pmanager;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = MomClientAttendies.class, mappedBy = "momClientId")
    List<MomClientAttendies> momClientAttendiesList = new ArrayList<MomClientAttendies>(0);

    public MomForClient() {
    }

    public MomForClient(Integer momClientId) {
        this.momClientId = momClientId;
    }

    public MomForClient(Integer momClientId, Integer pid, Date heldOn, Integer heldAt, Integer createdBy, Date createdOn, Date modifiedOn, String startTime, String endTime) {
        this.momClientId = momClientId;
        this.pid = pid;
        this.heldOn = heldOn;
        this.heldAt = heldAt;
        this.createdBy = createdBy;
        this.createdOn = createdOn;
        this.modifiedOn = modifiedOn;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public MomForClient(Integer momClientId, Integer pid, Date heldOn, Integer heldAt, Integer createdBy, Date createdOn, Date modifiedOn, String startTime, String endTime, Integer pmanager) {
        this.momClientId = momClientId;
        this.pid = pid;
        this.heldOn = heldOn;
        this.heldAt = heldAt;
        this.createdBy = createdBy;
        this.createdOn = createdOn;
        this.modifiedOn = modifiedOn;
        this.startTime = startTime;
        this.endTime = endTime;
        this.pmanager = pmanager;
    }
    
    

    public Integer getMomClientId() {
        return momClientId;
    }

    public void setMomClientId(Integer momClientId) {
        this.momClientId = momClientId;
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

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Date getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(Date modifiedOn) {
        this.modifiedOn = modifiedOn;
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

    public String getDiscussion() {
        return discussion;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public void setDiscussion(String discussion) {
        this.discussion = discussion;
    }

    public String getEscalation() {
        return escalation;
    }

    public void setEscalation(String escalation) {
        this.escalation = escalation;
    }

    public Integer getResponsiblePerson() {
        return responsiblePerson;
    }

    public void setResponsiblePerson(Integer responsiblePerson) {
        this.responsiblePerson = responsiblePerson;
    }

    public Integer getPmanager() {
        return pmanager;
    }

    public void setPmanager(Integer pmanager) {
        this.pmanager = pmanager;
    }
    
    

    public List<MomClientAttendies> getMomClientAttendiesList() {
        return momClientAttendiesList;
    }

    public void setMomClientAttendiesList(List<MomClientAttendies> momClientAttendiesList) {
        this.momClientAttendiesList = momClientAttendiesList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (momClientId != null ? momClientId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MomForClient)) {
            return false;
        }
        MomForClient other = (MomForClient) object;
        if ((this.momClientId == null && other.momClientId != null) || (this.momClientId != null && !this.momClientId.equals(other.momClientId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.MomForClient[ momClientId=" + momClientId + " ]";
    }
}
