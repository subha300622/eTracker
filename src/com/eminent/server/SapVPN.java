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
public class SapVPN {

    private int id;
    private int pid;
    private String vIpAdd;
    private int vPort;
    private String vUname;
    private String vPwd;
    private String vName;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getvIpAdd() {
        return vIpAdd;
    }

    public void setvIpAdd(String vIpAdd) {
        this.vIpAdd = vIpAdd;
    }

    public int getvPort() {
        return vPort;
    }

    public void setvPort(int vPort) {
        this.vPort = vPort;
    }

    public String getvUname() {
        return vUname;
    }

    public void setvUname(String vUname) {
        this.vUname = vUname;
    }

    public String getvPwd() {
        return vPwd;
    }

    public void setvPwd(String vPwd) {
        this.vPwd = vPwd;
    }

    public String getvName() {
        return vName;
    }

    public void setvName(String vName) {
        this.vName = vName;
    }
    
    

}
