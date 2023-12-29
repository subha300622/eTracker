/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

/**
 *
 * @author EMINENT
 */
public class IssueSearchFormBean {

    private String issueId;
    private String subject;
    private int wordMatchCount;

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getWordMatchCount() {
        return wordMatchCount;
    }

    public void setWordMatchCount(int wordMatchCount) {
        this.wordMatchCount = wordMatchCount;
    }

    

}
