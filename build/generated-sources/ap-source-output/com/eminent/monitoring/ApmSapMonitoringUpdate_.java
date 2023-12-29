package com.eminent.monitoring;

import com.eminent.monitoring.SapSystemMonitoring;
import java.math.BigDecimal;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ApmSapMonitoringUpdate.class)
public class ApmSapMonitoringUpdate_ { 

    public static volatile SingularAttribute<ApmSapMonitoringUpdate, Integer> addedBy;
    public static volatile SingularAttribute<ApmSapMonitoringUpdate, Integer> pid;
    public static volatile SingularAttribute<ApmSapMonitoringUpdate, BigDecimal> id;
    public static volatile SingularAttribute<ApmSapMonitoringUpdate, String> remarks;
    public static volatile SingularAttribute<ApmSapMonitoringUpdate, Date> addedOn;
    public static volatile SingularAttribute<ApmSapMonitoringUpdate, SapSystemMonitoring> sapMoId;

}