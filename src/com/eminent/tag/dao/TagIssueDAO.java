/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tag.dao;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.tags.TagIssues;
import java.util.List;
import java.util.Map;

/**
 *
 * @author EMINENT
 */
public interface TagIssueDAO {

    public void addTagIssues(TagIssues tagIssue);

    public List<String> findAllIssuesByTagId(Long tagid);

    public List<String> findAllIssuesByTagIdAndUser(Long tagid, Integer currentuser);

    public String findAllTagIsuueByIssueAndTag(String issueId, Long tagid, Integer userId);

    public String deleteTagIssueByIssue(String issueId, Long tagid);

    public List<IssueFormBean> getAllIssueByTag(List<Long> tagId);

    public Map<Long, Integer> getCountIssueforTag();
    public String deleteTagIssueByTagId(Long tagId);
}
