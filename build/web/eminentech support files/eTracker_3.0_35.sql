alter table "ERM_APPLICANT" add
("WATER" VARCHAR2(4000) NULL)
/   
alter table "ERM_APPLICANT" add
("RTI" VARCHAR2(4000) NULL)
/   
alter table "ERM_APPLICANT" add
("RTE" VARCHAR2(4000) NULL)
/   
alter table "ERM_APPLICANT" add
("HABITS" VARCHAR2(4000) NULL)
/   
alter table "ERM_APPLICANT" add
("SOCIAL" VARCHAR2(4000) NULL)
/   

alter table "ERM_APPLICANT" add
("APJBOOK" NUMBER NULL)
/   

update ERM_Applicant set apjbook=0 where apjbook is  null