/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.controller;

import com.eminent.util.GetProjectMembers;
import com.eminent.util.GetProjects;
import com.eminentlabs.mom.MoMUtil;
import com.pack.DAO.AdminProjectModuleDAO;
import com.pack.DAO.AdminProjectModuleDAOImpl;
import com.pack.controller.formbean.EditmoduleFormBean;
import dashboard.CheckCategory;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author admin
 */
public class ViewModulesController {

    AdminProjectModuleDAO apmDAO = new AdminProjectModuleDAOImpl();
    List<EditmoduleFormBean> editModuleList = new ArrayList<EditmoduleFormBean>();
    HashMap<String, String> teamMembers = new HashMap<String, String>();
    String category;
    String projectdetails;
    String project;
    int noOfModule;
    Integer totalNoOFTarget = 0;

    public void getAll(HttpServletRequest request) {
        if ((Integer) request.getSession().getAttribute("Role") == 1) {
            int pid = MoMUtil.parseInteger(request.getParameter("pid"), 0);
            String projectId = String.valueOf(pid);
            project = GetProjects.getProjectName(projectId);
            category = "NA";
            if (project != null) {
                category = CheckCategory.getCategory(project);
            }
            teamMembers = GetProjectMembers.getTeamMembers(projectId);
            projectdetails = GetProjects.getProjectDetails(new Integer(pid).toString());
            List<EditmoduleFormBean> editModuleFormBeanList = apmDAO.getModuleByPID(pid);
            Map<Integer, Integer> map = apmDAO.getModuletargetByMonth(pid);
            for (EditmoduleFormBean editModule : editModuleFormBeanList) {
                if (map == null || map.isEmpty()) {
                    editModule.setTarget(0);
                } else {
                    int count = 0;
                    for (Map.Entry<Integer, Integer> entrySet : map.entrySet()) {
                        if (editModule.getModuleid().intValue() == entrySet.getKey().intValue()) {
                            editModule.setTarget(entrySet.getValue());
                            count = 1;
                        }
                    }
                    if (count == 0) {
                        editModule.setTarget(0);
                    }
                }
                editModuleList.add(editModule);
            }

        }

    }

    public void getAllEditProject(HttpServletRequest request) {
        int pid = MoMUtil.parseInteger(request.getParameter("pid"), 0);
        Map<Integer, Integer> map = apmDAO.getModuletargetByMonth(pid);
        for (Map.Entry<Integer, Integer> entrySet : map.entrySet()) {
            totalNoOFTarget = totalNoOFTarget + entrySet.getValue();

        }
    }

    public List<EditmoduleFormBean> addTargetCountAjax(HttpServletRequest request) {
        int pid = MoMUtil.parseInteger(request.getParameter("pid"), 0);
        List<EditmoduleFormBean> emlist = apmDAO.getModuleTargetByPID(pid);
        Map<Integer, String> map = apmDAO.getAllModuleByProject(pid);

        for (Map.Entry<Integer, String> entrySet : map.entrySet()) {
            EditmoduleFormBean editModule = new EditmoduleFormBean();
            editModule.setModule(entrySet.getValue());
            editModule.setModuleid(entrySet.getKey());
            int count = 0;
            for (EditmoduleFormBean emfb : emlist) {
                if (emfb.getModuleid().intValue() == entrySet.getKey().intValue()) {
                    editModule.setTarget(emfb.getTarget());
                    editModule.setTargetId(emfb.getTargetId());
                    count = 1;
                }
            }
            if (count == 0) {
                editModule.setTarget(0);
                editModule.setTargetId(0);
            }
            editModuleList.add(editModule);
        }
        return editModuleList;
    }

    public String getTragetCountByModule(HttpServletRequest request) {
        int mid = MoMUtil.parseInteger(request.getParameter("mid"), 0);
        EditmoduleFormBean emfb = apmDAO.getEditModuleByMid(mid);
        if (emfb == null) {
            emfb = new EditmoduleFormBean();
            emfb.setTargetId(0);
            emfb.setTarget(0);
        }

        String target = emfb.getTargetId() + "-" + emfb.getTarget();
        return target;
    }

    public String saveUpdateModuleTarget(HttpServletRequest request) {

        String currtform = request.getParameter("currtform");
        String[] target = currtform.split("\\n");

        String res = apmDAO.saveUpdate(target);
        return res;
    }

    public List<EditmoduleFormBean> getEditModuleList() {
        return editModuleList;
    }

    public void setEditModuleList(List<EditmoduleFormBean> editModuleList) {
        this.editModuleList = editModuleList;
    }

    public HashMap<String, String> getTeamMembers() {
        return teamMembers;
    }

    public void setTeamMembers(HashMap<String, String> teamMembers) {
        this.teamMembers = teamMembers;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getProjectdetails() {
        return projectdetails;
    }

    public void setProjectdetails(String projectdetails) {
        this.projectdetails = projectdetails;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public int getNoOfModule() {
        return noOfModule;
    }

    public void setNoOfModule(int noOfModule) {
        this.noOfModule = noOfModule;
    }

    public Integer getTotalNoOFTarget() {
        if (totalNoOFTarget == null) {
            totalNoOFTarget = 0;
        }
        return totalNoOFTarget;
    }

    public void setTotalNoOFTarget(Integer totalNoOFTarget) {
        this.totalNoOFTarget = totalNoOFTarget;
    }

}
