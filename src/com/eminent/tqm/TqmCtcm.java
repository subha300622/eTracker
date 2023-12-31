package com.eminent.tqm;
// Generated 8 Mar, 2010 5:27:38 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * TqmCtcm generated by hbm2java
 */
public class TqmCtcm  implements java.io.Serializable {


     private String ctcid;
     private String ptcid;
     private String functionality;
     private String description;
     private String expectedresult;
     private Date createdon;
     private Integer createdby;
     private Integer approvedby;
     private Date modifiedon;

    public TqmCtcm() {
    }

	
    public TqmCtcm(String ctcid) {
        this.ctcid = ctcid;
    }
    public TqmCtcm(String ctcid, String ptcid, String functionality, String description, String expectedresult, Date createdon, Integer createdby, Integer approvedby, Date modifiedon) {
       this.ctcid = ctcid;
       this.ptcid = ptcid;
       this.functionality = functionality;
       this.description = description;
       this.expectedresult = expectedresult;
       this.createdon = createdon;
       this.createdby = createdby;
       this.approvedby    =   approvedby;
       this.modifiedon = modifiedon;
    }
   
    public String getCtcid() {
        return this.ctcid;
    }
    
    public void setCtcid(String ctcid) {
        this.ctcid = ctcid;
    }
    public String getPtcid() {
        return this.ptcid;
    }
    
    public void setPtcid(String ptcid) {
        this.ptcid = ptcid;
    }
    public String getFunctionality() {
        return this.functionality;
    }
    
    public void setFunctionality(String functionality) {
        this.functionality = functionality;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getExpectedresult() {
        return this.expectedresult;
    }
    
    public void setExpectedresult(String expectedresult) {
        this.expectedresult = expectedresult;
    }
    public Date getCreatedon() {
        return this.createdon;
    }
    
    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }
    public Integer getCreatedby() {
        return this.createdby;
    }
    
    public void setCreatedby(Integer createdby) {
        this.createdby = createdby;
    }
    public Integer getApprovedby() {
        return this.approvedby;
    }

    public void setApprovedby(Integer approvedby) {
        this.approvedby = approvedby;
    }
    public Date getModifiedon() {
        return this.modifiedon;
    }
    
    public void setModifiedon(Date modifiedon) {
        this.modifiedon = modifiedon;
    }




}


