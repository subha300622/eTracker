/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmComponent;
import com.eminent.issue.ApmComponentIssues;
import com.eminent.issue.dao.ApmComponentIssueDAOImpl;
import com.eminent.issue.dao.ApmComponentIssuesDAO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author EMINENT
 */
public class ApmComponentIssueController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ApmComponentIssueController");
    }

    List<ApmComponentIssues> componentIssueList = new ArrayList<ApmComponentIssues>();
    List<String> componentList = new ArrayList<>();
    List<BigDecimal> compIdList = new ArrayList<BigDecimal>();
    ApmComponentIssues apmComponentIssues = new ApmComponentIssues();
    ApmComponentIssuesDAO apmComponentIssuesDAO = new ApmComponentIssueDAOImpl();

    public void addIssues(String[] issueComponent, String issueId) {
        apmComponentIssuesDAO.deleteByIssue(issueId);
        ApmComponentIssues apmComponentissue = new ApmComponentIssues();
        if (issueComponent != null) {
            for (String componentId : issueComponent) {
                apmComponentissue.setIssueId(issueId);
                apmComponentissue.setComponentId(new ApmComponent(BigDecimal.valueOf(Integer.parseInt(componentId))));
                apmComponentIssuesDAO.addIssue(apmComponentissue);
            }
        }
    }

    public List<ApmComponentIssues> findByIssueId(String issueId) {
        componentIssueList = apmComponentIssuesDAO.findByIssueId(issueId);
        return componentIssueList;

    }

    public List<BigDecimal> findcomponentsByIssueId(String issueId) {
        componentIssueList = apmComponentIssuesDAO.findComponentsByIssueId(issueId);
        List<BigDecimal> compIdList = new ArrayList<BigDecimal>();
        for (ApmComponentIssues l : componentIssueList) {
            compIdList.add(l.getComponentId().getComponentId());

        }
        return compIdList;
    }

    public void setfindcomponentsByIssueId(List<BigDecimal> compIdList) {
        this.compIdList = compIdList;
    }

    public void setfindByIssueId(List<ApmComponentIssues> componentIssueList) {
        this.componentIssueList = componentIssueList;
    }

    public List<ApmComponentIssues> findByComponentId(BigDecimal compId) {
        ApmComponentIssues apmComponentissue = new ApmComponentIssues();
        apmComponentissue.setComponentId(new ApmComponent(compId));
        componentIssueList = apmComponentIssuesDAO.findIssueByComponentId(apmComponentissue);
        return componentIssueList;
    }

    public void setfindByComponentId(List<ApmComponentIssues> componentIssueList) {
        this.componentIssueList = componentIssueList;
    }

    public void findByComponentId(List<ApmComponentIssues> componentIssueList) {
        this.componentIssueList = componentIssueList;
    }

    public List<ApmComponentIssues> getComponentIssueList() {
        return componentIssueList;
    }

    public void setComponentIssueList(List<ApmComponentIssues> componentIssueList) {
        this.componentIssueList = componentIssueList;
    }

}
