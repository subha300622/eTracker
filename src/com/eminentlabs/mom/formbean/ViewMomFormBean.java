/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public class ViewMomFormBean extends MomDaySummationFormbean {

    private int userId;
    private String name;
    //edit by mukesh leave variable and getter setter
    private boolean leaveToday;
    private boolean leaveNextday;
    List<String> prevDayPlanTasks = new LinkedList<String>();
    List<String> prevDayActualTasks = new ArrayList<String>();
    List<String> currentDayPlanTasks = new LinkedList<String>();
    List<String> currentDayActualTasks = new ArrayList<String>();
    List<String> nextDayPlanTasks = new LinkedList<String>();
    List<String> nextDayActualTasks = new ArrayList<String>();

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getPrevDayPlanTasks() {
        return prevDayPlanTasks;
    }

    public void setPrevDayPlanTasks(List<String> prevDayPlanTasks) {
        this.prevDayPlanTasks = prevDayPlanTasks;
    }

    public List<String> getPrevDayActualTasks() {
        return prevDayActualTasks;
    }

    public void setPrevDayActualTasks(List<String> prevDayActualTasks) {
        this.prevDayActualTasks = prevDayActualTasks;
    }

    public List<String> getCurrentDayPlanTasks() {
        return currentDayPlanTasks;
    }

    public void setCurrentDayPlanTasks(List<String> currentDayPlanTasks) {
        this.currentDayPlanTasks = currentDayPlanTasks;
    }

    public List<String> getCurrentDayActualTasks() {
        return currentDayActualTasks;
    }

    public void setCurrentDayActualTasks(List<String> currentDayActualTasks) {
        this.currentDayActualTasks = currentDayActualTasks;
    }

    public List<String> getNextDayPlanTasks() {
        return nextDayPlanTasks;
    }

    public void setNextDayPlanTasks(List<String> nextDayPlanTasks) {
        this.nextDayPlanTasks = nextDayPlanTasks;
    }

    public List<String> getNextDayActualTasks() {
        return nextDayActualTasks;
    }

    public void setNextDayActualTasks(List<String> nextDayActualTasks) {
        this.nextDayActualTasks = nextDayActualTasks;
    }
     public boolean isLeaveToday() {
        return leaveToday;
    }
     
    public void setLeaveToday(boolean leaveToday) {
        this.leaveToday = leaveToday;
    }
    
    public boolean isLeaveNextday() {
        return leaveNextday;
    } 
    
    public void setLeaveNextday(boolean leaveNextday) {
        this.leaveNextday = leaveNextday;
    } 
}
