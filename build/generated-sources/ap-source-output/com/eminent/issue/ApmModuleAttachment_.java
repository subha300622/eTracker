package com.eminent.issue;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmModuleAttachment.class)
public class ApmModuleAttachment_ { 

    public static volatile SingularAttribute<ApmModuleAttachment, Integer> owner;
    public static volatile SingularAttribute<ApmModuleAttachment, String> filename;
    public static volatile SingularAttribute<ApmModuleAttachment, Date> attacheddate;
    public static volatile SingularAttribute<ApmModuleAttachment, Long> id;
    public static volatile SingularAttribute<ApmModuleAttachment, Integer> moduleid;
    public static volatile SingularAttribute<ApmModuleAttachment, Long> projectId;

}