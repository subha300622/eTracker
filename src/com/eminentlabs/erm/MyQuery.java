/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import java.io.Serializable;
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

/**
 *
 * @author E0288
 */
@Entity
@Table(name = "MYQUERY")
@NamedQueries({
    @NamedQuery(name = "MyQuery.findAll", query = "SELECT m FROM MyQuery m")
    ,
    @NamedQuery(name = "MyQuery.findByEmail", query = "SELECT m FROM MyQuery m WHERE m.email =:email")
    ,
    @NamedQuery(name = "MyQuery.findByQueryId", query = "SELECT m FROM MyQuery m WHERE m.queryId =:queryId")
})
public class MyQuery implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "QUERY_ID")
    private long queryId;
    @Size(max = 50)
    @Column(name = "NAME")
    private String name;
    @Size(max = 50)
    @Column(name = "DESCRIPTION")
    private String description;
    @Size(max = 4000)
    @Column(name = "QUERY_STRING")
    private String queryString;
    @Column(name = "CREATEDON")
    @Temporal(TemporalType.DATE)
    private Date createdon;
    @Size(max = 100)
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "SEARCH_TYPE")
    private String searchType;
    @Column(name = "ISSUEDAYHISTORY")
    private String issueDayHistory;
    @Column(name = "ISSUERATING")
    private String issueRating;

    public MyQuery() {
    }

    public long getQueryId() {
        return queryId;
    }

    public void setQueryId(long queryId) {
        this.queryId = queryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getQueryString() {
        return queryString;
    }

    public void setQueryString(String queryString) {
        this.queryString = queryString;
    }

    public Date getCreatedon() {
        return createdon;
    }

    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getIssueDayHistory() {
        return issueDayHistory;
    }

    public void setIssueDayHistory(String issueDayHistory) {
        this.issueDayHistory = issueDayHistory;
    }

    public String getIssueRating() {
        return issueRating;
    }

    public void setIssueRating(String issueRating) {
        this.issueRating = issueRating;
    }

    @Override
    public String toString() {
        return "com.eminentlabs.erm.MyQuery[ queryId=" + queryId + " ]";
    }
}
