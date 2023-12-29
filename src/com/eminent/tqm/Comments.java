/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tqm;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Tamilvelan
 */
public class Comments {
    private String comments;
 //   private String status;
    private Integer commentedby;
    private Date commentedon;
    
    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    public Integer getCommentedby() {
        return this.commentedby;
    }
    
    public void setCommentedby(Integer commentedby) {
        this.commentedby = commentedby;
    }
     public Date getCommentedon() {
        return this.commentedon;
    }
    
    public void setCommentedon(Date commentedon) {
        this.commentedon = commentedon;
    }
    
}
