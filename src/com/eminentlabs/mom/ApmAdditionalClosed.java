/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.mom;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "APM_ADDITIONAL_CLOSED")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmAdditionalClosed.findAll", query = "SELECT a FROM ApmAdditionalClosed a"),
    @NamedQuery(name = "ApmAdditionalClosed.findById", query = "SELECT a FROM ApmAdditionalClosed a WHERE a.id = :id"),
    @NamedQuery(name = "ApmAdditionalClosed.findByIssueid", query = "SELECT a FROM ApmAdditionalClosed a WHERE a.issueid = :issueid")})
public class ApmAdditionalClosed implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 12)
    @Column(name = "ISSUEID")
    private String issueid;
    @JoinColumn(name = "WRMID", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private ApmWrmPlan wrmid;

    public ApmAdditionalClosed() {
    }

    public ApmAdditionalClosed(long id, String issueid, ApmWrmPlan wrmid) {
        this.id = id;
        this.issueid = issueid;
        this.wrmid = wrmid;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    

    public String getIssueid() {
        return issueid;
    }

    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }

    public ApmWrmPlan getWrmid() {
        return wrmid;
    }

    public void setWrmid(ApmWrmPlan wrmid) {
        this.wrmid = wrmid;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 53 * hash + Objects.hashCode(this.issueid);
        hash = 53 * hash + Objects.hashCode(this.wrmid);
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
        final ApmAdditionalClosed other = (ApmAdditionalClosed) obj;
        if (!Objects.equals(this.issueid, other.issueid)) {
            return false;
        }
        if (!Objects.equals(this.wrmid, other.wrmid)) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminentlabs.mom.ApmAdditionalClosed[ id=" + id + " ]";
    }
    
}
