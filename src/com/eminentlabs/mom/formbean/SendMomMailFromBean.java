/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

import java.util.Map;

/**
 *
 * @author admin
 */
public class SendMomMailFromBean {
 private Map<Integer,String> attendance;  
 private Integer chairPerson;
 private String startTime;
 private  String endTime;
 private String momtime;
 private Integer teamType;
 private Integer branch;

    public Map<Integer, String> getAttendance() {
        return attendance;
    }

    public void setAttendance(Map<Integer, String> attendance) {
        this.attendance = attendance;
    }

    public Integer getChairPerson() {
        return chairPerson;
    }

    public void setChairPerson(Integer chairPerson) {
        this.chairPerson = chairPerson;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getMomtime() {
        return momtime;
    }

    public void setMomtime(String momtime) {
        this.momtime = momtime;
    }

    public Integer getTeamType() {
        return teamType;
    }

    public void setTeamType(Integer teamType) {
        this.teamType = teamType;
    }

    public Integer getBranch() {
        return branch;
    }

    public void setBranch(Integer branch) {
        this.branch = branch;
    }
    

    @Override
    public String toString() {
        return "SendMomMailFromBean{" + "attendance=" + attendance + ", chairPerson=" + chairPerson + ", startTime=" + startTime + ", endTime=" + endTime + ", momtime=" + momtime + ", teamType=" + teamType + '}';
    }
 
 
}
