package com.eminent.timesheet;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(TimesheetMaintanance.class)
public class TimesheetMaintanance_ { 

    public static volatile SingularAttribute<TimesheetMaintanance, Integer> requester;
    public static volatile SingularAttribute<TimesheetMaintanance, Integer> attendanceApprover;
    public static volatile SingularAttribute<TimesheetMaintanance, Integer> timesheetApprover;
    public static volatile SingularAttribute<TimesheetMaintanance, Date> modifiedon;
    public static volatile SingularAttribute<TimesheetMaintanance, Integer> reimbursementApprover;
    public static volatile SingularAttribute<TimesheetMaintanance, Integer> needinfoApprover;
    public static volatile SingularAttribute<TimesheetMaintanance, Integer> accountsApprover;
    public static volatile SingularAttribute<TimesheetMaintanance, Long> id;
    public static volatile SingularAttribute<TimesheetMaintanance, Date> createdon;

}