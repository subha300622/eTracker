alter table "PROJECT_PLANNED_ISSUE" add
("CREATEDON" TIMESTAMP NULL)
/   
update project_planned_issue set createdon=modifiedon
/
alter table "PROJECT_PLANNED_ISSUE" modify
("CREATEDON" TIMESTAMP NOT NULL)
/   

