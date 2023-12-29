alter table "FINE_AMOUNT_USERS" add
("STATUS" VARCHAR2(50) NULL)
/
   
alter table "FINE_AMOUNT_USERS" add
("COMMENTS" VARCHAR2(200) NULL)
/ 

update FINE_AMOUNT_USERS set status='Active'
/

  


