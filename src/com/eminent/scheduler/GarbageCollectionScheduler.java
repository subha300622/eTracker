/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author DhanVa CompuTers
 */
public class GarbageCollectionScheduler implements Job{
    org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger("GarbageCollectionScheduler");

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        String s=null,sc=null;
        try {
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec("cmd /c netstat -ano | findstr 80");
            BufferedReader stdInput = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            if ((s = stdInput.readLine()) != null) {
                int index = s.lastIndexOf(" ");
                sc = s.substring(index, s.length());
            }
            proc = rt.exec("cmd /c jcmd " + sc + " GC.run");
        } catch (IOException ex) {
          logger.error(ex.getMessage());
        }catch (Exception e) {
          logger.error(e.getMessage());
        }
    }
    
}
