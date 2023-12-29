package com.eminent.bpm;
// Generated Jun 14, 2012 4:44:57 PM by Hibernate Tools 3.2.1.GA

import java.util.Date;




/**
 * BpmVariant generated by hbm2java
 */
public class BpmVariant  implements java.io.Serializable {


     private Integer variantId;
     private String variant;
     private String vtType;
     private Integer scenarioId;
     private Integer leadModule;
     private Integer impactedModule;
     private String classification;
     private String type;
     private String priority;
     private Integer createdby;
     private Date createdon;

    public BpmVariant() {
    }

    public BpmVariant(Integer variantId, String variant, String vtType, Integer scenarioId, Integer leadModule, Integer impactedModule, String classification, String type, String priority, Integer createdby, Date createdon) {
       this.variantId = variantId;
       this.variant = variant;
       this.vtType  =   vtType;
       this.scenarioId = scenarioId;
       this.leadModule = leadModule;
       this.impactedModule = impactedModule;
       this.classification = classification;
       this.type = type;
       this.priority = priority;
       this.createdby = createdby;
       this.createdon = createdon;
    }
   
    public Integer getVariantId() {
        return this.variantId;
    }
    
    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }
    public String getVariant() {
        return this.variant;
    }
    
    public void setVariant(String variant) {
        this.variant = variant;
    }
    public String getVtType() {
        return this.vtType;
    }
    
    public void setVtType(String vtType) {
        this.vtType = vtType;
    }
    public Integer getScenarioId() {
        return this.scenarioId;
    }
    
    public void setScenarioId(Integer scenarioId) {
        this.scenarioId = scenarioId;
    }
    public Integer getLeadModule() {
        return this.leadModule;
    }
    
    public void setLeadModule(Integer leadModule) {
        this.leadModule = leadModule;
    }
    public Integer getImpactedModule() {
        return this.impactedModule;
    }
    
    public void setImpactedModule(Integer impactedModule) {
        this.impactedModule = impactedModule;
    }
    public String getClassification() {
        return this.classification;
    }
    
    public void setClassification(String classification) {
        this.classification = classification;
    }
    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    public String getPriority() {
        return this.priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
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


