/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

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

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "MOM_CLIENT_ATTENDIES", catalog = "", schema = "EMINENTTRACKER")
@NamedQueries({
    @NamedQuery(name = "MomClientAttendies.findAll", query = "SELECT m FROM MomClientAttendies m")})
public class MomClientAttendies implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(nullable = false)
    private Integer attendie;
    @JoinColumn(name = "MOM_CLIENT_ID", referencedColumnName = "MOM_CLIENT_ID", nullable = false)
    @ManyToOne(optional = false)
    private MomForClient momClientId;

    public MomClientAttendies() {
    }

    public MomClientAttendies(Integer id) {
        this.id = id;
    }

    public MomClientAttendies(Integer id, Integer attendie) {
        this.id = id;
        this.attendie = attendie;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAttendie() {
        return attendie;
    }

    public void setAttendie(Integer attendie) {
        this.attendie = attendie;
    }

    

    public MomForClient getMomClientId() {
        return momClientId;
    }

    public void setMomClientId(MomForClient momClientId) {
        this.momClientId = momClientId;
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
        if (!(object instanceof MomClientAttendies)) {
            return false;
        }
        MomClientAttendies other = (MomClientAttendies) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.mom.MomClientAttendies[ id=" + id + " ]";
    }
    
}
