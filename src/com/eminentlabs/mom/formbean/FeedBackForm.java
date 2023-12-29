/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

/**
 *
 * @author E0288
 */
public class FeedBackForm {

    private String momdate;
    private String mostartTime;
    private String moendTime;
    private String evstartTime;
    private String evEndTime;
    private String name;
    private String morningFeedBack;
    private String eveningFeedBack;
    private int momTeamType;

    public String getMomdate() {
        return momdate;
    }

    public void setMomdate(String momdate) {
        this.momdate = momdate;
    }

    public String getMostartTime() {
        return mostartTime;
    }

    public void setMostartTime(String mostartTime) {
        this.mostartTime = mostartTime;
    }

    public String getMoendTime() {
        return moendTime;
    }

    public void setMoendTime(String moendTime) {
        this.moendTime = moendTime;
    }

    public String getEvstartTime() {
        return evstartTime;
    }

    public void setEvstartTime(String evstartTime) {
        this.evstartTime = evstartTime;
    }

    public String getEvEndTime() {
        return evEndTime;
    }

    public void setEvEndTime(String evEndTime) {
        this.evEndTime = evEndTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMorningFeedBack() {
       if(morningFeedBack!=null){
        if(morningFeedBack.contains("null")){
            morningFeedBack=morningFeedBack.replace("null", "");
        }
       }
        return morningFeedBack;
    }

    public void setMorningFeedBack(String morningFeedBack) {
        this.morningFeedBack = morningFeedBack;
    }

    public String getEveningFeedBack() {
        return eveningFeedBack;
    }

    public void setEveningFeedBack(String eveningFeedBack) {
        this.eveningFeedBack = eveningFeedBack;
    }

    public int getMomTeamType() {
        return momTeamType;
    }

    public void setMomTeamType(int momTeamType) {
        this.momTeamType = momTeamType;
    }

   
    
    
}
