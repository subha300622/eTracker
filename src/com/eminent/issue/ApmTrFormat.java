/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.issue;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author EMINENT
 */
@Entity
@Table(name = "APM_TR_FORMAT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmTrFormat.findAll", query = "SELECT a FROM ApmTrFormat a"),
    @NamedQuery(name = "ApmTrFormat.findById", query = "SELECT a FROM ApmTrFormat a WHERE a.id = :id"),
    @NamedQuery(name = "ApmTrFormat.findByPid", query = "SELECT a FROM ApmTrFormat a WHERE a.pid = :pid"),
    @NamedQuery(name = "ApmTrFormat.findByTrFormat", query = "SELECT a FROM ApmTrFormat a WHERE a.trFormat = :trFormat")})
public class ApmTrFormat implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PID")
    private long pid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 4000)
    @Column(name = "TR_FORMAT")
    private String trFormat;
    
    @Column(name = "TR_TYPE")
    private Integer trType;

    public ApmTrFormat() {
    }

    public ApmTrFormat(long pid, String trFormat) {
        this.pid = pid;
        this.trFormat = trFormat;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    

    public String getTrFormat() {
        return trFormat;
    }

    public void setTrFormat(String trFormat) {
        this.trFormat = trFormat;
    }

    public Integer getTrType() {
        return trType;
    }

    public void setTrType(Integer trType) {
        this.trType = trType;
    }

    
    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + (int) (this.pid ^ (this.pid >>> 32));
        hash = 59 * hash + Objects.hashCode(this.trFormat);
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
        final ApmTrFormat other = (ApmTrFormat) obj;
        if (this.pid != other.pid) {
            return false;
        }
        if (!Objects.equals(this.trFormat, other.trFormat)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ApmTrFormat{" + "id=" + id + ", pid=" + pid + ", trFormat=" + trFormat + '}';
    }
    
    
    
    
}
