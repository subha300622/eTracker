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
@Table(name = "CRM_COMPANY_SALES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CrmCompanySales.findAll", query = "SELECT c FROM CrmCompanySales c")
    , @NamedQuery(name = "CrmCompanySales.findBySalesId", query = "SELECT c FROM CrmCompanySales c WHERE c.salesId = :salesId")
    , @NamedQuery(name = "CrmCompanySales.findByCompany", query = "SELECT c FROM CrmCompanySales c WHERE c.company = :company")
    , @NamedQuery(name = "CrmCompanySales.findBySalesYear", query = "SELECT c FROM CrmCompanySales c WHERE c.salesYear = :salesYear")
    , @NamedQuery(name = "CrmCompanySales.findBySales", query = "SELECT c FROM CrmCompanySales c WHERE c.sales = :sales")
    , @NamedQuery(name = "CrmCompanySales.findByEmployees", query = "SELECT c FROM CrmCompanySales c WHERE c.employees = :employees")
    , @NamedQuery(name = "CrmCompanySales.findByItSpend", query = "SELECT c FROM CrmCompanySales c WHERE c.itSpend = :itSpend")
    , @NamedQuery(name = "CrmCompanySales.findByErpSpend", query = "SELECT c FROM CrmCompanySales c WHERE c.erpSpend = :erpSpend")})
public class CrmCompanySales implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "SALES_ID")
    private long salesId;
    @Size(max = 500)
    @Column(name = "COMPANY")
    private String company;
    @Column(name = "SALES_YEAR")
    private Integer salesYear;
    @Column(name = "SALES")
    private long sales;
    @Column(name = "EMPLOYEES")
    private Integer employees;
    @Column(name = "IT_SPEND")
    private long itSpend;
    @Column(name = "ERP_SPEND")
    private long erpSpend;
    @Size(max = 500)
    @Column(name = "CURRENCY")
    private String currency;

    public CrmCompanySales() {
    }

    public long getSalesId() {
        return salesId;
    }

    public void setSalesId(long salesId) {
        this.salesId = salesId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Integer getSalesYear() {
        return salesYear;
    }

    public void setSalesYear(Integer salesYear) {
        this.salesYear = salesYear;
    }

    public long getSales() {
        return sales;
    }

    public void setSales(long sales) {
        this.sales = sales;
    }

    public Integer getEmployees() {
        return employees;
    }

    public void setEmployees(Integer employees) {
        this.employees = employees;
    }

    public long getItSpend() {
        return itSpend;
    }

    public void setItSpend(long itSpend) {
        this.itSpend = itSpend;
    }

    public long getErpSpend() {
        return erpSpend;
    }

    public void setErpSpend(long erpSpend) {
        this.erpSpend = erpSpend;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 59 * hash + (int) (this.salesId ^ (this.salesId >>> 32));
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
        final CrmCompanySales other = (CrmCompanySales) obj;
        if (this.salesId != other.salesId) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminentlabs.crm.persistence.CrmCompanySales[ salesId=" + salesId + " ]";
    }
    
}
