alter table "PROJECT_PLANNED_ISSUE" modify
("PLANNEDON" DATE )
/ 
alter table "PROJECT_PLANNED_ISSUE" drop constraint
"PROJECT_PLANNED_ISSUE_CON"
/   

alter table "PROJECT_PLANNED_ISSUE" drop column
"WEEKYEAR"
/   
alter table "PROJECT_PLANNED_ISSUE" add constraint
"PROJECT_PLANNED_ISSUE_UNI" unique ("PID","ISSUEID","PLANNEDON")
/
CREATE OR REPLACE FORCE VIEW  "VIEW1" ("ISSUEID", "ASSIGNEDTO", "DUE_DATE", "STATUS") AS 
  select  i.ISSUEID ,i.ASSIGNEDTO,i.DUE_DATE,s.status from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed'
/
CREATE OR REPLACE FORCE VIEW  "VIEW2" ("CT", "AST") AS 
  select count(*) as ct,ASSIGNEDTO as Ast from view1 where DUE_DATE< sysdate-1 group by ASSIGNEDTO
/
CREATE OR REPLACE FORCE VIEW  "ALLVIEW" ("CT", "AST") AS 
  select count(*) as ct,ASSIGNEDTO as Ast from view1 group by ASSIGNEDTO
/
CREATE OR REPLACE FORCE VIEW  "ATWEEKS" ("CT", "AST") AS 
  select count(*) as ct,ASSIGNEDTO as Ast from view1 where due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual) group by ASSIGNEDTO
/
CREATE OR REPLACE FORCE VIEW  "CWEEK" ("CT", "AST") AS 
  select count(*) as ct,ASSIGNEDTO as Ast from view1 where due_date > sysdate-1 and due_date<=(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual)group by ASSIGNEDTO
/
CREATE OR REPLACE FORCE VIEW  "NWEEK" ("CT", "AST") AS 
  select count(*) as ct,ASSIGNEDTO as Ast from view1 where due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) and due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual) group by ASSIGNEDTO
/
CREATE OR REPLACE FORCE VIEW  "LEAVEVIEW" ("APPROVAL", "ASSIGNEDTO") AS 
  select approval,assignedto from Leave
/
CREATE OR REPLACE FORCE VIEW  "WAITAPPROVALVIEW" ("CT", "ASSIGNEDTO") AS 
  select count(*) as ct,assignedto from leaveview where approval=0 group by assignedto
/
CREATE OR REPLACE FORCE VIEW  "TCEVIEW" ("STATUSID", "ASSIGNEDTO") AS 
  select statusid,assignedto from TQM_TESTCASEEXECUTION where statusid <>1 and statusid <> 4
/
CREATE OR REPLACE FORCE VIEW  "TCEUSERVIEW" ("CT", "ASSIGNEDTO") AS 
  select count(*) as tcecount,ASSIGNEDTO as Ast from TCEVIEW group by ASSIGNEDTO
/
CREATE OR REPLACE FORCE VIEW  "TIMESHEETVIEW" ("ASSIGNEDTO", "ACCOUNTSTATUS") AS 
  select assignedto,accountstatus from TIMESHEET
/
CREATE OR REPLACE FORCE VIEW  "ACSTATUSNULLVIEW" ("CT", "ASSIGNEDTO") AS 
  Select count(*) as ct,assignedto from timesheetview where ACCOUNTSTATUS is null group by assignedto
/
create or replace procedure AssignmentCounts(usid IN varchar, backlog OUT NUMBER ,cwcount OUT number, nwcount out number, atwcount out number , allcount out number,tcecount out number,wapcount out number,tmscount out number)
is
begin
begin
select ct into backlog from view2 where Ast=usid;
exception
when  no_data_found
then
backlog:=0;
end;
begin
select ct into cwcount from CWEEK where Ast=usid;
exception
when  no_data_found
then
cwcount:=0;
end;
begin
select ct into nwcount from NWEEK where Ast=usid;
exception
when  no_data_found
then
nwcount:=0;
end;
begin
select ct into atwcount from ATWEEKS where Ast=usid;
exception
when  no_data_found
then
atwcount:=0;
end;
begin
select ct into allcount from ALLVIEW where Ast=usid;
exception
when  no_data_found
then
allcount:=0;
end;
begin
select ct into tcecount from TCEUSERVIEW where Assignedto=usid;
exception
when  no_data_found
then
tcecount:=0;
end;
begin
select ct into wapcount from WAITAPPROVALVIEW where Assignedto=usid;
exception
when  no_data_found
then
wapcount:=0;
end;
begin
select ct into tmscount from ACSTATUSNULLVIEW where Assignedto=usid;
exception
when  no_data_found
then
tmscount:=0;
end;
END;
/
alter table "USERS_PERFORMANCE" add
("TEAM" VARCHAR2(50) NULL)
/ 
update users_performance set team='NA';
/
alter table "USERS_PERFORMANCE" modify
("TEAM" VARCHAR2(50) NOT NULL)
/   