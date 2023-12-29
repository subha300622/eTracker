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
@Table(name = "CONTACT_WORK_HISTORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ContactWorkHistory.findAll", query = "SELECT c FROM ContactWorkHistory c")
    , @NamedQuery(name = "ContactWorkHistory.findByConWorkId", query = "SELECT c FROM ContactWorkHistory c WHERE c.conWorkId = :conWorkId")
    , @NamedQuery(name = "ContactWorkHistory.findByContactid", query = "SELECT c FROM ContactWorkHistory c WHERE c.contactid = :contactid")
    , @NamedQuery(name = "ContactWorkHistory.findByCompany", query = "SELECT c FROM ContactWorkHistory c WHERE c.company = :company")
    , @NamedQuery(name = "ContactWorkHistory.findByFromYear", query = "SELECT c FROM ContactWorkHistory c WHERE c.fromYear = :fromYear")
    , @NamedQuery(name = "ContactWorkHistory.findByToYear", query = "SELECT c FROM ContactWorkHistory c WHERE c.toYear = :toYear")
    , @NamedQuery(name = "ContactWorkHistory.findByRole", query = "SELECT c FROM ContactWorkHistory c WHERE c.role = :role")})
public class ContactWorkHistory implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "CON_WORK_ID")
    private long conWorkId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CONTACTID")
    private Integer contactid;
    @Size(max = 200)
    @Column(name = "COMPANY")
    private String company;
    @Column(name = "FROM_YEAR")
    private Integer fromYear;
    @Column(name = "TO_YEAR")
    private Integer toYear;
    @Size(max = 100)
    @Column(name = "ROLE")
    private String role;

    public ContactWorkHistory() {
    }

    public ContactWorkHistory(long conWorkId) {
        this.conWorkId = conWorkId;
    }

    public ContactWorkHistory(long conWorkId, Integer contactid) {
        this.conWorkId = conWorkId;
        this.contactid = contactid;
    }

    public long getConWorkId() {
        return conWorkId;
    }

    public void setConWorkId(long conWorkId) {
        this.conWorkId = conWorkId;
    }

    public Integer getContactid() {
        return contactid;
    }

    public void setContactid(Integer contactid) {
        this.contactid = contactid;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Integer getFromYear() {
        return fromYear;
    }

    public void setFromYear(Integer fromYear) {
        this.fromYear = fromYear;
    }

    public Integer getToYear() {
        return toYear;
    }

    public void setToYear(Integer toYear) {
        this.toYear = toYear;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + (int) (this.conWorkId ^ (this.conWorkId >>> 32));
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
        final ContactWorkHistory other = (ContactWorkHistory) obj;
        if (this.conWorkId != other.conWorkId) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminentlabs.crm.persistence.ContactWorkHistory[ conWorkId=" + conWorkId + " ]";
    }
    
}
