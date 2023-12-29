/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "APM_WRM_PLAN")
@NamedQueries({
    @NamedQuery(name = "ApmWrmPlan.findAll", query = "SELECT a FROM ApmWrmPlan a"),
    @NamedQuery(name = "ApmWrmPlan.findById", query = "SELECT a FROM ApmWrmPlan a WHERE a.id = :id"),
    @NamedQuery(name = "ApmWrmPlan.findByWrmdayAndPid", query = "SELECT a FROM ApmWrmPlan a WHERE a.wrmday = :wrmday AND a.pid= :pid"),
    @NamedQuery(name = "ApmWrmPlan.findLastWrmIssueByPid", query = "SELECT a FROM ApmWrmPlan a WHERE a.wrmday = (select MAX(b.wrmday) from ApmWrmPlan b where b.pid=:pid) AND a.pid= :pid"),
    @NamedQuery(name = "ApmWrmPlan.findByPlannedon", query = "SELECT a FROM ApmWrmPlan a WHERE a.plannedon = :plannedon"),
    @NamedQuery(name = "ApmWrmPlan.findByPlannedby", query = "SELECT a FROM ApmWrmPlan a WHERE a.plannedby = :plannedby"),
    @NamedQuery(name = "ApmWrmPlan.findByPid", query = "SELECT a FROM ApmWrmPlan a WHERE a.pid = :pid"),
    @NamedQuery(name = "ApmWrmPlan.findByIssueid", query = "SELECT a FROM ApmWrmPlan a WHERE a.issueid = :issueid"),
    @NamedQuery(name = "ApmWrmPlan.findByComments", query = "SELECT a FROM ApmWrmPlan a WHERE a.comments = :comments")})
public class ApmWrmPlan implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "WRMDAY")
    @Temporal(TemporalType.DATE)
    private Date wrmday;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PLANNEDON")
    @Temporal(TemporalType.TIMESTAMP)
    private Date plannedon;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PLANNEDBY")
    private Integer plannedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private long pid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "ISSUEID")
    private String issueid;
    @Size(max = 250)
    @Column(name = "COMMENTS")
    private String comments;
    @Size(max = 10)
    @Column(name = "STATUS")
    private String status;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "wrmid")
    private List<ApmAdditionalClosed> apmAdditionalClosedList;

    public ApmWrmPlan() {
    }

    public ApmWrmPlan(long id) {
        this.id = id;
    }

    public ApmWrmPlan(long id, Date wrmday, Date plannedon, Integer plannedby, long pid, String issueid) {
        this.id = id;
        this.wrmday = wrmday;
        this.plannedon = plannedon;
        this.plannedby = plannedby;
        this.pid = pid;
        this.issueid = issueid;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getWrmday() {
        return wrmday;
    }

    public void setWrmday(Date wrmday) {
        this.wrmday = wrmday;
    }

    public Date getPlannedon() {
        return plannedon;
    }

    public void setPlannedon(Date plannedon) {
        this.plannedon = plannedon;
    }

    public Integer getPlannedby() {
        return plannedby;
    }

    public void setPlannedby(Integer plannedby) {
        this.plannedby = plannedby;
    }

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public String getIssueid() {
        return issueid;
    }

    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 43 * hash + (int) (this.id ^ (this.id >>> 32));
        hash = 43 * hash + Objects.hashCode(this.wrmday);
        hash = 43 * hash + Objects.hashCode(this.plannedon);
        hash = 43 * hash + Objects.hashCode(this.plannedby);
        hash = 43 * hash + Objects.hashCode(this.pid);
        hash = 43 * hash + Objects.hashCode(this.issueid);
        hash = 43 * hash + Objects.hashCode(this.comments);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ApmWrmPlan other = (ApmWrmPlan) obj;
        if (this.id != other.id) {
            return false;
        }
        if (!Objects.equals(this.wrmday, other.wrmday)) {
            return false;
        }
        if (!Objects.equals(this.plannedon, other.plannedon)) {
            return false;
        }
        if (!Objects.equals(this.plannedby, other.plannedby)) {
            return false;
        }
        if (!Objects.equals(this.pid, other.pid)) {
            return false;
        }
        if (!Objects.equals(this.issueid, other.issueid)) {
            return false;
        }
        if (!Objects.equals(this.comments, other.comments)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ApmWrmPlan{" + "id=" + id + ", wrmday=" + wrmday + ", plannedon=" + plannedon + ", plannedby=" + plannedby + ", pid=" + pid + ", issueid=" + issueid + ", comments=" + comments + '}';
    }

    

    

    @XmlTransient
    public List<ApmAdditionalClosed> getApmAdditionalClosedList() {
        return apmAdditionalClosedList;
    }

    public void setApmAdditionalClosedList(List<ApmAdditionalClosed> apmAdditionalClosedList) {
        this.apmAdditionalClosedList = apmAdditionalClosedList;
    }
}
