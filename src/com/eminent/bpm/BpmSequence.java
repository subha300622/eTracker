/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.bpm;

import static com.eminent.bpm.BpmUtil.logger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author vanithaalliraj
 */
public class BpmSequence {

    public static String updateTSCSeq(HttpServletRequest request) {
        Connection dbConnection = null;
        CallableStatement tsc_callableStatement = null;
        String status = "";
        int i = 1;
        try {
            String level = request.getParameter("level");
            String seq[] = request.getParameter("seq").split(",");
            if (seq != null) {
                dbConnection = MakeConnection.getConnection();
                dbConnection.setAutoCommit(false);
                switch (level) {
                    case "com":

                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_COMPANY_SEQ_UPDATE(?,?)}");
                        break;
                    case "bp":

                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_BP_SEQ_UPDATE(?,?)}");
                        break;
                    case "mp":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_MAIN_PROCESS_SEQ_UPDATE(?,?)}");
                        break;
                    case "sp":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_SP_SEQ_UPDATE(?,?)}");
                        break;
                    case "sc":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_SCENARIO_SEQ_UPDATE(?,?)}");
                        break;
                    case "vt":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_VARIANT_SEQ_UPDATE(?,?)}");
                        break;
                    case "tc":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_TESTCASE_SEQ_UPDATE(?,?)}");
                        break;
                    case "ts":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_TESTSTEP_SEQ_UPDATE(?,?)}");
                        break;
                    case "tsc":
                        tsc_callableStatement = dbConnection.prepareCall("{call BPM_TESTSCRIPT_SEQ_UPDATE(?,?)}");
                        break;
                }
                if (tsc_callableStatement != null) {
                    i = 1;
                    for (String tsc : seq) {
                        tsc_callableStatement.setInt(1, Integer.parseInt(tsc));
                        tsc_callableStatement.setInt(2, i);
                        tsc_callableStatement.executeUpdate();
                        i++;
                    }
                    status = "Success";
                    dbConnection.commit();
                    dbConnection.setAutoCommit(true);
                }
            }
        } catch (Exception e) {

            status = "Failure";
            try {
                if (dbConnection != null) {
                    dbConnection.rollback();
                }
                logger.error(e.getMessage());

            } catch (SQLException ex) {
                logger.error(ex.getMessage());
            }

        } finally {
            try {

                if (tsc_callableStatement != null) {
                    tsc_callableStatement.close();
                    logger.info("tsc_callableStatement closed");
                }

                if (dbConnection != null) {
                    dbConnection.close();
                    logger.info("dbConnection closed");
                }

            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }

        return status;
    }
}
