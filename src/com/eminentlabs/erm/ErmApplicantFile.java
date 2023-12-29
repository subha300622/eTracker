/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Muthu
 */
@Entity
@Table(name = "ERM_APPLICANT_FILE", catalog = "", schema = "EMINENTTRACKER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErmApplicantFile.findByApplicantId", query = "SELECT e FROM ErmApplicantFile e WHERE e.applicantId = :applicantId"),
    @NamedQuery(name = "ErmApplicantFile.findByOwner", query = "SELECT e FROM ErmApplicantFile e WHERE e.owner = :owner")})
public class ErmApplicantFile implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "FILE_ID", nullable = false, precision = 22)
    private long fileId;
    @Size(max = 15)
    @Column(name = "APPLICANT_ID", length = 15)
    private String applicantId;
    @Size(max = 100)
    @Column(name = "FILENAME", length = 100)
    private String filename;
    @Column(name = "ATTACHEDDATE")
    @Temporal(TemporalType.DATE)
    private Date attacheddate;
    @Column(name = "OWNER")
    private BigInteger owner;

    public ErmApplicantFile() {
    }

    public ErmApplicantFile(long fileId) {
        this.fileId = fileId;
    }

    public long getFileId() {
        return fileId;
    }

    public void setFileId(long fileId) {
        this.fileId = fileId;
    }

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Date getAttacheddate() {
        return attacheddate;
    }

    public void setAttacheddate(Date attacheddate) {
        this.attacheddate = attacheddate;
    }

    public BigInteger getOwner() {
        return owner;
    }

    public void setOwner(BigInteger owner) {
        this.owner = owner;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 73 * hash + (int) (this.fileId ^ (this.fileId >>> 32));
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
        final ErmApplicantFile other = (ErmApplicantFile) obj;
        if (this.fileId != other.fileId) {
            return false;
        }
        return true;
    }

    

    @Override
    public String toString() {
        return "com.eminentlabs.erm.ErmApplicantFile[ fileId=" + fileId + " ]";
    }
    
}
