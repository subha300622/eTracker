package com.eminentlabs.mom.reimbursement;

import com.eminentlabs.mom.reimbursement.ReimbursementBill;
import com.eminentlabs.mom.reimbursement.ReimbursementComments;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:50:59")
@StaticMetamodel(ReimbursementVouchers.class)
public class ReimbursementVouchers_ { 

    public static volatile SingularAttribute<ReimbursementVouchers, Integer> requestedBy;
    public static volatile ListAttribute<ReimbursementVouchers, ReimbursementBill> reimbursementBillList;
    public static volatile SingularAttribute<ReimbursementVouchers, String> fileName;
    public static volatile SingularAttribute<ReimbursementVouchers, Date> period;
    public static volatile SingularAttribute<ReimbursementVouchers, Date> modifiedon;
    public static volatile SingularAttribute<ReimbursementVouchers, Long> rvid;
    public static volatile ListAttribute<ReimbursementVouchers, ReimbursementComments> reimbursementCommentsList;
    public static volatile SingularAttribute<ReimbursementVouchers, Date> createdon;
    public static volatile SingularAttribute<ReimbursementVouchers, Integer> uploadedBy;
    public static volatile SingularAttribute<ReimbursementVouchers, Integer> assignedTo;
    public static volatile SingularAttribute<ReimbursementVouchers, Integer> status;

}