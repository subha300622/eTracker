CREATE OR REPLACE FORCE VIEW  "LASTWRM" ("WRMDAY", "PID") AS 
  select MAX(wrmday) AS wrmday,pid from Apm_Wrm_Plan group by pid
/
CREATE OR REPLACE FORCE VIEW  "UPDATED" ("COUNT", "PID") AS 
  SELECT count(distinct(i.ISSUEID)) as count,i.pid as pid from issue i,issuecomments ic,issuestatus s,lastwrm l,Apm_wrm_plan ap where to_date(comment_date,'DD-MM-yyyy')>=to_date(l.WRMDAY,'DD-MM-yyyy') and to_date(ap.wrmday,'DD-MM-yyyy')>=to_date(l.WRMDAY,'DD-MM-yyyy') and  i.issueid=ic.issueid and i.pid=l.pid and ap.pid=i.pid and i.issueid=ap.issueid and i.issueid=s.issueid and s.status!='Closed' and ap.status='Active' group by i.pid
/
