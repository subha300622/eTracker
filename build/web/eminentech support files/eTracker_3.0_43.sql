
/* store procudre for create issue count task*/
create or replace PROCEDURE PROC_CREATEISSUECOUNTTASK( in_userid IN NUMBER, in_rset OUT SYS_REFCURSOR) is begin OPEN in_rset FOR select count(*) as issueCount, p.pname as pname,p.version as version from issue i,issuestatus s ,project p where i.pId in(select PID from userproject where userid=in_userid ) and assignedto= in_userid and i.issueid=s.issueid and i.pid=p.pid and s.status <>'Closed' group by i.pid,p.pname,p.version; END;
/
/*store procudre for createtask . Execute this new query for Stoping duplicate count for user date:01-06-2016 */

create or replace procedure "PROC_CREATETASK"
(
in_userid IN NUMBER,
in_task IN VARCHAR2,
in_type IN VARCHAR2,
in_createdby IN NUMBER,
in_createdon IN TIMESTAMP,
in_modifiedon IN TIMESTAMP,
in_momdate IN TIMESTAMP,
in_tasktime IN VARCHAR2)
is
begin 
DECLARE mtaskid VARCHAR2(25) := null;
begin
begin
 if in_type='Count' then
select Distinct(m.momtaskid) into mtaskid from mom_user_task m where to_char(m.momdate,'DD-Mon-YYYY') =to_char(in_momdate,'DD-Mon-YYYY') and m.userid= in_userid and m.tasktime=in_tasktime and type='Count'; 
else
select Distinct(m.momtaskid) into mtaskid from mom_user_task m where to_char(m.momdate,'DD-Mon-YYYY') =to_char(in_momdate,'DD-Mon-YYYY') and m.userid= in_userid and m.task=in_task and m.tasktime=in_tasktime;
end if; 
exception
when  no_data_found
then
mtaskid:=null;
end;
if mtaskid is null then 
insert INTO MOM_USER_TASK (userid ,task,type ,createdby,createdon,modifiedon,momdate,tasktime) VALUES (in_userid ,in_task,in_type ,in_createdby,in_createdon,in_modifiedon,in_momdate,in_tasktime);
 else 
 update MOM_USER_TASK set userid= in_userid, type=in_type,task=in_task, createdby=in_createdby,modifiedon=in_modifiedon,momdate=in_momdate,tasktime=in_tasktime where momtaskid=mtaskid ; 
 end if; 
end;
end;

/*create or replace procedure "PROC_CREATETASK" ( in_userid IN NUMBER, in_task IN VARCHAR2, in_type IN VARCHAR2, in_createdby IN NUMBER, in_createdon IN TIMESTAMP, in_modifiedon IN TIMESTAMP, in_momdate IN TIMESTAMP, in_tasktime IN VARCHAR2) is begin DECLARE mtaskid VARCHAR2(25) := null; begin begin select Distinct(m.momtaskid) into mtaskid from mom_user_task m,users u where to_char(m.momdate,'DD-Mon-YYYY') =to_char(in_momdate,'DD-Mon-YYYY') and m.userid= in_userid and m.task=in_task and m.tasktime=in_tasktime; exception when no_data_found then mtaskid:=null; end; if mtaskid is null then insert INTO MOM_USER_TASK (userid ,task,type ,createdby,createdon,modifiedon,momdate,tasktime) VALUES (in_userid ,in_task,in_type ,in_createdby,in_createdon,in_modifiedon,in_momdate,in_tasktime); else update MOM_USER_TASK set userid= in_userid, type=in_type,task=in_task, createdby=in_createdby,modifiedon=in_modifiedon,momdate=in_momdate,tasktime=in_tasktime where momtaskid=mtaskid ; end if; end; end;
*/
/
/*store procudre for create mom details */
create or replace procedure "PROC_CREATMOMDETAILS" ( in_userid IN NUMBER, in_momdate IN TIMESTAMP, in_status varchar2, in_createdby IN NUMBER, in_createdon IN TIMESTAMP, in_modifiedon IN TIMESTAMP, in_momtime varchar2, in_comments IN VARCHAR2) is begin DECLARE momdetailId number:= 0; begin begin select momuserdetailid into momdetailId from Mom_user_detail where (momtime=in_momtime And userId=in_userid) And momdate=to_char(in_momdate,'DD-Mon-YYYY') ; exception when no_data_found then momdetailId:=0; end; if momdetailId=0 then insert INTO Mom_user_detail (USERID ,MOMDATE ,STATUS,CREATEDBY,CREATEDON,MODIFIEDON,MOMTIME,MOMCOMMENT) VALUES (in_userid ,to_char(in_momdate,'DD-Mon-YYYY') ,in_status ,in_createdby,in_createdon,in_modifiedon,in_momtime,in_comments); else update Mom_user_detail set userid= in_userid, MOMDATE=to_char(in_momdate,'DD-Mon-YYYY') ,STATUS=in_status , createdby=in_createdby,modifiedon=in_modifiedon,momtime=in_momtime,MOMCOMMENT=in_comments where momuserdetailid=momdetailId ; end if; end; end;
/
/*store procudre for delete or unplann task for user  */
create or replace procedure "PROC_UNPLANNEFORUSER" ( in_datefor IN VARCHAR2, in_issueno IN VARCHAR2, in_userid IN NUMBER, in_momtaskid IN VARCHAR2, in_type in VARCHAR2) is begin if in_type is null then Delete from mom_user_task m where MOMTASKID =in_momtaskid ; else Delete from mom_user_task m where m.momdate =in_datefor and type='Issue' and task like '%'||in_issueno||'%' and USERID=in_userid; end if; end;

/

/* alert the sequence for MOM_USER_TASK table*/

CREATE OR REPLACE TRIGGER  "BI_MOM_USER_TASK" before insert on "MOM_USER_TASK" for each row begin  SELECT (TO_CHAR(SYSDATE, 'DDMMYYYY')||MOMID_SEQ.nextval) into :NEW.momtaskid from dual; end;
/
ALTER TRIGGER  "BI_MOM_USER_TASK" ENABLE

/* alert or sequence for mom_user_detail table */
CREATE OR REPLACE TRIGGER  "BI_MOM_USER_DETAIL" 
  before insert on "MOM_USER_DETAIL"               
  for each row  
begin   
    select "MOM_USER_DETAIL_SEQ".nextval into :NEW.MOMUSERDETAILID from dual; 
end;
/
ALTER TRIGGER  "BI_MOM_USER_DETAIL" ENABLE

/

/*Drop MomId seq Job store procedure*/
CREATE OR REPLACE PROCEDURE PROC_DROPMOMIDSEQ
IS
begin
   begin
      execute immediate 'drop sequence MOMID_SEQ';
   exception
      when others then null;
   end;
   execute immediate
      'create sequence MOMID_SEQ start with 1 increment by 1 nocache nocycle';
end;
/
 
/* login as admin as system  */
grant create job to eminenttracker;
/

/*start the job login as eminenttraker*/
BEGIN 
   dbms_scheduler.create_job ( 
    job_name => 'Drop_MomID_Seq', 
    job_type => 'PLSQL_BLOCK', 
    job_action => 'PROC_DROPMOMIDSEQ;', 
    start_date => SYSTIMESTAMP, 
    enabled => true, 
    repeat_interval => 'FREQ=DAILY; BYHOUR=00; BYMINUTE=00;',
Comments => 'Execute this task every 00:00 hour.'
   ); 
END;



/* runing the job */
BEGIN
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME            => 'Drop_MomID_Seq',
    USE_CURRENT_SESSION => false);
END;
