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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "LEAV_APPROVAL_HISTORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LeavApprovalHistory.findAll", query = "SELECT l FROM LeavApprovalHistory l"),
    @NamedQuery(name = "LeavApprovalHistory.findById", query = "SELECT l FROM LeavApprovalHistory l WHERE l.id = :id"),
    @NamedQuery(name = "LeavApprovalHistory.findByLeaveId", query = "SELECT l FROM LeavApprovalHistory l WHERE l.leaveid = :leaveid order by l.id"),
    @NamedQuery(name = "LeavApprovalHistory.findByApprovallevel", query = "SELECT l FROM LeavApprovalHistory l WHERE l.approvallevel = :approvallevel"),
    @NamedQuery(name = "LeavApprovalHistory.findByApprover", query = "SELECT l FROM LeavApprovalHistory l WHERE l.approver = :approver"),
    @NamedQuery(name = "LeavApprovalHistory.findByUpdateon", query = "SELECT l FROM LeavApprovalHistory l WHERE l.updateon = :updateon"),
    @NamedQuery(name = "LeavApprovalHistory.findByUpdatedby", query = "SELECT l FROM LeavApprovalHistory l WHERE l.updatedby = :updatedby")})
public class LeavApprovalHistory implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Long id;
    @Column(name = "APPROVALLEVEL")
    private Integer approvallevel;
    @Column(name = "APPROVER")
    private Integer approver;
    @Column(name = "UPDATEON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateon;
    @Column(name = "UPDATEDBY")
    private Integer updatedby;
    @NotNull
    @Column(name = "LEAVEID")
    private long leaveid;
     @Column(name = "COMMENTS")
    private String comments;

    public LeavApprovalHistory() {
    }

    public LeavApprovalHistory(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getApprovallevel() {
        return approvallevel;
    }

    public void setApprovallevel(Integer approvallevel) {
        this.approvallevel = approvallevel;
    }

    public Integer getApprover() {
        return approver;
    }

    public void setApprover(Integer approver) {
        this.approver = approver;
    }

    public Date getUpdateon() {
        return updateon;
    }

    public void setUpdateon(Date updateon) {
        this.updateon = updateon;
    }

    public Integer getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Integer updatedby) {
        this.updatedby = updatedby;
    }

    public long getLeaveid() {
        return leaveid;
    }

    public void setLeaveid(long leaveid) {
        this.leaveid = leaveid;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
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
        if (!(object instanceof LeavApprovalHistory)) {
            return false;
        }
        LeavApprovalHistory other = (LeavApprovalHistory) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "LeavApprovalHistory{" + "id=" + id + ", approvallevel=" + approvallevel + ", approver=" + approver + ", updateon=" + updateon + ", updatedby=" + updatedby + ", leaveid=" + leaveid + '}';
    }

    
    
}
