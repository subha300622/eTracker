/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.issue;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;
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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author EMINENT
 */
@Entity
@Table(name = "APM_COMPONENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmComponent.findAll", query = "SELECT a FROM ApmComponent a"),
    @NamedQuery(name = "ApmComponent.findByComponentId", query = "SELECT a FROM ApmComponent a WHERE a.componentId = :componentId"),
    @NamedQuery(name = "ApmComponent.findByComponentName", query = "SELECT a FROM ApmComponent a WHERE a.componentName = :componentName")})
public class ApmComponent implements Serializable {
  
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
  
    @Basic(optional = false)
     @NotNull
     @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="APM_COMPONENT_SEQ")

 @SequenceGenerator(name="APM_COMPONENT_SEQ",sequenceName="APM_COMPONENT_SEQ",allocationSize=1)

    @Column(name = "COMPONENT_ID")
    private BigDecimal componentId;
    @Size(max = 50)
    @Column(name = "COMPONENT_NAME")
    private String componentName;
    @OneToMany(mappedBy = "componentId")
    private List<ApmComponentIssues> apmComponentIssuesList;
    @JoinColumn(name = "TEAM_ID", referencedColumnName = "TEAM_ID")
    @ManyToOne
    private ApmTeam teamId;

    public ApmComponent() {
    }

    public ApmComponent(BigDecimal componentId) {
        this.componentId = componentId;
    }

    public BigDecimal getComponentId() {
        return componentId;
    }

    public void setComponentId(BigDecimal componentId) {
        this.componentId = componentId;
    }

    public String getComponentName() {
        return componentName;
    }

    public void setComponentName(String componentName) {
        this.componentName = componentName;
    }

    @XmlTransient
    public List<ApmComponentIssues> getApmComponentIssuesList() {
        return apmComponentIssuesList;
    }

    public void setApmComponentIssuesList(List<ApmComponentIssues> apmComponentIssuesList) {
        this.apmComponentIssuesList = apmComponentIssuesList;
    }

    public ApmTeam getTeamId() {
        return teamId;
    }

    public void setTeamId(ApmTeam teamId) {
        this.teamId = teamId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (componentId != null ? componentId.hashCode() : 0);
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
        final ApmComponent other = (ApmComponent) obj;
        if (!Objects.equals(this.componentId, other.componentId)) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminent.issue.ApmComponent[ componentId=" + componentId + " ]";
    }

 
    
}
