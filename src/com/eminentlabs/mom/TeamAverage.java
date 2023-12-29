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
public class TeamAverage {

    private String team;
    private String teamUserIds;
    private int teamPlanAvg = 0;
    private int teamCloseAvg = 0;
    private String teamPerAvg;
    private int teamIssueCount = 0;
    List<WeekPerformersBean> teamWiseUsers = new ArrayList<WeekPerformersBean>();

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public String getTeamUserIds() {
        return teamUserIds;
    }

    public void setTeamUserIds(String teamUserIds) {
        this.teamUserIds = teamUserIds;
    }

    public int getTeamPlanAvg() {
        return teamPlanAvg;
    }

    public void setTeamPlanAvg(int teamPlanAvg) {
        this.teamPlanAvg = teamPlanAvg;
    }

    public int getTeamCloseAvg() {
        return teamCloseAvg;
    }

    public void setTeamCloseAvg(int teamCloseAvg) {
        this.teamCloseAvg = teamCloseAvg;
    }

    public String getTeamPerAvg() {
        return teamPerAvg;
    }

    public void setTeamPerAvg(String teamPerAvg) {
        this.teamPerAvg = teamPerAvg;
    }

    public List<WeekPerformersBean> getTeamWiseUsers() {
        return teamWiseUsers;
    }

    public void setTeamWiseUsers(List<WeekPerformersBean> teamWiseUsers) {
        this.teamWiseUsers = teamWiseUsers;
    }

    public int getTeamIssueCount() {
        return teamIssueCount;
    }

    public void setTeamIssueCount(int teamIssueCount) {
        this.teamIssueCount = teamIssueCount;
    }

    
}
