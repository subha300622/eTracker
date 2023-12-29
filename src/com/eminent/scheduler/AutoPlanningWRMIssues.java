/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminent.issue.controller.Escalation;
import com.eminent.issue.dao.EscalationDAO;
import com.eminent.issue.dao.EscalationDAOImpl;
import com.eminent.util.ProjectPlanUtil;
import com.eminentlabs.mom.MoMUtil;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author vanithaalliraj
 */
public class AutoPlanningWRMIssues implements Job {

    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
        EscalationDAO escalationDAO;
        List<Escalation> wrmplanned;
        System.out.println("AutoPlanningWRMIssues start");
        try {
            Calendar c = new GregorianCalendar();
            Date date = c.getTime();
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(date);
            if (holidaysList.isEmpty()) {
                Date today = c.getTime();
                date = MoMUtil.nextDay(date);
                boolean flag = true;
                while (flag == true) {
                    holidaysList = HolidaysUtil.findByHolidayDate(date);
                    if (!holidaysList.isEmpty()) {
                        date = MoMUtil.nextDay(date);
                    } else {
                        flag = false;
                    }

                    escalationDAO = new EscalationDAOImpl();
                    List<Escalation> escalatdIssues = escalationDAO.getESPLEscalation();
                    if (escalatdIssues.size() > 0) {
                        for (Escalation e : escalatdIssues) {
                            MoMUtil.createTask(e.getAssginedToId(), e.getIssueId(), 104, "Issue", "Planned", date);
                            long plannedId = ProjectPlanUtil.uniqueProjectPlan(e.getPid(), e.getIssueId(), date);
                            if (plannedId == 0l) {
                                ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(e.getPid(), e.getIssueId(), 104, date, date, date, PlanStatus.ACTIVE.getStatus());
                                ProjectPlanUtil.createProjectPlanIssue(projectPlannedIssue);
                            } else {
                                ProjectPlannedIssue ppi = new ProjectPlannedIssue();
                                ppi.setId(plannedId);
                                ppi.setpId(e.getPid());
                                ppi.setIssueId(e.getIssueId());
                                ppi.setPlannedBy(104);
                                ppi.setPlannedOn(date);
                                ppi.setCreatedOn(date);
                                ppi.setStatus(PlanStatus.getACTIVE().getStatus());
                                ppi.setModifiedOn(date);
                                ProjectPlanUtil.updateProjectPlanIssue(ppi);
                            }
                        }
                    }
                    wrmplanned = escalationDAO.getWRMPlannedIssues();
                    if (wrmplanned.size() > 0) {
                        for (Escalation e : wrmplanned) {
                            MoMUtil.createTask(e.getAssginedToId(), e.getIssueId(), 104, "Issue", "Planned", date);
                            long plannedId = ProjectPlanUtil.uniqueProjectPlan(e.getPid(), e.getIssueId(), date);
                            if (plannedId == 0l) {
                                ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(e.getPid(), e.getIssueId(), 104, date, today, today, PlanStatus.ACTIVE.getStatus());
                                ProjectPlanUtil.createProjectPlanIssue(projectPlannedIssue);
                            } else {
                                ProjectPlannedIssue ppi = new ProjectPlannedIssue();
                                ppi.setId(plannedId);
                                ppi.setpId(e.getPid());
                                ppi.setIssueId(e.getIssueId());
                                ppi.setPlannedBy(104);
                                ppi.setPlannedOn(date);
                                ppi.setCreatedOn(today);
                                ppi.setStatus(PlanStatus.getACTIVE().getStatus());
                                ppi.setModifiedOn(today);
                                ProjectPlanUtil.updateProjectPlanIssue(ppi);
                            }
                        }
                    }
                    List<Escalation> untouchedIssues = escalationDAO.getTodayUntouchedIssues();
                    if (untouchedIssues.size() > 0) {
                        for (Escalation e : untouchedIssues) {
                            long plannedId = ProjectPlanUtil.uniqueProjectPlan(e.getPid(), e.getIssueId(), date);
                            if (plannedId == 0l) {
                                ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(e.getPid(), e.getIssueId(), 104, date, today, today, PlanStatus.ACTIVE.getStatus());
                                ProjectPlanUtil.createProjectPlanIssue(projectPlannedIssue);
                            } else {
                                ProjectPlannedIssue ppi = new ProjectPlannedIssue();
                                ppi.setId(plannedId);
                                ppi.setpId(e.getPid());
                                ppi.setIssueId(e.getIssueId());
                                ppi.setPlannedBy(104);
                                ppi.setPlannedOn(date);
                                ppi.setCreatedOn(today);
                                ppi.setStatus(PlanStatus.getACTIVE().getStatus());
                                ppi.setModifiedOn(today);
                                ProjectPlanUtil.updateProjectPlanIssue(ppi);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
