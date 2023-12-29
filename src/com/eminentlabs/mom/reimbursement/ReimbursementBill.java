/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.reimbursement;

import java.io.Serializable;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author EMINENT
 */
@Entity
@Table(name = "REIMBURSEMENT_BILL")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ReimbursementBill.findAll", query = "SELECT r FROM ReimbursementBill r"),
    @NamedQuery(name = "ReimbursementBill.findByBid", query = "SELECT r FROM ReimbursementBill r WHERE r.bid = :bid"),
    @NamedQuery(name = "ReimbursementBill.findByFilename", query = "SELECT r FROM ReimbursementBill r WHERE r.fileName = :fileName"),
    @NamedQuery(name = "ReimbursementBill.findByMonthlyCount", query = "SELECT COUNT(r) FROM ReimbursementBill r,ReimbursementVouchers rv WHERE r.rvid.rvid=rv.rvid AND r.rvid.rvid=:rvid AND r.fileName LIKE :fileName")})
public class ReimbursementBill implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "BID")
    private Long bid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FILENAME")
    private String fileName;
    @JoinColumn(name = "RVID", referencedColumnName = "RVID")
    @ManyToOne(optional = false)
    ReimbursementVouchers rvid = new ReimbursementVouchers();

    public ReimbursementBill() {
    }

    public ReimbursementBill(Long bid) {
        this.bid = bid;
    }

    public ReimbursementBill(Long bid, String fileName) {
        this.bid = bid;
        this.fileName = fileName;
    }

    public Long getBid() {
        return bid;
    }

    public void setBid(Long bid) {
        this.bid = bid;
    }

    public String getFilename() {
        return fileName;
    }

    public void setFilename(String fileName) {
        this.fileName = fileName;
    }

    public ReimbursementVouchers getRvid() {
        return rvid;
    }

    public void setRvid(ReimbursementVouchers rvid) {
        this.rvid = rvid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (bid != null ? bid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ReimbursementBill)) {
            return false;
        }
        ReimbursementBill other = (ReimbursementBill) object;
        if ((this.bid == null && other.bid != null) || (this.bid != null && !this.bid.equals(other.bid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.reimbursement.ReimbursementBill[ bid=" + bid + " ]";
    }

}
