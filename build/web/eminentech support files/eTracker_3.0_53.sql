create or replace procedure PROC_getAllSpecificTeamUsers(in_rset OUT SYS_REFCURSOR)is begin OPEN in_rset FOR select distinct(a.CONTACTID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Contact' as type from CONTACT a where a.roleid<3 UNION select distinct(a.LEADID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Lead' as type from lead a where a.roleid<3 UNION SELECT distinct(a.OPPORTUNITYID) as id ,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Opportunity' as type from opportunity a,LEAD l where a.LEAD_REFERENCE=l.leadid and a.roleid<3 UNION SELECT distinct(a.ACCOUNTID) as id,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Account' as type from ACCOUNT a,lead l,opportunity o where a.roleid<3 and a.OPPORTUNITY_REFERENCE =o.OPPORTUNITYid and o.LEAD_REFERENCE = l.leadid; END;


create or replace procedure PROC_getAllSpecificTeamUserss(in_rset OUT SYS_REFCURSOR)is begin OPEN in_rset FOR 
select * from (select distinct(a.CONTACTID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Contact' as type from CONTACT a where a.roleid<3
UNION 
select distinct(a.LEADID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Lead' as type 
 from lead a where a.roleid<3 
UNION
SELECT distinct(a.OPPORTUNITYID) as id ,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Opportunity' as type from opportunity a,LEAD l where a.LEAD_REFERENCE=l.leadid and  a.roleid<3
  UNION
 SELECT distinct(a.ACCOUNTID) as id,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Account' as type  from ACCOUNT a,lead l,opportunity o where a.roleid<3 and a.OPPORTUNITY_REFERENCE =o.OPPORTUNITYid and o.LEAD_REFERENCE = l.leadid) order by id desc;
 
END;

create or replace procedure PROC_getAllSpecificTeamUsersss(in_rset OUT SYS_REFCURSOR)is begin OPEN in_rset FOR 
select * from (select distinct(a.CONTACTID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Contact' as type from CONTACT a where a.roleid<3
UNION 
select distinct(a.LEADID) as id,a.title as title,a.firstname||' '||a.lastname as name,a.company,a.phone as phone,a.email as email,to_char(a.mobile),a.roleId,'Lead' as type 
 from lead a where a.roleid<3 
UNION
SELECT distinct(a.OPPORTUNITYID) as id ,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Opportunity' as type from opportunity a,LEAD l where a.LEAD_REFERENCE=l.leadid and  a.roleid<3
  UNION
 SELECT distinct(a.ACCOUNTID) as id,l.title as title,l.firstname||' '||l.lastname as name,l.company,l.phone as phone,l.email as email,to_char(l.mobile),a.roleId,'Account' as type  from ACCOUNT a,lead l,opportunity o where a.roleid<3 and a.OPPORTUNITY_REFERENCE =o.OPPORTUNITYid and o.LEAD_REFERENCE = l.leadid) order by type asc;
 
END;


CREATE TABLE  "SEND_SMS" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"ADDED_BY" NUMBER NOT NULL ENABLE, 
	"TYPE" VARCHAR2(20) NOT NULL ENABLE, 
	"SUBJECT" VARCHAR2(200) NOT NULL ENABLE, 
	"DESCRIPTION" VARCHAR2(4000) NOT NULL ENABLE, 
	 CONSTRAINT "SEND_SMS_PK" PRIMARY KEY ("ID") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_SEND_SMS" 
  before insert on "SEND_SMS"               
  for each row  
begin   
    select "SEND_SMS_SEQ".nextval into :NEW.ID from dual; 
end; 

/


 CREATE SEQUENCE   "SEND_SMS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 1 NOORDER  NOCYCLE
/

ALTER TRIGGER  "BI_SEND_SMS" ENABLE
/