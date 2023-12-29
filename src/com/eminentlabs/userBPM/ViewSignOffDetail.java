/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.userBPM;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
import com.eminent.util.GetProjectManager;
import java.util.Collections;
/**
 *
 * @author Tamilvelan
 */
public class ViewSignOffDetail {
    public static Logger logger     =   Logger.getLogger("View BPM");
        public static ArrayList getClient(){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList client  =   new ArrayList<String>();
        try{
        connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select customer from PROJECT");
        while(resultset.next()){
            client.add(resultset.getString(1));
        }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return client;
    }
    public static ArrayList getClient(int pId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList client  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select customer from PROJECT where pid="+pId);
        while(resultset.next()){
            client.add(resultset.getString(1));
        }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return client;
    }
        public static String getClientName(int pId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        String client  =   null;
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select customer from PROJECT where pid="+pId);
        while(resultset.next()){
            client  =   resultset.getString(1);
        }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return client;
    }
    public static int getCompanyCount(int client_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int clientCount  =   0;
        logger.info("Client Id"+client_id);
        try{


         connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select count(*) from BPM_COMPANY WHERE CLIENT_ID="+client_id);
        while(resultset.next()){
            clientCount=resultset.getInt(1);
        }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return clientCount;
    }
    public static HashMap getCompany(int client_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;
     
        HashMap client  =   new HashMap<Integer,String>();
        logger.info("Client Id"+client_id);
        try{
        

         connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select company_id,company_name from BPM_COMPANY WHERE CLIENT_ID="+client_id);
        while(resultset.next()){
            client.put(resultset.getInt(1), resultset.getString(2));
        }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return client;
    }
    public static int getBPCount(int company_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int bpCount  =   0;
        logger.info("Company Id"+company_id);
        try{
        
            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*) from BPM_BP WHERE COMPANY_ID="+company_id+" ORDER BY BP_ID");
            while(resultset.next()){
                bpCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bpCount;
    }
        public static HashMap getAllBP(){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();

        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select bp_id,bp_name from BPM_BP ORDER BY BP_ID");
            while(resultset.next()){
                bp.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bp;
    }
    public static HashMap getBP(int company_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("Company Id"+company_id);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select bp_id,bp_name from BPM_BP WHERE COMPANY_ID="+company_id+" ORDER BY BP_ID");
            while(resultset.next()){
                bp.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bp;
    }
    public static int getMPCount(int bpId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int mpCount  =   0;
        
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*) from BPM_MAIN_PROCESS WHERE BP_ID="+bpId+" ORDER BY MP_ID");
            while(resultset.next()){
                mpCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return mpCount;
    }
    public static HashMap getMP(int bpId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("BP Id"+bpId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select mp_id,MAIN_PROCESS from BPM_MAIN_PROCESS WHERE BP_ID="+bpId+" ORDER BY MP_ID");
            while(resultset.next()){
                bp.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bp;
    }
    public static int getSPCount(int mpId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int spCount  =   0;
        logger.info("SP Id"+mpId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*) from BPM_SUB_PROCESS WHERE MP_ID="+mpId+" ORDER BY SP_ID");
            while(resultset.next()){
                spCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return spCount;
    }
        public static HashMap getSP(int mpId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("SP Id"+mpId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select SP_ID,SUB_PROCESS from BPM_SUB_PROCESS WHERE MP_ID="+mpId+" ORDER BY SP_ID");
            while(resultset.next()){
                bp.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bp;
    }
    public static HashMap getClientMP(int clientId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("SP Id"+clientId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select distinct mp.mp_id, main_process from bpm_company c,bpm_bp bp,bpm_main_process mp,bpm_sub_process sp where c.company_id = bp.company_id and bp.bp_id=mp.bp_id and c.client_id="+clientId+" order by mp.mp_id");
            while(resultset.next()){
                bp.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bp;
    }
    public static int getSCCount(int spId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int scCount  =   0;
        logger.info("SC Id"+spId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*) from BPM_SCENARIO WHERE SP_ID="+spId+" ORDER BY SCENARIO_ID");
            while(resultset.next()){
                scCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return scCount;
    }
    public static HashMap getSC(int spId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("SC Id"+spId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select SCENARIO_ID,SCENARIO from BPM_SCENARIO WHERE SP_ID="+spId+" ORDER BY SCENARIO_ID");
            while(resultset.next()){
                bp.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return bp;
    }
    public static int getVTCount(int scId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int vtCount  =   0;
        logger.info("SC Id"+scId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*) from BPM_VARIANT WHERE SCENARIO_ID="+scId+" ORDER BY VARIANT_ID");
            while(resultset.next()){
                vtCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return vtCount;
    }
    public static HashMap getVT(int scId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap vt  =   new HashMap<Integer,String>();
        logger.info("SC Id"+scId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select VARIANT_ID,VARIANT from BPM_VARIANT WHERE SCENARIO_ID="+scId+" ORDER BY VARIANT_ID");
            while(resultset.next()){
                vt.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return vt;
    }
    public static HashMap getVTDetails(int vtId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap vt  =   new HashMap<Integer,String>();
        logger.info("SC Id"+vtId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select moduleid, module from bpm_variant v,modules m where m.moduleid=v.lead_module and variant_id="+vtId);
            while(resultset.next()){
                vt.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return vt;
    }
    public static int getTCCount(int vtId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int tcCount  =   0;
        logger.info("vt Id"+vtId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*) from BPM_TESTCASE WHERE VARIANT_ID="+vtId+" ORDER BY TESTCASE_ID");
            while(resultset.next()){
                tcCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return tcCount;
    }
    public static HashMap getTC(int vtId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap vt  =   new HashMap<Integer,String>();
        logger.info("vt Id"+vtId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select TESTCASE_ID,TESTCASE from BPM_TESTCASE WHERE VARIANT_ID="+vtId+" ORDER BY TESTCASE_ID");
            while(resultset.next()){
                vt.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return vt;
    }
    public static int getTSCount(int tcId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int tsCount  =   0;
        logger.info("tc Id"+tcId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*)  from BPM_TESTSTEP WHERE TESTCASE_ID="+tcId+" ORDER BY TESTSTEP_ID");
            while(resultset.next()){
                tsCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return tsCount;
    }
    public static HashMap getTS(int tcId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap ts  =   new HashMap<Integer,String>();
        logger.info("tc Id"+tcId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select TESTSTEP_ID,TESTSTEP  from BPM_TESTSTEP WHERE TESTCASE_ID="+tcId+" ORDER BY TESTSTEP_ID");
            while(resultset.next()){
                ts.put(resultset.getInt(1), resultset.getString(2));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return ts;
    }
    public static void getTSStatusCount(int tsId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int tsCount  =   0;
        logger.info("ts Id"+tsId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select ptcid from BPM_TESTSCRIPT WHERE TESTSTEP_ID="+tsId+" ORDER BY TESTSCRIPT_ID");
            while(resultset.next()){
                tsCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
    }
    public static int getTestScriptCount(int tsId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        int tsCount  =   0;
        logger.info("ts Id"+tsId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select count(*)  from BPM_TESTSCRIPT WHERE TESTSTEP_ID="+tsId+" ORDER BY TESTSCRIPT_ID");
            while(resultset.next()){
                tsCount=resultset.getInt(1);
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return tsCount;
    }
    public static HashMap getTestScript(int tsId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap ts  =   new HashMap<String,String>();
        logger.info("ts Id"+tsId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select TESTSCRIPT_ID,TEST_SCRIPT,EXPECTED_RESULT,CREATEDBY,PTCID  from BPM_TESTSCRIPT WHERE TESTSTEP_ID="+tsId+" ORDER BY TESTSCRIPT_ID");
            while(resultset.next()){
                ts.put(resultset.getString(5), resultset.getString(2)+"###"+ resultset.getString(3)+"###"+GetProjectManager.getUserName(resultset.getInt(4))+"*"+getTestScriptStatus(resultset.getString(5))+"*"+resultset.getString(1));
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return ts;
    }
    public static String getTestScriptStatus(String ptcId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap StatusMap  =   new HashMap<Integer,String>();
        StatusMap.put(0, "Yet to Test");
        StatusMap.put(1, "Not Applicable");
        StatusMap.put(2, "Could Not Run");
        StatusMap.put(3, "Failed");
        StatusMap.put(4, "Passed");

        ArrayList<Integer> testcaseStatus   =   new ArrayList<Integer>();

        String status   =   "Passed";

        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("SELECT STATUSID, COUNT(*) FROM TQM_TESTCASEEXECUTION WHERE PTCID='"+ptcId+"' GROUP BY STATUSID");
            while(resultset.next()){
                testcaseStatus.add(resultset.getInt(1));
            }
            if(!testcaseStatus.isEmpty()){
                Collections.sort(testcaseStatus);

                if(testcaseStatus.contains((Integer)3)){
                    status  =   "Failed";
                }else if(testcaseStatus.contains((Integer)2)){
                    status  =   "Could Not Run";
                }else if(testcaseStatus.contains((Integer)1)){
                    status  =   "Not Applicable";
                }else if(testcaseStatus.contains((Integer)0)){
                    status  =   "Yet To Test";
                }
            }else{
                 status  =   "Not Run";
            }


        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }

            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return status;
    }
}

