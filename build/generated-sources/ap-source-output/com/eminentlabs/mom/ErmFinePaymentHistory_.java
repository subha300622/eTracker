package com.eminentlabs.mom;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ErmFinePaymentHistory.class)
public class ErmFinePaymentHistory_ { 

    public static volatile SingularAttribute<ErmFinePaymentHistory, Integer> amount;
    public static volatile SingularAttribute<ErmFinePaymentHistory, String> comments;
    public static volatile SingularAttribute<ErmFinePaymentHistory, Long> paymentid;
    public static volatile SingularAttribute<ErmFinePaymentHistory, Long> id;
    public static volatile SingularAttribute<ErmFinePaymentHistory, Date> paymentDate;
    public static volatile SingularAttribute<ErmFinePaymentHistory, Integer> userid;
    public static volatile SingularAttribute<ErmFinePaymentHistory, Integer> collectedby;
    public static volatile SingularAttribute<ErmFinePaymentHistory, Date> addedon;
    public static volatile SingularAttribute<ErmFinePaymentHistory, String> status;

}