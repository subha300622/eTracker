/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler.controller;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminent.util.ProjectPlanUtil;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.mom.MoMUtil;
import static com.eminentlabs.mom.MoMUtil.getTaskId;
import static com.eminentlabs.mom.MoMUtil.subtractDay;
import static com.eminentlabs.mom.MoMUtil.uniqueIssueTask;
import com.eminentlabs.mom.MomUserTask;
import com.eminentlabs.mom.controller.MomMaintananceController;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.log4j.Logger;

/**
 *
 * @author EMINENT
 */
public class NextDayScheduler {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("NextDayScheduler");
    }

    public void executeme() {
        MomMaintananceController maintananceController = new MomMaintananceController();
        Calendar cat = new GregorianCalendar();
        Date dateToday = cat.getTime();
        SimpleDateFormat time = new SimpleDateFormat("HH");
        String timeFor = time.format(dateToday);
        int current_time = Integer.parseInt(timeFor);

        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        date = MoMUtil.nextDay(date);
        String dateFor = sdf.format(date);
        boolean flag = true;
        while (flag == true) {
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(date);
            if (!holidaysList.isEmpty()) {
                date = MoMUtil.nextDay(date);
            } else {
                flag = false;
            }
        }
        List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(date);
        Map<Integer, List<String>> planIssueByUser = new HashMap<Integer, List<String>>();
        planIssueByUser = MoMUtil.todayPlannedIssuesByUser(dateFor);
        List<String> plannedIssues = new ArrayList<String>();
        if (holidaysList.isEmpty()) {
            maintananceController.setSendMomAll();
            int adminId = GetProjectMembers.getAdminID();
            maintananceController.setSendMomAll();
            Set<Integer> momUserIds = maintananceController.getTotalUsers();
            try {

                for (Map.Entry<Integer, List<String>> issues : planIssueByUser.entrySet()) {
                    for (String issueId : issues.getValue()) {
                        MomUserTask usertask = new MomUserTask();
                        HashMap issue = IssueDetails.getIssue(issueId);
                        int userId = MoMUtil.parseInteger(((String) issue.get("assignedto")), 0);
                        String sub = (String) issue.get("subject");
                        String status = (String) issue.get("status");
                        if (!status.equalsIgnoreCase("Closed")) {

                            String duedate = (String) issue.get("Formatduedate");
                            String pName = (String) issue.get("projectname") + " v" + (String) issue.get("fixversion");
                            Date duDate = sdf.parse(duedate);
                            Date currentDate = new Date();
                            String statusColor = "";
                            currentDate = subtractDay(currentDate);
                            if (duDate.compareTo(currentDate) < 0) {
                                statusColor = "Red";
                            }
                            String task = issueId;
                            if ("".equals(statusColor)) {
                                if (sub != null) {
                                    task = task + ":" + pName + " # " + status + " : " + sub;
                                }
                            } else {
                                task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : " + sub + "</font>";
                            }
                            usertask.setMomtaskid(getTaskId());
                            usertask.setUserid(userId);
                            usertask.setTask(task);
                            usertask.setCreatedby(adminId);
                            usertask.setCreatedon(new Date());
                            usertask.setModifiedon(date);
                            usertask.setMomdate(date);
                            usertask.setType("Issue");
                            usertask.setTasktime("Planned");
                            boolean flaga = true;
                            String momtaskid = uniqueIssueTask(userId, dateFor, issueId, "Planned");
                            if (momtaskid == null) {
                                flaga = false;
                            }
                            if (flaga == false) {
                                if (issues.getKey().equals(userId)) {
                                    DAOFactory.createTask(usertask);
                                } else {
                                    MoMUtil.deleteTaskByIssueAndUserId(dateFor, issueId, issues.getKey());
                                    task = issueId;
                                    if (momUserIds.contains(userId)) {
                                        if ("".equals(statusColor)) {
                                            if (sub != null) {
                                                if (current_time > 18) {
                                                    task = task + ":" + pName + " # " + status + " : <b style='background-color:#E8EEF7;'>" + sub + "</b>";
                                                } else {
                                                    task = task + ":" + pName + " # " + status + " : " + sub;
                                                }
                                            }
                                        } else {
                                            if (current_time > 18) {
                                                task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : <b style='background-color:#E8EEF7;'>" + sub + "</b>";
                                            } else {
                                                task = task + ":" + pName + " # <font color='" + statusColor + "'>" + status + "</font> : " + sub;
                                            }

                                        }
                                        usertask.setTask(task);
                                        DAOFactory.createTask(usertask);
                                    }
                                }
                            }

                        } else {
                            MoMUtil.deleteTaskByIssue(dateFor, issueId);
                        }
                    }
                }
                planIssueByUser = MoMUtil.todayPlannedIssuesByUser(dateFor);
                for (List<String> value : planIssueByUser.values()) {
                    plannedIssues.addAll(value);
                }
                List<ProjectPlannedIssue> dayWisePlan = ProjectPlanUtil.findByDay(date);
                for (ProjectPlannedIssue ppi : dayWisePlan) {
                    if (!plannedIssues.contains(ppi.getIssueId())) {
                        ppi.setStatus(PlanStatus.INACTIVE.getStatus());
                        ppi.setModifiedOn(date);
                        ProjectPlanUtil.updateProjectPlanIssue(ppi);
                    }
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {

            }
        }
    }
}
