package com.eminent.bpm;
// Generated Jun 14, 2012 2:37:30 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;




/**
 * BpmBp generated by hbm2java
 */
public class BpmBp  {


     private Integer bpId;
     private String bpName;
     private String bpType;
     private Integer companyId;
     private Integer createdby;
     private Date createdon;

    public BpmBp() {
    }
    
    public BpmBp(int bpId) {
        this.bpId = bpId;
    }

    public BpmBp(Integer bpId, String bpName, String bpType, Integer companyId, Integer createdby, Date createdon) {
       this.bpId = bpId;
       this.bpName = bpName;
       this.bpType = bpType;
       this.companyId = companyId;
       this.createdby = createdby;
       this.createdon = createdon;
    }
   
    public Integer getBpId() {
        return this.bpId;
    }
    
    public void setBpId(Integer bpId) {
        this.bpId = bpId;
    }
    public String getBpName() {
        return this.bpName;
    }
    
    public void setBpName(String bpName) {
        this.bpName = bpName;
    }
    public String getBpType() {
        return this.bpType;
    }
    
    public void setBpType(String bpType) {
        this.bpType = bpType;
    }
    public Integer getCompanyId() {
        return this.companyId;
    }
    
    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }
    public Integer getCreatedby() {
        return this.createdby;
    }
    
    public void setCreatedby(Integer createdby) {
        this.createdby = createdby;
    }
    public Date getCreatedon() {
        return this.createdon;
    }
    
    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }




}

