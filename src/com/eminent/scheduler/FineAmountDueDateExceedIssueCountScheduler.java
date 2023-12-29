/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.issue.PlanStatus;
import com.eminent.issue.controller.DueDateReport;
import com.eminentlabs.mom.Fine;
import com.eminentlabs.mom.FineAmountUsers;
import com.eminentlabs.mom.FineUtil;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author EMINENT
 */
public class FineAmountDueDateExceedIssueCountScheduler implements Job{

    Logger logger = Logger.getLogger("FineAmountDueDateExceedIssueCountScheduler");

    public void execute(JobExecutionContext arg0) throws JobExecutionException {
        Map<Integer, Integer> dueDateExceedIssueAmount = new HashMap<>();
        System.out.println("FineAmountDueDateExceedIssueCountScheduler is tsrtaed");
        dueDateExceedIssueAmount = DueDateReport.dueDateExceededCountAmount();
        FineAmountUsers fau = new FineAmountUsers();
        Calendar c = new GregorianCalendar();
        java.util.Date date = c.getTime();
        Fine resaon = FineUtil.getReasonId("Red Issue");
        String status = PlanStatus.ACTIVE.getStatus();
        for (Map.Entry<Integer, Integer> entry : dueDateExceedIssueAmount.entrySet()) {
            if (entry.getValue() > 0) {
                fau.setAmount(entry.getValue());
                fau.setUserid(entry.getKey());
                fau.setReasonid((int) (resaon.getId()));
                fau.setAddedon(date);
                fau.setFineDate(date);
                fau.setAddedby(104);
                fau.setStatus(status);
                FineUtil.addFineAmtForUser(fau);
            }
        }
    }
}
