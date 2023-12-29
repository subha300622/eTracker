package com.eminent.issue;

import com.eminent.issue.ApmComponentIssues;
import com.eminent.issue.ApmTeam;
import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmComponent.class)
public class ApmComponent_ { 

    public static volatile ListAttribute<ApmComponent, ApmComponentIssues> apmComponentIssuesList;
    public static volatile SingularAttribute<ApmComponent, BigDecimal> componentId;
    public static volatile SingularAttribute<ApmComponent, ApmTeam> teamId;
    public static volatile SingularAttribute<ApmComponent, String> componentName;

}