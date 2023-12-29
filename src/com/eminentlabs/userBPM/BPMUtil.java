/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.userBPM;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class BPMUtil {
     public static Logger logger     =   Logger.getLogger("BPM Util");
    public static String getModule(int tsId){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;
        int mid =   0;
        String testcase =   null;

        logger.info("vt Id"+tsId);
        try{

            connection = MakeConnection.getConnection();
            statement=connection.createStatement();
            resultset=statement.executeQuery("select v.lead_module,t.testcase,s.teststep from bpm_variant v,bpm_testcase t,bpm_teststep s where  v.variant_id=t.variant_id and t.testcase_id=s.testcase_id and s.teststep_id="+tsId);
            while(resultset.next()){
                mid         =   resultset.getInt(1);
                testcase    =   resultset.getString(2);
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
        return mid+":"+testcase;
    }

}
