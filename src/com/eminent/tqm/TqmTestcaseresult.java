/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.tqm;
import com.eminent.timesheet.Users;
import java.sql.Timestamp;

/**
 *
 * @author Administrator
 */
public class TqmTestcaseresult implements java.io.Serializable {
    private long resultid;
    private TqmPtcm tqmPtcm;
    private String issueid;
    private Users   commentedby;
    private TqmTestcasestatus tqmTestcasestatus;
    private String comments;
    private Timestamp commentedon;

    public TqmTestcaseresult(){

    }
    public TqmTestcaseresult(long resultid,TqmPtcm tqmPtcm,String issueid,Users commentedby, TqmTestcasestatus tqmTestcasestatus,String comments,Timestamp commentedon){
        this.resultid           =   resultid;
        this.tqmPtcm            =   tqmPtcm;
        this.issueid            =   issueid;
        this.commentedby        =   commentedby;
        this.tqmTestcasestatus  =   tqmTestcasestatus;
        this.comments           =   comments;
        this.commentedon        =   commentedon;
    }
    public void setResultid(long resultid){
        this.resultid=resultid;
    }
    public long getResultid(){
        return resultid;
    }
    public void setTqmptcm(TqmPtcm tqmPtcm){
        this.tqmPtcm=tqmPtcm;
    }
    public TqmPtcm getTqmptcm(){
        return tqmPtcm;
    }
    public void setIssueid(String issueid){
        this.issueid=issueid;
    }
    public String getIssueid(){
        return issueid;
    }
    public void setCommentedby(Users commentedby){
        this.commentedby=commentedby;
    }
    public Users getCommentedby(){
        return commentedby;
    }
    public void setTqmtestcasestatus(TqmTestcasestatus tqmTestcasestatus){
        this.tqmTestcasestatus=tqmTestcasestatus;
    }
    public TqmTestcasestatus getTqmtestcasestatus(){
        return tqmTestcasestatus;
    }
    public void setTestcomments(String comments){
        this.comments=comments;
    }
    public String getTestcomments(){
        return comments;
    }
    public void setCommentedon(Timestamp commentedon){
        this.commentedon=commentedon;
    }
    public Timestamp getCommentedon(){
        return commentedon;
    }
}
