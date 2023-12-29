package com.eminentlabs.erm;

import java.math.BigDecimal;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ErmApplicantExperience.class)
public class ErmApplicantExperience_ { 

    public static volatile SingularAttribute<ErmApplicantExperience, BigDecimal> experienceId;
    public static volatile SingularAttribute<ErmApplicantExperience, String> currentEmployer;
    public static volatile SingularAttribute<ErmApplicantExperience, Date> currentDoj;
    public static volatile SingularAttribute<ErmApplicantExperience, String> jobProfile;
    public static volatile SingularAttribute<ErmApplicantExperience, String> currentDesignation;
    public static volatile SingularAttribute<ErmApplicantExperience, String> currentRole;
    public static volatile SingularAttribute<ErmApplicantExperience, Date> relievingDate;
    public static volatile SingularAttribute<ErmApplicantExperience, String> currentCtc;

}