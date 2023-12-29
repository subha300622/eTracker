package com.eminentlabs.meeting;

import com.eminentlabs.meeting.ApmMeetingParticipants;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:50:59")
@StaticMetamodel(ApmMeetings.class)
public class ApmMeetings_ { 

    public static volatile SingularAttribute<ApmMeetings, Integer> heldAt;
    public static volatile SingularAttribute<ApmMeetings, Date> modifiedOn;
    public static volatile SingularAttribute<ApmMeetings, Integer> createdBy;
    public static volatile SingularAttribute<ApmMeetings, String> subject;
    public static volatile ListAttribute<ApmMeetings, ApmMeetingParticipants> apmMeetingParticipantsList;
    public static volatile SingularAttribute<ApmMeetings, Integer> meetingId;
    public static volatile SingularAttribute<ApmMeetings, Integer> pid;
    public static volatile SingularAttribute<ApmMeetings, String> startTime;
    public static volatile SingularAttribute<ApmMeetings, String> discussion;
    public static volatile SingularAttribute<ApmMeetings, String> endTime;
    public static volatile SingularAttribute<ApmMeetings, Date> createdOn;
    public static volatile SingularAttribute<ApmMeetings, Date> heldOn;

}