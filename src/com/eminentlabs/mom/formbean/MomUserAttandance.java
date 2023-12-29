/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

/**
 *
 * @author admin
 */
public class MomUserAttandance {

    private Integer userid;
    private String username;
    private Integer present;
    private Integer intimated;
    private Integer permission;
    private Integer unintimated;
    private Integer clinet;
    private Integer medicalleave;
    private Integer approveleave;

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getPresent() {
        return present;
    }

    public void setPresent(Integer present) {
        this.present = present;
    }

    public Integer getIntimated() {
        return intimated;
    }

    public void setIntimated(Integer intimated) {
        this.intimated = intimated;
    }

    public Integer getPermission() {
        return permission;
    }

    public void setPermission(Integer permission) {
        this.permission = permission;
    }

    public Integer getUnintimated() {
        return unintimated;
    }

    public void setUnintimated(Integer unintimated) {
        this.unintimated = unintimated;
    }

    public Integer getClinet() {
        return clinet;
    }

    public void setClinet(Integer clinet) {
        this.clinet = clinet;
    }

    public Integer getMedicalleave() {
        return medicalleave;
    }

    public void setMedicalleave(Integer medicalleave) {
        this.medicalleave = medicalleave;
    }

    public Integer getApproveleave() {
        return approveleave;
    }

    public void setApproveleave(Integer approveleave) {
        this.approveleave = approveleave;
    }
    
    
}
