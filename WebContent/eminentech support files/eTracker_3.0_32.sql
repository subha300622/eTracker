CREATE TABLE  "APM_TR_FORMAT" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"PID" NUMBER NOT NULL ENABLE, 
	"TR_FORMAT" VARCHAR2(4000) NOT NULL ENABLE, 
	 CONSTRAINT "APM_TR_FORMAT_PK" PRIMARY KEY ("ID") ENABLE, 
	 CONSTRAINT "APM_TR_FORMAT_UK1" UNIQUE ("PID", "TR_FORMAT") ENABLE
   )
/
 CREATE SEQUENCE   "APM_TR_FORMAT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/

CREATE OR REPLACE TRIGGER  "BI_APM_TR_FORMAT" 
  before insert on "APM_TR_FORMAT"               
  for each row  
begin   
    select "APM_TR_FORMAT_SEQ".nextval into :NEW.ID from dual; 
end; 

/
ALTER TRIGGER  "BI_APM_TR_FORMAT" ENABLE
/
