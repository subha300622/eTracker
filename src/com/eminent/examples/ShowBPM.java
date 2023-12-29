/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import org.apache.log4j.Logger;
/**
 *
 * @author Tamilvelan
 */
public class ShowBPM {
    public static Logger logger     =   Logger.getLogger("Show BPM");
    public static HashMap getClient(){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;
        PreparedStatement createClient  =   null;
        HashMap client  =   new HashMap<Integer,String>();
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        resultset=statement.executeQuery("select * from BPM_CLIENT");
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
    public static HashMap getCompany(int client_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;
        PreparedStatement createClient  =   null;
        HashMap client  =   new HashMap<Integer,String>();
        logger.info("Client Id"+client_id);
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
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
    public static HashMap getBP(int company_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("Company Id"+company_id);
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        resultset=statement.executeQuery("select bp_id,bp_name from BPM_BP WHERE COMPANY_ID="+company_id);
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
    public static HashMap getMP(int bp_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap bp  =   new HashMap<Integer,String>();
        logger.info("BP Id"+bp_id);
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        resultset=statement.executeQuery("select mp_id,main_process from BPM_MAIN_PROCESS WHERE BP_ID="+bp_id);
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
    public static HashMap getSP(int mp_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap sp  =   new HashMap<Integer,String>();
        logger.info("MP Id"+mp_id);
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        resultset=statement.executeQuery("select sp_id,SUB_PROCESS from BPM_SUB_PROCESS WHERE BP_ID="+mp_id);
        while(resultset.next()){
            sp.put(resultset.getInt(1), resultset.getString(2));
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
        return sp;
    }
     public static HashMap getScenario(int sp_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap scenario  =   new HashMap<Integer,String>();
        logger.info("Sub process Id"+sp_id);
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        resultset=statement.executeQuery("select SCENARIO_ID,SCENARIO from BPM_SCENARIO WHERE SP_ID="+sp_id);
        while(resultset.next()){
            scenario.put(resultset.getInt(1), resultset.getString(2));
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
        return scenario;
    }
    public static HashMap getVariant(int scenario_id){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        HashMap variant  =   new HashMap<Integer,String>();
        logger.info("Scenario Id"+scenario_id);
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        resultset=statement.executeQuery("select VARIANT_ID,VARIANT from BPM_VARIANT WHERE SCENARIO_ID="+scenario_id);
        while(resultset.next()){
            variant.put(resultset.getInt(1), resultset.getString(2));
            logger.info("Variant Id"+resultset.getInt(1));
            logger.info("Variant"+resultset.getString(2));
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
        return variant;
    }
}
