
CREATE TABLE  "ISSUE_IMAGE_URL" 
   (	"IMAGE_ID" NUMBER NOT NULL ENABLE, 
	"ISSUE_ID" VARCHAR2(20), 
	"ISSUE_ROW_ID" VARCHAR2(20), 
	"ORGINIAL_URL" VARCHAR2(500), 
	"LOCAL_URL" VARCHAR2(500), 
	"ADDED_ON" TIMESTAMP (6), 
	 CONSTRAINT "ISSUE_IMAGE_URL_PK" PRIMARY KEY ("IMAGE_ID") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_ISSUE_IMAGE_URL" 
  before insert on "ISSUE_IMAGE_URL"               
  for each row  
begin   
    select "ISSUE_IMAGE_URL_SEQ".nextval into :NEW.IMAGE_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_ISSUE_IMAGE_URL" ENABLE
/

 CREATE SEQUENCE   "ISSUE_IMAGE_URL_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE


alter table "ISSUE_IMAGE_URL" add
("GOOGLE_URL_STATUS" NUMBER(1,0) NULL)
/   
alter table "ISSUE_IMAGE_URL" add
("LOCAL_URL_STATUS" NUMBER(1,0) NULL)
/   

-- ** update query 
---------------------------------------------
/*
 DECLARE
  CURSOR image_url_update IS
   SELECT * FROM issue_image_url;    
 BEGIN
   FOR item IN image_url_update
  LOOP   
 update issuecomments set comments=Replace(comments,item.ORGINIAL_URL,item.LOCAL_URL) where rowid=item.ISSUE_ROW_ID;
   END LOOP;
 END;
*/

-- ** update query for replacing the local server url
---------------------------------------------
/*
 DECLARE
  CURSOR image_url_update IS
   SELECT * FROM issue_image_url;    
 BEGIN
   FOR item IN image_url_update
  LOOP   
 update issuecomments set comments=Replace(comments,item.LOCAL_URL,item.ORGINIAL_URL) where rowid=item.ISSUE_ROW_ID;
   END LOOP;
delete from issue_image_url;
 END;
*/

CREATE TABLE  "AGREED_ISSUES" 
   (	"ISSUE_ID" VARCHAR2(20) NOT NULL ENABLE, 
	"PROJECT_ID" NUMBER NOT NULL ENABLE, 
	"ADDEDBY" NUMBER, 
	"ADDEDON" TIMESTAMP (6), 
	"STATUS" NUMBER(2,0), 
	 CONSTRAINT "AGREED_ISSUES_PK" PRIMARY KEY ("ISSUE_ID") ENABLE
   )
/