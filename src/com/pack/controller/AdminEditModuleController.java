/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.controller;

import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.MoMUtil;
import com.pack.controller.formbean.EditmoduleFormBean;
import com.pack.DAO.AdminProjectModuleDAO;
import com.pack.DAO.AdminProjectModuleDAOImpl;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author admin
 */
public class AdminEditModuleController {

    Logger logger = Logger.getLogger("moduleupdate");

    AdminProjectModuleDAO apmDAO = new AdminProjectModuleDAOImpl();

    public void setAllModuleByProject(HttpServletRequest request) {
        if (request.getMethod().equalsIgnoreCase("post")) {
            int mid = Integer.parseInt(request.getParameter("mid"));
            String module = request.getParameter("module");
            String customerOwner = request.getParameter("customerOwner");
            String internalOwner = request.getParameter("internalOwner");
            String targetId = request.getParameter("targetId");
            String moduleTarget = request.getParameter("moduleTarget");
            int cOwner = 0;
            int iOwner = 0;
            int tid = 0;
            int mtarget = 0;
            if (customerOwner != null && customerOwner.length() != 0) {
                cOwner = MoMUtil.parseInteger(customerOwner, 0);

            }
            if (internalOwner != null && internalOwner.length() != 0) {
                iOwner = MoMUtil.parseInteger(internalOwner, 0);
            }
            if (targetId != null && targetId.length() != 0) {
                tid = MoMUtil.parseInteger(targetId, 0);
            }
            if (moduleTarget != null && moduleTarget.length() != 0) {
                mtarget = MoMUtil.parseInteger(moduleTarget, 0);
            }
            if (module != null) {
                module = module.trim();
            }
            int pid = Integer.parseInt(request.getParameter("pid"));

            apmDAO.moduleUpdate(mid, module, cOwner, iOwner, pid, mtarget, tid);
        }

    }

    public EditmoduleFormBean getAllModuleByProject(HttpServletRequest request) {
        EditmoduleFormBean emfb;
        int mid = MoMUtil.parseInteger(request.getParameter("mid"), 0);
        emfb = apmDAO.getEditModuleByMid(mid);
        String projectId = String.valueOf(emfb.getPid());
        HashMap<String, String> teamMembers = GetProjectMembers.getAllTeamMembers(projectId);
        teamMembers = GetProjectMembers.sortHashMapByKeys(teamMembers, true);
        HashMap<Integer, String> eminentUsers = GetProjectMembers.getEminentUsers();
        emfb.setTeamMembers(teamMembers);
        emfb.setEminentUsers(eminentUsers);
        return emfb;
    }

    /*Add Module for project*/
    public String addModuleForProjet(HttpServletRequest request) {
        String res = "false";
        String mname = request.getParameter("mname");
        int pid = (Integer) request.getSession().getAttribute("projectid");
        int target = MoMUtil.parseInteger(request.getParameter("moduleTarget"), 0);
        System.out.println("mname" + mname + " pid " + pid + " target" + " " + target);
        if (mname != null) {
            mname = mname.trim();
        }
        if (pid != 0) {
            res = apmDAO.CreateNewModule(mname, pid, target);
        }
        return res;
    }

    public String alreadyExitsModule(HttpServletRequest request) {
        String res = "false";
        String mname = request.getParameter("mname");

        int pid = MoMUtil.parseInteger(request.getParameter("pid"), 0);
        if (pid != 0) {
            res = apmDAO.checkExistModule(mname, pid);
        } else {
            res = "false";
        }
        
        return res;
    }
}
