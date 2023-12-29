/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.issue.controller.IssueController;
import com.eminent.issue.dao.IssueDAOImpl;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author Muthu
 */
public class IssueImageBackup implements Job {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("IssueImageBackup");
    }

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
//        IssueController ic = new IssueController();
//
//        if (new IssueDAOImpl().getAllImageURLCount() == 0) {
//            ic.extractImageURL("");
//        } else {
//            ic.extractImageURL(new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
//        }
    }

}
