/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.issue.ApmIssueAssignment;
import com.eminent.issue.dao.ApmIssueAssignDAOImpl;
import java.util.List;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author Eminent
 */
public class AssignExcedsNotification implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {

        List<ApmIssueAssignment> issueAssignments = new ApmIssueAssignDAOImpl().getAll();
        if (issueAssignments != null && !issueAssignments.isEmpty()) {

        }
    }

}
    