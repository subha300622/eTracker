/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author EMINENT
 */
@Entity
@Table(name = "REIMBURSEMENT_COMMENTS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ReimbursementComments.findAll", query = "SELECT r FROM ReimbursementComments r"),
    @NamedQuery(name = "ReimbursementComments.findByRcid", query = "SELECT r FROM ReimbursementComments r WHERE r.rcid = :rcid"),
    @NamedQuery(name = "ReimbursementComments.findByCommentedby", query = "SELECT r FROM ReimbursementComments r WHERE r.commentedby = :commentedby"),
    @NamedQuery(name = "ReimbursementComments.findByCommentDate", query = "SELECT r FROM ReimbursementComments r WHERE r.commentDate = :commentDate"),
    @NamedQuery(name = "ReimbursementComments.findByComments", query = "SELECT r FROM ReimbursementComments r WHERE r.comments = :comments"),
    @NamedQuery(name = "ReimbursementComments.findByStatus", query = "SELECT r FROM ReimbursementComments r WHERE r.status = :status"),
    @NamedQuery(name = "ReimbursementComments.findByCommentedto", query = "SELECT r FROM ReimbursementComments r WHERE r.commentedto = :commentedto")})
public class ReimbursementComments implements Serializable{

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "RCID")
    private Long rcid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COMMENTEDBY")
    private Integer commentedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COMMENT_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date commentDate;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 4000)
    @Column(name = "COMMENTS")
    private String comments;
    @Basic(optional = false)
    @NotNull
    @Column(name = "STATUS")
    private Integer status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COMMENTEDTO")
    private Integer commentedto;
    @JoinColumn(name = "RVID", referencedColumnName = "RVID")
    @ManyToOne(optional = false)
    private ReimbursementVouchers rvid;

    public ReimbursementComments() {
    }

    public ReimbursementComments(Long rcid, Integer commentedby, Date commentDate, String comments, Integer status, Integer commentedto, ReimbursementVouchers rvid) {
        this.rcid = rcid;
        this.commentedby = commentedby;
        this.commentDate = commentDate;
        this.comments = comments;
        this.status = status;
        this.commentedto = commentedto;
        this.rvid = rvid;
    }

    public Long getRcid() {
        return rcid;
    }

    public void setRcid(Long rcid) {
        this.rcid = rcid;
    }

    public Integer getCommentedby() {
        return commentedby;
    }

    public void setCommentedby(Integer commentedby) {
        this.commentedby = commentedby;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCommentedto() {
        return commentedto;
    }

    public void setCommentedto(Integer commentedto) {
        this.commentedto = commentedto;
    }

    public ReimbursementVouchers getRvid() {
        return rvid;
    }

    public void setRvid(ReimbursementVouchers rvid) {
        this.rvid = rvid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rcid != null ? rcid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ReimbursementComments)) {
            return false;
        }
        ReimbursementComments other = (ReimbursementComments) object;
        if ((this.rcid == null && other.rcid != null) || (this.rcid != null && !this.rcid.equals(other.rcid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.reimbursement.ReimbursementComments[ rcid=" + rcid + " ]";
    }

    


}
