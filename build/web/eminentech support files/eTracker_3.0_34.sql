alter table "MOM_FEEDBACK" add
("MOMTEAMTYPE" NUMBER NULL)
/
  
alter table "MOM_FEEDBACK" add constraint
"MOM_FEEDBACK_CON1" unique ("MOMDATE","MOMTIME","MOMTEAMTYPE")
/   
update MOM_FEEDBACK set MOMTEAMTYPE=0

/ 
alter table "MOM_FEEDBACK" modify
("MOMTEAMTYPE" NUMBER )