/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import java.util.Objects;

/**
 *
 * @author E0288
 */
public class IssuesTask {
    
    private String issueno="";
    private String projectName="";
    private String status="";
    private String subject="";
    private String color="";
    private String checkBox="yes";
    private String checkParam = "true";
    private int assignedTo;

    public String getIssueno() {
        return issueno;
    }

    public void setIssueno(String issueno) {
        this.issueno = issueno;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCheckBox() {
        return checkBox;
    }

    public void setCheckBox(String checkBox) {
        this.checkBox = checkBox;
    } 

    public String getCheckParam() {
        return checkParam;
    }

    public void setCheckParam(String checkParam) {
        this.checkParam = checkParam;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 89 * hash + Objects.hashCode(this.issueno);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final IssuesTask other = (IssuesTask) obj;
        if (!Objects.equals(this.issueno, other.issueno)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "IssuesTask{" + "issueno=" + issueno + ", projectName=" + projectName + ", status=" + status + ", subject=" + subject + ", color=" + color + ", checkBox=" + checkBox + ", checkParam=" + checkParam + ", assignedTo=" + assignedTo + '}';
    }
    
}
