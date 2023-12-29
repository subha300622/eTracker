package com.eminent.issue;

import com.eminent.issue.AgreedIssuesPK;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(AgreedIssues.class)
public class AgreedIssues_ { 

    public static volatile SingularAttribute<AgreedIssues, AgreedIssuesPK> agreedIssuesPK;
    public static volatile SingularAttribute<AgreedIssues, Integer> addedby;
    public static volatile SingularAttribute<AgreedIssues, Long> projectId;
    public static volatile SingularAttribute<AgreedIssues, Date> addedon;
    public static volatile SingularAttribute<AgreedIssues, Integer> status;

}