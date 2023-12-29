/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.AgreedIssues;
import com.eminent.issue.dao.IssueDAO;
import com.eminent.issue.dao.IssueDAOImpl;
import com.eminent.util.GetProjectManager;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author QSERVER
 */
public class IssueSearchController {
static Logger logger = null;

    static {
        logger = Logger.getLogger("IssueSearchController");
    }

    public String checkPMorDMForProjects(HttpServletRequest request) {
        String result ="true";
        String project[] = request.getParameter("project").split(",");
        Set<String> set = new HashSet<>(Arrays.asList(project));
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
        try {
            List<String> projects = GetProjectManager.getProjectNameByPmDM(userId);
            set.removeAll(projects);
            if(!set.isEmpty()){
                result ="You are not PM/DM for "+set.toString()+" . Please uncheck those issues";
            }
        } catch (Exception e) {
            logger.error("checkPMorDMForProjects :" + e.getMessage());
            result ="failure";
        }
        return result;
    }
    public String updateAgreedIssues(HttpServletRequest request) {
        String result ="success";
        String issues[] = request.getParameter("issues").split(",");
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
        IssueDAO issueDAO = new  IssueDAOImpl();
        StringBuilder sb = new StringBuilder();
        try {
            for (String issId : issues) {
                sb.append("'").append(issId).append("'").append(",");
            }
           HashMap<String,Integer> hashMap = issueDAO.getPIdForIssues(sb.substring(0, sb.length()-1));
           for(Map.Entry<String,Integer> entry:hashMap.entrySet()){
                            AgreedIssues ai = new AgreedIssues();
                ai.getAgreedIssuesPK().setIssueId(entry.getKey());
                ai.setProjectId(entry.getValue());
                ai.setAddedby(userId);
                ai.setAddedon(new Date());
                ai.setStatus(0);
                ai.getAgreedIssuesPK().setIssueType("Agreed");
                ModelDAO.saveOrUpdate("AgreedIssues", ai);   
           }
            
        } catch (Exception e) {
            logger.error("updateAgreedIssues :" + e.getMessage());
            result ="Something went wrong."+e.getMessage();
        }
        return result;
    }
    
}
