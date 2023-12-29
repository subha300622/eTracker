/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.IssueImageUrl;
import com.eminent.issue.ProjectDetail;
import com.eminent.issue.formbean.IssueFormBean;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Muthu
 */
public interface IssueDAO {

    public String generateIssueIdSeq();

    public String createIssue(String dueDate, String issueidFormat, int pid, String version, String type, String moduleId, String severity, String priority, String subject, String desc, String product, String rootCause, String expectedResult, String module, String user2, String pmanager);

    public ProjectDetail getProjectDetailByProduct(String product, String version, String module);

    public List<String> getAllDomainsByProjectId(String pid);

    public String readIssuesFromExcel(InputStream file, String projectId, Integer createdBy);

    public String readIssuesFromXlsx(InputStream file, String projectId, Integer createdBy);

    public int checkDuplicateIssue(int projectId, String subject);

    public String readIssuesFromExcelByAdmin(InputStream file, Integer createdBy);

    public String readIssuesFromXlsxByAdmin(InputStream file, Integer createdBy);
    
    public List<IssueImageUrl> getIssueImagecommentswithRowid();
    
    public int getAllImageURLCount();
    public int getImageURLCountByURL(String url,String issueId);
    public void updateLocalURLinComments(String googleUrl,String localUrl,String rowid);
    
    public List<IssueImageUrl> getAllImageURLs();
    
    public List<IssueImageUrl>  getImageURLByIds(List<Long> imageIds);
    
    public HashMap<String,Integer> getPIdForIssues(String issues);
    
    public HashMap<String,String> getPIDandStatus(String issues);
    
    public void updateMainIssue(String mainIssue,String subIssue);
        public String getMainIssue(String subIssue);

        public List<IssueFormBean> getMyassignmentissues(int userId);
public void updateIssue(HttpServletRequest request);

    public String updatIssue();
}
