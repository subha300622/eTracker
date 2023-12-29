/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.sapserver;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author vanithaalliraj
 */
@Entity
@Table(name = "APM_SAP_CLIENTS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ApmSapClients.findAll", query = "SELECT a FROM ApmSapClients a")
    , @NamedQuery(name = "ApmSapClients.findById", query = "SELECT a FROM ApmSapClients a WHERE a.id = :id")
    , @NamedQuery(name = "ApmSapClients.findByClientId", query = "SELECT a FROM ApmSapClients a WHERE a.clientId = :clientId")
    , @NamedQuery(name = "ApmSapClients.findByModuleId", query = "SELECT a FROM ApmSapClients a WHERE a.moduleId = :moduleId")
    , @NamedQuery(name = "ApmSapClients.findByCUname", query = "SELECT a FROM ApmSapClients a WHERE a.cUname = :cUname")
    , @NamedQuery(name = "ApmSapClients.findByCPwd", query = "SELECT a FROM ApmSapClients a WHERE a.cPwd = :cPwd")})
public class ApmSapClients implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Integer id;
    @Column(name = "CLIENT_ID")
    private Integer clientId;
    @Column(name = "MODULE_ID")
    private Integer moduleId;
    @Size(max = 20)
    @Column(name = "C_UNAME")
    private String cUname;
    @Size(max = 20)
    @Column(name = "C_PWD")
    private String cPwd;
    @JoinColumn(name = "TYPE_ID", referencedColumnName = "ID")
    @ManyToOne(fetch = FetchType.EAGER)
    private ApmSapSystemType typeId;

    public ApmSapClients() {
    }

    public ApmSapClients(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getClientId() {
        return clientId;
    }

    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getCUname() {
        return cUname;
    }

    public void setCUname(String cUname) {
        this.cUname = cUname;
    }

    public String getCPwd() {
        return cPwd;
    }

    public void setCPwd(String cPwd) {
        this.cPwd = cPwd;
    }

    public ApmSapSystemType getTypeId() {
        return typeId;
    }

    public void setTypeId(ApmSapSystemType typeId) {
        this.typeId = typeId;
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
        if (!(object instanceof ApmSapClients)) {
            return false;
        }
        ApmSapClients other = (ApmSapClients) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.sapserver.ApmSapClients[ id=" + id + " ]";
    }
    
}
