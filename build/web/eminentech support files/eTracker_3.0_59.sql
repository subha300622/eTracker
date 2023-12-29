CREATE TABLE  "WRM_MAIL_MAINTENANCE" 
   (	"WRM_MAIL_ID" NUMBER, 
	"PID" NUMBER, 
	"USERID" NUMBER, 
	 CONSTRAINT "WRM_MAIL_MAINTENANCE_PK" PRIMARY KEY ("WRM_MAIL_ID") ENABLE, 
	 CONSTRAINT "WRM_MAIL_MAINTENANCE_PID_UID" UNIQUE ("PID", "USERID") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_WRM_MAIL_MAINTENANCE" 
  before insert on "WRM_MAIL_MAINTENANCE"               
  for each row  
begin   
    select "WRM_MAIL_MAINTENANCE_SEQ".nextval into :NEW.WRM_MAIL_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_WRM_MAIL_MAINTENANCE" ENABLE
/
 CREATE SEQUENCE   "WRM_MAIL_MAINTENANCE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/



CREATE TABLE  "NOTIFICATION" 
   (	"NOTIFICATION_ID" NUMBER, 
	"NOTIFICATION" VARCHAR2(1000), 
	"EXPIRY_DATE" DATE, 
	"ADDED_BY" NUMBER, 
	"ADDED_ON" TIMESTAMP (6), 
	"NOTIFICATION_TYPE" VARCHAR2(20), 
	 CONSTRAINT "NOTIFICATION_PK" PRIMARY KEY ("NOTIFICATION_ID") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_NOTIFICATION" 
  before insert on "NOTIFICATION"               
  for each row  
begin   
    select "NOTIFICATION_SEQ".nextval into :NEW.NOTIFICATION_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_NOTIFICATION" ENABLE
/

CREATE SEQUENCE   "NOTIFICATION_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/
