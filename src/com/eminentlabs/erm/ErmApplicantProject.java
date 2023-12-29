/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Muthu
 */
@Entity
@Table(name = "ERM_APPLICANT_PROJECT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErmApplicantProject.findAll", query = "SELECT e FROM ErmApplicantProject e"),
    @NamedQuery(name = "ErmApplicantProject.findByProjectId", query = "SELECT e FROM ErmApplicantProject e WHERE e.projectId = :projectId"),
    @NamedQuery(name = "ErmApplicantProject.findByProjectName", query = "SELECT e FROM ErmApplicantProject e WHERE e.projectName = :projectName"),
    @NamedQuery(name = "ErmApplicantProject.findByDuration", query = "SELECT e FROM ErmApplicantProject e WHERE e.duration = :duration"),
    @NamedQuery(name = "ErmApplicantProject.findByTeamsize", query = "SELECT e FROM ErmApplicantProject e WHERE e.teamsize = :teamsize"),
    @NamedQuery(name = "ErmApplicantProject.findByClient", query = "SELECT e FROM ErmApplicantProject e WHERE e.client = :client"),
    @NamedQuery(name = "ErmApplicantProject.findByEnvironment", query = "SELECT e FROM ErmApplicantProject e WHERE e.environment = :environment"),
    @NamedQuery(name = "ErmApplicantProject.findByDescription", query = "SELECT e FROM ErmApplicantProject e WHERE e.description = :description"),
    @NamedQuery(name = "ErmApplicantProject.findByResponsibilities", query = "SELECT e FROM ErmApplicantProject e WHERE e.responsibilities = :responsibilities")})
public class ErmApplicantProject implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PROJECT_ID")
    private BigDecimal projectId;
    @Size(max = 250)
    @Column(name = "PROJECT_NAME")
    private String projectName;
    @Size(max = 50)
    @Column(name = "DURATION")
    private String duration;
    @Column(name = "TEAMSIZE")
    private BigInteger teamsize;
    @Size(max = 250)
    @Column(name = "CLIENT")
    private String client;
    @Size(max = 250)
    @Column(name = "ENVIRONMENT")
    private String environment;
    @Size(max = 3000)
    @Column(name = "DESCRIPTION")
    private String description;
    @Size(max = 3000)
    @Column(name = "RESPONSIBILITIES")
    private String responsibilities;

    public ErmApplicantProject() {
    }

    public ErmApplicantProject(BigDecimal projectId) {
        this.projectId = projectId;
    }

    public BigDecimal getProjectId() {
        return projectId;
    }

    public void setProjectId(BigDecimal projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public BigInteger getTeamsize() {
        return teamsize;
    }

    public void setTeamsize(BigInteger teamsize) {
        this.teamsize = teamsize;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getResponsibilities() {
        return responsibilities;
    }

    public void setResponsibilities(String responsibilities) {
        this.responsibilities = responsibilities;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (projectId != null ? projectId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ErmApplicantProject)) {
            return false;
        }
        ErmApplicantProject other = (ErmApplicantProject) object;
        if ((this.projectId == null && other.projectId != null) || (this.projectId != null && !this.projectId.equals(other.projectId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.erm.ErmApplicantProject[ projectId=" + projectId + " ]";
    }
    
}
