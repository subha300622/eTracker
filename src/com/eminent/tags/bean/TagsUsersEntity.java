/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags.bean;

import com.eminent.tags.Tags;
import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author admin
 */
@Entity
@Table(name = "TagsUsers")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TagsUsersEntity.findAll", query = "SELECT t FROM TagsUsersEntity t"),
    @NamedQuery(name = "TagsUsersEntity.findById", query = "SELECT t FROM TagsUsersEntity t WHERE t.taguserid = :Id"),
    @NamedQuery(name = "TagsUsersEntity.findByTagId", query = "SELECT t FROM TagsUsersEntity t WHERE t.tagId.tagId = :tagId"),
    @NamedQuery(name = "TagsUsersEntity.deleteByTagId", query = "DELETE FROM  TagsUsersEntity t WHERE t.tagId.tagId = :tagId")
})
public class TagsUsersEntity implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TAGUSERS_SEQ")
    @SequenceGenerator(name = "TAGUSERS_SEQ", sequenceName = "TAGUSERS_SEQ", allocationSize = 1)
    @Column(name = "TAGUSERID")
    private Long taguserid;
    @Column(name = "USERID")
    private Integer userid;
    @JoinColumn(name = "TAG_ID", referencedColumnName = "TAG_ID")
    @ManyToOne(optional = false)
    private Tags tagId;

    public TagsUsersEntity() {
    }

    public TagsUsersEntity( Integer userid, Tags tagId) {
      
        this.userid = userid;
        this.tagId = tagId;
    }

    public TagsUsersEntity(Long taguserid, Integer userid, Tags tagId) {
        this.taguserid = taguserid;
        this.userid = userid;
        this.tagId = tagId;
    }

    public Long getTaguserid() {
        return taguserid;
    }

    public void setTaguserid(Long taguserid) {
        this.taguserid = taguserid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Tags getTagId() {
        return tagId;
    }

    public void setTagId(Tags tagId) {
        this.tagId = tagId;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 23 * hash + Objects.hashCode(this.userid);
        hash = 23 * hash + Objects.hashCode(this.tagId);
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
        final TagsUsersEntity other = (TagsUsersEntity) obj;
        if (!Objects.equals(this.userid, other.userid)) {
            return false;
        }
        if (!Objects.equals(this.tagId, other.tagId)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.tags.bean.TagsUsersEntitys[ taguserid=" + taguserid + " ]";
    }

}
