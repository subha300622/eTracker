 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

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
 * @author EMINENT
 */
@Entity
@Table(name = "SEND_SMS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SendSms.findAll", query = "SELECT s FROM SendSms s"),
    @NamedQuery(name = "SendSms.findById", query = "SELECT s FROM SendSms s WHERE s.id = :id"),
    @NamedQuery(name = "SendSms.findByAddedBy", query = "SELECT s FROM SendSms s WHERE s.addedBy = :addedBy"),
    @NamedQuery(name = "SendSms.findByType", query = "SELECT s FROM SendSms s WHERE s.type = :type"),
    @NamedQuery(name = "SendSms.findBySubject", query = "SELECT s FROM SendSms s WHERE s.subject = :subject"),
    @NamedQuery(name = "SendSms.findByDescription", query = "SELECT s FROM SendSms s WHERE s.description = :description")})
public class SendSms implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "ADDED_BY")
    private Integer addedBy;
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "TYPE")
    private String type;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "SUBJECT")
    private String subject;
   
    
    @Size(min = 1, max = 4000)
    @Column(name = "DESCRIPTION")
    private String description;

    public SendSms() {
    }

    public SendSms(Integer id) {
        this.id = id;
    }

    public SendSms(Integer id,Integer addedBy, String type, String subject, String description) {
        this.id = id;
        this.addedBy = addedBy;
        this.type = type;
        this.subject = subject;
        this.description = description;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(Integer addedBy) {
        this.addedBy = addedBy;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
        if (!(object instanceof SendSms)) {
            return false;
        }
        SendSms other = (SendSms) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.pack.SendSms[ id=" + id + " ]";
    }

 

  
}
