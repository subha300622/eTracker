/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.bpm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class TestMapTree {

    public static Logger logger = Logger.getLogger("TestMapTree");
    HashMap client = new HashMap<Integer, String>();
    List<Integer> companyIds = new ArrayList<Integer>();
    List<BpmBp> bpList = new ArrayList<BpmBp>();
    List<Integer> bpIds = new ArrayList<Integer>();
    List<BpmMainProcess> mpList = new ArrayList<BpmMainProcess>();
    List<Integer> mpIds = new ArrayList<Integer>();
    List<BpmSubProcess> spList = new ArrayList<BpmSubProcess>();
    List<Integer> spIds = new ArrayList<Integer>();
    List<BpmScenario> scList = new ArrayList<BpmScenario>();
    List<Integer> scIds = new ArrayList<Integer>();
    List<BpmVariant> vtList = new ArrayList<BpmVariant>();
    List<Integer> vtIds = new ArrayList<Integer>();
    List<BpmTestcase> tcList = new ArrayList<BpmTestcase>();
    List<Integer> tcIds = new ArrayList<Integer>();
    List<BpmTeststep> tsList = new ArrayList<BpmTeststep>();
    List<Integer> tsIds = new ArrayList<Integer>();
    List<BpmTestscript> tscList = new ArrayList<BpmTestscript>();
    List<Integer> tscIds = new ArrayList<Integer>();

    public HashMap getComapnys(int companyId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select company_id,company_name from BPM_COMVIEW WHERE CLIENT_ID=" + companyId);
            while (resultset.next()) {
                client.put(resultset.getInt(1), resultset.getString(2));
                
                companyIds.add(resultset.getInt(1));
            }
            getBP(companyIds);
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

    public HashMap getBP(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        HashMap bp = new HashMap<Integer, String>();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select bp_id,bp_name,BP_TYPE from BPM_BPVIEW WHERE COMPANY_ID in(" + whole_ids + ") ORDER BY BP_ID");
            while (resultset.next()) {
                BpmBp bb = new BpmBp();
                bb.setBpId(resultset.getInt(1));
                bb.setBpName(resultset.getString(2));
                bb.setBpType(resultset.getString(3));
                bpList.add(bb);
                bpIds.add(resultset.getInt(1));
            }
            getMP(bpIds);

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

    public HashMap getMP(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select mp_id,MAIN_PROCESS,MP_TYPE from BPM_MPVIEW WHERE BP_ID in(" + whole_ids + ") ORDER BY MP_ID");
            while (resultset.next()) {
                BpmMainProcess bmp = new BpmMainProcess();
                bmp.setMpId(resultset.getInt(1));
                bmp.setMainProcess(resultset.getString(2));
                bmp.setMpType(resultset.getString(3));
                mpList.add(bmp);
                mpIds.add(resultset.getInt(1));
            }
            getSP(mpIds);

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

    public HashMap getSP(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        logger.info("SP Id" + totalIds);
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select SP_ID,SUB_PROCESS,SP_TYPE from BPM_SPVIEW WHERE MP_ID in(" + whole_ids + ") ORDER BY SP_ID");
            while (resultset.next()) {
                BpmSubProcess bsp = new BpmSubProcess();
                bsp.setSpId(resultset.getInt(1));
                bsp.setSubProcess(resultset.getString(2));
                bsp.setSpType(resultset.getString(3));
                spList.add(bsp);
                spIds.add(resultset.getInt(1));
            }
            getSC(spIds);

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

    public HashMap getSC(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap bp = new HashMap<Integer, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select SCENARIO_ID,SCENARIO,SC_TYPE from BPM_SCVIEW WHERE SP_ID in(" + whole_ids + ") ORDER BY SCENARIO_ID");
            while (resultset.next()) {
                BpmScenario bsc = new BpmScenario();
                bsc.setScenarioId(resultset.getInt(1));
                bsc.setScenario(resultset.getString(2));
                bsc.setScType(resultset.getString(3));
                scList.add(bsc);
                scIds.add(resultset.getInt(1));
            }

            getVT(scIds);
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

    public HashMap getVT(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap vt = new HashMap<Integer, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select VARIANT_ID,VARIANT,VT_TYPE from BPM_VTVIEW WHERE SCENARIO_ID in(" + whole_ids + ") ORDER BY VARIANT_ID");
            while (resultset.next()) {
                BpmVariant bv = new BpmVariant();
                bv.setVariantId(resultset.getInt(1));
                bv.setVariant(resultset.getString(2));
                bv.setVtType(resultset.getString(3));
                vtList.add(bv);
                vtIds.add(resultset.getInt(1));
            }
            getTC(vtIds);

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

    public HashMap getTC(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap vt = new HashMap<Integer, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTCASE_ID,TESTCASE,TC_TYPE from BPM_TCVIEW WHERE VARIANT_ID in(" + whole_ids + ") ORDER BY TESTCASE_ID");
            while (resultset.next()) {
                BpmTestcase bt = new BpmTestcase();
                bt.setTestcaseId(resultset.getInt(1));
                bt.setTestcase(resultset.getString(2));
                bt.setTcType(resultset.getString(3));
                tcList.add(bt);
                tcIds.add(resultset.getInt(1));
            }
            getTS(tcIds);

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

    public HashMap getTS(List<Integer> totalIds) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap ts = new HashMap<Integer, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        String query = "";
        String modifiedQuery = "";
        String issues[] = whole_ids.split(",");
        if (issues.length > 1000) {

            int j = issues.length / 1000;
            int l = issues.length % 1000;
            if (l != 0) {
                j = j + 1;
            }
            for (int k = 1; k <= j; k++) {
                String totalIssue = "";
                int start = (1000 * (k - 1));
                int end = 1000 * (k);
                if (end > issues.length) {
                    end = issues.length;
                }
                logger.info("start,end" + start + "," + end);
                for (int i = start; i < end; i++) {
                    if (issues[i] != null) {
                        totalIssue = totalIssue + issues[i] + ",";
                    }
                }
                if (!"".equals(totalIssue)) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                }
                if ("".equals(modifiedQuery)) {
                    modifiedQuery = modifiedQuery + "(TESTCASE_ID in (" + totalIssue + ")";
                } else {
                    modifiedQuery = modifiedQuery + " OR TESTCASE_ID in (" + totalIssue + ")";
                }
            }
            query = "select TESTSTEP_ID,TESTSTEP,TS_TYPE  from BPM_TSVIEW where " + modifiedQuery + ")  ORDER BY TESTSTEP_ID";
        } else {
            query = "select TESTSTEP_ID,TESTSTEP,TS_TYPE  from BPM_TSVIEW where TESTCASE_ID in (" + whole_ids + ")  ORDER BY TESTSTEP_ID";
        }
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                BpmTeststep bts = new BpmTeststep();
                bts.setTeststepId(resultset.getInt(1));
                bts.setTeststep(resultset.getString(2));
                bts.setTsType(resultset.getString(3));
                tsList.add(bts);
                tsIds.add(resultset.getInt(1));
            }
            getTestScript(tsIds);

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

    public HashMap getTestScript(List<Integer> totalIds) {

        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        HashMap ts = new HashMap<String, String>();
        String whole_ids = "";
        for (int cid : totalIds) {
            whole_ids = whole_ids + cid + ",";
        }
        if (!"".equals(whole_ids)) {
            whole_ids = whole_ids.substring(0, whole_ids.length() - 1);
        }
        String query = "";
        String modifiedQuery = "";
        String issues[] = whole_ids.split(",");
        if (issues.length > 1000) {

            int j = issues.length / 1000;
            int l = issues.length % 1000;
            if (l != 0) {
                j = j + 1;
            }
            for (int k = 1; k <= j; k++) {
                String totalIssue = "";
                int start = (1000 * (k - 1));
                int end = 1000 * (k);
                if (end > issues.length) {
                    end = issues.length;
                }
                logger.info("start,end" + start + "," + end);
                for (int i = start; i < end; i++) {
                    if (issues[i] != null) {
                        totalIssue = totalIssue + issues[i] + ",";
                    }
                }
                if (!"".equals(totalIssue)) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                }
                if ("".equals(modifiedQuery)) {
                    modifiedQuery = modifiedQuery + "(TESTSTEP_ID in (" + totalIssue + ")";
                } else {
                    modifiedQuery = modifiedQuery + " OR TESTSTEP_ID in (" + totalIssue + ")";
                }
            }
            query = "select TESTSCRIPT_ID,TEST_SCRIPT,EXPECTED_RESULT,CREATEDBY,PTCID  from BPM_TSCVIEW WHERE " + modifiedQuery + ")  ORDER BY TESTSCRIPT_ID";
        } else {
            query = "select TESTSCRIPT_ID,TEST_SCRIPT,EXPECTED_RESULT,CREATEDBY,PTCID  from BPM_TSCVIEW WHERE  TESTSTEP_ID in (" + whole_ids + ")  ORDER BY TESTSCRIPT_ID";
        }
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                // ts.put(resultset.getString(5), resultset.getString(2) + "###" + resultset.getString(3) + "###" + GetProjectManager.getUserName(resultset.getInt(4)) + "***" + ViewBPM.getTestScriptStatus(resultset.getString(5)) + "***" + resultset.getString(1));
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

    public HashMap getBpIdName(List<BpmBp> bpList) {
        HashMap bpIdNameList=new HashMap<Integer, String>();
        
        for(BpmBp bp:bpList){
            bpIdNameList.put(bp.getBpId(), bp.getBpName());
        }
        
        return bpIdNameList;
        
    }

    public HashMap getMpIdName(List<BpmMainProcess> mpList) {
        HashMap mpIdNameList=new HashMap<Integer, String>();
        
        for(BpmMainProcess bmp:mpList){
            mpIdNameList.put(bmp.getMpId(), bmp.getMainProcess());
        }
        
        return mpIdNameList;
        
    }
    public HashMap getSpIdName(List<BpmSubProcess> spList) {
        HashMap spIdNameList=new HashMap<Integer, String>();
        
        for(BpmSubProcess sp:spList){
            spIdNameList.put(sp.getSpId(), sp.getSubProcess());
        }
        
        return spIdNameList;
        
    }
    public HashMap getScIdName(List<BpmScenario> scList) {
        HashMap scIdNameList=new HashMap<Integer, String>();
        
        for(BpmScenario sc:scList){
            scIdNameList.put(sc.getScenario(), sc.getScenario());
        }
        
        return scIdNameList;
        
    }
    public HashMap getVtIdName(List<BpmVariant> vtList) {
        HashMap vtIdNameList=new HashMap<Integer, String>();
        
        for(BpmVariant vt:vtList){
            vtIdNameList.put(vt.getVariantId(), vt.getVariant());
        }
        
        return vtIdNameList;
        
    }
    public HashMap getTcIdName(List<BpmTestcase> tcList) {
        HashMap tcIdNameList=new HashMap<Integer, String>();
        
        for(BpmTestcase tc:tcList){
            tcIdNameList.put(tc.getTestcaseId(), tc.getTestcase());
        }
        
        return tcIdNameList;
        
    }
    public HashMap getTsIdName(List<BpmTeststep> tsList) {
        HashMap tsIdNameList=new HashMap<Integer, String>();
        
        for(BpmTeststep ts:tsList){
            tsIdNameList.put(ts.getTeststepId(), ts.getTeststep());
        }
        
        return tsIdNameList;
        
    }
    public HashMap getTscIdName(List<BpmTestscript> tscList) {
        HashMap tscIdNameList=new HashMap<Integer, String>();
        
        for(BpmTestscript tsc:tscList){
            tscIdNameList.put(tsc.getTestscriptId(), tsc.getTestScript());
        }
        
        return tscIdNameList;
        
    }
    

    public List<BpmBp> getBpList() {
        return bpList;
    }

    public void setBpList(List<BpmBp> bpList) {
        this.bpList = bpList;
    }

    public List<BpmMainProcess> getMpList() {
        return mpList;
    }

    public void setMpList(List<BpmMainProcess> mpList) {
        this.mpList = mpList;
    }

    public List<BpmSubProcess> getSpList() {
        return spList;
    }

    public void setSpList(List<BpmSubProcess> spList) {
        this.spList = spList;
    }

    public List<BpmScenario> getScList() {
        return scList;
    }

    public void setScList(List<BpmScenario> scList) {
        this.scList = scList;
    }

    public List<BpmVariant> getVtList() {
        return vtList;
    }

    public void setVtList(List<BpmVariant> vtList) {
        this.vtList = vtList;
    }

    public List<BpmTestcase> getTcList() {
        return tcList;
    }

    public void setTcList(List<BpmTestcase> tcList) {
        this.tcList = tcList;
    }

    public List<BpmTeststep> getTsList() {
        return tsList;
    }

    public void setTsList(List<BpmTeststep> tsList) {
        this.tsList = tsList;
    }

    public List<BpmTestscript> getTscList() {
        return tscList;
    }

    public void setTscList(List<BpmTestscript> tscList) {
        this.tscList = tscList;
    }
}
