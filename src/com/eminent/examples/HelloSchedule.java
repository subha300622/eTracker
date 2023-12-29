/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

/**
 *
 * @author Tamilvelan
 */
import java.util.Date;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.SimpleTrigger;
import org.quartz.impl.StdSchedulerFactory;

public class HelloSchedule {
  public HelloSchedule()throws Exception{
  SchedulerFactory sf=new StdSchedulerFactory();
  Scheduler sched=sf.getScheduler();
  sched.start();
  JobDetail jd=new JobDetail("myjob",sched.DEFAULT_GROUP,HelloJob.class);
  SimpleTrigger st=new SimpleTrigger("mytrigger",sched.DEFAULT_GROUP,new Date(),
  null,SimpleTrigger.DEFAULT_PRIORITY,60L*1000L);
  sched.scheduleJob(jd, st);
  }
  public static void main(String args[]){
    try{
      new HelloSchedule();
    }catch(Exception e){}
  }
}