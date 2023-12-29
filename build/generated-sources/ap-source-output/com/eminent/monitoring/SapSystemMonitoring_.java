package com.eminent.monitoring;

import com.eminent.monitoring.ApmSapMonitoringUpdate;
import java.math.BigDecimal;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(SapSystemMonitoring.class)
public class SapSystemMonitoring_ { 

    public static volatile SingularAttribute<SapSystemMonitoring, String> transcation;
    public static volatile SingularAttribute<SapSystemMonitoring, Integer> addedBy;
    public static volatile SingularAttribute<SapSystemMonitoring, String> procedureName;
    public static volatile SingularAttribute<SapSystemMonitoring, String> taskName;
    public static volatile ListAttribute<SapSystemMonitoring, ApmSapMonitoringUpdate> apmSapMonitoringUpdateList;
    public static volatile SingularAttribute<SapSystemMonitoring, BigDecimal> id;
    public static volatile SingularAttribute<SapSystemMonitoring, Date> addedOn;

}