CREATE TABLE  "TAGS" 
   (	"TAG_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"TAG_NAME" VARCHAR2(50 CHAR), 
	"USER_ID" NUMBER(10,0), 
	 PRIMARY KEY ("TAG_ID") ENABLE, 
	 CONSTRAINT "TAGS_CON" UNIQUE ("TAG_NAME", "USER_ID") ENABLE
   )
/
CREATE SEQUENCE   "TAGS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/
CREATE TABLE  "TAGISSUES" 
   (	"ID" NUMBER(19,2) NOT NULL ENABLE, 
	"ISSUE_ID" VARCHAR2(255 CHAR), 
	"TAG_ID" NUMBER(10,0), 
	 PRIMARY KEY ("ID") ENABLE, 
	 CONSTRAINT "FK33C5A6B423B705B1" FOREIGN KEY ("TAG_ID")
	  REFERENCES  "TAGS" ("TAG_ID") ENABLE
   )
/
 CREATE SEQUENCE   "TAGISSUES_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE



CREATE OR REPLACE TRIGGER  "BI_TAGS" 
  before insert on "TAGS"               
  for each row  
begin   
    select "TAGS_SEQ".nextval into :NEW.TAG_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_TAGS" ENABLE
/
CREATE OR REPLACE TRIGGER  "BI_TAGISSUES" 
  before insert on "TAGISSUES"               
  for each row  
begin   
    select "TAGISSUES_SEQ".nextval into :NEW.ID from dual; 
end; 

/
ALTER TRIGGER  "BI_TAGISSUES" ENABLE
/