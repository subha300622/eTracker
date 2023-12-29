/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.branch;

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
 * @author Muthu
 */
@Entity
@Table(name = "BRANCHES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Branches.findAll", query = "SELECT b FROM Branches b"),
    @NamedQuery(name = "Branches.findByBranchId", query = "SELECT b FROM Branches b WHERE b.branchId = :branchId"),
    @NamedQuery(name = "Branches.findByLocation", query = "SELECT b FROM Branches b WHERE b.location = :location"),
    @NamedQuery(name = "Branches.findByAddressOne", query = "SELECT b FROM Branches b WHERE b.addressOne = :addressOne"),
    @NamedQuery(name = "Branches.findByAddressTwo", query = "SELECT b FROM Branches b WHERE b.addressTwo = :addressTwo")})
public class Branches implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "BRANCH_ID")
    private int branchId;
    @Size(max = 100)
    @Column(name = "LOCATION")
    private String location;
    @Size(max = 1000)
    @Column(name = "ADDRESS_ONE")
    private String addressOne;
    @Size(max = 1000)
    @Column(name = "ADDRESS_TWO")
    private String addressTwo;

    public Branches() {
    }

    public Branches(int branchId) {
        this.branchId = branchId;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAddressOne() {
        return addressOne;
    }

    public void setAddressOne(String addressOne) {
        this.addressOne = addressOne;
    }

    public String getAddressTwo() {
        return addressTwo;
    }

    public void setAddressTwo(String addressTwo) {
        this.addressTwo = addressTwo;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + this.branchId;
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
        final Branches other = (Branches) obj;
        if (this.branchId != other.branchId) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminent.branch.Branches[ branchId=" + branchId + " ]";
    }
    
}
