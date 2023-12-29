package com.eminent.leaveUtil;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:50:59")
@StaticMetamodel(LeaveApproverMaintenance.class)
public class LeaveApproverMaintenance_ { 

    public static volatile SingularAttribute<LeaveApproverMaintenance, Integer> requester;
    public static volatile SingularAttribute<LeaveApproverMaintenance, Integer> approver;
    public static volatile SingularAttribute<LeaveApproverMaintenance, Date> modifiedon;
    public static volatile SingularAttribute<LeaveApproverMaintenance, Long> approvalId;
    public static volatile SingularAttribute<LeaveApproverMaintenance, Integer> approvalLevel;
    public static volatile SingularAttribute<LeaveApproverMaintenance, Date> addedon;

}