package com.eminentlabs.erm;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(MyQuery.class)
public class MyQuery_ { 

    public static volatile SingularAttribute<MyQuery, String> issueRating;
    public static volatile SingularAttribute<MyQuery, String> searchType;
    public static volatile SingularAttribute<MyQuery, String> name;
    public static volatile SingularAttribute<MyQuery, String> description;
    public static volatile SingularAttribute<MyQuery, String> queryString;
    public static volatile SingularAttribute<MyQuery, String> issueDayHistory;
    public static volatile SingularAttribute<MyQuery, Date> createdon;
    public static volatile SingularAttribute<MyQuery, String> email;
    public static volatile SingularAttribute<MyQuery, Long> queryId;

}