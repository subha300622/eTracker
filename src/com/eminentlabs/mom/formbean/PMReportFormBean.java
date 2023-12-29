/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

import com.eminent.issue.formbean.IssueFormBean;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author E0288
 */
public class PMReportFormBean {

    private long pid;
    private String pname;
    private String projectManager;
    private int closedCount;
    private String rating;
    private String feedback;
    List<IssueFormBean> projectWiseissuesList = new ArrayList<IssueFormBean>();
    private int pmid;

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getProjectManager() {
        return projectManager;
    }

    public void setProjectManager(String projectManager) {
        this.projectManager = projectManager;
    }

    public int getClosedCount() {
        return closedCount;
    }

    public void setClosedCount(int closedCount) {
        this.closedCount = closedCount;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public List<IssueFormBean> getProjectWiseissuesList() {
        return projectWiseissuesList;
    }

    public void setProjectWiseissuesList(List<IssueFormBean> projectWiseissuesList) {
        this.projectWiseissuesList = projectWiseissuesList;
    }

    public int getPmid() {
        return pmid;
    }

    public void setPmid(int pmid) {
        this.pmid = pmid;
    }

}
