/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

/**
 *
 * @author admin
 */
public class LeaveBalanceReportBean {

    private String userId;
    private String empNo;
    private String empName;
    private String empDivision;
    public String team;
    private String periodPresent;
    private String periodOther;
    private float periodUnInitmeted;
    private String periodSickLeave;
    private String periodCasualLeave;
    private String periodPrivilegeLeave;
    private String periodAbsent;

    private String availableSickLeave;
    private String availableCasualLeave;
    private String availablePrivilegeLeave;
    private String availableAbsent;

    private float availedSickLeave;
    private float availedCasualLeave;
    private float availedPrivilegeLeave;
    private float availedAbsent;

    private String balanceSickLeave;
    private String balanceCasualLeave;
    private String balancePrivilegeLeave;
    private String balanceAbsent;

    private String totalLeaveTaken;

    public LeaveBalanceReportBean() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEmpDivision() {
        return empDivision;
    }

    public void setEmpDivision(String empDivision) {
        this.empDivision = empDivision;
    }

    public String getPeriodPresent() {
        return periodPresent;
    }

    public void setPeriodPresent(String periodPresent) {
        this.periodPresent = periodPresent;
    }

    public String getPeriodOther() {
        return periodOther;
    }

    public void setPeriodOther(String periodOther) {
        this.periodOther = periodOther;
    }

    public String getPeriodSickLeave() {
        return periodSickLeave;
    }

    public void setPeriodSickLeave(String periodSickLeave) {
        this.periodSickLeave = periodSickLeave;
    }

    public String getPeriodCasualLeave() {
        return periodCasualLeave;
    }

    public void setPeriodCasualLeave(String periodCasualLeave) {
        this.periodCasualLeave = periodCasualLeave;
    }

    public String getPeriodPrivilegeLeave() {
        return periodPrivilegeLeave;
    }

    public void setPeriodPrivilegeLeave(String periodPrivilegeLeave) {
        this.periodPrivilegeLeave = periodPrivilegeLeave;
    }

    public String getPeriodAbsent() {
        return periodAbsent;
    }

    public void setPeriodAbsent(String periodAbsent) {
        this.periodAbsent = periodAbsent;
    }

    public String getAvailableSickLeave() {
        return availableSickLeave;
    }

    public void setAvailableSickLeave(String availableSickLeave) {
        this.availableSickLeave = availableSickLeave;
    }

    public String getAvailableCasualLeave() {
        return availableCasualLeave;
    }

    public void setAvailableCasualLeave(String availableCasualLeave) {
        this.availableCasualLeave = availableCasualLeave;
    }

    public String getAvailablePrivilegeLeave() {
        return availablePrivilegeLeave;
    }

    public void setAvailablePrivilegeLeave(String availablePrivilegeLeave) {
        this.availablePrivilegeLeave = availablePrivilegeLeave;
    }

    public String getAvailableAbsent() {
        return availableAbsent;
    }

    public void setAvailableAbsent(String availableAbsent) {
        this.availableAbsent = availableAbsent;
    }

    public float getAvailedSickLeave() {
        return availedSickLeave;
    }

    public void setAvailedSickLeave(float availedSickLeave) {
        this.availedSickLeave = availedSickLeave;
    }

    public float getAvailedCasualLeave() {
        return availedCasualLeave;
    }

    public void setAvailedCasualLeave(float availedCasualLeave) {
        this.availedCasualLeave = availedCasualLeave;
    }

    public float getAvailedPrivilegeLeave() {
        return availedPrivilegeLeave;
    }

    public void setAvailedPrivilegeLeave(float availedPrivilegeLeave) {
        this.availedPrivilegeLeave = availedPrivilegeLeave;
    }


    public float getAvailedAbsent() {
        return availedAbsent;
    }

    public void setAvailedAbsent(float availedAbsent) {
        this.availedAbsent = availedAbsent;
    }

    public String getBalanceSickLeave() {
        return balanceSickLeave;
    }

    public void setBalanceSickLeave(String balanceSickLeave) {
        this.balanceSickLeave = balanceSickLeave;
    }

    public String getBalanceCasualLeave() {
        return balanceCasualLeave;
    }

    public void setBalanceCasualLeave(String balanceCasualLeave) {
        this.balanceCasualLeave = balanceCasualLeave;
    }

    public String getBalancePrivilegeLeave() {
        return balancePrivilegeLeave;
    }

    public void setBalancePrivilegeLeave(String balancePrivilegeLeave) {
        this.balancePrivilegeLeave = balancePrivilegeLeave;
    }

    public String getBalanceAbsent() {
        return balanceAbsent;
    }

    public void setBalanceAbsent(String balanceAbsent) {
        this.balanceAbsent = balanceAbsent;
    }

    public String getTotalLeaveTaken() {
        return totalLeaveTaken;
    }

    public void setTotalLeaveTaken(String totalLeaveTaken) {
        this.totalLeaveTaken = totalLeaveTaken;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public float getPeriodUnInitmeted() {
        return periodUnInitmeted;
    }

    public void setPeriodUnInitmeted(float periodUnInitmeted) {
        this.periodUnInitmeted = periodUnInitmeted;
    }

}
