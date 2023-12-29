/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.controller;

import com.eminent.branch.BranchDAO;
import com.eminent.branch.BranchDAOImpl;
import com.eminent.branch.Branches;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.SendMomMaintenance;
import com.eminentlabs.mom.SendMomMaintenanceDAO;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author vanithaalliraj
 */
public class SendMomMaintainController {

    List<SendMomMaintenance> sendMomMaintenances;
    Map<Integer, String> eminentUsers;
    Map<Integer, String> momTypeList;
    Map<Integer, String> branchMap;
    String message, id;
    SendMomMaintenance sendMomMaintenance;

    public void setAll(HttpServletRequest request) {
        try {
            eminentUsers = GetProjectMembers.getEminentUsersOrder();
            momTypeList = momTypeMaintanance();
            BranchDAO branchDAO = new BranchDAOImpl();
            List<Branches> branchesa = branchDAO.findAll();
            branchMap = new HashMap<>();
            branchMap.put(0, "All Location");
            for (Branches b : branchesa) {
                branchMap.put(b.getBranchId(), b.getLocation());
            }

            if (request.getMethod().equalsIgnoreCase("post")) {
                String[] userId = request.getParameterValues("userid");
                String[] momType = request.getParameterValues("momType");
                String[] branch = request.getParameterValues("branch");
                for (int i = 0; i < userId.length; i++) {
                    SendMomMaintenance smm = SendMomMaintenanceDAO.findByRequester(MoMUtil.parseInteger(userId[i], 0));
                    if (smm.getId() == null) {
                        smm.setId(0);
                        smm.setUserId(MoMUtil.parseInteger(userId[i], 0));
                        smm.setMomType(MoMUtil.parseInteger(momType[i], 0));
                        smm.setBranchId(MoMUtil.parseInteger(branch[i], 0));
                        ModelDAO.save("SendMomMaintenance", smm);
                    } else {
                        smm.setUserId(MoMUtil.parseInteger(userId[i], 0));
                        smm.setMomType(MoMUtil.parseInteger(momType[i], 0));
                        smm.setBranchId(MoMUtil.parseInteger(branch[i], 0));
                        ModelDAO.update("SendMomMaintenance", smm);
                    }
                }
                id = null;
                message = "Send MoM maintained successfully";

            } else {
                if (request.getParameter("id") != null) {
                    id = request.getParameter("id");
                }
                if (id != null) {
                    sendMomMaintenance = SendMomMaintenanceDAO.findByRequester(MoMUtil.parseInteger(id, 0));
                }
            }
            sendMomMaintenances = SendMomMaintenanceDAO.findAll();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public String deleteSendMomByUser(HttpServletRequest request) {
        String res = "failure";
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            res = SendMomMaintenanceDAO.deleteById(id);
        } catch (Exception e) {
            res = "failure." + e.getMessage();
            e.printStackTrace();
        }

        return res;
    }

    public void getLocationNBranch(int userid) {
        sendMomMaintenance = SendMomMaintenanceDAO.findByRequester(userid);
    }

    public Map<Integer, String> momTypeMaintanance() {
        Map<Integer, String> userType = new LinkedHashMap<Integer, String>();
        userType.put(0, "All");
        userType.put(1, "Technical");
        userType.put(2, "Functional");
        return userType;
    }

    public List<SendMomMaintenance> getSendMomMaintenances() {
        return sendMomMaintenances;
    }

    public void setSendMomMaintenances(List<SendMomMaintenance> sendMomMaintenances) {
        this.sendMomMaintenances = sendMomMaintenances;
    }

    public Map<Integer, String> getEminentUsers() {
        return eminentUsers;
    }

    public void setEminentUsers(Map<Integer, String> eminentUsers) {
        this.eminentUsers = eminentUsers;
    }

    public Map<Integer, String> getMomTypeList() {
        return momTypeList;
    }

    public void setMomTypeList(Map<Integer, String> momTypeList) {
        this.momTypeList = momTypeList;
    }

    public Map<Integer, String> getBranchMap() {
        return branchMap;
    }

    public void setBranchMap(Map<Integer, String> branchMap) {
        this.branchMap = branchMap;
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

    public SendMomMaintenance getSendMomMaintenance() {
        return sendMomMaintenance;
    }

    public void setSendMomMaintenance(SendMomMaintenance sendMomMaintenance) {
        this.sendMomMaintenance = sendMomMaintenance;
    }

}
