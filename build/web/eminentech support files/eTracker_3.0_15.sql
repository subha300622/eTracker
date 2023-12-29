CREATE OR REPLACE FORCE VIEW  "DUEDATECHANGECOUNT" ("COUNT", "ISSUEID") AS 
  select count(distinct(duedate))-1 as count,ic.issueid from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and  duedate is not null group by ic.issueid order by ic.issueid
/

CREATE TABLE  "APM_TEAM" 
   (	"TEAM_ID" NUMBER NOT NULL ENABLE, 
	"TEAM_NAME" VARCHAR2(100) NOT NULL ENABLE, 
	 CONSTRAINT "APM_TEAM_PK" PRIMARY KEY ("TEAM_ID") ENABLE, 
	 CONSTRAINT "APM_TEAM_CON" UNIQUE ("TEAM_NAME") ENABLE
   )
/
 CREATE SEQUENCE   "APM_TEAM_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/
CREATE OR REPLACE TRIGGER  "BI_APM_TEAM" 
  before insert on "APM_TEAM"               
  for each row  
begin   
    select "APM_TEAM_SEQ".nextval into :NEW.TEAM_ID from dual; 
end; 
/
ALTER TRIGGER  "BI_APM_TEAM" ENABLE
/

