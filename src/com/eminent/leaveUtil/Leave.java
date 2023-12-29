/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;

/**
 *
 * @author EMINENT
 */
public class Leave implements Serializable {

    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    private BigInteger leaveid;
    private Date fromdate;
    private Date todate;
    private String type;
    private String description;
    private Date createdon;
    private Date modifiedon;
    private String comments;
    private String duration;
    private BigInteger approval;
    private BigDecimal approver;
    private BigDecimal requestedby;
    private BigDecimal assignedto;
    private float noOfLeaveDays;

    public Leave() {
    }

    public BigInteger getLeaveid() {
        return leaveid;
    }

    public void setLeaveid(BigInteger leaveid) {
        this.leaveid = leaveid;
    }

    public Date getFromdate() {
        return fromdate;
    }

    public void setFromdate(Date fromdate) {
        this.fromdate = fromdate;
    }

    public Date getTodate() {
        return todate;
    }

    public void setTodate(Date todate) {
        this.todate = todate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public BigInteger getApproval() {
        return approval;
    }

    public void setApproval(BigInteger approval) {
        this.approval = approval;
    }

    public BigDecimal getApprover() {
        return approver;
    }

    public void setApprover(BigDecimal approver) {
        this.approver = approver;
    }

   
    public BigDecimal getRequestedby() {
        return requestedby;
    }

    public void setRequestedby(BigDecimal requestedby) {
        this.requestedby = requestedby;
    }

    public BigDecimal getAssignedto() {
        return assignedto;
    }

    public void setAssignedto(BigDecimal assignedto) {
        this.assignedto = assignedto;
    }

    public float getNoOfLeaveDays() {
        return noOfLeaveDays;
    }

    public void setNoOfLeaveDays(float noOfLeaveDays) {
        this.noOfLeaveDays = noOfLeaveDays;
    }

    
   

    

}
