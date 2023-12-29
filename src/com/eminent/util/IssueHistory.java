/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.util;

/**
 *
 * @author EMINENT
 */
public class IssueHistory {
    
    private String userName;
    private Integer days;
    private String status;
    private int userId;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    

    @Override
    public String toString() {
        return "IssueHistory{" + "userName=" + userName + ", days=" + days + '}';
    }

    
    
    
}
