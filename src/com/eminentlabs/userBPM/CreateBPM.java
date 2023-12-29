/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.userBPM;

import com.eminent.hibernate.HibernateUtil;
import com.eminent.tqm.TqmPtcm;
import com.eminent.tqm.TqmUtil;
import static com.eminentlabs.userBPM.UpdateBPM.logger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;
import java.sql.Timestamp;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 *
 * @author Tamilvelan
 */
public class CreateBPM {

    public static Logger logger = Logger.getLogger("CreateBPM");

    public static int createCompany(String company, int clientId, int createdBy, String srcCompany) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        CallableStatement cStmt = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_COMPANY(COMPANY_ID,COMPANY_NAME,CLIENT_ID,CREATEDBY,CREATEDON) values(?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_COMPANY_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, company);
            createClient.setInt(3, clientId);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);

            createClient.executeQuery();
            logger.info("Company Created");
            if (!srcCompany.equals("")) {
                cStmt = connection.prepareCall("{call bpm_create(?,?,?)}");
                cStmt.setInt(1, Integer.parseInt(srcCompany));
                cStmt.setInt(2, nextValue);
                cStmt.setInt(3, createdBy);
                cStmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (cStmt != null) {
                    cStmt.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createBP(int company_id, String bpName, int createdBy, String cBpType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_BP(BP_ID,BP_NAME,COMPANY_ID,CREATEDBY,CREATEDON,BP_TYPE) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_BP_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, bpName);
            createClient.setInt(3, company_id);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);
            createClient.setString(6, cBpType);
            createClient.executeQuery();
            logger.info("BP Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createMP(int bpId, String mpName, int createdBy, String mpType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_MAIN_PROCESS(MP_ID,MAIN_PROCESS,BP_ID,CREATEDBY,CREATEDON,MP_TYPE) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_MP_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, mpName);
            createClient.setInt(3, bpId);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);
            createClient.setString(6, mpType);
            createClient.executeQuery();
            logger.info("MP Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createSP(int mpId, String spName, int createdBy, String spType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_SUB_PROCESS(SP_ID,SUB_PROCESS,MP_ID,CREATEDBY,CREATEDON,SP_TYPE) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_SP_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, spName);
            createClient.setInt(3, mpId);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);
            createClient.setString(6, spType);
            createClient.executeQuery();
            logger.info("MP Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createSC(int spId, String scName, int createdBy, String scType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_SCENARIO(SCENARIO_ID,SCENARIO,SP_ID,CREATEDBY,CREATEDON,SC_TYPE) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_SCENARIO_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, scName);
            createClient.setInt(3, spId);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);
            createClient.setString(6, scType);
            createClient.executeQuery();
            logger.info("MP Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createVT(int scId, String vtName, int lead, int impact, String classification, String type, String priority, int createdBy, String vtType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_VARIANT(VARIANT_ID,VARIANT,SCENARIO_ID,LEAD_MODULE,IMPACTED_MODULE,CLASSIFICATION,TYPE,PRIORITY,CREATEDBY,CREATEDON,VT_TYPE) values(?,?,?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_VARIANT_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, vtName);
            createClient.setInt(3, scId);
            createClient.setInt(4, lead);
            createClient.setInt(5, impact);
            createClient.setString(6, classification);
            createClient.setString(7, type);
            createClient.setString(8, priority);
            createClient.setInt(9, createdBy);
            createClient.setTimestamp(10, date);
            createClient.setString(11, vtType);
            createClient.executeQuery();
            logger.info("VT Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createTC(int vtId, String tcName, int createdBy, String tcType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_TESTCASE(TESTCASE_ID,TESTCASE,VARIANT_ID,CREATEDBY,CREATEDON,TC_TYPE) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_TESTCASE_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, tcName);
            createClient.setInt(3, vtId);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);
            createClient.setString(6, tcType);
            createClient.executeQuery();
            logger.info("TC Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static int createTS(int tcId, String tsName, int createdBy, String tsType) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        int nextValue = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_TESTSTEP(TESTSTEP_ID,TESTSTEP,TESTCASE_ID,CREATEDBY,CREATEDON,TS_TYPE) values(?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_TESTSTEP_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            nextValue = resultset.getInt("nextvalue");

            createClient.setInt(1, nextValue);
            createClient.setString(2, tsName);
            createClient.setInt(3, tcId);
            createClient.setInt(4, createdBy);
            createClient.setTimestamp(5, date);
            createClient.setString(6, tsType);
            createClient.executeQuery();
            logger.info("TC Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return nextValue;
    }

    public static void createTestScript(int tsId, String testScript, String expectedResult, int createdBy, String ptcId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        PreparedStatement createClient = null;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            createClient = connection.prepareStatement("insert into BPM_TESTSCRIPT(TESTSCRIPT_ID,TEST_SCRIPT,EXPECTED_RESULT,TESTSTEP_ID,CREATEDBY,CREATEDON,PTCID) values(?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select BPM_TESTSCRIPT_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            int nextValue = resultset.getInt("nextvalue");
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            createClient.setInt(1, nextValue);
            createClient.setString(2, testScript);
            createClient.setString(3, expectedResult);
            createClient.setInt(4, tsId);
            createClient.setInt(5, createdBy);
            createClient.setTimestamp(6, date);
            createClient.setString(7, ptcId);
            createClient.executeQuery();
            logger.info("Test Script Created");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (createClient != null) {
                    createClient.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    public static String createPTC(int pid, int mid, String functionality, String description, String expectedresult, int userId) {

        SessionFactory sessionFactory = null;
        Session sess = null;
        String ptcid = null;
        try {
            ptcid = com.eminent.tqm.TqmUtil.getID();
            logger.info("ID" + ptcid);
            sessionFactory = HibernateUtil.getSessionFactory();
            sess = sessionFactory.openSession();
            sess.beginTransaction();
            Timestamp date = new Timestamp(new java.util.Date().getTime());
            TqmPtcm tc = new TqmPtcm();
            tc.setPtcid(ptcid);
            tc.setPid(pid);
            tc.setMid(mid);
            tc.setFunctionality(functionality);
            tc.setDescription(description);
            tc.setExpectedresult(expectedresult);
            tc.setCreatedby(userId);
            tc.setCreatedon(date);
            tc.setModifiedon(date);
            sess.save("producttestcases", tc);
            sess.getTransaction().commit();

            //           sess.flush();
            //           sess.clear();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (sess != null) {
                sess.close();
            }
        }
        return ptcid;
    }
}
