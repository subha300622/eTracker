/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "MOM_FEEDBACK")
@NamedQueries({
    @NamedQuery(name = "MomFeedback.findAll", query = "SELECT m FROM MomFeedback m where m.momTeamType in (:momTeamType) ORDER BY m.momdate DESC,m.momTeamType, m.momTime DESC "),
    @NamedQuery(name = "MomFeedback.findAllByBranch", query = "SELECT m FROM MomFeedback m where m.branchId=:branchId and m.momTeamType in (:momTeamType) ORDER BY m.momdate DESC,m.momTeamType, m.momTime DESC "),
    @NamedQuery(name = "MomFeedback.findUniqueMomFeedback", query = "SELECT m FROM MomFeedback m WHERE m.momdate=:momdate AND m.momTime=:momTime AND m.momTeamType=:momTeamType and m.branchId=:branchId")
})
public class MomFeedback implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @Column(name = "FEEDBACKBY")
    private Integer feedbackby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CHAIRPERSON")
    private Integer chairperson;
    @Basic(optional = false)
    @NotNull
    @Column(name = "STARTTIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttime;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ENDTIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endtime;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MOMDATE")
    @Temporal(TemporalType.DATE)
    private Date momdate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdon;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODIFIEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedon;
    @Size(max = 4000)
    @Column(name = "FEEDBACK")
    private String feedback;
    @Size(max = 10)
    @Column(name = "MOMTIME")
    private String momTime;
    @Column(name = "MOMTEAMTYPE")
    private int momTeamType;
    @Column(name = "Discussion")
    private String discussion;
@Column(name = "BRANCH_ID")
    private int branchId;
    public MomFeedback() {
    }

    public MomFeedback(long id) {
        this.id = id;
    }

    public MomFeedback(long id, Integer feedbackby, Integer chairperson, Date starttime, Date endtime, Date momdate, Date createdon, String feedback, String momTime, int momTeamType, String discussion, int branchId) {
        this.id = id;
        this.feedbackby = feedbackby;
        this.chairperson = chairperson;
        this.starttime = starttime;
        this.endtime = endtime;
        this.momdate = momdate;
        this.createdon = createdon;
        this.feedback = feedback;
        this.momTime = momTime;
        this.momTeamType = momTeamType;
        this.discussion = discussion;
        this.branchId = branchId;
    }
    
    public MomFeedback(long id, Integer feedbackby, Integer chairperson, Date starttime, Date endtime, Date momdate, Date createdon, Date modifiedon, String feedback, String momTime, int momTeamType,String discussion) {
        this.id = id;
        this.feedbackby = feedbackby;
        this.chairperson = chairperson;
        this.starttime = starttime;
        this.endtime = endtime;
        this.momdate = momdate;
        this.createdon = createdon;
        this.modifiedon = modifiedon;
        this.feedback = feedback;
        this.momTime = momTime;
        this.momTeamType = momTeamType;
        this.discussion=discussion;
    }
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Integer getFeedbackby() {
        return feedbackby;
    }

    public void setFeedbackby(Integer feedbackby) {
        this.feedbackby = feedbackby;
    }

    public Integer getChairperson() {
        return chairperson;
    }

    public void setChairperson(Integer chairperson) {
        this.chairperson = chairperson;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public Date getMomdate() {
        return momdate;
    }

    public void setMomdate(Date momdate) {
        this.momdate = momdate;
    }

    public Date getCreatedon() {
        return createdon;
    }

    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }

    public Date getModifiedon() {
        return modifiedon;
    }

    public void setModifiedon(Date modifiedon) {
        this.modifiedon = modifiedon;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getMomTime() {
        return momTime;
    }

    public void setMomTime(String momTime) {
        this.momTime = momTime;
    }

    public int getMomTeamType() {
        return momTeamType;
    }

    public void setMomTeamType(int momTeamType) {
        this.momTeamType = momTeamType;
    }

    public String getDiscussion() {
        return discussion;
    }

    public void setDiscussion(String discussion) {
        this.discussion = discussion;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }
    
    

    @Override
    public String toString() {
        return "com.eminentlabs.mom.MomFeedback[ id=" + id + " ]";
    }

}
