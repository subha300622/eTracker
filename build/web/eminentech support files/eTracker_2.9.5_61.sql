alter table "LEAVE" add ("DURATION" VARCHAR2(16) NULL)
Update leave set duration='Full Day' ;
Update leave set duration='First Half' where type like '%Half%' ;
Update leave set type='Casual Leave' where type like '%Half%' ;
alter table "LEAVE" modify
("DURATION" VARCHAR2(16) NOT NULL)