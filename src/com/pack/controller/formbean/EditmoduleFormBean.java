/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.controller.formbean;

import java.util.HashMap;

/**
 *
 * @author admin
 */
public class EditmoduleFormBean {

    private String module;
    private Integer moduleid;
    private Integer pid;
    private Integer cOwner;
    private Integer iOwner;
    private String category;
    private String pname;
    private Integer targetId;
    private Integer target;
    private String month;
    private Integer issuecount;
    HashMap<String, String> teamMembers;
    HashMap<Integer, String> eminentUsers;

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public Integer getModuleid() {
        return moduleid;
    }

    public void setModuleid(Integer moduleid) {
        this.moduleid = moduleid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getcOwner() {
        return cOwner;
    }

    public void setcOwner(Integer cOwner) {
        this.cOwner = cOwner;
    }

    public Integer getiOwner() {
        return iOwner;
    }

    public void setiOwner(Integer iOwner) {
        this.iOwner = iOwner;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getTargetId() {
        return targetId;
    }

    public void setTargetId(Integer targetId) {
        this.targetId = targetId;
    }

    public Integer getTarget() {
        return target;
    }

    public void setTarget(Integer target) {
        this.target = target;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public HashMap<String, String> getTeamMembers() {
        return teamMembers;
    }

    public void setTeamMembers(HashMap<String, String> teamMembers) {
        this.teamMembers = teamMembers;
    }

    public HashMap<Integer, String> getEminentUsers() {
        return eminentUsers;
    }

    public void setEminentUsers(HashMap<Integer, String> eminentUsers) {
        this.eminentUsers = eminentUsers;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public Integer getIssuecount() {
        return issuecount;
    }

    public void setIssuecount(Integer issuecount) {
        this.issuecount = issuecount;
    }

}
