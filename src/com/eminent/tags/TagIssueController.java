/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.tag.dao.TagDAO;
import com.eminent.tag.dao.TagDAOImpl;
import com.eminent.tag.dao.TagIssueDAO;
import com.eminent.tag.dao.TagIssueDAOImpl;
import com.eminent.util.GetAge;
import com.eminent.util.IssueDetails;
import com.eminentlabs.mom.MoMUtil;
import dashboard.dao.MydashboardDAO;
import dashboard.dao.MydashboardDAOImpl;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author EMINENT
 */
public class TagIssueController {
    
    static Logger logger = null;
    MydashboardDAO mydeshboardDAO = new MydashboardDAOImpl();
    
    TagIssueDAO tagIssueDAO = new TagIssueDAOImpl();
    TagDAO tagDAO = new TagDAOImpl();
    private String totalTagIssues = "";
    List<IssueFormBean> listIssueFormBean = new ArrayList<IssueFormBean>();
    Map<String, Integer> fileCountList = new HashMap<String, Integer>();
    HashMap<Integer, String> userMap = new HashMap<Integer, String>();
    Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
    Map<String, Integer> ageofIssue = new HashMap<String, Integer>();
    
    static {
        logger = Logger.getLogger("TagIssueController");
    }
    
    public void doAction(HttpServletRequest request) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("create")) {
            
            Long tagId = MoMUtil.parseLong(request.getParameter("tagId"), 0l);
            Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
            String issueId[] = request.getParameter("issueId").split(",");
            for (String issId : issueId) {
                String res = tagIssueDAO.findAllTagIsuueByIssueAndTag(issId, tagId, userId);
                if (res.equalsIgnoreCase("false")) {
                    TagIssues tagissue = new TagIssues();
                    tagissue.setId(0l);
                    tagissue.setTagId(new Tags(tagId));
                    tagissue.setUserId(userId);
                    tagissue.setIssueId(issId);
                    tagIssueDAO.addTagIssues(tagissue);
                }
                
            }
            
        }
    }
    
    public List<String> getIssueByTagId(HttpServletRequest request) {
        Long tagId = MoMUtil.parseLong(request.getParameter("tagid"), 0);
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
        List<String> list = new ArrayList<String>();
        if (tagId == 0) {
        } else {
            list =tagIssueDAO.findAllIssuesByTagId(tagId);
                  //  tagIssueDAO.findAllIssuesByTagIdAndUser(tagId, userId);
        }
        return list;
    }
    
    public String deleteTagIssue(HttpServletRequest request) {
        Long tagId = MoMUtil.parseLong(request.getParameter("tagId"), 0);
        String issueId = request.getParameter("issueId").trim();
        String res = tagIssueDAO.deleteTagIssueByIssue(issueId, tagId);
        return res;
    }
    
    
    public void getAllIssueByTag(HttpServletRequest request) {
        try {
            Long tagId = 0l;
            List<Long> list = new ArrayList<Long>();
            if (request.getParameter("tagId").equalsIgnoreCase("onload")) {
                Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
                List<Tags> listtag = tagDAO.findTagsByUserId(userId);
                if (listtag.isEmpty()) {
                } else {
                    for (Tags listt : listtag) {
                        list.add(listt.getTagId());
                    }
                }
            } else {
                tagId = MoMUtil.parseLong(request.getParameter("tagId"), 0l);
                list.add(tagId);
            }
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            userMap = mydeshboardDAO.getUser();
            listIssueFormBean = tagIssueDAO.getAllIssueByTag(list);
            if (listIssueFormBean.isEmpty()) {
            } else {
                
                String totalIssue = "";
                int i = 0;
                for (IssueFormBean issueFormBean : listIssueFormBean) {
                    if (i == 0) {
                        totalIssue = "'" + issueFormBean.getIssueId() + "'";
                    } else {
                        totalIssue = totalIssue + ",'" + issueFormBean.getIssueId() + "'";
                    }
                    i++;
                    issueFormBean.setCreatedOn(sdf.format(issueFormBean.getCreated()));
                    issueFormBean.setModifiedOn(sdf.format(issueFormBean.getModifiedDate()));
                    issueFormBean.setDueDate(sdf.format(issueFormBean.getDuedateOn()));
                    int age = GetAge.getIssueAge(issueFormBean.getCreatedOn(), issueFormBean.getStatus(), issueFormBean.getModifiedOn());
                    ageofIssue.put(issueFormBean.getIssueId(), age);
                    
                    if (issueFormBean.getStatus().equalsIgnoreCase("Closed")) {
                        if (issueFormBean.getRating() != null) {
                            if (issueFormBean.getRating().equalsIgnoreCase("Excellent")) {
                                issueFormBean.setRatingColor("#336600");
                                
                            } else if (issueFormBean.getRating().equalsIgnoreCase("Good")) {
                                issueFormBean.setRatingColor("#33CC66");
                                
                            } else if (issueFormBean.getRating().equalsIgnoreCase("Average")) {
                                issueFormBean.setRatingColor("#CC9900");
                                
                            } else if (issueFormBean.getRating().equalsIgnoreCase("Need Improvement")) {
                                issueFormBean.setRatingColor("#CC0000");
                                
                            }
                        }
                        
                    }
                    
                }
                if (totalIssue.contains(",")) {
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalIssue);
                    fileCountList = IssueDetails.displayFilesCount(totalIssue);
                }
            }
            
        } catch (Exception e) {
            e.getStackTrace();
        }
    }
    
    public Map<String, String> getServrityMap() {
        Map<String, String> map = new HashMap<String, String>();
        map.put("S1- Fatal", "#FF0000");
        map.put("S2- Critical", "#DF7401");
        map.put("S3- Important", "#F7FE2E");
        map.put("S4- Minor", "#04B45F");
        
        return map;
    }
    
    public String getTotalTagIssues() {
        return totalTagIssues;
    }
    
    public void setTotalTagIssues(String totalTagIssues) {
        this.totalTagIssues = totalTagIssues;
    }
    
    public List<IssueFormBean> getListIssueFormBean() {
        return listIssueFormBean;
    }
    
    public void setListIssueFormBean(List<IssueFormBean> listIssueFormBean) {
        this.listIssueFormBean = listIssueFormBean;
    }
    
    public Map<String, Integer> getFileCountList() {
        return fileCountList;
    }
    
    public void setFileCountList(Map<String, Integer> fileCountList) {
        this.fileCountList = fileCountList;
    }
    
    public HashMap<Integer, String> getUserMap() {
        return userMap;
    }
    
    public void setUserMap(HashMap<Integer, String> userMap) {
        this.userMap = userMap;
    }
    
    public Map<String, Integer> getLastAsigneeAgeList() {
        return lastAsigneeAgeList;
    }
    
    public void setLastAsigneeAgeList(Map<String, Integer> lastAsigneeAgeList) {
        this.lastAsigneeAgeList = lastAsigneeAgeList;
    }
    
    public Map<String, Integer> getAgeofIssue() {
        return ageofIssue;
    }
    
    public void setAgeofIssue(Map<String, Integer> ageofIssue) {
        this.ageofIssue = ageofIssue;
    }
    
}
