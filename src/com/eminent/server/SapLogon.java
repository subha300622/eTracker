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
public class SapLogon {

    private int id;
    private int mId;
    private int serverId;
    private int systemId;
    private String systemName;
    private String appServer;
    private int instNo;
    private String systemNo;
    private String routStr;

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

    public String getAppServer() {
        return appServer;
    }

    public void setAppServer(String appServer) {
        this.appServer = appServer;
    }

    public int getInstNo() {
        return instNo;
    }

    public void setInstNo(int instNo) {
        this.instNo = instNo;
    }

    public String getSystemNo() {
        return systemNo;
    }

    public void setSystemNo(String systemNo) {
        this.systemNo = systemNo;
    }

    public String getRoutStr() {
        return routStr;
    }

    public void setRoutStr(String routStr) {
        this.routStr = routStr;
    }

    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }

}
