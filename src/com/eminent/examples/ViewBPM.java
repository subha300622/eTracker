/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.PreparedStatement;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import java.util.HashMap;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author Tamilvelan
 */
public class ViewBPM {
    public static Logger logger     =   Logger.getLogger("Show BPM");
    public static ArrayList getClient(){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList client  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT CLIENT from BPM_TEST");
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
    public static ArrayList getCompany(String client){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList company  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT COMPANY from BPM_TEST where client='"+client+"'");
        while(resultset.next()){
            company.add(resultset.getString(1));
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
        return company;
    }
    public static ArrayList getBP(String company){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList bp  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT BUSINESS_PROCESS from BPM_TEST where company='"+company+"'");
        while(resultset.next()){
            bp.add(resultset.getString(1));
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
    public static ArrayList getMainProcess(String bp){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList mp  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT MAIN_PROCESS from BPM_TEST where BUSINESS_PROCESS='"+bp+"'");
        while(resultset.next()){
            mp.add(resultset.getString(1));
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
        return mp;
    }
    public static ArrayList getSubProcess(String mp){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList sp  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT SUB_PROCESS from BPM_TEST where MAIN_PROCESS='"+mp+"'");
        while(resultset.next()){
            sp.add(resultset.getString(1));
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
     public static ArrayList getScenario(String sp){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList scenario  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT SCENARIO from BPM_TEST where SUB_PROCESS='"+sp+"'");
        while(resultset.next()){
            scenario.add(resultset.getString(1));
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
 public static ArrayList getVariant(String scenario){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList variant  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
 //       connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT VARIANT from BPM_TEST where SCENARIO='"+scenario+"'");
        while(resultset.next()){
            variant.add(resultset.getString(1));
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
public static ArrayList getTestcase(String variant){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList testcase  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        resultset=statement.executeQuery("select DISTINCT TESTCASE from BPM_TEST where VARIANT='"+variant+"'");
        while(resultset.next()){
            testcase.add(resultset.getString(1));
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
        return testcase;
    }
    
public static ArrayList getTestScript(String testcase){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;

        ArrayList testScript  =   new ArrayList<String>();
        try{
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
             connection = MakeConnection.getConnection();
        statement=connection.createStatement();
        String sql  =   "select TEST_SEQUENCE,TEST_STEP,TEST_SCRIPT,EXPECTED_RESULT,DEPARTMENT_USER from BPM_TEST where TESTCASE='"+testcase+"' order by TEST_SEQUENCE";
        resultset=statement.executeQuery(sql);
        while(resultset.next()){
            testScript.add(resultset.getString(1));
            testScript.add(resultset.getString(2));
            testScript.add(resultset.getString(3));
            testScript.add(resultset.getString(4));
            testScript.add(resultset.getString(5));

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
        return testScript;
    }
public static void main(String[] args){
    ArrayList<String> ts    =   getTestScript("Create Frame work order for the Plant 6521 / Pur org 6520 / C.code 6520");
     int row    =   ts.size()/5;
     int k=0;
    for(int i=0;i<row;i++){
        
        k=k+5;
    }

}

}
