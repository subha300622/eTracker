/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util.bean;

/**
 *
 * @author admin
 */
public class ModuleWaiseCountBean {

    private String moduleName;
    private Integer openIssue;
    private Integer targetCount;
    private Integer closeCount;
    private Integer workedCount;
    private Integer planCount;
    private Integer wrmCount;
    private Integer createdCount;

    public ModuleWaiseCountBean() {
    }

    public ModuleWaiseCountBean(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public Integer getOpenIssue() {
        return openIssue;
    }

    public void setOpenIssue(Integer openIssue) {
        this.openIssue = openIssue;
    }

    public Integer getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(Integer targetCount) {
        this.targetCount = targetCount;
    }

    public Integer getCloseCount() {
        return closeCount;
    }

    public void setCloseCount(Integer closeCount) {
        this.closeCount = closeCount;
    }

    public Integer getWorkedCount() {
        return workedCount;
    }

    public void setWorkedCount(Integer workedCount) {
        this.workedCount = workedCount;
    }

    public Integer getPlanCount() {
        return planCount;
    }

    public void setPlanCount(Integer planCount) {
        this.planCount = planCount;
    }

    public Integer getWrmCount() {
        return wrmCount;
    }

    public void setWrmCount(Integer wrmCount) {
        this.wrmCount = wrmCount;
    }

    public Integer getCreatedCount() {
        return createdCount;
    }

    public void setCreatedCount(Integer createdCount) {
        this.createdCount = createdCount;
    }

    
}
