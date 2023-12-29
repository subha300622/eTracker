package com.eminentlabs.mom;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(UsersPerformance.class)
public class UsersPerformance_ { 

    public static volatile SingularAttribute<UsersPerformance, Integer> branchId;
    public static volatile SingularAttribute<UsersPerformance, Date> evaluationDate;
    public static volatile SingularAttribute<UsersPerformance, Date> endDate;
    public static volatile SingularAttribute<UsersPerformance, Long> id;
    public static volatile SingularAttribute<UsersPerformance, String> team;
    public static volatile SingularAttribute<UsersPerformance, Integer> userId;
    public static volatile SingularAttribute<UsersPerformance, Date> createdOn;
    public static volatile SingularAttribute<UsersPerformance, String> performanceType;
    public static volatile SingularAttribute<UsersPerformance, String> tasks;
    public static volatile SingularAttribute<UsersPerformance, Date> startDate;

}