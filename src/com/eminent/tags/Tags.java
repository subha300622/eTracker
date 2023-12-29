/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags;

import com.eminent.tags.bean.TagsUsersEntity;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "TAGS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tags.findAll", query = "SELECT t FROM Tags t"),
    @NamedQuery(name = "Tags.findByTagId", query = "SELECT t FROM Tags t WHERE t.tagId = :tagId"),
    @NamedQuery(name = "Tags.findByTagName", query = "SELECT t FROM Tags t WHERE t.tagName = :tagName"),
    @NamedQuery(name = "Tags.findByUniqueTagByUser", query = "SELECT t FROM Tags t WHERE t.tagName = :tagName and t.userId = :userId"),
    @NamedQuery(name = "Tags.deletByTagId", query = "DELETE FROM  Tags t WHERE t.tagId=:tagId and t.userId=:userId")})
public class Tags implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
  //  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TAGS_SEQ")
   // @SequenceGenerator(name = "TAGS_SEQ", sequenceName = "TAGS_SEQ", allocationSize = 1)
    @Column(name = "TAG_ID")
    private Long tagId;
    @Size(max = 50)
    @Column(name = "TAG_NAME")
    private String tagName;
    @Column(name = "Tag_type")
    private Integer tagType;
    @Column(name = "USER_ID")
    private Integer userId;
    @OneToMany(mappedBy = "tagId")
    List<TagIssues> tagIssuesCollection = new ArrayList<TagIssues>();
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, targetEntity = TagsUsersEntity.class, mappedBy = "tagId")
    @Fetch(FetchMode.SUBSELECT)
    private List<TagsUsersEntity> tagedUserList = new ArrayList<TagsUsersEntity>();

    public Tags() {
    }

    public Tags(Long tagId) {
        this.tagId = tagId;
    }

    public Tags(String tagName, Integer tagType, Integer userId) {
        this.tagName = tagName;
        this.tagType = tagType;
        this.userId = userId;
    }

    public Tags(Long tagId, String tagName, Integer tagType, Integer userId) {
        this.tagId = tagId;
        this.tagName = tagName;
        this.tagType = tagType;
        this.userId = userId;
    }

    public Long getTagId() {
        return tagId;
    }

    public void setTagId(Long tagId) {
        this.tagId = tagId;
    }

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public List<TagIssues> getTagIssuesCollection() {
        return tagIssuesCollection;
    }

    public void setTagIssuesCollection(List<TagIssues> tagIssuesCollection) {
        this.tagIssuesCollection = tagIssuesCollection;
    }

    public Integer getTagType() {
        return tagType;
    }

    public void setTagType(Integer tagType) {
        this.tagType = tagType;
    }

    public List<TagsUsersEntity> getTagedUserList() {
        return tagedUserList;
    }

    public void setTagedUserList(List<TagsUsersEntity> tagedUserList) {
        this.tagedUserList = tagedUserList;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 37 * hash + Objects.hashCode(this.tagId);
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
        final Tags other = (Tags) obj;
        if (!Objects.equals(this.tagId, other.tagId)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.eminent.tags.Tags[ tagId=" + tagId + " ]";
    }

}
