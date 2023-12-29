CREATE OR REPLACE FORCE VIEW  "WRM_ISSUES" ("ISSUEID") AS 
  select i.issueid from issue i, WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid  and p.status='Work in progress' and pmanager <>104 and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date(sysdate,'DD-MM-YY') group by pid) and ap.issueid=i.issueid and ap.status='Active'
/
