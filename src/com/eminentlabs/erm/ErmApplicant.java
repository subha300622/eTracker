/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

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

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "ERM_APPLICANT")
@NamedQueries({
    @NamedQuery(name = "ErmApplicant.findAll", query = "SELECT e FROM ErmApplicant e")
    ,
    @NamedQuery(name = "ErmApplicant.findByAssignedToAndStatus", query = "SELECT e FROM ErmApplicant e WHERE e.assignedto =:assignedto and e.applicantStatus =:applicantStatus ORDER BY e.sapExpYr DESC, e.sapExpMon DESC, e.totalExpYr DESC, e.totalExpMon DESC")
    ,
    @NamedQuery(name = "ErmApplicant.findByStatus", query = "SELECT e FROM ErmApplicant e WHERE  e.applicantStatus =:applicantStatus ORDER BY e.sapExpYr DESC, e.sapExpMon DESC, e.totalExpYr DESC, e.totalExpMon DESC")
    ,
    @NamedQuery(name = "ErmApplicant.findByApplicantId", query = "SELECT e FROM ErmApplicant e WHERE e.applicantId =:applicantId"),})
public class ErmApplicant implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "APPLICANT_ID")
    private String applicantId;
    @Size(max = 50)
    @Column(name = "PASSWORD")
    private String password;
    @Size(max = 100)
    @Column(name = "FIRSTNAME")
    private String firstname;
    @Size(max = 100)
    @Column(name = "LASTNAME")
    private String lastname;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 100)
    @Column(name = "EMAIL")
    private String email;
    @Size(max = 50)
    @Column(name = "REFERENCE_EMPID")
    private String referenceEmpid;
    @Size(max = 100)
    @Column(name = "CURRENT_LOCATION")
    private String currentLocation;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Size(max = 20)
    @Column(name = "PHONE")
    private String phone;
    @Size(max = 20)
    @Column(name = "MOBILE")
    private String mobile;
    @Size(max = 100)
    @Column(name = "UG")
    private String ug;
    @Size(max = 100)
    @Column(name = "UG_BRANCH")
    private String ugBranch;
    @Size(max = 100)
    @Column(name = "UG_INSTITUTE")
    private String ugInstitute;
    @Size(max = 10)
    @Column(name = "UG_YEAR")
    private String ugYear;
    @Size(max = 10)
    @Column(name = "UG_PERCENTAGE")
    private String ugPercentage;
    @Size(max = 100)
    @Column(name = "PG")
    private String pg;
    @Size(max = 100)
    @Column(name = "PG_BRANCH")
    private String pgBranch;
    @Size(max = 100)
    @Column(name = "PG_INSTITUTE")
    private String pgInstitute;
    @Size(max = 10)
    @Column(name = "PG_YEAR")
    private String pgYear;
    @Size(max = 10)
    @Column(name = "PG_PERCENTAGE")
    private String pgPercentage;
    @Column(name = "SAP_EXP_YR")
    private Integer sapExpYr;
    @Column(name = "SAP_EXP_MON")
    private Integer sapExpMon;
    @Column(name = "TOTAL_EXP_YR")
    private Integer totalExpYr;
    @Column(name = "TOTAL_EXP_MON")
    private Integer totalExpMon;
    @Size(max = 100)
    @Column(name = "CORE_COMPETENCE")
    private String coreCompetence;
    @Size(max = 200)
    @Column(name = "AREA_OF_EXPERTISE")
    private String areaOfExpertise;
    @Size(max = 100)
    @Column(name = "LANGUAGES")
    private String languages;
    @Size(max = 100)
    @Column(name = "ERP_PACKAGES")
    private String erpPackages;
    @Size(max = 100)
    @Column(name = "OS")
    private String os;
    @Size(max = 100)
    @Column(name = "DB")
    private String db;
    @Size(max = 100)
    @Column(name = "TOOLS")
    private String tools;
    @Size(max = 20)
    @Column(name = "DESIRED_JOB_TYPE")
    private String desiredJobType;
    @Size(max = 100)
    @Column(name = "DESIRED_POSITION")
    private String desiredPosition;
    @Size(max = 100)
    @Column(name = "DESIRED_LOCATION")
    private String desiredLocation;
    @Column(name = "NOTICE_PERIOD")
    private Integer noticePeriod;
    @Column(name = "EXPECTED_CTC")
    private Integer expectedCtc;
    @Size(max = 100)
    @Column(name = "REFERENCE_NAME")
    private String referenceName;
    @Size(max = 100)
    @Column(name = "REFERENCE_DESIGNATION")
    private String referenceDesignation;
    @Size(max = 100)
    @Column(name = "REFERENCE_ORG")
    private String referenceOrg;
    @Size(max = 100)
    @Column(name = "REFERENCE_ID")
    private String referenceId;
    @Size(max = 50)
    @Column(name = "REFERENCE_COUNTRY_CODE")
    private String referenceCountryCode;
    @Size(max = 50)
    @Column(name = "REFERENCE_STD")
    private String referenceStd;
    @Size(max = 50)
    @Column(name = "REFERENCE_PHONE")
    private String referencePhone;
    @Size(max = 50)
    @Column(name = "REFERENCE_MOBILE")
    private String referenceMobile;
    @Size(max = 100)
    @Column(name = "REFERENCE_EMAIL")
    private String referenceEmail;
    @Size(max = 50)
    @Column(name = "DOB")
    private String dob;
    @Size(max = 50)
    @Column(name = "GENDER")
    private String gender;
    @Size(max = 50)
    @Column(name = "MARITAL_STATUS")
    private String maritalStatus;
    @Size(max = 100)
    @Column(name = "CITY")
    private String city;
    @Size(max = 600)
    @Column(name = "MAILING_ADDRESS")
    private String mailingAddress;
    @Size(max = 50)
    @Column(name = "PINCODE")
    private String pincode;
    @Size(max = 50)
    @Column(name = "PAN_NO")
    private String panNo;
    @Size(max = 50)
    @Column(name = "DRIVING_LIECENCE")
    private String drivingLiecence;
    @Size(max = 50)
    @Column(name = "VOTERID")
    private String voterid;
    @Size(max = 50)
    @Column(name = "PASSPORT_NO")
    private String passportNo;
    @Size(max = 2500)
    @Column(name = "PROFESSIONAL_SUMMARY")
    private String professionalSummary;
    @Column(name = "REGISTEREDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date registeredon;
    @Column(name = "APPLICANT_STATUS")
    private Integer applicantStatus;
    @Column(name = "ASSIGNEDTO")
    private Integer assignedto;
    @Column(name = "APJBOOK")
    private Integer apjBook;
    @Column(name = "WATER")
    private String water;
    @Column(name = "RTI")
    private String rti;
    @Column(name = "RTE")
    private String rte;
    @Column(name = "HABITS")
    private String habits;
    @Column(name = "SOCIAL")
    private String social;
    @Column(name = "ISFAKE")
    private Integer isFake;
    @Column(name = "AADHAAR")
    private String aadhaar;

    public ErmApplicant() {
    }

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getReferenceEmpid() {
        return referenceEmpid;
    }

    public void setReferenceEmpid(String referenceEmpid) {
        this.referenceEmpid = referenceEmpid;
    }

    public String getCurrentLocation() {
        return currentLocation;
    }

    public void setCurrentLocation(String currentLocation) {
        this.currentLocation = currentLocation;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUg() {
        return ug;
    }

    public void setUg(String ug) {
        this.ug = ug;
    }

    public String getUgBranch() {
        return ugBranch;
    }

    public void setUgBranch(String ugBranch) {
        this.ugBranch = ugBranch;
    }

    public String getUgInstitute() {
        return ugInstitute;
    }

    public void setUgInstitute(String ugInstitute) {
        this.ugInstitute = ugInstitute;
    }

    public String getUgYear() {
        return ugYear;
    }

    public void setUgYear(String ugYear) {
        this.ugYear = ugYear;
    }

    public String getUgPercentage() {
        return ugPercentage;
    }

    public void setUgPercentage(String ugPercentage) {
        this.ugPercentage = ugPercentage;
    }

    public String getPg() {
        return pg;
    }

    public void setPg(String pg) {
        this.pg = pg;
    }

    public String getPgBranch() {
        return pgBranch;
    }

    public void setPgBranch(String pgBranch) {
        this.pgBranch = pgBranch;
    }

    public String getPgInstitute() {
        return pgInstitute;
    }

    public void setPgInstitute(String pgInstitute) {
        this.pgInstitute = pgInstitute;
    }

    public String getPgYear() {
        return pgYear;
    }

    public void setPgYear(String pgYear) {
        this.pgYear = pgYear;
    }

    public String getPgPercentage() {
        return pgPercentage;
    }

    public void setPgPercentage(String pgPercentage) {
        this.pgPercentage = pgPercentage;
    }

    public Integer getSapExpYr() {
        return sapExpYr;
    }

    public void setSapExpYr(Integer sapExpYr) {
        this.sapExpYr = sapExpYr;
    }

    public Integer getSapExpMon() {
        return sapExpMon;
    }

    public void setSapExpMon(Integer sapExpMon) {
        this.sapExpMon = sapExpMon;
    }

    public Integer getTotalExpYr() {
        return totalExpYr;
    }

    public void setTotalExpYr(Integer totalExpYr) {
        this.totalExpYr = totalExpYr;
    }

    public Integer getTotalExpMon() {
        return totalExpMon;
    }

    public void setTotalExpMon(Integer totalExpMon) {
        this.totalExpMon = totalExpMon;
    }

    public String getCoreCompetence() {
        return coreCompetence;
    }

    public void setCoreCompetence(String coreCompetence) {
        this.coreCompetence = coreCompetence;
    }

    public String getAreaOfExpertise() {
        return areaOfExpertise;
    }

    public void setAreaOfExpertise(String areaOfExpertise) {
        this.areaOfExpertise = areaOfExpertise;
    }

    public String getLanguages() {
        return languages;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
    }

    public String getErpPackages() {
        return erpPackages;
    }

    public void setErpPackages(String erpPackages) {
        this.erpPackages = erpPackages;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getDb() {
        return db;
    }

    public void setDb(String db) {
        this.db = db;
    }

    public String getTools() {
        return tools;
    }

    public void setTools(String tools) {
        this.tools = tools;
    }

    public String getDesiredJobType() {
        return desiredJobType;
    }

    public void setDesiredJobType(String desiredJobType) {
        this.desiredJobType = desiredJobType;
    }

    public String getDesiredPosition() {
        return desiredPosition;
    }

    public void setDesiredPosition(String desiredPosition) {
        this.desiredPosition = desiredPosition;
    }

    public String getDesiredLocation() {
        return desiredLocation;
    }

    public void setDesiredLocation(String desiredLocation) {
        this.desiredLocation = desiredLocation;
    }

    public Integer getNoticePeriod() {
        return noticePeriod;
    }

    public void setNoticePeriod(Integer noticePeriod) {
        this.noticePeriod = noticePeriod;
    }

    public Integer getExpectedCtc() {
        return expectedCtc;
    }

    public void setExpectedCtc(Integer expectedCtc) {
        this.expectedCtc = expectedCtc;
    }

    public String getReferenceName() {
        return referenceName;
    }

    public void setReferenceName(String referenceName) {
        this.referenceName = referenceName;
    }

    public String getReferenceDesignation() {
        return referenceDesignation;
    }

    public void setReferenceDesignation(String referenceDesignation) {
        this.referenceDesignation = referenceDesignation;
    }

    public String getReferenceOrg() {
        return referenceOrg;
    }

    public void setReferenceOrg(String referenceOrg) {
        this.referenceOrg = referenceOrg;
    }

    public String getReferenceId() {
        return referenceId;
    }

    public void setReferenceId(String referenceId) {
        this.referenceId = referenceId;
    }

    public String getReferenceCountryCode() {
        return referenceCountryCode;
    }

    public void setReferenceCountryCode(String referenceCountryCode) {
        this.referenceCountryCode = referenceCountryCode;
    }

    public String getReferenceStd() {
        return referenceStd;
    }

    public void setReferenceStd(String referenceStd) {
        this.referenceStd = referenceStd;
    }

    public String getReferencePhone() {
        return referencePhone;
    }

    public void setReferencePhone(String referencePhone) {
        this.referencePhone = referencePhone;
    }

    public String getReferenceMobile() {
        return referenceMobile;
    }

    public void setReferenceMobile(String referenceMobile) {
        this.referenceMobile = referenceMobile;
    }

    public String getReferenceEmail() {
        return referenceEmail;
    }

    public void setReferenceEmail(String referenceEmail) {
        this.referenceEmail = referenceEmail;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getMailingAddress() {
        return mailingAddress;
    }

    public void setMailingAddress(String mailingAddress) {
        this.mailingAddress = mailingAddress;
    }

    public String getPincode() {
        return pincode;
    }

    public void setPincode(String pincode) {
        this.pincode = pincode;
    }

    public String getPanNo() {
        return panNo;
    }

    public void setPanNo(String panNo) {
        this.panNo = panNo;
    }

    public String getDrivingLiecence() {
        return drivingLiecence;
    }

    public void setDrivingLiecence(String drivingLiecence) {
        this.drivingLiecence = drivingLiecence;
    }

    public String getVoterid() {
        return voterid;
    }

    public void setVoterid(String voterid) {
        this.voterid = voterid;
    }

    public String getPassportNo() {
        return passportNo;
    }

    public void setPassportNo(String passportNo) {
        this.passportNo = passportNo;
    }

    public String getProfessionalSummary() {
        return professionalSummary;
    }

    public void setProfessionalSummary(String professionalSummary) {
        this.professionalSummary = professionalSummary;
    }

    public Date getRegisteredon() {
        return registeredon;
    }

    public void setRegisteredon(Date registeredon) {
        this.registeredon = registeredon;
    }

    public Integer getApplicantStatus() {
        return applicantStatus;
    }

    public void setApplicantStatus(Integer applicantStatus) {
        this.applicantStatus = applicantStatus;
    }

    public Integer getAssignedto() {
        return assignedto;
    }

    public void setAssignedto(Integer assignedto) {
        this.assignedto = assignedto;
    }

    public Integer getApjBook() {
        return apjBook;
    }

    public void setApjBook(Integer apjBook) {
        this.apjBook = apjBook;
    }

    public String getWater() {
        return water;
    }

    public void setWater(String water) {
        this.water = water;
    }

    public String getRti() {
        return rti;
    }

    public void setRti(String rti) {
        this.rti = rti;
    }

    public String getRte() {
        return rte;
    }

    public void setRte(String rte) {
        this.rte = rte;
    }

    public String getHabits() {
        return habits;
    }

    public void setHabits(String habits) {
        this.habits = habits;
    }

    public String getSocial() {
        return social;
    }

    public void setSocial(String social) {
        this.social = social;
    }

    public Integer getIsFake() {
        return isFake;
    }

    public void setIsFake(Integer isFake) {
        this.isFake = isFake;
    }

    public String getAadhaar() {
        return aadhaar;
    }

    public void setAadhaar(String aadhaar) {
        this.aadhaar = aadhaar;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (applicantId != null ? applicantId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ErmApplicant)) {
            return false;
        }
        ErmApplicant other = (ErmApplicant) object;
        if ((this.applicantId == null && other.applicantId != null) || (this.applicantId != null && !this.applicantId.equals(other.applicantId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.erm.ErmApplicant[ applicantId=" + applicantId + " ]";
    }
}
