/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Muthu
 */
@Entity
@Table(name = "ISSUE_IMAGE_URL")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "IssueImageUrl.findAll", query = "SELECT i FROM IssueImageUrl i"),
    @NamedQuery(name = "IssueImageUrl.findByImageId", query = "SELECT i FROM IssueImageUrl i WHERE i.imageId = :imageId"),
    @NamedQuery(name = "IssueImageUrl.findByImageIds", query = "SELECT i FROM IssueImageUrl i WHERE i.imageId in (:imageIds)"),
    @NamedQuery(name = "IssueImageUrl.findByIssueId", query = "SELECT i FROM IssueImageUrl i WHERE i.issueId = :issueId"),
    @NamedQuery(name = "IssueImageUrl.findByIssueRowId", query = "SELECT i FROM IssueImageUrl i WHERE i.issueRowId = :issueRowId"),
    @NamedQuery(name = "IssueImageUrl.findByOrginialUrl", query = "SELECT i FROM IssueImageUrl i WHERE i.orginialUrl = :orginialUrl"),
    @NamedQuery(name = "IssueImageUrl.findByLocalUrl", query = "SELECT i FROM IssueImageUrl i WHERE i.localUrl = :localUrl"),
    @NamedQuery(name = "IssueImageUrl.findByAddedOn", query = "SELECT i FROM IssueImageUrl i WHERE i.addedOn = :addedOn")})
public class IssueImageUrl implements Serializable {
    @Column(name = "GOOGLE_URL_STATUS")
    private Integer googleUrlStatus;
    @Column(name = "LOCAL_URL_STATUS")
    private Integer localUrlStatus;
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "IMAGE_ID")
    private long imageId;
    @Size(max = 20)
    @Column(name = "ISSUE_ID")
    private String issueId;
    @Size(max = 20)
    @Column(name = "ISSUE_ROW_ID")
    private String issueRowId;
    @Size(max = 500)
    @Column(name = "ORGINIAL_URL")
    private String orginialUrl;
    @Size(max = 500)
    @Column(name = "LOCAL_URL")
    private String localUrl;
    @Column(name = "ADDED_ON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedOn;

    public IssueImageUrl() {
    }

    public IssueImageUrl(long imageId) {
        this.imageId = imageId;
    }

    public long getImageId() {
        return imageId;
    }

    public void setImageId(long imageId) {
        this.imageId = imageId;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getIssueRowId() {
        return issueRowId;
    }

    public void setIssueRowId(String issueRowId) {
        this.issueRowId = issueRowId;
    }

    public String getOrginialUrl() {
        return orginialUrl;
    }

    public void setOrginialUrl(String orginialUrl) {
        this.orginialUrl = orginialUrl;
    }

    public String getLocalUrl() {
        return localUrl;
    }

    public void setLocalUrl(String localUrl) {
        this.localUrl = localUrl;
    }

    public Date getAddedOn() {
        return addedOn;
    }

    public void setAddedOn(Date addedOn) {
        this.addedOn = addedOn;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 97 * hash + (int) (this.imageId ^ (this.imageId >>> 32));
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
        final IssueImageUrl other = (IssueImageUrl) obj;
        if (this.imageId != other.imageId) {
            return false;
        }
        return true;
    }

   
    public Integer getGoogleUrlStatus() {
        return googleUrlStatus;
    }

    public void setGoogleUrlStatus(Integer googleUrlStatus) {
        this.googleUrlStatus = googleUrlStatus;
    }

    public Integer getLocalUrlStatus() {
        return localUrlStatus;
    }

    public void setLocalUrlStatus(Integer localUrlStatus) {
        this.localUrlStatus = localUrlStatus;
    }

    @Override
    public String toString() {
        return "IssueImageUrl{" + "googleUrlStatus=" + googleUrlStatus + ", localUrlStatus=" + localUrlStatus + ", imageId=" + imageId + ", issueId=" + issueId + ", issueRowId=" + issueRowId + ", orginialUrl=" + orginialUrl + ", localUrl=" + localUrl + ", addedOn=" + addedOn + '}';
    }
 
    
}
