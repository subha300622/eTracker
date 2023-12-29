/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

import java.util.Date;

/**
 *
 * @author E0288
 */
public class IssueFormBean {

    private String severity;
    private String issueId;
    private String type;
    private String priority;
    private int pId;
    private String pName;
    private String redPName;
    private String mName;
    private String redMName;
    private String subject;
    private String description;
    private String status;
    private String dueDate;
    private String createdOn;
    private String modifiedOn;
    private String dueDateColor;
    private String createdBy;
    private String assignto;
    private int createdById;
    private int assigntoId;
    private String refer;
    private int age;
    private int lastAssigneeAge=1;
    private String rating;
    private String ratingColor;
    private String feedback;
    private String lastAssigneeName;
    private String lastModifiedOn;
    private String lastAssigneeEmail;
    private String assigneeEmail;

    private Date duedateOn;
    private Date modifiedDate;
    private Date created;
    private Integer filecount=0;
    private String version;
    private String rootCause;
    private String expResult;
    private Integer sino;
   
    
    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getRedPName() {
        return redPName;
    }

    public void setRedPName(String redPName) {
        this.redPName = redPName;
    }

    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName;
    }

    public String getRedMName() {
        return redMName;
    }

    public void setRedMName(String redMName) {
        this.redMName = redMName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public String getDueDateColor() {
        return dueDateColor;
    }

    public void setDueDateColor(String dueDateColor) {
        this.dueDateColor = dueDateColor;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getAssignto() {
        return assignto;
    }

    public void setAssignto(String assignto) {
        this.assignto = assignto;
    }

    public int getCreatedById() {
        return createdById;
    }

    public void setCreatedById(int createdById) {
        this.createdById = createdById;
    }

    public int getAssigntoId() {
        return assigntoId;
    }

    public void setAssigntoId(int assigntoId) {
        this.assigntoId = assigntoId;
    }

    public String getRefer() {
        return refer;
    }

    public void setRefer(String refer) {
        this.refer = refer;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getLastAssigneeAge() {
        return lastAssigneeAge;
    }

    public void setLastAssigneeAge(int lastAssigneeAge) {
        this.lastAssigneeAge = lastAssigneeAge;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getRatingColor() {
        return ratingColor;
    }

    public void setRatingColor(String ratingColor) {
        this.ratingColor = ratingColor;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getLastAssigneeName() {
        return lastAssigneeName;
    }

    public void setLastAssigneeName(String lastAssigneeName) {
        this.lastAssigneeName = lastAssigneeName;
    }

    public String getLastModifiedOn() {
        return lastModifiedOn;
    }

    public void setLastModifiedOn(String lastModifiedOn) {
        this.lastModifiedOn = lastModifiedOn;
    }

    public String getLastAssigneeEmail() {
        return lastAssigneeEmail;
    }

    public void setLastAssigneeEmail(String lastAssigneeEmail) {
        this.lastAssigneeEmail = lastAssigneeEmail;
    }

    public String getAssigneeEmail() {
        return assigneeEmail;
    }

    public void setAssigneeEmail(String assigneeEmail) {
        this.assigneeEmail = assigneeEmail;
    }

    public Date getDuedateOn() {
        return duedateOn;
    }

    public void setDuedateOn(Date duedateOn) {
        this.duedateOn = duedateOn;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Integer getFilecount() {
        return filecount;
    }

    public void setFilecount(Integer filecount) {
        this.filecount = filecount;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getRootCause() {
        return rootCause;
    }

    public void setRootCause(String rootCause) {
        this.rootCause = rootCause;
    }

    public String getExpResult() {
        return expResult;
    }

    public void setExpResult(String expResult) {
        this.expResult = expResult;
    }    

    public Integer getSino() {
        return sino;
    }

    public void setSino(Integer sino) {
        this.sino = sino;
    }
    
}
