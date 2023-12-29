package com.eminentlabs.appraisal;
// Generated Dec 17, 2011 10:34:40 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import java.sql.Timestamp;

/**
 * ErmAppraisalComment generated by hbm2java
 */
public class ErmAppraisalComment  implements java.io.Serializable {


     private Integer commentId;
     private ErmAppraisal ermAppraisal;
     private Integer commentedBy;
     private String comments;
     private Integer commentedTo;
     private Date dueDate;
     private Integer status;
     private Timestamp commentedOn;

    public ErmAppraisalComment() {
    }

	
    public ErmAppraisalComment(Integer commentId) {
        this.commentId = commentId;
    }
    public ErmAppraisalComment(Integer commentId, ErmAppraisal ermAppraisal, Integer commentedBy, String comments, Integer commentedTo, Date dueDate, Integer status, Timestamp commentedOn) {
       this.commentId = commentId;
       this.ermAppraisal = ermAppraisal;
       this.commentedBy = commentedBy;
       this.comments = comments;
       this.commentedTo = commentedTo;
       this.dueDate = dueDate;
       this.status = status;
       this.commentedOn = commentedOn;
    }
   
    public Integer getCommentId() {
        return this.commentId;
    }
    
    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }
    public ErmAppraisal getErmAppraisal() {
        return this.ermAppraisal;
    }
    
    public void setErmAppraisal(ErmAppraisal ermAppraisal) {
        this.ermAppraisal = ermAppraisal;
    }
    public Integer getCommentedBy() {
        return this.commentedBy;
    }
    
    public void setCommentedBy(Integer commentedBy) {
        this.commentedBy = commentedBy;
    }
    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    public Integer getCommentedTo() {
        return this.commentedTo;
    }
    
    public void setCommentedTo(Integer commentedTo) {
        this.commentedTo = commentedTo;
    }
    public Date getDueDate() {
        return this.dueDate;
    }
    
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Date getCommentedOn() {
        return this.commentedOn;
    }
    
    public void setCommentedOn(Timestamp commentedOn) {
        this.commentedOn = commentedOn;
    }




}


