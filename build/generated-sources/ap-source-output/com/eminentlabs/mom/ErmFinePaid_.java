package com.eminentlabs.mom;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ErmFinePaid.class)
public class ErmFinePaid_ { 

    public static volatile SingularAttribute<ErmFinePaid, Integer> amount;
    public static volatile SingularAttribute<ErmFinePaid, Date> modifiedon;
    public static volatile SingularAttribute<ErmFinePaid, String> comments;
    public static volatile SingularAttribute<ErmFinePaid, Date> paidDate;
    public static volatile SingularAttribute<ErmFinePaid, Integer> modifiedby;
    public static volatile SingularAttribute<ErmFinePaid, Long> id;
    public static volatile SingularAttribute<ErmFinePaid, Integer> userid;
    public static volatile SingularAttribute<ErmFinePaid, Integer> collectedby;
    public static volatile SingularAttribute<ErmFinePaid, String> status;

}