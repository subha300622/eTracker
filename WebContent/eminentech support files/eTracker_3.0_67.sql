	alter table "BPM_COMPANY" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_BP" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_MAIN_PROCESS" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_SUB_PROCESS" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_SCENARIO" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_VARIANT" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_TESTCASE" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_TESTSTEP" add ("SINO" NUMBER(9,0) NULL) /
	alter table "BPM_TESTSCRIPT" add ("SINO" NUMBER(9,0) NULL) /
	
	create or replace procedure "BPM_COMPANY_SEQ_UPDATE"
(comp_id IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_COMPANY SET SINO=SEQ_NO WHERE COMPANY_ID=comp_id ;

end;
/   
create or replace procedure "BPM_BP_SEQ_UPDATE"
(BP_ID IN NUMBER,
seq_no IN NUMBER)d
is
begin
UPDATE BPM_BP SET SINO=SEQ_NO WHERE BP_ID=BP_ID;

end;
/   

create or replace procedure "BPM_MAIN_PROCESS_SEQ_UPDATE"
(MP_ID IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_MAIN_PROCESS SET SINO=SEQ_NO WHERE MP_ID=MP_ID;

end;
/   

create or replace procedure "BPM_SUP_PROCESS_SEQ_UPDATE"
(SP_ID IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_SUP_PROCESS SET SINO=SEQ_NO WHERE SP_ID=SP_ID;

end;
/   

create or replace procedure "BPM_SCENARIO_SEQ_UPDATE"
(SC_ID IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_SCENARIO SET SINO=SEQ_NO WHERE SCENARIO_ID=SC_ID;
end;
/   

create or replace procedure "BPM_VARIANT_SEQ_UPDATE"
(V_ID IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_VARIANT SET SINO=SEQ_NO WHERE VARIANT_ID=V_ID;
end;
/   
create or replace procedure "BPM_TESTCASE_SEQ_UPDATE"
(TC_ID IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_TESTCASE SET SINO=SEQ_NO WHERE TESTCASE_ID=TC_ID;
end;
/   

create or replace procedure "BPM_TESTSTEP_SEQ_UPDATE"
(TS_ID IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_TESTSTEP SET SINO=SEQ_NO WHERE TESTSTEP_ID=TS_ID;
end;
/   

create or replace procedure "BPM_TESTSCRIPT_SEQ_UPDATE"
(tsc_id IN NUMBER,
seq_no IN NUMBER)
is
begin
UPDATE BPM_TESTSCRIPT SET SINO=SEQ_NO WHERE TESTSCRIPT_ID=TSC_ID;

end;
/   


create or replace procedure "BPM_SP_SEQ_UPDATE" (mpId IN NUMBER, seq_no IN NUMBER) is begin UPDATE BPM_SUB_PROCESS SET SINO=seq_no WHERE SP_ID=mpId; end;






