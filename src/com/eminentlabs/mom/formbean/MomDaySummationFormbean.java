/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

import java.util.List;

/**
 *
 * @author EMINENT
 */
public class MomDaySummationFormbean {

    private String momDate;
    private int wrmPlanned;
    private int nonWrmPlanned;
    private int wrmWithCustomers;
    private int wrmWithUs;
    private int withCustomer;
    private int notWithCustomer;
    private int closed;
    private int notUpdated;
    private int wrmCount;
    private int adhoc;
    List<String> issueList;
    List<String> wrmIssueList;

    public String getMomDate() {
        return momDate;
    }

    public void setMomDate(String momDate) {
        this.momDate = momDate;
    }

    public int getWrmPlanned() {
        return wrmPlanned;
    }

    public void setWrmPlanned(int wrmPlanned) {
        this.wrmPlanned = wrmPlanned;
    }

    public int getWrmWithCustomers() {
        return wrmWithCustomers;
    }

    public void setWrmWithCustomers(int wrmWithCustomers) {
        this.wrmWithCustomers = wrmWithCustomers;
    }

    public int getWrmWithUs() {
        return wrmWithUs;
    }

    public void setWrmWithUs(int wrmWithUs) {
        this.wrmWithUs = wrmWithUs;
    }

    public int getNonWrmPlanned() {
        return nonWrmPlanned;
    }

    public void setNonWrmPlanned(int nonWrmPlanned) {
        this.nonWrmPlanned = nonWrmPlanned;
    }

    public int getWithCustomer() {
        return withCustomer;
    }

    public void setWithCustomer(int withCustomer) {
        this.withCustomer = withCustomer;
    }

    public int getNotWithCustomer() {
        return notWithCustomer;
    }

    public void setNotWithCustomer(int notWithCustomer) {
        this.notWithCustomer = notWithCustomer;
    }

    public int getClosed() {
        return closed;
    }

    public void setClosed(int closed) {
        this.closed = closed;
    }

    public int getNotUpdated() {
        return notUpdated;
    }

    public void setNotUpdated(int notUpdated) {
        this.notUpdated = notUpdated;
    }

    public int getWrmCount() {
        return wrmCount;
    }

    public void setWrmCount(int wrmCount) {
        this.wrmCount = wrmCount;
    }

    public int getAdhoc() {
        return adhoc;
    }

    public void setAdhoc(int adhoc) {
        this.adhoc = adhoc;
    }

    public List<String> getIssueList() {
        return issueList;
    }

    public void setIssueList(List<String> issueList) {
        this.issueList = issueList;
    }

    public List<String> getWrmIssueList() {
        return wrmIssueList;
    }

    public void setWrmIssueList(List<String> wrmIssueList) {
        this.wrmIssueList = wrmIssueList;
    }

}
