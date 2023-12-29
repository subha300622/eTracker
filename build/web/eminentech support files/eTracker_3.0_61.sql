

CREATE OR REPLACE FUNCTION tqm_new_ptcid RETURN VARCHAR2 IS

    ptcid              VARCHAR2(20);
    c_day              NUMBER := 0;
    c_mon              NUMBER := 0;
    c_year             NUMBER := 0;
    testcaseidformat   VARCHAR2(20);
    ptcid_count        NUMBER := 0;
    ptcid_sequ         NUMBER := 0;
BEGIN
    SELECT
        EXTRACT(DAY FROM SYSDATE),
        EXTRACT(MONTH FROM SYSDATE),
        EXTRACT(YEAR FROM SYSDATE)
    INTO
        c_day,c_mon,c_year
    FROM
        dual;

    IF
        ( c_day < 10 )
    THEN
        testcaseidformat := 'Q0'
        || c_day;
    ELSE
        testcaseidformat := 'Q'
        || c_day;
    END IF;

    IF
        ( c_mon < 10 )
    THEN
        testcaseidformat := testcaseidformat
        || '0'
        || c_mon
        || c_year;
    ELSE
        testcaseidformat := testcaseidformat
        || c_mon
        || c_year;
    END IF;

    SELECT
        COUNT(ptcid)
    INTO
        ptcid_count
    FROM
        tqm_ptcm
    WHERE
        TO_CHAR(createdon,'dd-mm-yyyy') LIKE (
            SELECT
                TO_CHAR(SYSDATE,'dd-mm-yyyy')
            FROM
                dual
        );

    IF
        ( ptcid = 0 )
    THEN
        EXECUTE IMMEDIATE 'drop sequence PTCID_SEQ';
        EXECUTE IMMEDIATE 'create sequence PTCID_SEQ start with 1 increment by 1 nocache nocycle';
    END IF;
    SELECT
        ptcid_seq.NEXTVAL
    INTO
        ptcid_sequ
    FROM
        dual;

    IF
        ( ptcid_sequ < 10 )
    THEN
        testcaseidformat := testcaseidformat
        || '00'
        || ptcid_sequ;
    ELSIF ( ptcid_sequ >= 10 AND ptcid_sequ <= 99 ) THEN
        testcaseidformat := testcaseidformat
        || '0'
        || ptcid_sequ;
    ELSE
        testcaseidformat := testcaseidformat
        || ptcid_sequ;
    END IF;

    ptcid := testcaseidformat;
    RETURN ptcid;
END;


CREATE OR REPLACE PROCEDURE bpm_create (
    src_comp_id       IN NUMBER,
    dest_company_id   IN NUMBER,
    userid            IN NUMBER
) IS
    new_pb_id    NUMBER := 1;
    new_mp_id    NUMBER := 1;
    new_sp_id    NUMBER := 1;
    new_sce_id   NUMBER := 1;
    new_va_id    NUMBER := 1;
    new_tc_id    NUMBER := 1;
    new_ts_id    NUMBER := 1;
    new_tsc_id   NUMBER := 1;
    new_ptc_id   tqm_ptcm.ptcid%TYPE;
    
BEGIN 

/*Starting of Business process */

    FOR r_bp IN (
        SELECT
            *
        FROM
            bpm_bp
        WHERE
            company_id = src_comp_id
    ) LOOP
        INSERT INTO bpm_bp (
            bp_id,
            bp_name,
            company_id,
            createdby,
            createdon,
            bp_type
        ) VALUES (
            bpm_bp_id_seq.NEXTVAL,
            r_bp.bp_name,
            dest_company_id,
            userid,
            SYSDATE,
            r_bp.bp_type
        ) RETURNING bp_id INTO new_pb_id; 
        
 /*Starting of Main process */

        FOR r_mp IN (
            SELECT
                *
            FROM
                bpm_main_process
            WHERE
                bp_id = r_bp.bp_id
        ) LOOP
            INSERT INTO bpm_main_process (
                mp_id,
                main_process,
                bp_id,
                createdby,
                createdon,
                mp_type
            ) VALUES (
                bpm_mp_id_seq.NEXTVAL,
                r_mp.main_process,
                new_pb_id,
                userid,
                SYSDATE,
                r_mp.mp_type
            ) RETURNING mp_id INTO new_mp_id; 
            
    /*Starting of sub process */

            FOR r_sp IN (
                SELECT
                    *
                FROM
                    bpm_sub_process
                WHERE
                    mp_id = r_mp.mp_id
            ) LOOP
                INSERT INTO bpm_sub_process (
                    sp_id,
                    sub_process,
                    mp_id,
                    createdby,
                    createdon,
                    sp_type
                ) VALUES (
                    bpm_sp_id_seq.NEXTVAL,
                    r_sp.sub_process,
                    new_mp_id,
                    userid,
                    SYSDATE,
                    r_sp.sp_type
                ) RETURNING sp_id INTO new_sp_id; 
                
        /*Starting of Scenario */

                FOR r_sce IN (
                    SELECT
                        *
                    FROM
                        bpm_scenario
                    WHERE
                        sp_id = r_sp.sp_id
                ) LOOP
                    INSERT INTO bpm_scenario (
                        scenario_id,
                        scenario,
                        sp_id,
                        createdby,
                        createdon,
                        sc_type
                    ) VALUES (
                        bpm_scenario_id_seq.NEXTVAL,
                        r_sce.scenario,
                        new_sp_id,
                        userid,
                        SYSDATE,
                        r_sce.sc_type
                    ) RETURNING scenario_id INTO new_sce_id; 
                    
        /*Starting of variant */

                    FOR r_va IN (
                        SELECT
                            *
                        FROM
                            bpm_variant
                        WHERE
                            scenario_id = r_sce.scenario_id
                    ) LOOP
                        INSERT INTO bpm_variant (
                            variant_id,
                            variant,
                            scenario_id,
                            lead_module,
                            impacted_module,
                            classification,
                            type,
                            priority,
                            createdby,
                            createdon,
                            vt_type
                        ) VALUES (
                            bpm_variant_id_seq.NEXTVAL,
                            r_va.variant,
                            new_sce_id,
                            r_va.lead_module,
                            r_va.impacted_module,
                            r_va.classification,
                            r_va.type,
                            r_va.priority,
                            userid,
                            SYSDATE,
                            r_sce.sc_type
                        ) RETURNING variant_id INTO new_va_id;

             /*Starting of test case */

                        FOR r_tc IN (
                            SELECT
                                *
                            FROM
                                bpm_testcase
                            WHERE
                                variant_id = r_va.variant_id
                        ) LOOP
                            INSERT INTO bpm_testcase (
                                testcase_id,
                                testcase,
                                variant_id,
                                createdby,
                                createdon,
                                tc_type
                            ) VALUES (
                                bpm_testcase_id_seq.NEXTVAL,
                                r_tc.testcase,
                                new_va_id,
                                userid,
                                SYSDATE,
                                r_tc.tc_type
                            ) RETURNING testcase_id INTO new_tc_id; 
        /*Starting of test step */

                            FOR r_ts IN (
                                SELECT
                                    *
                                FROM
                                    bpm_teststep
                                WHERE
                                    testcase_id = r_tc.testcase_id
                            ) LOOP
                                INSERT INTO bpm_teststep (
                                    teststep_id,
                                    teststep,
                                    testcase_id,
                                    createdby,
                                    createdon,
                                    ts_type
                                ) VALUES (
                                    bpm_teststep_id_seq.NEXTVAL,
                                    r_ts.teststep,
                                    new_tc_id,
                                    userid,
                                    SYSDATE,
                                    r_ts.ts_type
                                ) RETURNING teststep_id INTO new_ts_id;
                                
        /*Starting of test script */

                                FOR r_tsc IN (
                                    SELECT
                                        *
                                    FROM
                                        bpm_testscript
                                    WHERE
                                        teststep_id = r_ts.teststep_id
                                ) LOOP
                                    SELECT
                                        tqm_new_ptcid()
                                    INTO
                                        new_ptc_id
                                    FROM
                                        dual;

                                    INSERT INTO tqm_ptcm (
                                        ptcid,
                                        pid,
                                        mid,
                                        functionality,
                                        description,
                                        expectedresult,
                                        createdby,
                                        createdon,
                                        modifiedon
                                    )
                                        SELECT
                                            new_ptc_id,
                                            (
                                                SELECT
                                                    client_id
                                                FROM
                                                    bpm_company
                                                WHERE
                                                    company_id = dest_company_id
                                            ),
                                            b.mid,
                                            b.functionality,
                                            b.description,
                                            r_tsc.expected_result,
                                            userid,
                                            SYSDATE,
                                            SYSDATE
                                        FROM
                                            tqm_ptcm b
                                        WHERE
                                            b.ptcid = r_tsc.ptcid;

                                    INSERT INTO bpm_testscript (
                                        testscript_id,
                                        test_script,
                                        expected_result,
                                        teststep_id,
                                        ptcid,
                                        createdby,
                                        createdon
                                    ) VALUES (
                                        bpm_testscript_id_seq.NEXTVAL,
                                        r_tsc.test_script,
                                        r_tsc.expected_result,
                                        new_ts_id,
                                        new_ptc_id,
                                        userid,
                                        SYSDATE
                                    );

                                END LOOP; /*Ending of test step */

                            END LOOP; /*Ending of test step */

                        END LOOP; /*Ending of variant */

                    END LOOP; /*Ending of variant */

                END LOOP; /*Ending of scenario */

            END LOOP; /*Ending of sub process */

        END LOOP; /*Ending of Main process */

    END LOOP; /*Ending of Business process */
END;