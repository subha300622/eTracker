CREATE table "ERM_APPLICANT_FILE" (
    "FILE_ID"      NUMBER NOT NULL,
    "APPLICANT_ID" VARCHAR2(15),
    "FILENAME"     VARCHAR2(100),
    "ATTACHEDDATE" DATE,
    "OWNER"        NUMBER,
    constraint  "ERM_APPLICANT_FILE_PK" primary key ("FILE_ID")
)
/

CREATE sequence "ERM_APPLICANT_FILE_SEQ" 
/

CREATE trigger "BI_ERM_APPLICANT_FILE"  
  before insert on "ERM_APPLICANT_FILE"              
  for each row 
begin  
    select "ERM_APPLICANT_FILE_SEQ".nextval into :NEW.FILE_ID from dual;
end;
/   

