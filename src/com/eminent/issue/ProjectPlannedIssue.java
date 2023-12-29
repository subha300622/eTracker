/*
 * To change this template, choose Tools | Templates
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

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "PROJECT_PlANNED_ISSUE")
@NamedQueries({
    @NamedQuery(name = "ProjectPlannedIssue.findAll", query = "SELECT p FROM ProjectPlannedIssue p"),
    @NamedQuery(name = "ProjectPlannedIssue.findByPlannedOnAndProjectId", query = "SELECT p FROM ProjectPlannedIssue p WHERE p.pId =:pId AND p.plannedOn = :plannedOn ORDER BY p.sino"),
    @NamedQuery(name = "ProjectPlannedIssue.findByIssuesPlannedOnAndProjectId", query = "SELECT p.issueId FROM ProjectPlannedIssue p WHERE p.pId =:pId AND p.plannedOn = :plannedOn AND p.status=:status ORDER BY p.sino"),
    @NamedQuery(name = "ProjectPlannedIssue.findUniqueProjectPlan", query = "SELECT ppi FROM ProjectPlannedIssue ppi WHERE ppi.pId =:pId AND ppi.issueId=:issueId and ppi.plannedOn=:plannedOn ORDER BY ppi.sino"),
    @NamedQuery(name = "ProjectPlannedIssue.findAllByPlannedOn", query = "SELECT p FROM ProjectPlannedIssue p WHERE  p.plannedOn = :plannedOn AND p.status=:status ORDER BY p.sino"),
    @NamedQuery(name = "ProjectPlannedIssue.findByPlannedOn", query = "SELECT p.issueId FROM ProjectPlannedIssue p WHERE p.plannedOn =:plannedOn AND p.status=:status ORDER BY p.sino")})
public class ProjectPlannedIssue implements Serializable {

    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private long pId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ISSUEID")
    private String issueId;
    @Column(name = "PLANNEDBY")
    private Integer plannedBy;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PLANNEDON")
    @Temporal(TemporalType.DATE)
    private Date plannedOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODIFIEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedOn;
    @NotNull
    @Column(name = "STATUS")
    private String status;
    @Column(name = "SINO")
    private Integer sino;

    public ProjectPlannedIssue() {
    }

    public ProjectPlannedIssue(long pId, String issueId, Integer plannedBy, Date plannedOn, Date createdOn, Date modifiedOn, String status) {
        this.pId = pId;
        this.issueId = issueId;
        this.plannedBy = plannedBy;
        this.plannedOn = plannedOn;
        this.modifiedOn = modifiedOn;
        this.status = status;
        this.createdOn = createdOn;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getpId() {
        return pId;
    }

    public void setpId(long pId) {
        this.pId = pId;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public Integer getPlannedBy() {
        return plannedBy;
    }

    public void setPlannedBy(Integer plannedBy) {
        this.plannedBy = plannedBy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPlannedOn() {
        return plannedOn;
    }

    public void setPlannedOn(Date plannedOn) {
        this.plannedOn = plannedOn;
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

    public Integer getSino() {
        return sino;
    }

    public void setSino(Integer sino) {
        this.sino = sino;
    }

    @Override
    public String toString() {
        return "ProjectPlannedIssue{" + "id=" + id + ", pId=" + pId + ", issueId=" + issueId + ", plannedBy=" + plannedBy + ", plannedOn=" + plannedOn + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn + ", status=" + status + '}';
    }

}
