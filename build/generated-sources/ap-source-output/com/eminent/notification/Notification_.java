package com.eminent.notification;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:50:59")
@StaticMetamodel(Notification.class)
public class Notification_ { 

    public static volatile SingularAttribute<Notification, Date> expiryDate;
    public static volatile SingularAttribute<Notification, String> notification;
    public static volatile SingularAttribute<Notification, Integer> addedBy;
    public static volatile SingularAttribute<Notification, Long> notificationId;
    public static volatile SingularAttribute<Notification, String> notificationType;
    public static volatile SingularAttribute<Notification, Date> addedOn;

}