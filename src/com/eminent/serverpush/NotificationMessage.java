package com.eminent.serverpush;

public class NotificationMessage {

    private String issueId;
    private String assignedTo;
    private String subject;

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    @Override
    public String toString() {
        return "ChatMessage{" + "issueId=" + issueId + ", assignedTo=" + assignedTo + ", subject=" + subject + '}';
    }

    
    
}
