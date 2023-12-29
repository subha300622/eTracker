package com.eminentlabs.crm.persistence;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(MailCampaign.class)
public class MailCampaign_ { 

    public static volatile SingularAttribute<MailCampaign, Integer> campaignId;
    public static volatile SingularAttribute<MailCampaign, String> subject;
    public static volatile SingularAttribute<MailCampaign, String> mailid;
    public static volatile SingularAttribute<MailCampaign, Date> maildate;
    public static volatile SingularAttribute<MailCampaign, Integer> sentby;
    public static volatile SingularAttribute<MailCampaign, String> status;

}