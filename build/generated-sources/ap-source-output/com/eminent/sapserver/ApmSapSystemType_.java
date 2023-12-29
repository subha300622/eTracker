package com.eminent.sapserver;

import com.eminent.sapserver.ApmSapClients;
import com.eminent.sapserver.ApmSapServer;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmSapSystemType.class)
public class ApmSapSystemType_ { 

    public static volatile SingularAttribute<ApmSapSystemType, Integer> instanceId;
    public static volatile ListAttribute<ApmSapSystemType, ApmSapClients> apmSapClientsList;
    public static volatile SingularAttribute<ApmSapSystemType, String> sapString;
    public static volatile SingularAttribute<ApmSapSystemType, String> serverName;
    public static volatile SingularAttribute<ApmSapSystemType, Integer> id;
    public static volatile SingularAttribute<ApmSapSystemType, String> appSer;
    public static volatile SingularAttribute<ApmSapSystemType, ApmSapServer> serverId;
    public static volatile SingularAttribute<ApmSapSystemType, String> sId;

}