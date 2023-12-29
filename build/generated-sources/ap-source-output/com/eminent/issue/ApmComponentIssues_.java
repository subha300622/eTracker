package com.eminent.issue;

import com.eminent.issue.ApmComponent;
import java.math.BigInteger;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmComponentIssues.class)
public class ApmComponentIssues_ { 

    public static volatile SingularAttribute<ApmComponentIssues, String> issueId;
    public static volatile SingularAttribute<ApmComponentIssues, ApmComponent> componentId;
    public static volatile SingularAttribute<ApmComponentIssues, BigInteger> id;

}