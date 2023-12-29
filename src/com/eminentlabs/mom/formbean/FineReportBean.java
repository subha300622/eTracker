/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.mom.formbean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author RN.Khans
 */
public class FineReportBean {
    
    private int userId;
    private String name;
    private int prevBalance;
    private int currMonFine;
    private int currMonPaid;
    private int closeBalance;
     List<FineAmountBean> fineAmtList = new ArrayList();
     List<FinePaymentBean> finePaidList = new ArrayList();

    public int getPrevBalance() {
        return prevBalance;
    }

    public void setPrevBalance(int prevBalance) {
        this.prevBalance = prevBalance;
    }

    public int getCurrMonFine() {
        return currMonFine;
    }

    public void setCurrMonFine(int currMonFine) {
        this.currMonFine = currMonFine;
    }

    public int getCurrMonPaid() {
        return currMonPaid;
    }

    public void setCurrMonPaid(int currMonPaid) {
        this.currMonPaid = currMonPaid;
    }

    public int getCloseBalance() {
        return closeBalance;
    }

    public void setCloseBalance(int closeBalance) {
        this.closeBalance = closeBalance;
    }

    public List<FineAmountBean> getFineAmtList() {
        return fineAmtList;
    }

    public void setFineAmtList(List<FineAmountBean> fineAmtList) {
        this.fineAmtList = fineAmtList;
    }

    public List<FinePaymentBean> getFinePaidList() {
        return finePaidList;
    }

    public void setFinePaidList(List<FinePaymentBean> finePaidList) {
        this.finePaidList = finePaidList;
    }    

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
