/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.userBPM;

import com.eminent.issue.Issue;
import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.tqm.TestCasePlan;
import com.eminent.util.GetAge;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
import com.eminent.util.GetProjectManager;
import com.eminent.util.IssueDetails;
import com.eminentlabs.mom.MoMUtil;
import dashboard.MaxIssue;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Tamilvelan
 */
public class ViewBPM {

    public static Logger logger = Logger.getLogger("View BPM");

    public static ArrayList getClient() {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        ArrayList client = new ArrayList<String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select customer from PROJECT");
            while (resultset.next()) {
                client.add(resultset.getString(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return client;
    }

    public static ArrayList getClient(int pId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        ArrayList client = new ArrayList<String>();
        try {
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select customer from PROJECT where pid=" + pId);
            while (resultset.next()) {
                client.add(resultset.getString(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return client;
    }

    public static String getClientName(int pId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        String client = null;
        try {
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select customer from PROJECT where pid=" + pId);
            while (resultset.next()) {
                client = resultset.getString(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return client;
    }

    public static int getCompanyCount(int client_id) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int clientCount = 0;
        logger.info("Client Id" + client_id);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_COMPANY WHERE CLIENT_ID=" + client_id);
            while (resultset.next()) {
                clientCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return clientCount;
    }

    public static LinkedHashMap getCompany(int client_id) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap client = new LinkedHashMap<Integer, String>();
        logger.info("Client Id" + client_id);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select company_id,company_name from BPM_COMPANY WHERE CLIENT_ID=" + client_id+" order by sino");
            while (resultset.next()) {
                client.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return client;
    }

    public static int getBPCount(int company_id) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int bpCount = 0;
        logger.info("Company Id" + company_id);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_BP WHERE COMPANY_ID=" + company_id + " ORDER BY BP_ID");
            while (resultset.next()) {
                bpCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bpCount;
    }

    public static HashMap getAllBP() {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select bp_id,bp_name from BPM_BP ORDER BY BP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static LinkedHashMap  getBP(int company_id) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap  bp = new LinkedHashMap <Integer, String>();
        logger.info("Company Id" + company_id);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select bp_id,bp_name from BPM_BP WHERE COMPANY_ID=" + company_id + " ORDER BY SINO,BP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
      
        return bp;
    }

    public static HashMap getBPType(int company_id) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        logger.info("Company Id" + company_id);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select bp_id,bp_type from BPM_BP WHERE COMPANY_ID=" + company_id + " ORDER BY SINO,BP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static int getMPCount(int bpId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int mpCount = 0;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_MAIN_PROCESS WHERE BP_ID=" + bpId + " ORDER BY SINO,MP_ID");
            while (resultset.next()) {
                mpCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return mpCount;
    }

    public static LinkedHashMap getMP(int bpId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap bp = new LinkedHashMap<Integer, String>();
        logger.info("BP Id" + bpId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select mp_id,MAIN_PROCESS from BPM_MAIN_PROCESS WHERE BP_ID=" + bpId + " ORDER BY SINO,MP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static HashMap getMPType(int bpId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        logger.info("BP Id" + bpId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select mp_id,mp_type from BPM_MAIN_PROCESS WHERE BP_ID=" + bpId + " ORDER BY SINO,MP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static int getSPCount(int mpId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int spCount = 0;
        logger.info("SP Id" + mpId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_SUB_PROCESS WHERE MP_ID=" + mpId + " ORDER BY SINO,SP_ID");
            while (resultset.next()) {
                spCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return spCount;
    }

    public static LinkedHashMap getSP(int mpId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap bp = new LinkedHashMap<Integer, String>();
        logger.info("SP Id" + mpId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select SP_ID,SUB_PROCESS from BPM_SUB_PROCESS WHERE MP_ID=" + mpId + " ORDER BY SINO,SP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static HashMap getSPType(int mpId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        logger.info("SP Id" + mpId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select SP_ID,SP_Type from BPM_SUB_PROCESS WHERE MP_ID=" + mpId + " ORDER BY SINO,SP_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static HashMap getClientMP(int clientId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        logger.info("SP Id" + clientId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select distinct mp.mp_id, main_process from bpm_company c,bpm_bp bp,bpm_main_process mp,bpm_sub_process sp where c.company_id = bp.company_id and bp.bp_id=mp.bp_id and c.client_id=" + clientId + " order by mp.mp_id");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static int getSCCount(int spId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int scCount = 0;
        logger.info("SC Id" + spId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_SCENARIO WHERE SP_ID=" + spId + " ORDER BY SCENARIO_ID");
            while (resultset.next()) {
                scCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return scCount;
    }

    public static LinkedHashMap getSC(int spId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap bp = new LinkedHashMap<Integer, String>();
        logger.info("SC Id" + spId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select SCENARIO_ID,SCENARIO from BPM_SCENARIO WHERE SP_ID=" + spId + " ORDER BY SINO,SCENARIO_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static HashMap getSCTypes(int spId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        logger.info("SC Id" + spId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select SCENARIO_ID,SC_Type from BPM_SCENARIO WHERE SP_ID=" + spId + " ORDER BY SINO,SCENARIO_ID");
            while (resultset.next()) {
                bp.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bp;
    }

    public static int getVTCount(int scId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int vtCount = 0;
        logger.info("SC Id" + scId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_VARIANT WHERE SCENARIO_ID=" + scId + " ORDER BY SINO,VARIANT_ID");
            while (resultset.next()) {
                vtCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vtCount;
    }

    public static HashMap displayVTDetails(int scId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int vtId = 0;

        HashMap vt = new HashMap();
        logger.info("SC Id" + scId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT VARIANT_ID, VARIANT,LEAD_MODULE,IMPACTED_MODULE,CLASSIFICATION,TYPE,PRIORITY,VT_TYPE FROM BPM_VARIANT WHERE SCENARIO_ID=" + scId);
            while (resultset.next()) {
                vtId = resultset.getInt(1);
                vt.put(vtId, resultset.getString(2));
                vt.put(vtId + "lead", resultset.getString(3));
                vt.put(vtId + "impact", resultset.getString(4));
                vt.put(vtId + "classification", resultset.getString(5));
                vt.put(vtId + "type", resultset.getString(6));
                vt.put(vtId + "priority", resultset.getString(7));
                vt.put(vtId + "vttype", resultset.getString(8));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vt;
    }

    public static LinkedHashMap getVT(int scId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap vt = new LinkedHashMap<Integer, String>();
        logger.info("SC Id" + scId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select VARIANT_ID,VARIANT,LEAD_MODULE,IMPACTED_MODULE,CLASSIFICATION,TYPE,PRIORITY,VT_TYPE  from BPM_VARIANT WHERE SCENARIO_ID=" + scId + " ORDER BY SINO,VARIANT_ID");
            while (resultset.next()) {
                vt.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vt;
    }

    public static HashMap getVTTypes(int scId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap vt = new HashMap();
        logger.info("SC Id" + scId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select VARIANT_ID,VT_type from BPM_VARIANT WHERE SCENARIO_ID=" + scId + " ORDER BY SINO,VARIANT_ID");
            while (resultset.next()) {
                vt.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vt;
    }

    public static HashMap getVTDetails(int vtId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap vt = new HashMap();
        logger.info("SC Id" + vtId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select moduleid, module from bpm_variant v,modules m where m.moduleid=v.lead_module and variant_id=" + vtId);
            while (resultset.next()) {
                vt.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vt;
    }

    public static int getTCCount(int vtId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int tcCount = 0;
        logger.info("vt Id" + vtId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from BPM_TESTCASE WHERE VARIANT_ID=" + vtId + " ORDER BY SINO,TESTCASE_ID");
            while (resultset.next()) {
                tcCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return tcCount;
    }

    public static LinkedHashMap getTC(int vtId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap vt = new LinkedHashMap<Integer, String>();
        logger.info("vt Id" + vtId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTCASE_ID,TESTCASE from BPM_TESTCASE WHERE VARIANT_ID=" + vtId + " ORDER BY SINO,TESTCASE_ID");
            while (resultset.next()) {
                vt.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vt;
    }

    public static HashMap getTCTypes(int vtId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap vt = new HashMap<Integer, String>();
        logger.info("vt Id" + vtId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTCASE_ID,TC_type from BPM_TESTCASE WHERE VARIANT_ID=" + vtId + " ORDER BY SINO,TESTCASE_ID");
            while (resultset.next()) {
                vt.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vt;
    }

    public static List getPTCId(int tcId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        List<String> ptcIdList = new ArrayList<String>();
        int tsCount = 0;
        logger.info("tc Id" + tcId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select PTCID from BPM_TESTSCRIPT where TESTSTEP_ID in(select TESTSTEP_ID from BPM_TESTSTEP WHERE TESTCASE_ID=" + tcId + ")");
            while (resultset.next()) {
                ptcIdList.add(resultset.getString("PTCID"));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return ptcIdList;
    }

    public static int getTSCount(int tcId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int tsCount = 0;
        logger.info("tc Id" + tcId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*)  from BPM_TESTSTEP WHERE TESTCASE_ID=" + tcId + " ORDER BY SINO,TESTSTEP_ID");
            while (resultset.next()) {
                tsCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return tsCount;
    }

    public static LinkedHashMap getTS(int tcId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap ts = new LinkedHashMap<Integer, String>();
        logger.info("tc Id" + tcId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTSTEP_ID,TESTSTEP  from BPM_TESTSTEP WHERE TESTCASE_ID=" + tcId + " ORDER BY SINO,TESTSTEP_ID");
            while (resultset.next()) {
                ts.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return ts;
    }

    public static HashMap getTSTypes(int tcId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap ts = new HashMap<Integer, String>();
        logger.info("tc Id" + tcId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTSTEP_ID,TS_type  from BPM_TESTSTEP WHERE TESTCASE_ID=" + tcId + " ORDER BY TESTSTEP_ID");
            while (resultset.next()) {
                ts.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return ts;
    }

    public static void getTSStatusCount(int tsId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int tsCount = 0;
        logger.info("ts Id" + tsId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select ptcid from BPM_TESTSCRIPT WHERE TESTSTEP_ID=" + tsId + " ORDER BY TESTSCRIPT_ID");
            while (resultset.next()) {
                tsCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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

    public static int getTestScriptCount(int tsId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        int tsCount = 0;
        logger.info("ts Id" + tsId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*)  from BPM_TESTSCRIPT WHERE TESTSTEP_ID=" + tsId + " ORDER BY TESTSCRIPT_ID");
            while (resultset.next()) {
                tsCount = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return tsCount;
    }

    public static LinkedHashMap getTestScript(int tsId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        LinkedHashMap ts = new LinkedHashMap<String, String>();
        logger.info("ts Id" + tsId);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTSCRIPT_ID,TEST_SCRIPT,EXPECTED_RESULT,CREATEDBY,PTCID,(SELECT COUNT(*) FROM TQM_PTCFILEATTACH WHERE TQM_PTCFILEATTACH.PTCID=BPM_TESTSCRIPT.PTCID) AS FILES  from BPM_TESTSCRIPT WHERE TESTSTEP_ID=" + tsId + " ORDER BY SINO,TESTSCRIPT_ID");
            while (resultset.next()) {
                ts.put(resultset.getString(5), resultset.getString(2) + "###" + resultset.getString(3) + "###" + GetProjectManager.getUserName(resultset.getInt(4)) + "***" + getTestScriptStatus(resultset.getString(5)) + "***" + resultset.getString(1) + "@@@" + resultset.getString(6));

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return ts;
    }

    public static String getTestScriptStatus(String ptcId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap StatusMap = new HashMap<Integer, String>();
        StatusMap.put(0, "Yet to Test");
        StatusMap.put(1, "Not Applicable");
        StatusMap.put(2, "Could Not Run");
        StatusMap.put(3, "Failed");
        StatusMap.put(4, "Passed");

        ArrayList<Integer> testcaseStatus = new ArrayList<Integer>();

        String status = "Passed";

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT STATUSID, COUNT(*) FROM TQM_TESTCASEEXECUTION WHERE PTCID='" + ptcId + "' GROUP BY STATUSID");
            while (resultset.next()) {
                testcaseStatus.add(resultset.getInt(1));
            }
            if (!testcaseStatus.isEmpty()) {
                Collections.sort(testcaseStatus);

                if (testcaseStatus.contains((Integer) 3)) {
                    status = "Failed";
                } else if (testcaseStatus.contains((Integer) 2)) {
                    status = "Could Not Run";
                } else if (testcaseStatus.contains((Integer) 1)) {
                    status = "Not Applicable";
                } else if (testcaseStatus.contains((Integer) 0)) {
                    status = "Yet To Test";
                }
            } else {
                status = "Not Run";
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return status;
    }

    public static List<Integer> companyIds(String pid) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select co.company_id from  bpm_company co  where client_id='" + pid + "'");
            while (resultset.next()) {

                reids.add(resultset.getInt(1));

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> bpIds(List<Integer> comIds) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : comIds) {
            if ("".equals(extededQuery)) {
                extededQuery = "where company_id =" + id;
            } else {
                extededQuery = extededQuery + " OR company_id =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select bp_id from bpm_bp " + extededQuery);
                logger.info("select bp_id from bpm_bp " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        logger.info("bpIds" + reids);
        return reids;
    }

    public static List<Integer> mpIds(List<Integer> Ids) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : Ids) {
            if ("".equals(extededQuery)) {
                extededQuery = "where bp_id  =" + id;
            } else {
                extededQuery = extededQuery + " OR bp_id  =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select mp_id  from bpm_main_process " + extededQuery);
                logger.info("select mp_id  from bpm_main_process " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> spIds(List<Integer> Ids) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : Ids) {
            if ("".equals(extededQuery)) {
                extededQuery = "where mp_id  =" + id;
            } else {
                extededQuery = extededQuery + " OR mp_id   =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select SP_ID from bpm_sub_process  " + extededQuery);
                logger.info("select SP_ID from bpm_sub_process  " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> scIds(List<Integer> Ids) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : Ids) {
            if ("".equals(extededQuery)) {
                extededQuery = "where SP_ID  =" + id;
            } else {
                extededQuery = extededQuery + " OR SP_ID  =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select SCENARIO_ID  from BPM_scenario  " + extededQuery);
                logger.info("select SCENARIO_ID  from BPM_scenario  " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> vtIds(List<Integer> Ids) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : Ids) {
            if ("".equals(extededQuery)) {
                extededQuery = "where SCENARIO_ID =" + id;
            } else {
                extededQuery = extededQuery + " OR SCENARIO_ID =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select VARIANT_ID from BPM_variant  " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> tcIds(List<Integer> comIds) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : comIds) {
            if ("".equals(extededQuery)) {
                extededQuery = "where VARIANT_ID =" + id;
            } else {
                extededQuery = extededQuery + " OR VARIANT_ID =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select testcase_id from BPM_TESTCASE  " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> tsIds(List<Integer> comIds) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : comIds) {
            if ("".equals(extededQuery)) {
                extededQuery = "where testcase_id =" + id;
            } else {
                extededQuery = extededQuery + " OR testcase_id =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select teststep_id from BPM_testStep  " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static List<Integer> tscIds(List<Integer> comIds) {
        List<Integer> reids = new ArrayList<Integer>();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String extededQuery = "";
        for (int id : comIds) {
            if ("".equals(extededQuery)) {
                extededQuery = "where teststep_id =" + id;
            } else {
                extededQuery = extededQuery + " OR teststep_id =" + id;
            }
        }
        extededQuery = extededQuery.trim();
        try {
            if (!"".equals(extededQuery)) {
                connection = MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select TESTSCRIPT_ID from BPM_testscript " + extededQuery);
                logger.info("select Ptcid from BPM_testscript " + extededQuery);
                while (resultset.next()) {

                    reids.add(resultset.getInt(1));

                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return reids;
    }

    public static HashMap getAll(String pid) {
        List<Integer> cids = companyIds(pid);
        List<Integer> bpids = new ArrayList<Integer>();
        List<Integer> mpids = new ArrayList<Integer>();
        List<Integer> spids = new ArrayList<Integer>();
        List<Integer> scids = new ArrayList<Integer>();
        List<Integer> vtids = new ArrayList<Integer>();
        List<Integer> tcids = new ArrayList<Integer>();
        List<Integer> tsids = new ArrayList<Integer>();
        List<Integer> tscids = new ArrayList<Integer>();
        HashMap tecaseStatus = IssueDetails.getTestCaseStatus(pid);
        HashMap testPlantecaseStatus = IssueDetails.getTestPlanTestCaseStatus(pid);

        if (!cids.isEmpty()) {
            bpids = bpIds(cids);
        }

        if (!bpids.isEmpty()) {
            mpids = mpIds(bpids);
        }
        if (!mpids.isEmpty()) {
            spids = spIds(mpids);
        }
        if (!spids.isEmpty()) {
            scids = scIds(spids);
        }
        if (!scids.isEmpty()) {
            vtids = vtIds(scids);
        }
        if (!vtids.isEmpty()) {
            tcids = tcIds(vtids);
        }
        if (!tcids.isEmpty()) {
            tsids = tsIds(tcids);
        }
        if (!tsids.isEmpty()) {
            tscids = tscIds(tsids);
        }
        HashMap alldata = new HashMap();
        alldata.put("ccount", cids.size());
        alldata.put("bpcount", bpids.size());
        alldata.put("mpcount", mpids.size());
        alldata.put("spcount", spids.size());
        alldata.put("sccount", scids.size());
        alldata.put("vtcount", vtids.size());
        alldata.put("tccount", tcids.size());
        alldata.put("tscount", tsids.size());
        alldata.put("tsccount", tscids.size());
        if (tecaseStatus.get("Passed") != null && (testPlantecaseStatus.get("Passed") != null)) {
            int count = MoMUtil.parseInteger(tecaseStatus.get("Passed").toString(), 0) + MoMUtil.parseInteger(testPlantecaseStatus.get("Passed").toString(), 0);
            alldata.put("passedcount", count);
        } else if (tecaseStatus.get("Passed") != null) {
            alldata.put("passedcount", tecaseStatus.get("Passed"));
        } else if (testPlantecaseStatus.get("Passed") != null) {
            alldata.put("passedcount", testPlantecaseStatus.get("Passed"));
        } else {
            alldata.put("passedcount", 0);
        }
        if (tecaseStatus.get("Failed") != null && testPlantecaseStatus.get("Failed") != null) {
            int count = MoMUtil.parseInteger(tecaseStatus.get("Failed").toString(), 0) + MoMUtil.parseInteger(testPlantecaseStatus.get("Failed").toString(), 0);
            alldata.put("failedcount", count);

        } else if (tecaseStatus.get("Failed") != null) {
            alldata.put("failedcount", tecaseStatus.get("Failed"));
        } else if (testPlantecaseStatus.get("Failed") != null) {
            alldata.put("failedcount", testPlantecaseStatus.get("Failed"));
        } else {
            alldata.put("failedcount", 0);
        }
        alldata.put("tplancount", TestCasePlan.projectPlanCount(pid));
        HashMap<String, Integer> issues = MaxIssue.getProjectIssueCount(pid);
        alldata.put("issuecount", issues.get("altogether") + issues.get("closed"));
        logger.info("alldata---->" + alldata);
        return alldata;
    }

    public static HashMap bpCount(int pid) {
        HashMap<String, Integer> bpcount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select BP_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP WHERE C.COMPANY_ID=BP.COMPANY_ID  AND C.CLIENT_ID=" + pid + " GROUP BY BP_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "bpnone";
                }
                bpcount.put(type, count);

            }
            logger.info("Business Process" + bpcount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return bpcount;
    }

    public static HashMap mpCount(int pid) {
        HashMap<String, Integer> mpcount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT MP_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID  AND C.CLIENT_ID=" + pid + " GROUP BY MP_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "mpnone";
                }
                mpcount.put(type, count);

            }
            logger.info("Main Process" + mpcount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return mpcount;
    }

    public static HashMap spCount(int pid) {
        HashMap<String, Integer> spcount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT SP_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP, BPM_SUB_PROCESS SP WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID AND MP.MP_ID=SP.MP_ID AND C.CLIENT_ID=" + pid + " GROUP BY SP_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "spnone";
                }
                spcount.put(type, count);

            }
            logger.info("Sub Process Process" + spcount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return spcount;
    }

    public static HashMap scCount(int pid) {
        HashMap<String, Integer> sccount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT SC_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP, BPM_SUB_PROCESS SP, BPM_SCENARIO SC WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID AND MP.MP_ID=SP.MP_ID AND SP.SP_ID=SC.SP_ID AND C.CLIENT_ID=" + pid + " GROUP BY SC_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "scnone";
                }
                sccount.put(type, count);

            }
            logger.info("Scenario Process" + sccount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return sccount;
    }

    public static HashMap vtCount(int pid) {
        HashMap<String, Integer> vtcount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT VT_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP, BPM_SUB_PROCESS SP, BPM_SCENARIO SC, BPM_VARIANT VT WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID AND MP.MP_ID=SP.MP_ID AND SP.SP_ID=SC.SP_ID AND SC.SCENARIO_ID = VT.SCENARIO_ID AND C.CLIENT_ID=" + pid + " GROUP BY VT_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "vtnone";
                }
                vtcount.put(type, count);

            }
            logger.info("Variant Process" + vtcount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return vtcount;
    }

    public static HashMap tcCount(int pid) {
        HashMap<String, Integer> tccount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT TC_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP, BPM_SUB_PROCESS SP, BPM_SCENARIO SC, BPM_VARIANT VT, BPM_TESTCASE TC WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID AND MP.MP_ID=SP.MP_ID AND SP.SP_ID=SC.SP_ID AND SC.SCENARIO_ID = VT.SCENARIO_ID AND VT.VARIANT_ID = TC.VARIANT_ID AND C.CLIENT_ID=" + pid + " GROUP BY TC_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "spnone";
                }
                tccount.put(type, count);

            }
            logger.info("Test Case Process" + tccount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return tccount;
    }

    public static HashMap tsCount(int pid) {
        HashMap<String, Integer> tscount = new HashMap();
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count;
        String type;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT TS_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP, BPM_SUB_PROCESS SP, BPM_SCENARIO SC, BPM_VARIANT VT, BPM_TESTCASE TC, BPM_TESTSTEP TS WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID AND MP.MP_ID=SP.MP_ID AND SP.SP_ID=SC.SP_ID AND SC.SCENARIO_ID = VT.SCENARIO_ID AND VT.VARIANT_ID = TC.VARIANT_ID AND TC.TESTCASE_ID=TS.TESTCASE_ID AND C.CLIENT_ID=" + pid + " GROUP BY TS_TYPE");

            while (resultset.next()) {
                type = resultset.getString(1);
                count = resultset.getInt(2);
                if (type == null) {
                    type = "tsnone";
                }
                tscount.put(type, count);

            }
            logger.info("Test Step Process" + tscount);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return tscount;
    }

    public static HashMap typeCount(int pid) {
        HashMap count = new HashMap<String, Integer>();
        try {
            HashMap bpcount = bpCount(pid);
            HashMap mpcount = mpCount(pid);
            HashMap spcount = spCount(pid);
            HashMap sccount = scCount(pid);
            HashMap vtcount = vtCount(pid);
            HashMap tccount = tcCount(pid);
            HashMap tscount = tsCount(pid);
            //Business Process Count
            if (bpcount.get("SAP") != null) {
                count.put("BPSAP", bpcount.get("SAP"));
                logger.info("BP SAP" + bpcount.get("SAP"));
            } else {
                count.put("BPSAP", 0);
            }
            if (bpcount.get("Non SAP") != null) {
                count.put("BPNONSAP", bpcount.get("Non SAP"));
            } else {
                count.put("BPNONSAP", 0);
            }

            // Main Process Count
            if (mpcount.get("SAP") != null) {
                count.put("MPSAP", mpcount.get("SAP"));
            } else {
                count.put("MPSAP", 0);
            }
            if (mpcount.get("Non SAP") != null) {
                count.put("MPNONSAP", mpcount.get("Non SAP"));
            } else {
                count.put("MPNONSAP", 0);
            }
            // Sub Process Count
            if (spcount.get("SAP") != null) {
                count.put("SPSAP", spcount.get("SAP"));
            } else {
                count.put("SPSAP", 0);
            }
            if (spcount.get("Non SAP") != null) {
                count.put("SPNONSAP", spcount.get("Non SAP"));
            } else {
                count.put("SPNONSAP", 0);
            }
            // Scenario Count
            if (sccount.get("SAP") != null) {
                count.put("SCSAP", sccount.get("SAP"));
            } else {
                count.put("SCSAP", 0);
            }
            if (sccount.get("Non SAP") != null) {
                count.put("SCNONSAP", sccount.get("Non SAP"));
            } else {
                count.put("SCNONSAP", 0);
            }

            // Variant Count
            if (vtcount.get("SAP") != null) {
                count.put("VTSAP", vtcount.get("SAP"));
            } else {
                count.put("VTSAP", 0);
            }
            if (vtcount.get("Non SAP") != null) {
                count.put("VTNONSAP", vtcount.get("Non SAP"));
            } else {
                count.put("VTNONSAP", 0);
            }

            // Testcase Count
            if (tccount.get("SAP") != null) {
                count.put("TCSAP", tccount.get("SAP"));
            } else {
                count.put("TCSAP", 0);
            }
            if (tccount.get("Non SAP") != null) {
                count.put("TCNONSAP", tccount.get("Non SAP"));
            } else {
                count.put("TCNONSAP", 0);
            }

            // Teststep Count
            if (tscount.get("SAP") != null) {
                count.put("TSSAP", tscount.get("SAP"));
            } else {
                count.put("TSSAP", 0);
            }
            if (tscount.get("Non SAP") != null) {
                count.put("TSNONSAP", tscount.get("Non SAP"));
            } else {
                count.put("TSNONSAP", 0);
            }
            logger.info("Business Process" + count);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return count;

    }

    public static int getTECStatus(int tsId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int count = 0;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select count(*) from TQM_TESTCASEEXECUTION where PTCID = (select PTCID from BPM_TESTSCRIPT where TESTSCRIPT_ID ='" + tsId + "')";
            logger.info("PTCID : " + query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                count = resultset.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return count;
    }

    public  List<IssueFormBean> getTestScriptIssues(int tsId) {
        List<IssueFormBean> issueFormBeanList = new ArrayList<>();
        IssueFormBean issueFormBean;
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        //  List<String> issueList = new ArrayList<String>();
        String issueList = "";
        Map<String, Integer> fileCountList = new HashMap<String, Integer>();
        Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select i.issueid,  module, subject, description, severity,type, i.createdon, due_date, modifiedon, i.createdby, assignedto, s.status,priority  from APM_ISSUE_TESTSTEP_ID a,issue i, issuestatus s, modules m where a.issue_id=i.issueid and i.issueid = s.issueid and i.module_id=m.moduleid and  TESTSTEP_ID=" + tsId + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            logger.info(query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                issueFormBean = new IssueFormBean();
                issueFormBean.setIssueId(resultset.getString(1));
                issueFormBean.setmName(resultset.getString(2));
                issueFormBean.setSubject(resultset.getString(3));
                issueFormBean.setDescription(resultset.getString(4));
                issueFormBean.setSeverity(resultset.getString(5));
                issueFormBean.setType(resultset.getString(6));
                issueFormBean.setCreated((java.util.Date) resultset.getDate(7));
                issueFormBean.setDuedateOn((java.util.Date) resultset.getDate(8));
                issueFormBean.setModifiedDate((java.util.Date) resultset.getDate(9));
                issueFormBean.setCreatedBy((String) resultset.getString(10));
                issueFormBean.setAssignto(resultset.getString(11));
                issueFormBean.setStatus(resultset.getString(12));
                issueFormBean.setPriority(resultset.getString(13));
                issueFormBeanList.add(issueFormBean);

            }
            if (issueFormBeanList.isEmpty()) {
            } else {
                String totalIssue = "";
                for (IssueFormBean ifb : issueFormBeanList) {
                    totalIssue = totalIssue + "'" + ifb.getIssueId() + "',";
                    ifb.setCreatedOn(sdf.format(ifb.getCreated()));
                    ifb.setModifiedOn(sdf.format(ifb.getModifiedDate()));
                    ifb.setDueDate(sdf.format(ifb.getDuedateOn()));
                    ifb.setAge(GetAge.getIssueAge(ifb.getCreatedOn(), ifb.getStatus(), ifb.getModifiedOn()));
                }
                if (totalIssue.contains(",")) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalIssue);
                    fileCountList = IssueDetails.displayFilesCount(totalIssue);
                }
                for (IssueFormBean ifb : issueFormBeanList) {
                    ifb.setLastAssigneeAge(lastAsigneeAgeList.get(ifb.getIssueId()));
                    if(fileCountList.containsKey(ifb.getIssueId())){
                                            ifb.setFilecount(fileCountList.get(ifb.getIssueId()));
                    }else{
                                            ifb.setFilecount(0);
                    }
                }
            }
            logger.info("issueList :" + issueList);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return issueFormBeanList;
    }

    public static List<Issue> getIssuesTS(String pid) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        List<Issue> issueList = new ArrayList<Issue>();

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select i.issueid,subject,u.firstname,u.lastname,i.rating,s.status from issue i,ISSUESTATUS s,users u where i.issueid = s.issueid and u.userid = i.createdby and i.issueid not in(select ISSUE_ID from APM_ISSUE_TESTSTEP_ID where pid=" + pid + " )  and pid= " + pid + " order by i.issueid";
            logger.info(query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                Issue issue = new Issue();
                issue.setIssueid(resultset.getString(1));
                issue.setSubject(resultset.getString(2));
                issue.setRating(resultset.getString(5));
                issue.setIssuestatus(resultset.getString(6));
                issueList.add(issue);
            }
            logger.info("issueList :" + issueList.size());
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return issueList;
    } 
    public static Map<Integer,String> getAllCompany() {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        Map<Integer,String> client = new HashMap<Integer, String>();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select company_id,company_name from BPM_COMPANY order by CLIENT_ID");
            while (resultset.next()) {
                client.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
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
        return client;
    }
}
