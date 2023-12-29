/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "APM_TEAM")
@NamedQueries({
    @NamedQuery(name = "ApmTeam.findAll", query = "SELECT a FROM ApmTeam a"),
    @NamedQuery(name = "ApmTeam.findByTeamName", query = "SELECT a FROM ApmTeam a WHERE UPPER(a.teamName)=:teamName"),
    @NamedQuery(name = "ApmTeam.findByTeamId", query = "SELECT a FROM ApmTeam a WHERE a.teamId=:teamId")
})
public class ApmTeam implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "TEAM_ID")
    private long teamId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "TEAM_NAME")
    private String teamName;
    @OneToMany(mappedBy = "teamId")
    private List<ApmComponent> apmComponentList;

    public ApmTeam() {
    }

    public ApmTeam(long teamId) {
        this.teamId = teamId;
    }

    public ApmTeam(long teamId, String teamName) {
        this.teamId = teamId;
        this.teamName = teamName;
    }

    public long getTeamId() {
        return teamId;
    }

    public void setTeamId(long teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 11 * hash + (int) (this.teamId ^ (this.teamId >>> 32));
        hash = 11 * hash + Objects.hashCode(this.teamName);
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
        final ApmTeam other = (ApmTeam) obj;
        if (this.teamId != other.teamId) {
            return false;
        }
        if (!Objects.equals(this.teamName, other.teamName)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.issue.ApmTeam[ teamId=" + teamId + " ]";
    }

    @XmlTransient
    public List<ApmComponent> getApmComponentList() {
        return apmComponentList;
    }

    public void setApmComponentList(List<ApmComponent> apmComponentList) {
        this.apmComponentList = apmComponentList;
    }
     
}
