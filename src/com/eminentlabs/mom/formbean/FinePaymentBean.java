/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.mom.formbean;

/**
 *
 * @author RN.Khans
 */
public class FinePaymentBean {
    
    private long paymentId;
    private int userId;
    private String name;
    private String date;
    private int amount;
    private int collectedbyUserId;
    private String collectedby;
    private String comments;

    public long getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(long paymentId) {
        this.paymentId = paymentId;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getCollectedby() {
        return collectedby;
    }

    public void setCollectedby(String collectedby) {
        this.collectedby = collectedby;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public int getCollectedbyUserId() {
        return collectedbyUserId;
    }

    public void setCollectedbyUserId(int collectedbyUserId) {
        this.collectedbyUserId = collectedbyUserId;
    }    
}
