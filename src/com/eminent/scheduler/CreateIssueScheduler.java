/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.issue.controller.CreateIssueFromEmail;
import java.util.Calendar;
import java.util.Date;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author Muthu
 */
public class CreateIssueScheduler implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        CreateIssueFromEmail cife = new CreateIssueFromEmail();
        Calendar cal = Calendar.getInstance();
       // cal.add(Calendar.DATE, -1);
        cife.createIssue(cal.getTime());
    }
}
