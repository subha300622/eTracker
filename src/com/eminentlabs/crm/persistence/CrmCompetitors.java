/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.persistence;

import java.io.Serializable;
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
 * @author QSERVER
 */
@Entity
@Table(name = "CRM_COMPETITORS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CrmCompetitors.findAll", query = "SELECT c FROM CrmCompetitors c")
    , @NamedQuery(name = "CrmCompetitors.findByCompetitorId", query = "SELECT c FROM CrmCompetitors c WHERE c.competitorId = :competitorId")
    , @NamedQuery(name = "CrmCompetitors.findByCompany", query = "SELECT c FROM CrmCompetitors c WHERE c.company = :company")
    , @NamedQuery(name = "CrmCompetitors.findByCompetitor", query = "SELECT c FROM CrmCompetitors c WHERE c.competitor = :competitor")
    , @NamedQuery(name = "CrmCompetitors.findByCity", query = "SELECT c FROM CrmCompetitors c WHERE c.city = :city")
    , @NamedQuery(name = "CrmCompetitors.findByState", query = "SELECT c FROM CrmCompetitors c WHERE c.state = :state")
    , @NamedQuery(name = "CrmCompetitors.findByCountry", query = "SELECT c FROM CrmCompetitors c WHERE c.country = :country")})
public class CrmCompetitors implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "COMPETITOR_ID")
    private long competitorId;
    @Size(max = 500)
    @Column(name = "COMPANY")
    private String company;
    @Size(max = 500)
    @Column(name = "COMPETITOR")
    private String competitor;
    @Size(max = 100)
    @Column(name = "CITY")
    private String city;
    @Size(max = 100)
    @Column(name = "STATE")
    private String state;
    @Size(max = 100)
    @Column(name = "COUNTRY")
    private String country;

    public CrmCompetitors() {
    }

    public CrmCompetitors(long competitorId) {
        this.competitorId = competitorId;
    }

    public long getCompetitorId() {
        return competitorId;
    }

    public void setCompetitorId(long competitorId) {
        this.competitorId = competitorId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getCompetitor() {
        return competitor;
    }

    public void setCompetitor(String competitor) {
        this.competitor = competitor;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 83 * hash + (int) (this.competitorId ^ (this.competitorId >>> 32));
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final CrmCompetitors other = (CrmCompetitors) obj;
        if (this.competitorId != other.competitorId) {
            return false;
        }
        return true;
    }

   

    @Override
    public String toString() {
        return "com.eminentlabs.crm.persistence.CrmCompetitors[ competitorId=" + competitorId + " ]";
    }
    
}
