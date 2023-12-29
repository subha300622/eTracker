CREATE TABLE  "FINE" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"REASON" VARCHAR2(50) NOT NULL ENABLE, 
	"AMOUNT" NUMBER NOT NULL ENABLE, 
	"ADDEDON" TIMESTAMP (6) NOT NULL ENABLE, 
	"ADDEDBY" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "FINE_PK" PRIMARY KEY ("ID") ENABLE, 
	 CONSTRAINT "FINE_UK2" UNIQUE ("REASON", "AMOUNT") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_FINE" 
  before insert on "FINE"               
  for each row  
begin   
    select "FINE_SEQ".nextval into :NEW.ID from dual; 
end; 
/

 CREATE SEQUENCE   "FINE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/

ALTER TRIGGER  "BI_FINE" ENABLE
/


CREATE TABLE  "FINE_AMOUNT_USERS" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"USERID" NUMBER NOT NULL ENABLE, 
	"REASONID" NUMBER NOT NULL ENABLE, 
	"AMOUNT" NUMBER NOT NULL ENABLE, 
	"FINE_DATE" DATE NOT NULL ENABLE, 
	"ADDEDBY" NUMBER NOT NULL ENABLE, 
	"ADDEDON" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "FINE_AMOUNT_USERS_PK" PRIMARY KEY ("ID") ENABLE, 
	 CONSTRAINT "FINE_AMOUNT_USERS_UK1" UNIQUE ("USERID", "REASONID", "AMOUNT", "FINE_DATE") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_FINE_AMOUNT_USERS" 
  before insert on "FINE_AMOUNT_USERS"               
  for each row  
begin   
    select "FINE_AMOUNT_USERS_SEQ".nextval into :NEW.ID from dual; 
end; 
/

CREATE SEQUENCE   "FINE_AMOUNT_USERS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/

ALTER TRIGGER  "BI_FINE_AMOUNT_USERS" ENABLE
/


