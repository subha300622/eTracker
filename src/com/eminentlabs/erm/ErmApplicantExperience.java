/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import java.io.Serializable;
import java.math.BigDecimal;
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
 * @author Muthu
 */
@Entity
@Table(name = "ERM_APPLICANT_EXPERIENCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErmApplicantExperience.findAll", query = "SELECT e FROM ErmApplicantExperience e"),
    @NamedQuery(name = "ErmApplicantExperience.findByExperienceId", query = "SELECT e FROM ErmApplicantExperience e WHERE e.experienceId = :experienceId"),
    @NamedQuery(name = "ErmApplicantExperience.findByCurrentEmployer", query = "SELECT e FROM ErmApplicantExperience e WHERE e.currentEmployer = :currentEmployer"),
    @NamedQuery(name = "ErmApplicantExperience.findByCurrentCtc", query = "SELECT e FROM ErmApplicantExperience e WHERE e.currentCtc = :currentCtc"),
    @NamedQuery(name = "ErmApplicantExperience.findByCurrentDoj", query = "SELECT e FROM ErmApplicantExperience e WHERE e.currentDoj = :currentDoj"),
    @NamedQuery(name = "ErmApplicantExperience.findByCurrentDesignation", query = "SELECT e FROM ErmApplicantExperience e WHERE e.currentDesignation = :currentDesignation"),
    @NamedQuery(name = "ErmApplicantExperience.findByCurrentRole", query = "SELECT e FROM ErmApplicantExperience e WHERE e.currentRole = :currentRole"),
    @NamedQuery(name = "ErmApplicantExperience.findByRelievingDate", query = "SELECT e FROM ErmApplicantExperience e WHERE e.relievingDate = :relievingDate"),
    @NamedQuery(name = "ErmApplicantExperience.findByJobProfile", query = "SELECT e FROM ErmApplicantExperience e WHERE e.jobProfile = :jobProfile")})
public class ErmApplicantExperience implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "EXPERIENCE_ID")
    private BigDecimal experienceId;
    @Size(max = 50)
    @Column(name = "CURRENT_EMPLOYER")
    private String currentEmployer;
    @Size(max = 50)
    @Column(name = "CURRENT_CTC")
    private String currentCtc;
    @Column(name = "CURRENT_DOJ")
    @Temporal(TemporalType.DATE)
    private Date currentDoj;
    @Size(max = 50)
    @Column(name = "CURRENT_DESIGNATION")
    private String currentDesignation;
    @Size(max = 50)
    @Column(name = "CURRENT_ROLE")
    private String currentRole;
    @Column(name = "RELIEVING_DATE")
    @Temporal(TemporalType.DATE)
    private Date relievingDate;
    @Size(max = 50)
    @Column(name = "JOB_PROFILE")
    private String jobProfile;

    public ErmApplicantExperience() {
    }

    public ErmApplicantExperience(BigDecimal experienceId) {
        this.experienceId = experienceId;
    }

    public BigDecimal getExperienceId() {
        return experienceId;
    }

    public void setExperienceId(BigDecimal experienceId) {
        this.experienceId = experienceId;
    }

    public String getCurrentEmployer() {
        return currentEmployer;
    }

    public void setCurrentEmployer(String currentEmployer) {
        this.currentEmployer = currentEmployer;
    }

    public String getCurrentCtc() {
        return currentCtc;
    }

    public void setCurrentCtc(String currentCtc) {
        this.currentCtc = currentCtc;
    }

    public Date getCurrentDoj() {
        return currentDoj;
    }

    public void setCurrentDoj(Date currentDoj) {
        this.currentDoj = currentDoj;
    }

    public String getCurrentDesignation() {
        return currentDesignation;
    }

    public void setCurrentDesignation(String currentDesignation) {
        this.currentDesignation = currentDesignation;
    }

    public String getCurrentRole() {
        return currentRole;
    }

    public void setCurrentRole(String currentRole) {
        this.currentRole = currentRole;
    }

    public Date getRelievingDate() {
        return relievingDate;
    }

    public void setRelievingDate(Date relievingDate) {
        this.relievingDate = relievingDate;
    }

    public String getJobProfile() {
        return jobProfile;
    }

    public void setJobProfile(String jobProfile) {
        this.jobProfile = jobProfile;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (experienceId != null ? experienceId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ErmApplicantExperience)) {
            return false;
        }
        ErmApplicantExperience other = (ErmApplicantExperience) object;
        if ((this.experienceId == null && other.experienceId != null) || (this.experienceId != null && !this.experienceId.equals(other.experienceId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.erm.ErmApplicantExperience[ experienceId=" + experienceId + " ]";
    }
    
}
