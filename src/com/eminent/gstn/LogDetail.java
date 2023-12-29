/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.gstn;

/**
 *
 * @author vanithaalliraj
 */
public class LogDetail {

    private String gstin;
    private String category;
    private String action;
    private int apiCount;
    private int totInvoices;
    private int dupInvoices;
    private int orgInvoices;
    private int totCount;

    public String getGstin() {
        return gstin;
    }

    public void setGstin(String gstin) {
        this.gstin = gstin==null?"N/A":gstin;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public int getApiCount() {
        return apiCount;
    }

    public void setApiCount(int apiCount) {
        this.apiCount = apiCount;
    }

    public int getTotInvoices() {
        return totInvoices;
    }

    public void setTotInvoices(int totInvoices) {
        this.totInvoices = totInvoices;
    }

    public int getDupInvoices() {
        return dupInvoices;
    }

    public void setDupInvoices(int dupInvoices) {
        this.dupInvoices = dupInvoices;
    }

    public int getOrgInvoices() {
        return orgInvoices;
    }

    public void setOrgInvoices(int orgInvoices) {
        this.orgInvoices = orgInvoices;
    }

    public int getTotCount() {
        return totCount;
    }

    public void setTotCount(int totCount) {
        this.totCount = totCount;
    }

    @Override
    public String toString() {
        return "LogDetail{" + "gstin=" + gstin + ", category=" + category + ", action=" + action + ", apiCount=" + apiCount + ", totInvoices=" + totInvoices + ", dupInvoices=" + dupInvoices + ", orgInvoices=" + orgInvoices + ", totCount=" + totCount + '}';
    }
    
    
    
}
