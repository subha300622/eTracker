/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.dto;

import java.util.Date;

/**
 *
 * @author EMINENT
 */
public class MailCampaignDetails {

    private int campaignid;
    private String subject = null;
    private String sentby = null;
    private Date maildate;
    private String mailid = null;
    private String status=null;

    public int getCampaignid() {
        return campaignid;
    }

    public void setCampaignid(int campaignid) {
        this.campaignid = campaignid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getSentby() {
        return sentby;
    }

    public void setSentby(String sentby) {
        this.sentby = sentby;
    }

    public Date getMaildate() {
        return maildate;
    }

    public void setMaildate(Date maildate) {
        this.maildate = maildate;
    }

    public String getMailid() {
        return mailid;
    }

    public void setMailid(String mailid) {
        this.mailid = mailid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
