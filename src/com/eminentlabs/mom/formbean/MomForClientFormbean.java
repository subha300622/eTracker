/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminentlabs.mom.ApmWrmPlan;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author E0288
 */
public class MomForClientFormbean {

    private int momClientId;
    private String heldOn;
    private String heldAt;
    private String discussion;
    private String mRating;
    private String mFeedback;
    private int createBy;
    private String attendies;
    private String minattendies;
    private String startTime;
    private String endTime;
    private String escalation;
    private String responsiblePerson;
    List<IssueFormBean> wrmplanIssueDetails = new ArrayList<IssueFormBean>();
    List<ApmWrmPlan> wrmPlanList = new ArrayList<ApmWrmPlan>();
    List<IssueFormBean> additonalClosedIssueDetails = new ArrayList<IssueFormBean>();

    public int getMomClientId() {
        return momClientId;
    }

    public void setMomClientId(int momClientId) {
        this.momClientId = momClientId;
    }

    public String getHeldOn() {
        return heldOn;
    }

    public void setHeldOn(String heldOn) {
        this.heldOn = heldOn;
    }

    public String getHeldAt() {
        return heldAt;
    }

    public void setHeldAt(String heldAt) {
        this.heldAt = heldAt;
    }

    public String getDiscussion() {
        return discussion;
    }

    public void setDiscussion(String discussion) {
        this.discussion = discussion;
    }

    public String getmRating() {
        return mRating;
    }

    public void setmRating(String mRating) {
        this.mRating = mRating;
    }

    public String getmFeedback() {
        return mFeedback;
    }

    public void setmFeedback(String mFeedback) {
        this.mFeedback = mFeedback;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public String getAttendies() {
        return attendies;
    }

    public void setAttendies(String attendies) {
        this.attendies = attendies;
    }

    public String getMinattendies() {
        return minattendies;
    }

    public void setMinattendies(String minattendies) {
        this.minattendies = minattendies;
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

    public String getEscalation() {
        return escalation;
    }

    public void setEscalation(String escalation) {
        this.escalation = escalation;
    }

    public String getResponsiblePerson() {
        return responsiblePerson;
    }

    public void setResponsiblePerson(String responsiblePerson) {
        this.responsiblePerson = responsiblePerson;
    }

    public List<IssueFormBean> getWrmplanIssueDetails() {
        return wrmplanIssueDetails;
    }

    public void setWrmplanIssueDetails(List<IssueFormBean> wrmplanIssueDetails) {
        this.wrmplanIssueDetails = wrmplanIssueDetails;
    }

    public List<ApmWrmPlan> getWrmPlanList() {
        return wrmPlanList;
    }

    public void setWrmPlanList(List<ApmWrmPlan> wrmPlanList) {
        this.wrmPlanList = wrmPlanList;
    }

    public List<IssueFormBean> getAdditonalClosedIssueDetails() {
        return additonalClosedIssueDetails;
    }

    public void setAdditonalClosedIssueDetails(List<IssueFormBean> additonalClosedIssueDetails) {
        this.additonalClosedIssueDetails = additonalClosedIssueDetails;
    }

}
