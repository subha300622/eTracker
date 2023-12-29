package com.eminent.issue.dao;

import com.eminent.issue.ApmComponentIssues;
import java.util.List;

public interface ApmComponentIssuesDAO {

    public void addIssue(ApmComponentIssues apmComponentIssues);

    public void update(ApmComponentIssues apmComponentIssues);

    public List<ApmComponentIssues> findByIssueId(String issueId);

    public List<ApmComponentIssues> findIssueByComponentId(ApmComponentIssues apmComponentIssues);
    
    public List<ApmComponentIssues> findComponentsByIssueId(String issueId);

    public void delete(ApmComponentIssues apmComponentIssues);
        public void deleteByIssue(String issueId);

}
