/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.scheduler.controller.NextDayScheduler;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author EMINENT
 */
public class MoMNextDaySubmit implements Job {

    public void execute(JobExecutionContext jec) throws JobExecutionException {
        NextDayScheduler nds=new NextDayScheduler();
        nds.executeme();
    }
}
