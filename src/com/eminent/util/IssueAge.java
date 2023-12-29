/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.util;

/**
 *
 * @author Eminent
 */
public class IssueAge {
    
    private int commentedBy=0;
    private int commentedTo=0;
    private String commentDate;
    private int age=1;

    public int getCommentedBy() {
        return commentedBy;
    }

    public void setCommentedBy(int commentedBy) {
        this.commentedBy = commentedBy;
    }

    public int getCommentedTo() {
        return commentedTo;
    }

    public void setCommentedTo(int commentedTo) {
        this.commentedTo = commentedTo;
    }

    public String getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
    
    
            
    
}
