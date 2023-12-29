/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Muthu
 */
@Entity
@Table(name = "LEAVE_APPROVER_MAINTENANCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LeaveApproverMaintenance.findAll", query = "SELECT l FROM LeaveApproverMaintenance l order by l.requester,l.approvalLevel"),
    @NamedQuery(name = "LeaveApproverMaintenance.findByApprovalId", query = "SELECT l FROM LeaveApproverMaintenance l WHERE l.approvalId = :approvalId"),
    @NamedQuery(name = "LeaveApproverMaintenance.deleteByApprovalId", query = "DELETE FROM LeaveApproverMaintenance l WHERE l.approvalId = :approvalId"),
    @NamedQuery(name = "LeaveApproverMaintenance.findByRequester", query = "SELECT l FROM LeaveApproverMaintenance l WHERE l.requester = :requester"),
    @NamedQuery(name = "LeaveApproverMaintenance.deleteByRequester", query = "DELETE FROM LeaveApproverMaintenance l WHERE l.requester = :requester"),
    @NamedQuery(name = "LeaveApproverMaintenance.findByApprovalLevel", query = "SELECT l FROM LeaveApproverMaintenance l WHERE l.approvalLevel = :approvalLevel"),
    @NamedQuery(name = "LeaveApproverMaintenance.findByApprover", query = "SELECT l FROM LeaveApproverMaintenance l WHERE l.approver = :approver"),
    @NamedQuery(name = "LeaveApproverMaintenance.findByAddedon", query = "SELECT l FROM LeaveApproverMaintenance l WHERE l.addedon = :addedon"),
    @NamedQuery(name = "LeaveApproverMaintenance.findByModifiedon", query = "SELECT l FROM LeaveApproverMaintenance l WHERE l.modifiedon = :modifiedon")})
public class LeaveApproverMaintenance implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "APPROVAL_ID")
    private Long approvalId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "REQUESTER")
    private Integer requester;
    @Basic(optional = false)
    @NotNull
    @Column(name = "APPROVAL_LEVEL")
    private Integer approvalLevel;
    @Basic(optional = false)
    @NotNull
    @Column(name = "APPROVER")
    private Integer approver;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedon;
    @Column(name = "MODIFIEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedon;

    public LeaveApproverMaintenance() {
    }

    public LeaveApproverMaintenance(Long approvalId) {
        this.approvalId = approvalId;
    }

    public LeaveApproverMaintenance(Long approvalId, Integer requester, Integer approvalLevel, Integer approver, Date addedon) {
        this.approvalId = approvalId;
        this.requester = requester;
        this.approvalLevel = approvalLevel;
        this.approver = approver;
        this.addedon = addedon;
    }

    public Long getApprovalId() {
        return approvalId;
    }

    public void setApprovalId(Long approvalId) {
        this.approvalId = approvalId;
    }

    public Integer getRequester() {
        return requester;
    }

    public void setRequester(Integer requester) {
        this.requester = requester;
    }

    public Integer getApprovalLevel() {
        return approvalLevel;
    }

    public void setApprovalLevel(Integer approvalLevel) {
        this.approvalLevel = approvalLevel;
    }

    public Integer getApprover() {
        return approver;
    }

    public void setApprover(Integer approver) {
        this.approver = approver;
    }

    public Date getAddedon() {
        return addedon;
    }

    public void setAddedon(Date addedon) {
        this.addedon = addedon;
    }

    public Date getModifiedon() {
        return modifiedon;
    }

    public void setModifiedon(Date modifiedon) {
        this.modifiedon = modifiedon;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (approvalId != null ? approvalId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LeaveApproverMaintenance)) {
            return false;
        }
        LeaveApproverMaintenance other = (LeaveApproverMaintenance) object;
        if ((this.approvalId == null && other.approvalId != null) || (this.approvalId != null && !this.approvalId.equals(other.approvalId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.leaveUtil.LeaveApproverMaintenance[ approvalId=" + approvalId + " ]";
    }

}
