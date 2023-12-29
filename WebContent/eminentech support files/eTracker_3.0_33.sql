create  index eTrackerissuereference on issue(subject)
      indextype is ctxsys.CONTEXT;
/
-- The below quieries are one time execution quiries

CREATE OR REPLACE FORCE VIEW  "TR_INSERTEDDATE" ("ID", "INSERTDATE") AS 
  select id,to_Timestamp(to_char(SCN_TO_TIMESTAMP(ORA_ROWSCN),'DD-Mon-yyyy hh:mi:ss'),'DD-Mon-yyyy hh:mi:ss')as insertdate  from tr_details where created_on is null
/
CREATE OR REPLACE PROCEDURE UPDATE_TR_CREATEDON IS
       i   NUMBER := 0;
    BEGIN
       FOR rec IN (SELECT * FROM TR_INSERTEDDATE )
       LOOP
          i := i + 1;
update tr_details set created_on =rec.insertdate where id=rec.id ;
      END LOOP;
   END;
/
BEGIN
UPDATE_TR_CREATEDON ;
END
/