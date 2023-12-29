CREATE TABLE TQM_MODULEPLAN(
MPID NUMBER,
TEPID NUMBER,
MID NUMBER,
CONSTRAINT MPID_PK PRIMARY KEY("MPID") ENABLE,
CONSTRAINT TEPID_FK FOREIGN KEY("TEPID") REFERENCES TQM_TESTCASEEXECUTIONPLAN("TEPID") ON DELETE CASCADE ENABLE,
CONSTRAINT MID_MP_FK FOREIGN KEY("MID") REFERENCES MODULES("MODULEID") ON DELETE CASCADE ENABLE
);
CREATE SEQUENCE   "MPID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
ALTER TABLE TQM_TESTCASEEXECUTION RENAME COLUMN MID TO STATUSID;
ALTER TABLE TQM_TESTCASEEXECUTION ADD CONSTRAINT FK_EXECUTION_STATUSID FOREIGN KEY("STATUSID") REFERENCES TQM_TESTCASESTATUS("STATUSID") ON DELETE CASCADE ENABLE;
ALTER TABLE TQM_TESTCASEEXECUTION ADD DUEDATE DATE;

ALTER TABLE TQM_TESTCASEEXECUTIONRESULT ADD COMMENTEDTO NUMBER;

ALTER TABLE TQM_TESTCASEEXECUTIONPLAN ADD PLANNAME VARCHAR(75);

ALTER TABLE TQM_TESTCASEEXECUTIONRESULT ADD DUEDATE DATE;
ALTER TABLE TQM_TESTCASEEXECUTION DROP CONSTRAINT FK_EXECUTION_MID;