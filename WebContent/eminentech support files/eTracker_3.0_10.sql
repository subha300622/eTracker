create or replace function "CLOSEDISSUECOUNT" (userid in VARCHAR2 default '0')
 return NUMBER 
 is 
 closedcount number; 
 begin 
 select count(issueid) into closedcount from 
 (select distinct issuecomments.issueid from issue,issuestatus,issuecomments 
 where issue.issueid = issuestatus.issueid 
 and issue.issueid = issuecomments.issueid 
 and issuecomments.Commentedby = userid 
 and issuecomments.Commentedto = userid 
 and to_char(issue.Modifiedon,'Mon-YYYY')=to_char(sysdate,'Mon-YYYY') 
 and issuestatus.status ='Closed' 
 minus 
 select distinct issueid from issuecomments where status!='Closed' 
and (status='Rejected' or status='Duplicate') 
group by comment_date ,issueid 
having to_char(Max(comment_date),'DD-Mon-YYYY HH:mm:ss') =to_char(issuecomments.comment_date,'DD-Mon-YYYY HH:mm:ss')); 
return closedcount; 
end;