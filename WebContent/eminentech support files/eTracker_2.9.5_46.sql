CREATE TABLE  "TQM_PTCFILEATTACH" ("PTCFILEID" NUMBER(*,0) NOT NULL ENABLE, "PTCID" VARCHAR2(15 CHAR), "FILENAME" VARCHAR2(100 CHAR), "ATTACHEDDATE" DATE, "OWNER" NUMBER, "PTCSTATUS" VARCHAR2(25 CHAR),"TCEID" NUMBER, CONSTRAINT "PK_PTCFILEID" PRIMARY KEY ("PTCFILEID") ENABLE, CONSTRAINT "FK_FILEPTCID" FOREIGN KEY ("PTCID") REFERENCES  "TQM_PTCM" ("PTCID") ON DELETE CASCADE ENABLE)
CREATE SEQUENCE   "PTCFILEID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10000 NOCACHE  NOORDER  NOCYCLE;