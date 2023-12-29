package com.eminentlabs.erm;

import java.math.BigInteger;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.1.v20130918-rNA", date="2023-12-19T15:51:00")
@StaticMetamodel(ErmApplicantFile.class)
public class ErmApplicantFile_ { 

    public static volatile SingularAttribute<ErmApplicantFile, BigInteger> owner;
    public static volatile SingularAttribute<ErmApplicantFile, String> filename;
    public static volatile SingularAttribute<ErmApplicantFile, Date> attacheddate;
    public static volatile SingularAttribute<ErmApplicantFile, String> applicantId;
    public static volatile SingularAttribute<ErmApplicantFile, Long> fileId;

}