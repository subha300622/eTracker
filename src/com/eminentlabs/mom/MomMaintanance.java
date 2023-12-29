/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
@Table(name = "MOM_MAINTANANCE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MomMaintanance.findAll", query = "SELECT m FROM MomMaintanance m order by m.team, m.sino"),
    @NamedQuery(name = "MomMaintanance.findByTEAM", query = "SELECT m.userid FROM MomMaintanance m WHERE m.team =:team "),
    @NamedQuery(name = "MomMaintanance.findByMultipleTEAM", query = "SELECT m.userid FROM MomMaintanance m WHERE m.team IN(:team) "),
    @NamedQuery(name = "MomMaintanance.findAllUsers", query = "SELECT m.userid FROM MomMaintanance m order by m.team, m.sino")
})
public class MomMaintanance implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "MAINTANCE_ID")
    private long maintanceId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "USERID")
    private int userid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TEAM")
    private int team;
    @Basic(optional = false)
    @NotNull
    @Column(name = "SINO")
    private int sino;

    public MomMaintanance() {
    }

    public MomMaintanance(long maintanceId, int userid, int team, int sino) {
        this.maintanceId = maintanceId;
        this.userid = userid;
        this.team = team;
        this.sino = sino;
    }

    public MomMaintanance(long maintanceId) {
        this.maintanceId = maintanceId;
    }

    public long getMaintanceId() {
        return maintanceId;
    }

    public void setMaintanceId(long maintanceId) {
        this.maintanceId = maintanceId;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getTeam() {
        return team;
    }

    public void setTeam(int team) {
        this.team = team;
    }

    public int getSino() {
        return sino;
    }

    public void setSino(int sino) {
        this.sino = sino;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 11 * hash + Objects.hashCode(this.userid);
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
        final MomMaintanance other = (MomMaintanance) obj;
        if (!Objects.equals(this.userid, other.userid)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.MomUserMaintanance[ maintanceId=" + maintanceId + " ]";
    }

}
