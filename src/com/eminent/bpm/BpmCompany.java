package com.eminent.bpm;
// Generated Jun 14, 2012 4:44:57 PM by Hibernate Tools 3.2.1.GA

import java.math.BigDecimal;
import java.util.Date;




/**
 * BpmCompany generated by hbm2java
 */
public class BpmCompany  implements java.io.Serializable {

     private Integer companyId;
     private String companyName;
     private Integer clientId;
     private String clientName;
     private Integer createdby;
     private Date createdon;

    public BpmCompany() {
    }

    public BpmCompany(Integer companyId, String companyName, Integer clientId, String clientName, Integer createdby, Date createdon) {
       this.companyId = companyId;
       this.companyName = companyName;
       this.clientId = clientId;
       this.clientName = clientName;
       this.createdby = createdby;
       this.createdon = createdon;
    }
   
    public Integer getCompanyId() {
        return this.companyId;
    }
    
    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }
    public String getCompanyName() {
        return this.companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    public Integer getClientId() {
        return this.clientId;
    }
    
    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }
    public String getClientName() {
        return this.clientName;
    }
    
    public void setClientName(String clientName) {
        this.clientName = clientName;
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

