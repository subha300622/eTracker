CREATE TABLE  "ISSUE_LINK" 
   (	"LINK_ID" NUMBER, 
	"MAIN_ISSUE_ID" VARCHAR2(15) NOT NULL ENABLE, 
	"SUB_ISSUE_ID" VARCHAR2(15) NOT NULL ENABLE, 
	 CONSTRAINT "ISSUE_LINK_PK" PRIMARY KEY ("LINK_ID") ENABLE, 
	 CONSTRAINT "ISSUE_LINK_UNIQUE" UNIQUE ("MAIN_ISSUE_ID", "SUB_ISSUE_ID") ENABLE
   )
/
 CREATE SEQUENCE   "ISSUE_LINK_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/

CREATE OR REPLACE TRIGGER  "BI_ISSUE_LINK" 
  before insert on "ISSUE_LINK"               
  for each row  
begin   
    select "ISSUE_LINK_SEQ".nextval into :NEW.LINK_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_ISSUE_LINK" ENABLE
/


create or replace procedure "SUB_ISSUE_LINK" (main_issue IN VARCHAR2, sub_issue IN VARCHAR2) is counta NUMBER := 0; begin select count(*) into counta from ISSUE_LINK where sub_issue_id=sub_issue; if counta =0 then insert into issue_link (MAIN_ISSUE_ID,Sub_Issue_id) VALUES(main_issue,sub_issue); else update issue_link set MAIN_ISSUE_ID=main_issue where sub_issue_id=sub_issue; end if; end;

