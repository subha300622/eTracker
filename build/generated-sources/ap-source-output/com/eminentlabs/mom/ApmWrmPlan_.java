package com.eminentlabs.mom;

import com.eminentlabs.mom.ApmAdditionalClosed;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmWrmPlan.class)
public class ApmWrmPlan_ { 

    public static volatile SingularAttribute<ApmWrmPlan, Date> wrmday;
    public static volatile SingularAttribute<ApmWrmPlan, String> issueid;
    public static volatile SingularAttribute<ApmWrmPlan, String> comments;
    public static volatile SingularAttribute<ApmWrmPlan, Integer> plannedby;
    public static volatile ListAttribute<ApmWrmPlan, ApmAdditionalClosed> apmAdditionalClosedList;
    public static volatile SingularAttribute<ApmWrmPlan, Long> pid;
    public static volatile SingularAttribute<ApmWrmPlan, Long> id;
    public static volatile SingularAttribute<ApmWrmPlan, Date> plannedon;
    public static volatile SingularAttribute<ApmWrmPlan, String> status;

}