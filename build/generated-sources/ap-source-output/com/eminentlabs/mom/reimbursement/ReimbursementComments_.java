package com.eminentlabs.mom.reimbursement;

import com.eminentlabs.mom.reimbursement.ReimbursementVouchers;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ReimbursementComments.class)
public class ReimbursementComments_ { 

    public static volatile SingularAttribute<ReimbursementComments, Integer> commentedto;
    public static volatile SingularAttribute<ReimbursementComments, String> comments;
    public static volatile SingularAttribute<ReimbursementComments, Date> commentDate;
    public static volatile SingularAttribute<ReimbursementComments, Long> rcid;
    public static volatile SingularAttribute<ReimbursementComments, ReimbursementVouchers> rvid;
    public static volatile SingularAttribute<ReimbursementComments, Integer> commentedby;
    public static volatile SingularAttribute<ReimbursementComments, Integer> status;

}