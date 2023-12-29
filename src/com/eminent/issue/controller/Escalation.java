/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

/**
 *
 * @author vanithaalliraj
 */
public class Escalation {
    private String issueId;
    private String subject;
    private String assginedTo;
    private int assginedToId;
    private String pmanager;
    private String dmanager;
    private String emanager;
    private long pid;
    private long days;
    private int escDays;

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getAssginedTo() {
        return assginedTo;
    }

    public void setAssginedTo(String assginedTo) {
        this.assginedTo = assginedTo;
    }

    public String getPmanager() {
        return pmanager;
    }

    public void setPmanager(String pmanager) {
        this.pmanager = pmanager;
    }

    public String getDmanager() {
        return dmanager;
    }

    public void setDmanager(String dmanager) {
        this.dmanager = dmanager;
    }

    public String getEmanager() {
        return emanager;
    }

    public void setEmanager(String emanager) {
        this.emanager = emanager;
    }

    public long getDays() {
        return days;
    }

    public void setDays(long days) {
        this.days = days;
    }

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public int getAssginedToId() {
        return assginedToId;
    }

    public void setAssginedToId(int assginedToId) {
        this.assginedToId = assginedToId;
    }

    public int getEscDays() {
        return escDays;
    }

    public void setEscDays(int escDays) {
        this.escDays = escDays;
    }
    
    
}
