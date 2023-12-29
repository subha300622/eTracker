/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dashboard.controller;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.util.GetAge;
import com.eminent.util.IssueDetails;
import dashboard.dao.MydashboardDAO;
import dashboard.dao.MydashboardDAOImpl;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
public class MydashboardController {

    MydashboardDAO mydeshboardDAO = new MydashboardDAOImpl();
    List<IssueFormBean> listIssueFormBean = new ArrayList<IssueFormBean>();
    Map<String, Integer> fileCountList = new HashMap<String, Integer>();
    HashMap userMap;
    Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
    Map<String, Integer> ageofIssue = new HashMap<String, Integer>();

    public void getDisplayIssue(HttpServletRequest request) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            HttpSession session = request.getSession();
            session.setAttribute("dashBoard", "users");
            userMap = mydeshboardDAO.getUser();
            String userId = request.getParameter("userId");
            session.setAttribute("selectedUser", userId);
            String status = request.getParameter("status");
            String priority = request.getParameter("priority");
            String currentUser = request.getParameter("currentUser");
            if (status.equalsIgnoreCase("Performance QA")) {
                status = "Performance Testing";
            }
            if (status.equalsIgnoreCase("Customizing Req")) {
                status = "Customizing Request";
            }
            listIssueFormBean = mydeshboardDAO.QueryForUser(userId, currentUser, status, priority);
            if (listIssueFormBean.isEmpty()) {
            } else {
                String totalIssue = "";
                for (IssueFormBean issueFormBean : listIssueFormBean) {
                    totalIssue = totalIssue + "'" + issueFormBean.getIssueId() + "',";
                    issueFormBean.setCreatedOn(sdf.format(issueFormBean.getCreated()));
                    issueFormBean.setModifiedOn(sdf.format(issueFormBean.getModifiedDate()));
                    issueFormBean.setDueDate(sdf.format(issueFormBean.getDuedateOn()));
                    int age = GetAge.getIssueAge(issueFormBean.getCreatedOn(), issueFormBean.getStatus(), issueFormBean.getModifiedOn());
                    ageofIssue.put(issueFormBean.getIssueId(), age);

                }
                if (totalIssue.contains(",")) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalIssue);
                    fileCountList = IssueDetails.displayFilesCount(totalIssue);
                }
            }

        } catch (Exception e) {
            e.getStackTrace();
        }
    }

    
     public void getDisplayAllIssue(HttpServletRequest request) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            HttpSession session = request.getSession();
            session.setAttribute("dashBoard", "users");
            userMap = mydeshboardDAO.getUser();
            String userId = request.getParameter("userId");
           
            int currentUser =(Integer) session.getAttribute("userid_curr");
        
            listIssueFormBean = mydeshboardDAO.getAllIssueMyDashBorad(userId, currentUser);
            if (listIssueFormBean.isEmpty()) {
            } else {
                String totalIssue = "";
                for (IssueFormBean issueFormBean : listIssueFormBean) {
                    totalIssue = totalIssue + "'" + issueFormBean.getIssueId() + "',";
                    issueFormBean.setCreatedOn(sdf.format(issueFormBean.getCreated()));
                    issueFormBean.setModifiedOn(sdf.format(issueFormBean.getModifiedDate()));
                    issueFormBean.setDueDate(sdf.format(issueFormBean.getDuedateOn()));
                    int age = GetAge.getIssueAge(issueFormBean.getCreatedOn(), issueFormBean.getStatus(), issueFormBean.getModifiedOn());
                    ageofIssue.put(issueFormBean.getIssueId(), age);

                }
                if (totalIssue.contains(",")) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
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

    public List<IssueFormBean> getListIssueFormBean() {
        return listIssueFormBean;
    }

    public void setListIssueFormBean(List<IssueFormBean> listIssueFormBean) {
        this.listIssueFormBean = listIssueFormBean;
    }

    public HashMap getUserMap() {
        return userMap;
    }

    public void setUserMap(HashMap userMap) {
        this.userMap = userMap;
    }

    public Map<String, Integer> getFileCountList() {
        return fileCountList;
    }

    public void setFileCountList(Map<String, Integer> fileCountList) {
        this.fileCountList = fileCountList;
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
