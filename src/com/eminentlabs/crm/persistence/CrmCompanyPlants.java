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
@Table(name = "CRM_COMPANY_PLANTS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CrmCompanyPlants.findAll", query = "SELECT c FROM CrmCompanyPlants c")
    , @NamedQuery(name = "CrmCompanyPlants.findByPlantId", query = "SELECT c FROM CrmCompanyPlants c WHERE c.plantId = :plantId")
    , @NamedQuery(name = "CrmCompanyPlants.findByCompany", query = "SELECT c FROM CrmCompanyPlants c WHERE c.company = :company")
    , @NamedQuery(name = "CrmCompanyPlants.findByPlantAddress", query = "SELECT c FROM CrmCompanyPlants c WHERE c.plantAddress = :plantAddress")
    , @NamedQuery(name = "CrmCompanyPlants.findByPlantArea", query = "SELECT c FROM CrmCompanyPlants c WHERE c.plantArea = :plantArea")
    , @NamedQuery(name = "CrmCompanyPlants.findByPlantCity", query = "SELECT c FROM CrmCompanyPlants c WHERE c.plantCity = :plantCity")
    , @NamedQuery(name = "CrmCompanyPlants.findByPlantState", query = "SELECT c FROM CrmCompanyPlants c WHERE c.plantState = :plantState")
    , @NamedQuery(name = "CrmCompanyPlants.findByPlantCountry", query = "SELECT c FROM CrmCompanyPlants c WHERE c.plantCountry = :plantCountry")})
public class CrmCompanyPlants implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PLANT_ID")
    private long plantId;
    @Size(max = 500)
    @Column(name = "COMPANY")
    private String company;
    @Size(max = 500)
    @Column(name = "PLANT_ADDRESS")
    private String plantAddress;
    @Size(max = 100)
    @Column(name = "PLANT_AREA")
    private String plantArea;
    @Size(max = 100)
    @Column(name = "PLANT_CITY")
    private String plantCity;
    @Size(max = 100)
    @Column(name = "PLANT_STATE")
    private String plantState;
    @Size(max = 100)
    @Column(name = "PLANT_COUNTRY")
    private String plantCountry;

    public CrmCompanyPlants() {
    }

    public CrmCompanyPlants(long plantId) {
        this.plantId = plantId;
    }

    public long getPlantId() {
        return plantId;
    }

    public void setPlantId(long plantId) {
        this.plantId = plantId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPlantAddress() {
        return plantAddress;
    }

    public void setPlantAddress(String plantAddress) {
        this.plantAddress = plantAddress;
    }

    public String getPlantArea() {
        return plantArea;
    }

    public void setPlantArea(String plantArea) {
        this.plantArea = plantArea;
    }

    public String getPlantCity() {
        return plantCity;
    }

    public void setPlantCity(String plantCity) {
        this.plantCity = plantCity;
    }

    public String getPlantState() {
        return plantState;
    }

    public void setPlantState(String plantState) {
        this.plantState = plantState;
    }

    public String getPlantCountry() {
        return plantCountry;
    }

    public void setPlantCountry(String plantCountry) {
        this.plantCountry = plantCountry;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 23 * hash + (int) (this.plantId ^ (this.plantId >>> 32));
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
        final CrmCompanyPlants other = (CrmCompanyPlants) obj;
        if (this.plantId != other.plantId) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminentlabs.crm.persistence.CrmCompanyPlants[ plantId=" + plantId + " ]";
    }
    
}
