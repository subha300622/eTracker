/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.controller;

import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.MomMaintanance;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author EMINENT
 */
public class SendMomController {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger(SendMomController.class.getName());
    }
    private int momTeamType, branch = 0;
    private int userId;
    Map<Integer, String> momTypeList = new LinkedHashMap<Integer, String>();
    Map<Integer, List<MomMaintanance>> mmcSplit = new LinkedHashMap<Integer, List<MomMaintanance>>();
    List<MomMaintanance> momUsers = new ArrayList<MomMaintanance>();

    public void setAll(HttpServletRequest request) {
        HttpSession session = request.getSession();
        userId = (Integer) session.getAttribute("userid_curr");
        String momTeamsType = request.getParameter("momTeamType");
        MomMaintananceController mmc = new MomMaintananceController();
        ViewMomController vmc = new ViewMomController();
        List<MomMaintanance> mmList = mmc.findAll();
        MomMaintanance mm = mmc.findByList(mmList, userId);
        momTypeList = vmc.momTypeMaintanance();
        Map<Integer, Set<Integer>> branchwiseUsers = GetProjectMembers.getUsersByBranch();
        SendMomMaintainController smmc = new SendMomMaintainController();
        smmc.getLocationNBranch(userId);

        if (mm == null) {
            if (momTeamsType == null) {
                momTeamType = smmc.getSendMomMaintenance().getMomType() == null ? 0 : smmc.getSendMomMaintenance().getMomType();
            } else {
                momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
            }
        } else {
            if (momTeamsType == null) {
                momTeamType = smmc.getSendMomMaintenance().getMomType() == null ? mm.getTeam() : smmc.getSendMomMaintenance().getMomType();
            } else {
                if ("".equals(momTeamsType)) {

                } else {
                    momTeamType = mm.getTeam();
                    momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
                }
            }
        }

        String branchId = request.getParameter("branch");
        if (branchId != null) {
            if ("".equals(branchId)) {
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = smmc.getSendMomMaintenance().getBranchId() == null ? (Integer) session.getAttribute("branch") : smmc.getSendMomMaintenance().getBranchId();
        }
        if (branch > 0) {
            List<MomMaintanance> momUsersa = new ArrayList<MomMaintanance>();
            Set<Integer> users = branchwiseUsers.get(branch);
            if (users == null) {
                mmList.clear();
            } else {
                for (MomMaintanance mmce : mmList) {
                    for (Integer user : users) {
                        if (user == mmce.getUserid()) {
                            momUsersa.add(mmce);
                        }
                    }
                }
                mmList.clear();
                mmList.addAll(momUsersa);
            }
        }
        mmcSplit = mmc.splitLists(mmList);

        if (momTeamType == 1) {
            if (mmcSplit.get(1) != null) {

                momUsers = mmcSplit.get(1);
            }
            mmcSplit.remove(2);
            mmcSplit.remove(3);
        } else if (momTeamType == 2 || momTeamType == 3) {
            if (mmcSplit.get(2) != null) {

                momUsers.addAll(mmcSplit.get(2));
            }
            if (mmcSplit.get(3) != null) {
                momUsers.addAll(mmcSplit.get(3));
            }
            momTeamType = 2;
            mmcSplit.remove(1);
        } else {
            momUsers.addAll(mmList);
        }

    }

    public int getMomTeamType() {
        return momTeamType;
    }

    public void setMomTeamType(int momTeamType) {
        this.momTeamType = momTeamType;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Map<Integer, String> getMomTypeList() {
        return momTypeList;
    }

    public void setMomTypeList(Map<Integer, String> momTypeList) {
        this.momTypeList = momTypeList;
    }

    public List<MomMaintanance> getMomUsers() {
        return momUsers;
    }

    public void setMomUsers(List<MomMaintanance> momUsers) {
        this.momUsers = momUsers;
    }

    public Map<Integer, List<MomMaintanance>> getMmcSplit() {
        return mmcSplit;
    }

    public void setMmcSplit(Map<Integer, List<MomMaintanance>> mmcSplit) {
        this.mmcSplit = mmcSplit;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

}
