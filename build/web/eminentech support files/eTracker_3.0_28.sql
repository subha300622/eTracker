CREATE OR REPLACE FORCE VIEW  "LASTASSIGNEENAME" ("ISSUEID", "NAME", "COMMENTDATE", "EMAIL") AS 
  select distinct(ic.ISSUEID)as issueid, FIRSTNAME ||' '|| SUBSTR(LASTNAME,1,1) as name,to_char(comment_date,'DD-Mon-YYYY HH:mi:ss')  as commentdate,email as email from issuecomments ic,maxcommentdate m,users u where to_char(u.userid)=ic.commentedby and comment_date=m.COMMENTDATE and ic.issueid=m.issueid
/
