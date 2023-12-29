/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

/**
 *
 * @author DhanVa CompuTers
 */
public class SapConfig {

    private int id;
    private int mId;
    private int serverId;
    private int systemId;
    private String systemName;
    private String osName;
    private String erpVersion;
    private String ehpVersion;
    private String dbVersion;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getmId() {
        return mId;
    }

    public void setmId(int mId) {
        this.mId = mId;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public int getSystemId() {
        return systemId;
    }

    public void setSystemId(int systemId) {
        this.systemId = systemId;
    }

    public String getOsName() {
        return osName;
    }

    public void setOsName(String osName) {
        this.osName = osName;
    }

    public String getErpVersion() {
        return erpVersion;
    }

    public void setErpVersion(String erpVersion) {
        this.erpVersion = erpVersion;
    }

    public String getEhpVersion() {
        return ehpVersion;
    }

    public void setEhpVersion(String ehpVersion) {
        this.ehpVersion = ehpVersion;
    }

    public String getDbVersion() {
        return dbVersion;
    }

    public void setDbVersion(String dbVersion) {
        this.dbVersion = dbVersion;
    }

    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }

}
