package com.eminent.tags;

import com.eminent.tags.TagIssues;
import com.eminent.tags.bean.TagsUsersEntity;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(Tags.class)
public class Tags_ { 

    public static volatile SingularAttribute<Tags, Long> tagId;
    public static volatile SingularAttribute<Tags, Integer> tagType;
    public static volatile ListAttribute<Tags, TagIssues> tagIssuesCollection;
    public static volatile SingularAttribute<Tags, String> tagName;
    public static volatile SingularAttribute<Tags, Integer> userId;
    public static volatile ListAttribute<Tags, TagsUsersEntity> tagedUserList;

}