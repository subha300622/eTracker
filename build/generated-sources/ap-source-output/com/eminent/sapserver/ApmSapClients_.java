package com.eminent.sapserver;

import com.eminent.sapserver.ApmSapSystemType;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmSapClients.class)
public class ApmSapClients_ { 

    public static volatile SingularAttribute<ApmSapClients, Integer> clientId;
    public static volatile SingularAttribute<ApmSapClients, String> cPwd;
    public static volatile SingularAttribute<ApmSapClients, ApmSapSystemType> typeId;
    public static volatile SingularAttribute<ApmSapClients, Integer> id;
    public static volatile SingularAttribute<ApmSapClients, Integer> moduleId;
    public static volatile SingularAttribute<ApmSapClients, String> cUname;

}