package com.eminentlabs.timesheet.controller;

import com.eminent.timesheet.TimesheetMaintanance;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.timesheet.dao.TimesheetDAO;
import com.eminentlabs.timesheet.dao.TimesheetDAOImpl;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author EMINENT
 */
public class TimeSheetMaintananceController {

    Map<Integer, String> eminentUsers;
    Map<Integer, String> availRequesters;
    private String message;
    List<TimesheetMaintanance> approverRoles;
    private String id = null;
    TimesheetMaintanance timesheetMaintanance = new TimesheetMaintanance();

    public void setAll(HttpServletRequest request) {
        TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
        eminentUsers = GetProjectMembers.getEminentUsersOrder();
        int needInfoId = 0;

        try {
            if (request.getParameter("id") != null) {
                id = request.getParameter("id");
            }

            if (request.getMethod().equalsIgnoreCase("Post")) {

                String[] requesters = request.getParameterValues("selectItemrequesters");
                if (requesters == null) {
                } else {
                    String needInfo = request.getParameter("needInfo");
                    int reimbursement = MoMUtil.parseInteger(request.getParameter("reimbursement"), 0);
                    int accounts = MoMUtil.parseInteger(request.getParameter("accounts"), 0);
                    int attendance = MoMUtil.parseInteger(request.getParameter("attendance"), 0);
                    int timesheet = MoMUtil.parseInteger(request.getParameter("timesheet"), 0);
                    if (needInfo == null) {
                    } else {
                        needInfoId = MoMUtil.parseInteger(request.getParameter("needInfo"), 0);
                    }
                    System.out.println("Id : " + id + "\t reimbursement : " + reimbursement + "\t accounts : " + accounts + "\t attendance : " + attendance + "\t timesheet : " + timesheet + "\t needInfoId : " + needInfoId);
                    for (String requester : requesters) {
                        System.out.println("requesters : " + requester);
                        TimesheetMaintanance tm = new TimesheetMaintanance();
                        tm.setRequester(MoMUtil.parseInteger(requester, 0));
                        tm.setNeedinfoApprover(needInfoId);
                        tm.setAccountsApprover(accounts);
                        tm.setAttendanceApprover(attendance);
                        tm.setTimesheetApprover(timesheet);
                        tm.setReimbursementApprover(reimbursement);
                        tm.setCreatedon(new Date());
                        tm.setModifiedon(new Date());
                        if (id.equals("null")) {
                            ModelDAO.save("TimesheetMaintanance", tm);
                            message = "Approvers added successfully.";
                        } else {
                            tm.setModifiedon(new Date());
                            tm.setId(MoMUtil.parseLong(id, 0l));
                            ModelDAO.update("TimesheetMaintanance", tm);
                            message = "Approvers updated successfully.";
                        }
                    }
                }
                id = null;
            } else {
                if (id != null) {
                    timesheetMaintanance = timesheetDAO.findById(MoMUtil.parseLong(id, 0l));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (id == null) {
            timesheetMaintanance.setAccountsApprover(0);
            timesheetMaintanance.setAttendanceApprover(0);
            timesheetMaintanance.setTimesheetApprover(0);
            timesheetMaintanance.setReimbursementApprover(0);
            timesheetMaintanance.setRequester(0);
            timesheetMaintanance.setNeedinfoApprover(0);
        }
        approverRoles = timesheetDAO.findAll();
        if(approverRoles.isEmpty()){            
        }else{
            availRequesters = new HashMap<>();
            availRequesters.putAll(eminentUsers);
              for(TimesheetMaintanance tm:approverRoles){
           availRequesters.remove(tm.getRequester());
       }
        }     
    }

    public Map<Integer, String> getTimeaheetApproverRoles() {
        Map<Integer, String> timesheet = new LinkedHashMap<Integer, String>();
        timesheet.put(0, "Timesheet Approver");
        timesheet.put(1, "Attendance Approver");
        timesheet.put(2, "Accounts Approver");
        timesheet.put(3, "Reimbursement Approver");

        return timesheet;

    }

    public Map<Integer, String> getEminentUsers() {
        return eminentUsers;
    }

    public void setEminentUsers(Map<Integer, String> eminentUsers) {
        this.eminentUsers = eminentUsers;
    }

    public List<TimesheetMaintanance> getApproverRoles() {
        return approverRoles;
    }

    public void setApproverRoles(List<TimesheetMaintanance> approverRoles) {
        this.approverRoles = approverRoles;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public TimesheetMaintanance getTimesheetMaintanance() {
        return timesheetMaintanance;
    }

    public void setTimesheetMaintanance(TimesheetMaintanance timesheetMaintanance) {
        this.timesheetMaintanance = timesheetMaintanance;
    }

    public Map<Integer, String> getAvailRequesters() {
        return availRequesters;
    }

    public void setAvailRequesters(Map<Integer, String> availRequesters) {
        this.availRequesters = availRequesters;
    }

}
