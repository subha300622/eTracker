alter table holidays modify location varchar2(100);
update holidays set location='Bengaluru';
alter table HOLIDAYS drop constraint HOLIDAYS_CON;
drop index "HOLIDAYS_CON";
alter table
   HOLIDAYS
add constraint
   "HOLIDAYS_CONS" UNIQUE ("HOLIDAY_NAME", "HOLIDAY_DATE","LOCATION") ENABLE;

alter table HOLIDAYS drop constraint HOLIDAYS_CONS;

alter table "HOLIDAYS" drop column "LOCATION" /

alter table "HOLIDAYS" add ("BRANCH_ID" NUMBER NULL) /

update HOLIDAYS set BRANCH_ID=1

alter table "HOLIDAYS" add constraint
"HOLIDAYS_CONS" unique ("HOLIDAY_NAME","HOLIDAY_DATE","BRANCH_ID")
/   



CREATE TABLE  "BRANCHES" 
   (	"BRANCH_ID" NUMBER(8,0), 
	"LOCATION" VARCHAR2(100), 
	"ADDRESS_ONE" VARCHAR2(1000), 
	"ADDRESS_TWO" VARCHAR2(1000), 
	 CONSTRAINT "BRANCHES_PK" PRIMARY KEY ("BRANCH_ID") ENABLE
   )
/

 CREATE SEQUENCE   "BRANCHES_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_BRANCHES" 
  before insert on "BRANCHES"               
  for each row  
begin   
    select "BRANCHES_SEQ".nextval into :NEW.BRANCH_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_BRANCHES" ENABLE
/


CREATE TABLE  "USER_BRANCH_HISTORY" 
   (	"ID" NUMBER, 
	"USERID" NUMBER, 
	"OLD_BRANCH_ID" NUMBER(8,0), 
	"NEW_BRANCH_ID" NUMBER(8,0), 
	"CHANGEDON" TIMESTAMP (6), 
	"CHANGEDBY" NUMBER, 
	 CONSTRAINT "USER_BRANCH_HISTORY_PK" PRIMARY KEY ("ID") ENABLE
   )
/

CREATE SEQUENCE   "USER_BRANCH_HISTORY_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_USER_BRANCH_HISTORY" 
  before insert on "USER_BRANCH_HISTORY"               
  for each row  
begin   
    select "USER_BRANCH_HISTORY_SEQ".nextval into :NEW.ID from dual; 
end; 

/
ALTER TRIGGER  "BI_USER_BRANCH_HISTORY" ENABLE
/


alter table "USERS" add ("BRANCH_ID" NUMBER NULL) /

update users set BRANCH_ID=1 where company='Eminentlabs Software Pvt Ltd' and roleid>0
update users set BRANCH_ID=2 where company='EBSPL' and roleid>0


alter table "MOM_FEEDBACK" add ("BRANCH_ID" NUMBER NULL) /

update MOM_FEEDBACK set BRANCH_ID=1

-- Added on 03-Apr-2020 for team and pm performance

alter table "USERS_PERFORMANCE" add
("BRANCH_ID" NUMBER NULL)
/   

update USERS_PERFORMANCE set BRANCH_ID=0

alter table "USERS_PERFORMANCE" add constraint
"USERS_PERFORMANCE_CON" unique ("BRANCH_ID","STARTDATE","ENDDATE")
/   

alter table "PM_PERFORMANCE" add
("BRANCH_ID" NUMBER NULL)
/   
update PM_PERFORMANCE set BRANCH_ID=0


alter table "PM_PERFORMANCE" drop constraint
"PM_PERFORMANCE_CONS"
/   
drop INDEX "PM_PERFORMANCE_CONS"
/   


alter table "PM_PERFORMANCE" add constraint
"PM_PERFORMANCE_CON" unique ("STARTDATE","ENDDATE","BRANCH_ID")
/   

--   TR Type added on 22nd Apr 2020
alter table "APM_TR_FORMAT" add
("TR_TYPE" NUMBER NULL)
/   
update apm_tr_format set tr_type=0
/

alter table "APM_TR_FORMAT" drop constraint
"APM_TR_FORMAT_UK1"
/   
alter table "APM_TR_FORMAT" add constraint
"APM_TR_FORMAT_CON" unique ("PID","TR_FORMAT","TR_TYPE")
/   


CREATE UNIQUE INDEX  "APM_TR_FORMAT_UK1" ON  "APM_TR_FORMAT" ("PID", "TR_FORMAT")
/
