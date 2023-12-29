package com.eminent.sapserver;

import com.eminent.sapserver.ApmSapSystemType;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmSapServer.class)
public class ApmSapServer_ { 

    public static volatile ListAttribute<ApmSapServer, ApmSapSystemType> apmSapSystemTypeList;
    public static volatile SingularAttribute<ApmSapServer, String> serverName;
    public static volatile SingularAttribute<ApmSapServer, Integer> pid;
    public static volatile SingularAttribute<ApmSapServer, Integer> serverId;

}