/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.persistence;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
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
 * @author EMINENT
 */
@Entity
@Table(name = "MAIL_CAMPAIGN")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MailCampaign.findAll", query = "SELECT m FROM MailCampaign m"),
    @NamedQuery(name = "MailCampaign.findByCampaignId", query = "SELECT m FROM MailCampaign m WHERE m.campaignId = :campaignId"),
    @NamedQuery(name = "MailCampaign.findByMailid", query = "SELECT m FROM MailCampaign m WHERE m.mailid = :mailid"),
    @NamedQuery(name = "MailCampaign.findBySubject", query = "SELECT m FROM MailCampaign m WHERE m.subject = :subject"),
    @NamedQuery(name = "MailCampaign.findByMaildate", query = "SELECT m FROM MailCampaign m WHERE m.maildate = :maildate"),
    @NamedQuery(name = "MailCampaign.findBySentby", query = "SELECT m FROM MailCampaign m WHERE m.sentby = :sentby"),
    @NamedQuery(name = "MailCampaign.findByStatus", query = "SELECT m FROM MailCampaign m WHERE m.status = :status")})
public class MailCampaign implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "CAMPAIGN_ID")
    private Integer campaignId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "MAILID")
    private String mailid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "SUBJECT")
    private String subject;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MAILDATE")
    @Temporal(TemporalType.DATE)
    private Date maildate;
    @Column(name = "SENTBY")
    private Integer sentby;
    @Size(max = 10)
    @Column(name = "STATUS")
    private String status;

    public MailCampaign() {
    }

    public MailCampaign(Integer campaignId) {
        this.campaignId = campaignId;
    }

    public MailCampaign(Integer campaignId, String mailid, String subject, Date maildate) {
        this.campaignId = campaignId;
        this.mailid = mailid;
        this.subject = subject;
        this.maildate = maildate;
    }

    public Integer getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(Integer campaignId) {
        this.campaignId = campaignId;
    }

    public String getMailid() {
        return mailid;
    }

    public void setMailid(String mailid) {
        this.mailid = mailid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getMaildate() {
        return maildate;
    }

    public void setMaildate(Date maildate) {
        this.maildate = maildate;
    }

    public Integer getSentby() {
        return sentby;
    }

    public void setSentby(Integer sentby) {
        this.sentby = sentby;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (campaignId != null ? campaignId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MailCampaign)) {
            return false;
        }
        MailCampaign other = (MailCampaign) object;
        if ((this.campaignId == null && other.campaignId != null) || (this.campaignId != null && !this.campaignId.equals(other.campaignId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.crm.persistence.MailCampaign[ campaignId=" + campaignId + " ]";
    }
    
}
