package com.eminent.leaveUtil;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(LeavApprovalHistory.class)
public class LeavApprovalHistory_ { 

    public static volatile SingularAttribute<LeavApprovalHistory, Integer> approver;
    public static volatile SingularAttribute<LeavApprovalHistory, Integer> approvallevel;
    public static volatile SingularAttribute<LeavApprovalHistory, Integer> updatedby;
    public static volatile SingularAttribute<LeavApprovalHistory, String> comments;
    public static volatile SingularAttribute<LeavApprovalHistory, Long> leaveid;
    public static volatile SingularAttribute<LeavApprovalHistory, Long> id;
    public static volatile SingularAttribute<LeavApprovalHistory, Date> updateon;

}