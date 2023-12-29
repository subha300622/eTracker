package com.eminent.Assets;
// Generated Dec 12, 2009 11:06:39 AM by Hibernate Tools 3.2.1.GA

public class Assets implements java.io.Serializable {

    private String IpAddress;
    private String Machinename;
    private String AssignedUser;
    private String CpuDetails;
    private String RamDetails;

    private String hardDisk;
    private String MotherBoard;
    private String os;
    private String UNIQUE_ASSET_NO;
    private String Value;
    private String Status;

    public Assets() {
    }

    public Assets(String IpAddress) {
        this.IpAddress = IpAddress;
    }

    public Assets(String IpAddress, String Machinename, String AssignedUser, String CpuDetails, String RamDetails, String hardDisk,  String MotherBoard, String os, String UNIQUE_ASSET_NO, String Value, String Status) {
        this.IpAddress = IpAddress;
        this.Machinename = Machinename;
        this.AssignedUser = AssignedUser;
        this.CpuDetails = CpuDetails;
        this.RamDetails = RamDetails;
        this.hardDisk = hardDisk;
        this.MotherBoard = MotherBoard;
        this.os = os;
        this.UNIQUE_ASSET_NO = UNIQUE_ASSET_NO;
        this.Value = Value;
        this.Status = Status;
    }

    public String getIpAddress() {
        return IpAddress;
    }

    public void setIpAddress(String IpAddress) {
        this.IpAddress = IpAddress;
    }

    public String getMachinename() {
        return Machinename;
    }

    public void setMachinename(String Machinename) {
        this.Machinename = Machinename;
    }

    public String getAssignedUser() {
        return AssignedUser;
    }

    public void setAssignedUser(String AssignedUser) {
        this.AssignedUser = AssignedUser;
    }

    public String getCpuDetails() {
        return CpuDetails;
    }

    public void setCpuDetails(String CpuDetails) {
        this.CpuDetails = CpuDetails;
    }

    public String getRamDetails() {
        return RamDetails;
    }

    public void setRamDetails(String RamDetails) {
        this.RamDetails = RamDetails;
    }

    public String getHardDisk() {
        return hardDisk;
    }

    public void setHardDisk(String hardDisk) {
        this.hardDisk = hardDisk;
    }

    public String getMotherBoard() {
        return MotherBoard;
    }

    public void setMotherBoard(String MotherBoard) {
        this.MotherBoard = MotherBoard;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getUNIQUE_ASSET_NO() {
        return UNIQUE_ASSET_NO;
    }

    public void setUNIQUE_ASSET_NO(String UNIQUE_ASSET_NO) {
        this.UNIQUE_ASSET_NO = UNIQUE_ASSET_NO;
    }

    public String getValue() {
        return Value;
    }

    public void setValue(String Value) {
        this.Value = Value;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

}
