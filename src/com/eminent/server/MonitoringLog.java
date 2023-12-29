/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

/**
 *
 * @author vanithaalliraj
 */
public class MonitoringLog {
    
    private int pid;
    private int serverId;
    private int paramCount;
    private int staCount;

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public int getParamCount() {
        return paramCount;
    }

    public void setParamCount(int paramCount) {
        this.paramCount = paramCount;
    }

    public int getStaCount() {
        return staCount;
    }

    public void setStaCount(int staCount) {
        this.staCount = staCount;
    }

    @Override
    public String toString() {
        return "MonitoringLog{" + "pid=" + pid + ", serverId=" + serverId + ", paramCount=" + paramCount + ", staCount=" + staCount + '}';
    }
    
    
}
