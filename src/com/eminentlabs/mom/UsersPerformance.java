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

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "USERS_PERFORMANCE")
@NamedQueries({
    @NamedQuery(name = "UsersPerformance.findAll", query = "SELECT u FROM UsersPerformance u"),
        @NamedQuery(name = "UsersPerformance.findAllUsersPerformance", query = "SELECT u FROM UsersPerformance u WHERE u.startDate =:startDate and u.endDate =:endDate"),
    @NamedQuery(name = "UsersPerformance.findAllUsersPerformanceByBranch", query = "SELECT u FROM UsersPerformance u WHERE u.startDate =:startDate and u.endDate =:endDate and u.branchId=:branchId"),
    @NamedQuery(name = "UsersPerformance.findUniqueUserPerformance", query = "SELECT u FROM UsersPerformance u WHERE u.userId=:userId and u.startDate =:startDate and u.endDate =:endDate ")
})
public class UsersPerformance implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "USERID")
    private Integer userId;
    @Column(name = "EVALUATION_DATE")
    @Temporal(TemporalType.DATE)
    private Date evaluationDate;
    
    @Basic(optional = false)
    @Column(name = "TASKS")
    private String tasks;
    @Basic(optional = false)
    @NotNull
    @Column(name = "STARTDATE")
    @Temporal(TemporalType.DATE)
    private Date startDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ENDDATE")
    @Temporal(TemporalType.DATE)
    private Date endDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;
    @NotNull
    @Column(name = "PERFORMANCETYPE")
    private String performanceType;
    @NotNull
    @Column(name = "TEAM")
    private String team;
    @Column(name = "BRANCH_ID")
    private int branchId;
    public UsersPerformance() {
    }

    public UsersPerformance(long id) {
        this.id = id;
    }

    public UsersPerformance(long id, Integer userId, Date evaluationDate, String tasks, Date startDate, Date endDate, Date createdOn,String team,int branchId) {
        this.id = id;
        this.userId = userId;
        this.evaluationDate = evaluationDate;
        this.tasks = tasks;
        this.startDate = startDate;
        this.endDate = endDate;
        this.createdOn = createdOn;
        this.team=team;
        this.branchId=branchId;
    }

   

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getEvaluationDate() {
        return evaluationDate;
    }

    public void setEvaluationDate(Date evaluationDate) {
        this.evaluationDate = evaluationDate;
    }

    public String getTasks() {
        return tasks;
    }

    public void setTasks(String tasks) {
        this.tasks = tasks;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startdate) {
        this.startDate = startdate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date enddate) {
        this.endDate = enddate;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public String getPerformanceType() {
        return performanceType;
    }

    public void setPerformanceType(String performanceType) {
        this.performanceType = performanceType;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    @Override
    public String toString() {
        return "UsersPerformance{" + "id=" + id + ", userId=" + userId + ", evaluationDate=" + evaluationDate + ", tasks=" + tasks + ", startDate=" + startDate + ", endDate=" + endDate + ", createdOn=" + createdOn + ", team="+team+'}';
    }

    
   

    
    
}
