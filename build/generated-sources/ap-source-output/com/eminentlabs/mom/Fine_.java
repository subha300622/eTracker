package com.eminentlabs.mom;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(Fine.class)
public class Fine_ { 

    public static volatile SingularAttribute<Fine, String> reason;
    public static volatile SingularAttribute<Fine, Integer> amount;
    public static volatile SingularAttribute<Fine, Integer> addedby;
    public static volatile SingularAttribute<Fine, Long> id;
    public static volatile SingularAttribute<Fine, Date> addedon;

}