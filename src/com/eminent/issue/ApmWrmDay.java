/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "APM_WRM_DAY", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmWrmDay.findAll", query = "SELECT a FROM ApmWrmDay a"),
    @NamedQuery(name = "ApmWrmDay.findByPid", query = "SELECT a.wrmDay FROM ApmWrmDay a WHERE a.pid =:pid")
})
public class ApmWrmDay implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "WRM_ID")
    private long wrmId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private Long pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "WRM_DAY")
    private Integer wrmDay;

    public ApmWrmDay() {
    }

    public ApmWrmDay(Long pid, Integer wrmDay) {
        this.pid = pid;
        this.wrmDay = wrmDay;
    }

    

    public long getWrmId() {
        return wrmId;
    }

    public void setWrmId(long wrmId) {
        this.wrmId = wrmId;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Integer getWrmDay() {
        return wrmDay;
    }

    public void setWrmDay(Integer wrmDay) {
        this.wrmDay = wrmDay;
    }

   

   

    @Override
    public String toString() {
        return "com.eminent.issue.ApmWrmDay[ wrmId=" + wrmId + " ]";
    }
    
}
