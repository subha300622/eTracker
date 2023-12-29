/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.CronTrigger;
import org.quartz.impl.StdSchedulerFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;
import org.quartz.ee.servlet.*;

/**
 *
 * @author Tamilvelan
 */
public class SchedulerStartUp extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        Logger logger = Logger.getLogger("SchedulerStartUp");
        super.init(config);
        ServletContext ctx = config.getServletContext();
        Scheduler workedOnScheduler = null, verifiedStatusScheduler = null, notUpdatedScheduler = null, valueUpdaterScheduler = null, dueDateExceedScheduler = null, dueDateAboutToExceedScheduler = null, timeSheetScheduler = null, pmUpdateScheduler = null, projectUpdateScheduler = null, reassigningIssuesScheduler = null, timesheetApprovalScheduler = null, timesheetIntimation = null, momScheduler, momNextDayScheduler;
        Scheduler absentScheduler = null, createIssue;
        Scheduler fineAmountDueDateExceedIssueCountScheduler = null, planningRemainder, escalationIssues, autoplanning, accessKeyNotofication;
        try {
            workedOnScheduler = StdSchedulerFactory.getDefaultScheduler();
            verifiedStatusScheduler = StdSchedulerFactory.getDefaultScheduler();
//notUpdatedScheduler             =   StdSchedulerFactory.getDefaultScheduler();
            valueUpdaterScheduler = StdSchedulerFactory.getDefaultScheduler();
            dueDateExceedScheduler = StdSchedulerFactory.getDefaultScheduler();
            dueDateAboutToExceedScheduler = StdSchedulerFactory.getDefaultScheduler();
            timeSheetScheduler = StdSchedulerFactory.getDefaultScheduler();
            pmUpdateScheduler = StdSchedulerFactory.getDefaultScheduler();
            projectUpdateScheduler = StdSchedulerFactory.getDefaultScheduler();
//reassigningIssuesScheduler      =   StdSchedulerFactory.getDefaultScheduler();
            timesheetApprovalScheduler = StdSchedulerFactory.getDefaultScheduler();
            timesheetIntimation = StdSchedulerFactory.getDefaultScheduler();
            momScheduler = StdSchedulerFactory.getDefaultScheduler();
            momNextDayScheduler = StdSchedulerFactory.getDefaultScheduler();
            absentScheduler = StdSchedulerFactory.getDefaultScheduler();
            fineAmountDueDateExceedIssueCountScheduler = StdSchedulerFactory.getDefaultScheduler();
            createIssue = StdSchedulerFactory.getDefaultScheduler();
            planningRemainder = StdSchedulerFactory.getDefaultScheduler();
            escalationIssues = StdSchedulerFactory.getDefaultScheduler();
            autoplanning = StdSchedulerFactory.getDefaultScheduler();
            accessKeyNotofication = StdSchedulerFactory.getDefaultScheduler();
             Scheduler gcCollector = StdSchedulerFactory.getDefaultScheduler();
            JobDetail jd = new JobDetail("Todays Work", "group1", WorkAccomplished.class);
            JobDetail verifiedIssues = new JobDetail("Verified Issued", "group2", VerifiedIssues.class);
//JobDetail notUpdatedIssues         =   new JobDetail("Not Updated Issues","group3",NotUpdatedMail.class);
            JobDetail valueUpdater = new JobDetail("ValueUpdaterJob", "group4", UpdateValue.class);
            JobDetail dueDateExceedIssues = new JobDetail("DueDateExceededJob", "group5", DueDateExceeded.class);
            JobDetail dueDateAboutToExceed = new JobDetail("dueDateAboutToExceedJob", "group6", DueDate.class);
            JobDetail timeSheet = new JobDetail("timeSheetJob", "group7", MonthlyTimesheetIntimation.class);
            JobDetail pmUpdate = new JobDetail("pmJob", "group8", PMUpdateMail.class);
            JobDetail projectUpdate = new JobDetail("projectUpdateJob", "group9", CustomerUpdateMail.class);
//JobDetail reassignIssue            =   new JobDetail("reassignIssueJob","group10",ReassignIssues.class);
            JobDetail timesheetApp = new JobDetail("reassignIssueJob", "group11", TimesheetApprovalRemainder.class);
            JobDetail monthlyIntimation = new JobDetail("monthlytimesheet", "group12", MonthlyTimesheetIntimation.class);
//            JobDetail momIntimation = new JobDetail("momAutoSubmit", "group13", MoMAutoSubmit.class);
            JobDetail momNextDayIntimation = new JobDetail("moMNextDaySubmit", "group13", MoMNextDaySubmit.class);
            //    JobDetail absentIntimation = new JobDetail("moMNextDaySubmit", "group15", AbsentScheduler.class);
            JobDetail fineAmountReport = new JobDetail("fineAmountUpdate", "group16", FineAmountDueDateExceedIssueCountScheduler.class);
            JobDetail createIssueJob = new JobDetail("createIssueJob", "group17", CreateIssueScheduler.class);
            JobDetail planningRemainderJob = new JobDetail("planningRemainderJob", "group18", IssuePlanningRemainder.class);
            JobDetail escalationIssuesJob = new JobDetail("escalationIssuesJob", "group19", EscalationIssues.class);
            JobDetail autoplanJob = new JobDetail("autoplanJob", "group20", AutoPlanningWRMIssues.class);
            JobDetail accessKeyNotoficationJob = new JobDetail("accessKeyNotofication", "group21", AccessKeyExpiryNotification.class);
            JobDetail gcCollectorJob = new JobDetail("gcCollectorJob", "group22", GarbageCollectionScheduler.class);


            CronTrigger ModifiedIssues = new CronTrigger("Modified Issues", "group1");
            CronTrigger VerifiedIssuesTrigger = new CronTrigger("Modified Issues", "group2");
//CronTrigger NotUpdatedIssuesTrigger         =   new CronTrigger("Not Updated Issues","group3");
            CronTrigger ValueUpdaterTrigger = new CronTrigger("ValueUpdater", "group4");
            CronTrigger DueDateExceedTrigger = new CronTrigger("DueDateExceeded", "group5");
            CronTrigger DueDateAbouttoExceedTrigger = new CronTrigger("DueDateAbouttoExceed", "group6");
            CronTrigger MonthlyTimeSheetTigger = new CronTrigger("MonthlyTimeSheet", "group7");
            CronTrigger PMUpdateTigger = new CronTrigger("PMUpdateTigger", "group8");
            CronTrigger projectUpdateTigger = new CronTrigger("projectUpdateTigger", "group9");
//CronTrigger reassignIssueTrigger          =   new CronTrigger("reassignIssueTrigger","group10");
            CronTrigger timesheetAppTrigger = new CronTrigger("timesheetAppTrigger", "group11");
            CronTrigger monthyIntiTrigger = new CronTrigger("monthlyIntimationTrigger", "group12");
            CronTrigger dailyMoMIntiTrigger = new CronTrigger("momIntimation", "group13");
            CronTrigger nextDayMomPlannTrigger = new CronTrigger("momNextDayIntimation", "group14");
            //    CronTrigger absentIntimationTrigger = new CronTrigger("absentIntimation", "group15");
            CronTrigger fineAmountReportTrigger = new CronTrigger("fineAmountupdation", "group16");
            CronTrigger createIssueTrigger = new CronTrigger("createIssueTrigger", "group17");
            CronTrigger planningRemainderTrigger = new CronTrigger("planningRemainderTrigger", "group17");
            CronTrigger escalationIssuesTrigger = new CronTrigger("escalationIssuesTrigger", "group19");
            CronTrigger autoplanTrigger = new CronTrigger("autoplanTrigger", "group20");
            CronTrigger accessKeyNotoficationTrigger = new CronTrigger("accessKeyNotoficationTrigger", "group21");
            CronTrigger gcCollectorTrigger = new CronTrigger("gcCollectorTrigger", "group22");
//(sec(0-59),min(0-59),hours(0-23),day of month(1-31),month(1-12 or JAN-DEC),day of week(1-7 or SUN-SAT),year(empty, 1970-2099))
            ValueUpdaterTrigger.setCronExpression("0 1 0 1 * ?");
            ValueUpdaterTrigger.setPriority(1);
            ModifiedIssues.setCronExpression("0 1 6 ? * 1-7 ");
            VerifiedIssuesTrigger.setCronExpression("0 1 7 ? * 1-7 ");
            DueDateExceedTrigger.setCronExpression("0 0 8 ? * 1-7 ");
            DueDateAbouttoExceedTrigger.setCronExpression("0 0 9 ? * 1-7 ");
//NotUpdatedIssuesTrigger.setCronExpression("0 1 13 ? * 1-7 ");
            MonthlyTimeSheetTigger.setCronExpression("0 0 1 1 * ?");
            PMUpdateTigger.setCronExpression("0 1 17 ? * MON-FRI");
            projectUpdateTigger.setCronExpression("0 15 17 ? * FRI");
//reassignIssueTrigger.setCronExpression("0 10 0 ? * 1-7");
            timesheetAppTrigger.setCronExpression("0 0 5 ? * 1-7 ");
            monthyIntiTrigger.setCronExpression("0 0 4 ? * 1-7");
            dailyMoMIntiTrigger.setCronExpression("0 30 0/18 ? * 2-6");
            nextDayMomPlannTrigger.setCronExpression("0 30 15-22 ? * 1-7");
//PMUpdateTigger.setCronExpression("0 1/3 * * * ?");
//projectUpdateTigger.setCronExpression("0 1/1 * * * ?");
//reassignIssueTrigger.setCronExpression("0 1/3 * * * ?");
//monthyIntiTrigger.setCronExpression("0 1/3 * * * ?");
            //      absentIntimationTrigger.setCronExpression("0 30 0 * * ?");
            fineAmountReportTrigger.setCronExpression("0 0 8 * * ?");
               createIssueTrigger.setCronExpression("0 0 0/1 * * ?");
            planningRemainderTrigger.setCronExpression("0 0 16 ? * MON-FRI");
            escalationIssuesTrigger.setCronExpression("0 0 8 ? * MON-FRI");
            autoplanTrigger.setCronExpression("0 0 15 ? * MON-FRI");
            accessKeyNotoficationTrigger.setCronExpression("0 0 8 * * ?");
            gcCollectorTrigger.setCronExpression("0 0 0/1 * * ?");

            workedOnScheduler.scheduleJob(jd, ModifiedIssues);
            verifiedStatusScheduler.scheduleJob(verifiedIssues, VerifiedIssuesTrigger);
//notUpdatedScheduler.scheduleJob(notUpdatedIssues,NotUpdatedIssuesTrigger);
            valueUpdaterScheduler.scheduleJob(valueUpdater, ValueUpdaterTrigger);
            dueDateExceedScheduler.scheduleJob(dueDateExceedIssues, DueDateExceedTrigger);
            dueDateAboutToExceedScheduler.scheduleJob(dueDateAboutToExceed, DueDateAbouttoExceedTrigger);
            timeSheetScheduler.scheduleJob(timeSheet, MonthlyTimeSheetTigger);
            pmUpdateScheduler.scheduleJob(pmUpdate, PMUpdateTigger);
            projectUpdateScheduler.scheduleJob(projectUpdate, projectUpdateTigger);
//reassigningIssuesScheduler.scheduleJob(reassignIssue, reassignIssueTrigger);
            timesheetApprovalScheduler.scheduleJob(timesheetApp, timesheetAppTrigger);
            timesheetIntimation.scheduleJob(monthlyIntimation, monthyIntiTrigger);
      //      momScheduler.scheduleJob(momIntimation, dailyMoMIntiTrigger);
            momNextDayScheduler.scheduleJob(momNextDayIntimation, nextDayMomPlannTrigger);
            /*
             projectUpdateTigger.setCronExpression("0 55 21 * * ?");
             projectUpdateScheduler.scheduleJob(projectUpdate, projectUpdateTigger);
             */
            // absentScheduler.scheduleJob(absentIntimation, absentIntimationTrigger);
            fineAmountDueDateExceedIssueCountScheduler.scheduleJob(fineAmountReport, fineAmountReportTrigger);
          //  createIssue.scheduleJob(createIssueJob, createIssueTrigger);
            planningRemainder.scheduleJob(planningRemainderJob, planningRemainderTrigger);
            escalationIssues.scheduleJob(escalationIssuesJob, escalationIssuesTrigger);
            autoplanning.scheduleJob(autoplanJob, autoplanTrigger);
            accessKeyNotofication.scheduleJob(accessKeyNotoficationJob, accessKeyNotoficationTrigger);  
             gcCollector.scheduleJob(gcCollectorJob, gcCollectorTrigger);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
             out.println("<html>");
             out.println("<head>");
             out.println("<title>Servlet SchedulerStartUp</title>");
             out.println("</head>");
             out.println("<body>");
             out.println("<h1>Servlet SchedulerStartUp at " + request.getContextPath () + "</h1>");
             out.println("</body>");
             out.println("</html>");
             */
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
