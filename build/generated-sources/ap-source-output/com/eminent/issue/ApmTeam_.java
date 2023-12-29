package com.eminent.issue;

import com.eminent.issue.ApmComponent;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmTeam.class)
public class ApmTeam_ { 

    public static volatile SingularAttribute<ApmTeam, String> teamName;
    public static volatile SingularAttribute<ApmTeam, Long> teamId;
    public static volatile ListAttribute<ApmTeam, ApmComponent> apmComponentList;

}