CREATE TABLE  "TEMP_SUMMARYCOUNT" 
   (	"SUMISSUE" VARCHAR2(4000), 
	"STAT" VARCHAR2(4000), 
	"MAILID" VARCHAR2(4000), 
	"CDATE" DATE
   )
/
create or replace procedure "PROC_SUMMARYCOUNT" (plon IN VARCHAR2, teams IN VARCHAR2, pm IN NUMBER) is BEGIN EXECUTE IMMEDIATE 'TRUNCATE TABLE TEMP_SUMMARYCOUNT' ; INSERT INTO TEMP_SUMMARYCOUNT(SUMISSUE,STAT,MAILID,CDATE)(select distinct(i.issueid),ist.status,u.email,ic.comment_date from (select issueid, status, commentedby, commentedto,comment_date from issuecomments where to_char(comment_date,'dd-Mon-YYYY') =plon and status<>'Unconfirmed')ic,issue i ,issuestatus ist,project p,users u,users us, MOM_Maintanance mmt where  ic.issueid=i.issueid and ist.issueid=i.issueid and i.pid=p.pid and u.userid=i.assignedto and us.userid=ic.CommentedBy and mmt.userid=ic.CommentedBy and mmt.team in (select regexp_substr(teams,'[^,]+', 1, level) from dual connect by regexp_substr(teams, '[^,]+', 1, level) is not null ) And pmanager <> pm
); end;

