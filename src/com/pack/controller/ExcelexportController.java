/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.controller;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.util.IssueDetails;
import com.eminent.util.IssueHistory;
import com.pack.MyIssueBean;
import com.pack.excelexport.IssueBean;
import dashboard.dao.MydashboardDAO;
import dashboard.dao.MydashboardDAOImpl;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author admin
 */
public class ExcelexportController {

    List<IssueFormBean> finalListIssue = new ArrayList<IssueFormBean>();
    Map<String, List<IssueHistory>> issueHistoryMap=new HashMap<String, List<IssueHistory>>();
     MydashboardDAO mydeshboardDAO = new MydashboardDAOImpl();
    public void excelExportSummary(HttpServletRequest request) {
        Map<String, Integer> fileCountList = new HashMap<String, Integer>();
        try {
            String headerSortUp = request.getParameter("headerSortUp");
            String headerSortDown = request.getParameter("headerSortDown");
             String issueHistory = request.getParameter("issueHistory");
       
            String sql = (String) request.getSession().getAttribute("IssueSummaryQuery");

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

            List<IssueFormBean> listIssue = new ArrayList<IssueFormBean>();
             HashMap<Integer, String> userMap = mydeshboardDAO.getUser();
            if(issueHistory.equalsIgnoreCase("yes")){
               
               issueHistoryMap = IssueDetails.checkIssueHistory(sql, userMap);
                          
                
            }else{
              List<IssueFormBean> listIssueFormBean = new MyIssueBean().getAllIssueByQuery(sql,userMap);

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
                    listIssue.add(issueFormBean);
                }
                fileCountList = IssueDetails.displayFilesCount(totalIssue);
            }
            for (IssueFormBean issueFormBea : listIssueFormBean) {
                if (fileCountList.get(issueFormBea.getIssueId()) == null) {
                    issueFormBea.setFilecount(0);
                } else {
                    issueFormBea.setFilecount(fileCountList.get(issueFormBea.getIssueId()));
                }
                finalListIssue.add(issueFormBea);

            }
            if (headerSortDown == null || headerSortUp == null) {

            } else {
                Comparator<IssueFormBean> cp = null;
                if (headerSortDown == null) {
                } else {

                    if (headerSortDown.equalsIgnoreCase("Issue No")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.issueid_asc);
                    } else if (headerSortDown.equalsIgnoreCase("P")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.priority_asc);
                    } else if (headerSortDown.equalsIgnoreCase("S")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.severity_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Project")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.pname_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Module")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.module_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Subject")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.Subject_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Status")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.status_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Due Date")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.due_date_asc);
                    } else if (headerSortDown.equalsIgnoreCase("AssignedTo")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.assignedto_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Age")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.Age_asc);
                    } else if (headerSortDown.equalsIgnoreCase("Refer")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.Refer_asc);
                    }
                }
                if (headerSortUp == null) {
                } else {
                    if (headerSortUp.equalsIgnoreCase("Issue No")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.issueid_desc);
                    } else if (headerSortUp.equalsIgnoreCase("P")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.priority_desc);
                    } else if (headerSortUp.equalsIgnoreCase("S")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.severity_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Project")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.pname_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Module")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.module_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Subject")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.Subject_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Status")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.status_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Due Date")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.due_date_desc);
                    } else if (headerSortUp.equalsIgnoreCase("AssignedTo")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.assignedto_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Age")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.Age_desc);
                    } else if (headerSortUp.equalsIgnoreCase("Refer")) {
                        cp = IssueBean.getComparator(IssueBean.ExcelexportComprator.Refer_desc);

                    }
                }

                Collections.sort(finalListIssue, cp);
            }
            }
        } catch (Exception e) {
            e.getStackTrace();
        }

    }

    public List<IssueFormBean> getFinalListIssue() {
        return finalListIssue;
    }

    public void setFinalListIssue(List<IssueFormBean> finalListIssue) {
        this.finalListIssue = finalListIssue;
    }

    public Map<String, List<IssueHistory>> getIssueHistoryMap() {
        return issueHistoryMap;
    }

    public void setIssueHistoryMap(Map<String, List<IssueHistory>> issueHistoryMap) {
        this.issueHistoryMap = issueHistoryMap;
    }

}
