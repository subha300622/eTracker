package com.eminent.bpm;
// Generated Jun 14, 2012 4:44:57 PM by Hibernate Tools 3.2.1.GA

import java.util.Date;




/**
 * BpmScenario generated by hbm2java
 */
public class BpmScenario  implements java.io.Serializable {

 private Integer scenarioId;
     private String scenario;
     private String scType;
     private Integer spId;
     private Integer createdby;
     private Date createdon;

    public BpmScenario() {
    }

    public BpmScenario(Integer scenarioId, String scenario, String scType, Integer spId, Integer createdby, Date createdon) {
       this.scenarioId = scenarioId;
       this.scenario = scenario;
       this.scType= scType;
       this.spId = spId;
       this.createdby = createdby;
       this.createdon = createdon;
    }
   
    public Integer getScenarioId() {
        return this.scenarioId;
    }
    
    public void setScenarioId(Integer scenarioId) {
        this.scenarioId = scenarioId;
    }
    public String getScenario() {
        return this.scenario;
    }
    
    public void setScenario(String scenario) {
        this.scenario = scenario;
    }
    public String getScType() {
        return this.scType;
    }
    
    public void setScType(String scType) {
        this.scType = scType;
    }
    public Integer getSpId() {
        return this.spId;
    }
    
    public void setSpId(Integer spId) {
        this.spId = spId;
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


