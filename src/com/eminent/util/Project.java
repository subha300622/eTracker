/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

/**
 *
 * @author Muthu
 */
public class Project {
    
    private long pid;
    private String pname,verion;
    private int pmId,dmId;
    private String pmName,pmEMail;
    private String dmName,dmEMail;
    
    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getVerion() {
        return verion;
    }

    public void setVerion(String verion) {
        this.verion = verion;
    }

    public int getPmId() {
        return pmId;
    }

    public void setPmId(int pmId) {
        this.pmId = pmId;
    }

    public int getDmId() {
        return dmId;
    }

    public void setDmId(int dmId) {
        this.dmId = dmId;
    }

    public String getPmName() {
        return pmName;
    }

    public void setPmName(String pmName) {
        this.pmName = pmName;
    }

    public String getPmEMail() {
        return pmEMail;
    }

    public void setPmEMail(String pmEMail) {
        this.pmEMail = pmEMail;
    }

    public String getDmName() {
        return dmName;
    }

    public void setDmName(String dmName) {
        this.dmName = dmName;
    }

    public String getDmEMail() {
        return dmEMail;
    }

    public void setDmEMail(String dmEMail) {
        this.dmEMail = dmEMail;
    }

   
    
}
