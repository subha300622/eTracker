/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

/**
 *
 * @author Muthu
 */
public class IssueCountFormBean {

    private int projectId;
    private String projectName;
    private int openIssuesCount;
    private int wrmIssuesCount;
    private int plannedIssuesCount;
    private int wrmPlannedIssuesCount;
    private int wrmActualIssuesCount;
    private int nonWrmPlannedIssuesCount;
    private int nonWrmActualIssuesCount;

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    

    public int getOpenIssuesCount() {
        return openIssuesCount;
    }

    public void setOpenIssuesCount(int openIssuesCount) {
        this.openIssuesCount = openIssuesCount;
    }

    public int getWrmIssuesCount() {
        return wrmIssuesCount;
    }

    public void setWrmIssuesCount(int wrmIssuesCount) {
        this.wrmIssuesCount = wrmIssuesCount;
    }

    public int getPlannedIssuesCount() {
        return plannedIssuesCount;
    }

    public void setPlannedIssuesCount(int plannedIssuesCount) {
        this.plannedIssuesCount = plannedIssuesCount;
    }

    public int getWrmPlannedIssuesCount() {
        return wrmPlannedIssuesCount;
    }

    public void setWrmPlannedIssuesCount(int wrmPlannedIssuesCount) {
        this.wrmPlannedIssuesCount = wrmPlannedIssuesCount;
    }

    public int getNonWrmPlannedIssuesCount() {
        return nonWrmPlannedIssuesCount;
    }

    public void setNonWrmPlannedIssuesCount(int nonWrmPlannedIssuesCount) {
        this.nonWrmPlannedIssuesCount = nonWrmPlannedIssuesCount;
    }

    public int getWrmActualIssuesCount() {
        return wrmActualIssuesCount;
    }

    public void setWrmActualIssuesCount(int wrmActualIssuesCount) {
        this.wrmActualIssuesCount = wrmActualIssuesCount;
    }

    public int getNonWrmActualIssuesCount() {
        return nonWrmActualIssuesCount;
    }

    public void setNonWrmActualIssuesCount(int nonWrmActualIssuesCount) {
        this.nonWrmActualIssuesCount = nonWrmActualIssuesCount;
    }

   
        
}
