/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.bpm;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "BPM_PRINTACCESS")
@NamedQueries({
    @NamedQuery(name = "BpmPrintaccess.findAll", query = "SELECT b FROM BpmPrintaccess b"),
    @NamedQuery(name = "BpmPrintaccess.findByPid", query = "SELECT b FROM BpmPrintaccess b WHERE b.pid = :pid"),
    @NamedQuery(name = "BpmPrintaccess.findByType", query = "SELECT b FROM BpmPrintaccess b WHERE b.type = :type")})
public class BpmPrintaccess implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private Long pid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TYPE")
    private Integer type;

    public BpmPrintaccess() {
    }

    public BpmPrintaccess(Long pid) {
        this.pid = pid;
    }

    public BpmPrintaccess(Long pid, Integer type) {
        this.pid = pid;
        this.type = type;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    

    @Override
    public String toString() {
        return "com.eminent.bpm.BpmPrintaccess[ pid=" + pid + " ]";
    }
    
}
