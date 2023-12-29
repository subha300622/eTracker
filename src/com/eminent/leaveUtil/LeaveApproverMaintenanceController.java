/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Muthu
 */
public class LeaveApproverMaintenanceController {

    Map<Integer, String> eminentUsers;
    Map<Integer, String> availRequesters;
    private String message;
    List<LeaveApproverMaintenance> approverRoles;
    List<LeaveApproverMaintenance> leaveApproverMaintenance;
    private String id = null;

    public void setAll(HttpServletRequest request) {
        eminentUsers = GetProjectMembers.getEminentUsersOrder();
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
                String[] requesters = request.getParameterValues("selectItemrequesters");
                String[] approvers = request.getParameterValues("approver");
                if (requesters == null) {
                } else {
                    int level = 1;
                    for (String requester : requesters) {
                        level = 1;
                        LeaveApproverDAO.deleteByRequester(MoMUtil.parseInteger(requester, 0));
                        for (String approver : approvers) {
                            LeaveApproverMaintenance lam = new LeaveApproverMaintenance();
                            lam.setApprovalId(0l);
                            lam.setRequester(MoMUtil.parseInteger(requester, 0));
                            lam.setApprover(MoMUtil.parseInteger(approver, 0));
                            lam.setApprovalLevel(level);
                            lam.setAddedon(new Date());
                            lam.setModifiedon(new Date());
                            ModelDAO.save("LeaveApproverMaintenance", lam);
                            level++;
                        }
                    }
                    id = null;
                    message = "Leave Approver maintained successfully";
                }
            } else {
                if (request.getParameter("id") != null) {
                    id = request.getParameter("id");
                }
                if (id != null) {
                    leaveApproverMaintenance = LeaveApproverDAO.findByRequester(MoMUtil.parseInteger(id, 0));
                }
            }
            approverRoles = LeaveApproverDAO.findAll();
            if (approverRoles == null) {
            } else {
                availRequesters = new HashMap<>();
                availRequesters.putAll(eminentUsers);
                for (LeaveApproverMaintenance tm : approverRoles) {
                    availRequesters.remove(tm.getRequester());
                }
            }
        } catch (Exception e) {
            message = "Something went wrong." + e.getMessage();
            e.printStackTrace();
        }
    }

    public String deleteLeaveApprover(HttpServletRequest request) {
        String res = "failure";
        try {
            long approvalId = MoMUtil.parseLong(request.getParameter("id"), 0l);
            LeaveApproverMaintenance lam = LeaveApproverDAO.findByApprovalId(approvalId);
            if (lam != null) {
                    int count = LeaveUtil.getLeaveCount(lam.getRequester(), lam.getApprover());
                    if (count == 0) {                        
                        res = LeaveApproverDAO.deleteById(approvalId);
                    } else {
                        res = "Cant be delete. Leave request is pending for approval for this requester";
                    }
                }
        } catch (Exception e) {
            res = "failure." + e.getMessage();
            e.printStackTrace();
        }

        return res;
    }

    public Map<Integer, String> getEminentUsers() {
        return eminentUsers;
    }

    public void setEminentUsers(Map<Integer, String> eminentUsers) {
        this.eminentUsers = eminentUsers;
    }

    public Map<Integer, String> getAvailRequesters() {
        return availRequesters;
    }

    public void setAvailRequesters(Map<Integer, String> availRequesters) {
        this.availRequesters = availRequesters;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<LeaveApproverMaintenance> getApproverRoles() {
        return approverRoles;
    }

    public void setApproverRoles(List<LeaveApproverMaintenance> approverRoles) {
        this.approverRoles = approverRoles;
    }

    public List<LeaveApproverMaintenance> getLeaveApproverMaintenance() {
        return leaveApproverMaintenance;
    }

    public void setLeaveApproverMaintenance(List<LeaveApproverMaintenance> leaveApproverMaintenance) {
        this.leaveApproverMaintenance = leaveApproverMaintenance;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

}
