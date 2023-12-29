/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags;

import java.io.Serializable;
import java.math.BigDecimal;
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

@Entity
@Table(name = "TAGISSUES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TagIssues.findAll", query = "SELECT t FROM TagIssues t"),
    @NamedQuery(name = "TagIssues.findById", query = "SELECT t FROM TagIssues t WHERE t.id = :id"),
    @NamedQuery(name = "TagIssues.findByTagId", query = "SELECT t FROM TagIssues t WHERE t.tagId.tagId=:tagId"),
    @NamedQuery(name = "TagIssues.findByIssueId", query = "SELECT t FROM TagIssues t WHERE t.issueId = :issueId"),
    @NamedQuery(name = "TagIssues.findByUserIdAndTag", query = "SELECT t FROM TagIssues t WHERE t.tagId.tagId = :tagId and t.userId=:userId"),
    @NamedQuery(name = "TagIssues.findByIssueIdAndTag", query = "SELECT t FROM TagIssues t WHERE t.issueId = :issueId and t.tagId.tagId=:tagId and t.userId=:userId"),
    @NamedQuery(name = "TagIssues.deletByTagId", query = "DELETE FROM  TagIssues t WHERE t.tagId.tagId = :tagId")
})
public class TagIssues implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Long id;
    @Column(name = "addedBy")
    private Integer userId;

    @Column(name = "ISSUE_ID")
    private String issueId;
   
    @JoinColumn(name = "TAG_ID", referencedColumnName = "TAG_ID")
    @ManyToOne
    private Tags tagId;

    public TagIssues() {
    }

    public TagIssues(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public Tags getTagId() {
        return tagId;
    }

    public void setTagId(Tags tagId) {
        this.tagId = tagId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 17 * hash + Objects.hashCode(this.id);
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
        final TagIssues other = (TagIssues) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }


    @Override
    public String toString() {
        return "com.eminent.tags.TagIssues[ id=" + id + " ]";
    }

}
