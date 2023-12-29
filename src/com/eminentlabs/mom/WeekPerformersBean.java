/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author RN.Khans
 */
public class WeekPerformersBean {

    private String team;
    private String userId;
    private String name;
    private int plannedCount = 0;
    private int closedCount = 0;
    private String average;
    IssuesTask plannedTask =  new IssuesTask();
    List<IssuesTask> plannedList = new ArrayList<IssuesTask>();
    List<IssuesTask> actualList = new ArrayList<IssuesTask>();
    String actualIssues[][];
    private int myAssignmentCount=0;
    

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    

    public int getPlannedCount() {
        return plannedCount;
    }

    public void setPlannedCount(int plannedCount) {
        this.plannedCount = plannedCount;
    }

    public int getClosedCount() {
        return closedCount;
    }

    public void setClosedCount(int closedCount) {
        this.closedCount = closedCount;
    }

    public String getAverage() {
        return average;
    }

    public void setAverage(String average) {
        this.average = average;
    }

  

    public IssuesTask getPlannedTask() {
        return plannedTask;
    }

    public void setPlannedTask(IssuesTask plannedTask) {
        this.plannedTask = plannedTask;
    }
    
    

    public List<IssuesTask> getPlannedList() {
        return plannedList;
    }

    public void setPlannedList(List<IssuesTask> plannedList) {
        this.plannedList = plannedList;
    }

    public List<IssuesTask> getActualList() {
        return actualList;
    }

    public void setActualList(List<IssuesTask> actualList) {
        this.actualList = actualList;
    }

    public String[][] getActualIssues() {
        return actualIssues;
    }

    public void setActualIssues(String[][] actualIssues) {
        this.actualIssues = actualIssues;
    }

    public int getMyAssignmentCount() {
        return myAssignmentCount;
    }

    public void setMyAssignmentCount(int myAssignmentCount) {
        this.myAssignmentCount = myAssignmentCount;
    }
    
    
    
}
