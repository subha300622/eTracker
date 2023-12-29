alter table "MOM_FEEDBACK" add ("DISCUSSION" VARCHAR2(2000) NULL) 
/    
alter table "RESOURCES" add
("STATUS" VARCHAR2(20) NULL)
/     
update RESOURCES set status='Not Working'
/
alter table "RESOURCES" modify
("STATUS" VARCHAR2(20) NOT NULL)
