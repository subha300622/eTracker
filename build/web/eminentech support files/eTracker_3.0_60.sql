-- deleting table
drop table "TIMESHEET_MAINTANANCE"
/

CREATE TABLE  "TIMESHEET_MAINTANANCE" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"REQUESTER" NUMBER NOT NULL ENABLE, 
	"NEEDINFO_APPROVER" NUMBER, 
	"TIMESHEET_APPROVER" NUMBER NOT NULL ENABLE, 
	"ATTENDANCE_APPROVER" NUMBER NOT NULL ENABLE, 
	"ACCOUNTS_APPROVER" NUMBER NOT NULL ENABLE, 
	"REIMBURSEMENT_APPROVER" NUMBER NOT NULL ENABLE, 
	"CREATEDON" TIMESTAMP (6) NOT NULL ENABLE, 
	"MODIFIEDON" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "TIMESHEET_MAINTANANCE_PK" PRIMARY KEY ("ID") ENABLE
   )
/

CREATE SEQUENCE   "TIMESHEET_MAINTANANCE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/

CREATE OR REPLACE TRIGGER  "BI_TIMESHEET_MAINTANANCE" 
  before insert on "TIMESHEET_MAINTANANCE"               
  for each row  
begin   
    select "TIMESHEET_MAINTANANCE_SEQ".nextval into :NEW.ID from dual; 
end; 

/
ALTER TRIGGER  "BI_TIMESHEET_MAINTANANCE" ENABLE
/

CREATE TABLE  "LEAVE_APPROVER_MAINTENANCE" 
   (	"APPROVAL_ID" NUMBER NOT NULL ENABLE, 
	"REQUESTER" NUMBER NOT NULL ENABLE, 
	"APPROVAL_LEVEL" NUMBER NOT NULL ENABLE, 
	"APPROVER" NUMBER NOT NULL ENABLE, 
	"ADDEDON" TIMESTAMP (6) NOT NULL ENABLE, 
	"MODIFIEDON" TIMESTAMP (6), 
	 CONSTRAINT "LEAVE_APPROVER_MAINTENANCE_PK" PRIMARY KEY ("APPROVAL_ID") ENABLE
   )
/

 CREATE SEQUENCE   "LEAVE_APPROVER_MAINTENANC_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_LEAVE_APPROVER_MAINTENANCE" 
  before insert on "LEAVE_APPROVER_MAINTENANCE"               
  for each row  
begin   
    select "LEAVE_APPROVER_MAINTENANC_SEQ".nextval into :NEW.APPROVAL_ID from dual; 
end;
/
ALTER TRIGGER  "BI_LEAVE_APPROVER_MAINTENANCE" ENABLE
/

CREATE TABLE  "LEAV_APPROVAL_HISTORY" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"LEAVEID" NUMBER NOT NULL ENABLE, 
	"APPROVALLEVEL" NUMBER, 
	"APPROVER" NUMBER, 
	"UPDATEON" TIMESTAMP (6), 
	"UPDATEDBY" NUMBER, 
	"COMMENTS" VARCHAR2(2500), 
	 CONSTRAINT "LEAV_APPROVAL_HISTORY_PK" PRIMARY KEY ("ID") ENABLE
   )
/

 CREATE SEQUENCE   "LEAV_APPROVAL_HISTORY_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_LEAV_APPROVAL_HISTORY" 
  before insert on "LEAV_APPROVAL_HISTORY"               
  for each row  
begin   
    select "LEAV_APPROVAL_HISTORY_SEQ".nextval into :NEW.ID from dual; 
end;
/
ALTER TRIGGER  "BI_LEAV_APPROVAL_HISTORY" ENABLE
/

