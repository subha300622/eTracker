/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.gstn;

import java.util.Date;


/**
 *
 * @author Muthu
 */

public class AccessKey  {

    private Date expiryDate;   
    private Date changedOn;
    private Integer keyId;  
    private String projectName;   
    private String accessType;   
    private String accessKey; 
    private String serverType;

    public AccessKey() {
    }

    public AccessKey(Integer keyId) {
        this.keyId = keyId;
    }

    public AccessKey(Integer keyId, String projectName, String accessType, String accessKey,String serverType) {
        this.keyId = keyId;
        this.projectName = projectName;
        this.accessType = accessType;
        this.accessKey = accessKey;
        this.serverType = serverType;
    }

    public Integer getKeyId() {
        return keyId;
    }

    public void setKeyId(Integer keyId) {
        this.keyId = keyId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getAccessType() {
        return accessType;
    }

    public void setAccessType(String accessType) {
        this.accessType = accessType;
    }

    public String getAccessKey() {
        return accessKey;
    }

    public void setAccessKey(String accessKey) {
        this.accessKey = accessKey;
    }
  
    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Date getChangedOn() {
        return changedOn;
    }

    public void setChangedOn(Date changedOn) {
        this.changedOn = changedOn;
    }

    public String getServerType() {
        return serverType;
    }

    public void setServerType(String serverType) {
        this.serverType = serverType;
    }
    
}
