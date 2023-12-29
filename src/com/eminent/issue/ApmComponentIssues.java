/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author EMINENT
 */
@Entity
@Table(name = "APM_COMPONENT_ISSUES")
@NamedQueries({
    @NamedQuery(name = "ApmComponentIssues.findAll", query = "SELECT a FROM ApmComponentIssues a ORDER BY a.id"),
    @NamedQuery(name = "ApmComponentIssues.findById", query = "SELECT a FROM ApmComponentIssues a WHERE a.id = :id"),
    @NamedQuery(name = "ApmComponentIssues.findByComponentId", query = "SELECT a FROM ApmComponentIssues a WHERE a.componentId = :componentId"),
        @NamedQuery(name = "ApmComponentIssues.deleteByIssueId", query = "DELETE FROM ApmComponentIssues a WHERE a.issueId = :issueId"),
    @NamedQuery(name = "ApmComponentIssues.findByIssueId", query = "SELECT a FROM ApmComponentIssues a WHERE a.issueId = :issueId ORDER BY a.componentId")})
public class ApmComponentIssues implements Serializable {

    @Basic(optional = false)
    @NotNull
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "APM_COMPONENT_ISSUES_SEQ1")
    @SequenceGenerator(name = "APM_COMPONENT_ISSUES_SEQ1", sequenceName = "APM_COMPONENT_ISSUES_SEQ1", allocationSize = 1)
    @Column(name = "ID")
    @Id
    private BigInteger id;

    private static final long serialVersionUID = 1L;
    @Column(name = "ISSUE_ID")
    private String issueId;
    @JoinColumn(name = "COMPONENT_ID", referencedColumnName = "COMPONENT_ID")
    @ManyToOne
    private ApmComponent componentId;

    public ApmComponentIssues() {
    }

    public ApmComponentIssues(BigInteger id) {
        this.id = id;
    }

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public ApmComponent getComponentId() {
        return componentId;
    }

    public void setComponentId(ApmComponent componentId) {
        this.componentId = componentId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ApmComponentIssues)) {
            return false;
        }
        ApmComponentIssues other = (ApmComponentIssues) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.ApmComponentIssues[ id=" + id + " ]";
    }

}
