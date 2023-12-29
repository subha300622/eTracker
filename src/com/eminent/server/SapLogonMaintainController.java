/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

import com.eminent.util.GetProjectManager;
import com.eminentlabs.dao.ModelDAO;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author DhanVa CompuTers
 */
public class SapLogonMaintainController {

    String message = null;
    Map<Integer, List<String>> basisMembers = null;
    Map<Integer, String> projects = null;
    List<ApmSapLogonMaintain> sapLogonMaintains = null;
    Map<Integer, String> companyCodes = null;
    ApmSapLogonMaintain sapLogonMaintain = null;
    int serverId = 1, companyCode = 0;

    public void setAll(HttpServletRequest request) {
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
                String[] pids = request.getParameterValues("pid");
                String[] userid = request.getParameterValues("userid");
                if (pids != null) {
                    for (int i = 0; i < pids.length; i++) {
                        ApmSapLogonMaintain aslm = new ApmSapLogonMaintain();
                        aslm.setPid(Integer.parseInt(pids[i]));
                        aslm.setUserid(Integer.parseInt(userid[i]));
                        ModelDAO.saveOrUpdate("ApmSapLogonMaintain", aslm);
                    }
                    message = "SAP logon maintainer has been maintained successfully";
                }
            }
            basisMembers = GetProjectManager.getBasisMembersByProjects();
            sapLogonMaintains = new ServerDAOImpl().getAll();
            projects = GetProjectManager.getWIPProjects();
        } catch (Exception e) {
            message = "Something went wrong." + e.getMessage();
        }
    }

    public void getSapMaintain(int pid) {
        sapLogonMaintain = new ServerDAOImpl().getLogonMaintainByPid(pid);
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<Integer, List<String>> getBasisMembers() {
        return basisMembers;
    }

    public void setBasisMembers(Map<Integer, List<String>> basisMembers) {
        this.basisMembers = basisMembers;
    }

    public Map<Integer, String> getProjects() {
        return projects;
    }

    public void setProjects(Map<Integer, String> projects) {
        this.projects = projects;
    }

    public List<ApmSapLogonMaintain> getSapLogonMaintains() {
        return sapLogonMaintains;
    }

    public void setSapLogonMaintains(List<ApmSapLogonMaintain> sapLogonMaintains) {
        this.sapLogonMaintains = sapLogonMaintains;
    }

    public ApmSapLogonMaintain getSapLogonMaintain() {
        return sapLogonMaintain;
    }

    public void setSapLogonMaintain(ApmSapLogonMaintain sapLogonMaintain) {
        this.sapLogonMaintain = sapLogonMaintain;
    }

}
