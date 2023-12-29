/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author DhanVa CompuTers
 */
@Embeddable
public class AgreedIssuesPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "ISSUE_ID")
    private String issueId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "ISSUE_TYPE")
    private String issueType;

    public AgreedIssuesPK() {
    }

    public AgreedIssuesPK(String issueId, String issueType) {
        this.issueId = issueId;
        this.issueType = issueType;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (issueId != null ? issueId.hashCode() : 0);
        hash += (issueType != null ? issueType.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AgreedIssuesPK)) {
            return false;
        }
        AgreedIssuesPK other = (AgreedIssuesPK) object;
        if ((this.issueId == null && other.issueId != null) || (this.issueId != null && !this.issueId.equals(other.issueId))) {
            return false;
        }
        if ((this.issueType == null && other.issueType != null) || (this.issueType != null && !this.issueType.equals(other.issueType))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.AgreedIssuesPK[ issueId=" + issueId + ", issueType=" + issueType + " ]";
    }
    
}
