CREATE TABLE BPM_COMPANY(COMPANY_ID NUMBER,COMPANY_NAME VARCHAR(100),CLIENT_ID NUMBER,CLIENT_NAME VARCHAR(100));
CREATE SEQUENCE "BPM_COMPANY_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_BP(BP_ID NUMBER,BP_NAME VARCHAR(500),COMPANY_ID NUMBER);
CREATE SEQUENCE "BPM_BP_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_MAIN_PROCESS(MP_ID NUMBER,MAIN_PROCESS VARCHAR(500) ,BP_ID NUMBER);
CREATE SEQUENCE "BPM_MP_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_SUB_PROCESS(SP_ID NUMBER,SUB_PROCESS VARCHAR(500),MP_ID NUMBER);
CREATE SEQUENCE "BPM_SP_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_SCENARIO(SCENARIO_ID NUMBER,SCENARIO VARCHAR(500),SP_ID NUMBER);
CREATE SEQUENCE "BPM_SCENARIO_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

CREATE TABLE BPM_VARIANT(VARIANT_ID NUMBER,VARIANT VARCHAR(500),SCENARIO_ID NUMBER);
CREATE SEQUENCE "BPM_VARIANT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

CREATE TABLE BPM_TESTCASE(TESTCASE_ID NUMBER,TESTCASE VARCHAR(500),VARIANT_ID NUMBER,TYPE VARCHAR(50),CLASSIFICATION VARCHAR(50),LEAD_MODULE VARCHAR(50),PRIORITY VARCHAR(50));
CREATE SEQUENCE "BPM_TESTCASE_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

CREATE TABLE BPM_TESTSTEP(TESTSTEP_ID NUMBER,TESTSTEP VARCHAR(500),TESTCASE_ID NUMBER);
CREATE SEQUENCE "BPM_TESTSTEP_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

CREATE TABLE BPM_TESTSCRIPT(TESTSCRIPT_ID NUMBER,TEST_SCRIPT VARCHAR(500),EXPECTED_RESULT VARCHAR(500),TESTSTEP_ID NUMBER);
CREATE SEQUENCE "BPM_TESTSCRIPT_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;