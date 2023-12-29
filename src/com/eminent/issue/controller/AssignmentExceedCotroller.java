/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmIssueAssignment;
import com.eminent.issue.dao.ApmIssueAssignDAOImpl;
import com.eminentlabs.dao.ModelDAO;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DhanVa CompuTers
 */
public class AssignmentExceedCotroller {

    private String message, days="3", atype="3", utype="0", pid;
    ApmIssueAssignment issueAssignment = null;

    public Map<Integer, String> getAssignType() {
        Map<Integer, String> assignmentType = new HashMap<Integer, String>();
        assignmentType.put(1, "Internal");
        assignmentType.put(2, "External");
        assignmentType.put(3, "Both");
        return assignmentType;
    }

    public Map<Integer, String> getUserType() {
        Map<Integer, String> assignmentType = new HashMap<Integer, String>();
        assignmentType.put(1, "AssignedTo Users");
        assignmentType.put(2, "Module Owner/Lead");
        assignmentType.put(3, "Stake Holders/Managers");
        return assignmentType;
    }

    public void getTypes(HttpServletRequest request) {
        pid = request.getParameter("pid");
        issueAssignment = new ApmIssueAssignDAOImpl().getApmIssueAssignmentByPid(Integer.parseInt(pid));
    }

    public void setAll(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String uid = "" + session.getAttribute("uid");
        pid = request.getParameter("pid");
        days = request.getParameter("days");
        atype = request.getParameter("assignType");
        String userType[] = request.getParameterValues("userType[]");
        if (pid != null) {
            for (String type : userType) {
                utype += type + "," ;
            }
            ApmIssueAssignment aia = new ApmIssueAssignment();
            aia.setPid(Integer.parseInt(pid));
            aia.setAssignType(Integer.parseInt(atype));
            aia.setUserType(utype);
            aia.setDays(Integer.parseInt(days));
            aia.setAddedby(Integer.parseInt(uid));
            aia.setAddedon(new Date());
            ModelDAO.saveOrUpdate("ApmIssueAssignment", aia);
            message = "success";
        }
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDays() {
        return days;
    }

    public void setDays(String days) {
        this.days = days;
    }

    public String getAtype() {
        return atype;
    }

    public void setAtype(String atype) {
        this.atype = atype;
    }

    public String getUtype() {
        return utype;
    }

    public void setUtype(String utype) {
        this.utype = utype;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public ApmIssueAssignment getIssueAssignment() {
        return issueAssignment;
    }

    public void setIssueAssignment(ApmIssueAssignment issueAssignment) {
        this.issueAssignment = issueAssignment;
    }
    
    
}
