/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  DhanVa CompuTers
 * Created: 23 Jan, 2023
 */

CREATE TABLE  "APM_TS_ATTACHMENT" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TS_ID" NUMBER NOT NULL ENABLE, 
	"FILENAME" VARCHAR2(200) NOT NULL ENABLE, 
	"ATTACHEDDATE" TIMESTAMP (6) NOT NULL ENABLE, 
	"OWNER" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "APM_TS_ATTACHMENT_PK" PRIMARY KEY ("ID") ENABLE
   )

CREATE SEQUENCE   "APM_TS_ATTACHMENT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE

CREATE OR REPLACE TRIGGER  "BI_APM_TS_ATTACHMENT" 
  before insert on "APM_TS_ATTACHMENT"               
  for each row  
begin   
    select "APM_TS_ATTACHMENT_SEQ".nextval into :NEW.ID from dual; 
end; 

ALTER TRIGGER  "BI_APM_TS_ATTACHMENT" ENABLE


