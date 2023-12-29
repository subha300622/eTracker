package com.eminentlabs.mom;

import com.eminentlabs.mom.MomClientAttendies;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:50:59")
@StaticMetamodel(MomForClient.class)
public class MomForClient_ { 

    public static volatile SingularAttribute<MomForClient, String> rating;
    public static volatile SingularAttribute<MomForClient, Integer> momClientId;
    public static volatile SingularAttribute<MomForClient, Integer> pid;
    public static volatile SingularAttribute<MomForClient, String> discussion;
    public static volatile ListAttribute<MomForClient, MomClientAttendies> momClientAttendiesList;
    public static volatile SingularAttribute<MomForClient, Date> heldOn;
    public static volatile SingularAttribute<MomForClient, Date> createdOn;
    public static volatile SingularAttribute<MomForClient, String> feedback;
    public static volatile SingularAttribute<MomForClient, Integer> heldAt;
    public static volatile SingularAttribute<MomForClient, Integer> responsiblePerson;
    public static volatile SingularAttribute<MomForClient, Integer> pmanager;
    public static volatile SingularAttribute<MomForClient, Date> modifiedOn;
    public static volatile SingularAttribute<MomForClient, Integer> createdBy;
    public static volatile SingularAttribute<MomForClient, String> escalation;
    public static volatile SingularAttribute<MomForClient, String> startTime;
    public static volatile SingularAttribute<MomForClient, String> endTime;

}