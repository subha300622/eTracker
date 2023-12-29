/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement;

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
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

/**
 *
 * @author EMINENT
 */
@Entity
@Table(name = "REIMBURSEMENT_VOUCHERS")
@NamedQueries({
    @NamedQuery(name = "ReimbursementVouchers.findAll", query = "SELECT r FROM ReimbursementVouchers r"),
    @NamedQuery(name = "ReimbursementVouchers.findForAccountant", query = "SELECT r FROM ReimbursementVouchers r WHERE r.status <> :status and (r.requestedBy = :requestedBy OR r.assignedTo=:requestedBy)"),
    @NamedQuery(name = "ReimbursementVouchers.findBetweenPeriod", query = "SELECT r FROM ReimbursementVouchers r WHERE r.period <= :periodb AND r.period >= :perioda"),
    @NamedQuery(name = "ReimbursementVouchers.findByRvid", query = "SELECT r FROM ReimbursementVouchers r WHERE r.rvid = :rvid"),
    @NamedQuery(name = "ReimbursementVouchers.findByFileName", query = "SELECT r FROM ReimbursementVouchers r WHERE r.fileName = :fileName"),
    @NamedQuery(name = "ReimbursementVouchers.findByRequestedBy", query = "SELECT r FROM ReimbursementVouchers r WHERE r.requestedBy = :requestedBy OR r.assignedTo=:requestedBy"),
    @NamedQuery(name = "ReimbursementVouchers.findByUploadedBy", query = "SELECT r FROM ReimbursementVouchers r WHERE r.uploadedBy = :uploadedBy"),
    @NamedQuery(name = "ReimbursementVouchers.findByCreatedon", query = "SELECT r FROM ReimbursementVouchers r WHERE r.createdon = :createdon"),
    @NamedQuery(name = "ReimbursementVouchers.findByModifiedon", query = "SELECT r FROM ReimbursementVouchers r WHERE r.modifiedon = :modifiedon"),
    @NamedQuery(name = "ReimbursementVouchers.findByMonthlyCount", query = "SELECT COUNT(r) FROM ReimbursementVouchers r WHERE r.fileName LIKE :fileName")})
public class ReimbursementVouchers implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "RVID")
    private Long rvid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 250)
    @Column(name = "FILENAME")
    private String fileName;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Status")
    private Integer status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdon;
    @NotNull
    @Column(name = "Period")
    @Temporal(TemporalType.DATE)
    private Date period;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODIFIEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedon;

    @Basic(optional = false)
    @NotNull
    @Column(name = "REQUESTEDBY")
    private Integer requestedBy;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ASSIGNEDTO")
    private Integer assignedTo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "UPLOADEDBY")
    private Integer uploadedBy;
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = ReimbursementBill.class, mappedBy = "rvid")
    @Fetch(FetchMode.SUBSELECT)
    List<ReimbursementBill> reimbursementBillList = new ArrayList<ReimbursementBill>(0);
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = ReimbursementComments.class, mappedBy = "rvid")
    @Fetch(FetchMode.SUBSELECT)
    private List<ReimbursementComments> reimbursementCommentsList = new ArrayList<ReimbursementComments>(0);

    public ReimbursementVouchers() {
    }

    public ReimbursementVouchers(Long rvid) {
        this.rvid = rvid;
    }

    public ReimbursementVouchers(Long rvid, String fileName, Integer requestedBy, Integer uploadedBy, Date period, Date createdon, Date modifiedon, Integer status, Integer assignedTo) {
        this.rvid = rvid;
        this.fileName = fileName;
        this.requestedBy = requestedBy;
        this.uploadedBy = uploadedBy;
        this.period = period;
        this.createdon = createdon;
        this.modifiedon = modifiedon;
        this.status = status;
        this.assignedTo = assignedTo;
    }

    public Long getRvid() {
        return rvid;
    }

    public void setRvid(Long rvid) {
        this.rvid = rvid;
    }

    public Date getPeriod() {
        return period;
    }

    public void setPeriod(Date period) {
        this.period = period;
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

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getRequestedBy() {
        return requestedBy;
    }

    public void setRequestedBy(Integer requestedBy) {
        this.requestedBy = requestedBy;
    }

    public Integer getUploadedBy() {
        return uploadedBy;
    }

    public void setUploadedBy(Integer uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public Integer getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(Integer assignedTo) {
        this.assignedTo = assignedTo;
    }

    @XmlTransient
    public List<ReimbursementBill> getReimbursementBillList() {
        return reimbursementBillList;
    }

    public void setReimbursementBillList(List<ReimbursementBill> reimbursementBillList) {
        this.reimbursementBillList = reimbursementBillList;
    }

    public List<ReimbursementComments> getReimbursementCommentsList() {
        return reimbursementCommentsList;
    }

    public void setReimbursementCommentsList(List<ReimbursementComments> reimbursementCommentsList) {
        this.reimbursementCommentsList = reimbursementCommentsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rvid != null ? rvid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ReimbursementVouchers)) {
            return false;
        }
        ReimbursementVouchers other = (ReimbursementVouchers) object;
        if ((this.rvid == null && other.rvid != null) || (this.rvid != null && !this.rvid.equals(other.rvid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ReimbursementVouchers{" + "rvid=" + rvid + ", fileName=" + fileName + ", status=" + status + ", createdon=" + createdon + ", modifiedon=" + modifiedon + ", requestedBy=" + requestedBy + ", assignedTo=" + assignedTo + ", uploadedBy=" + uploadedBy + ", reimbursementBillList=" + reimbursementBillList + ", reimbursementCommentsList=" + reimbursementCommentsList + '}';
    }

}
