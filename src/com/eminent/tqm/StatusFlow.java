/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.tqm;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Iterator;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;
/**
 *
 * @author Tamilvelan
 */
public class StatusFlow {

    static Logger logger = Logger.getLogger("StatusFlow");

    public static boolean getFlow(String issueId){
        Connection connection   =   null;
        Statement  statement    =   null;
        ResultSet  resultset    =   null;
        boolean flag    =   true;
        HashSet status           = new HashSet<String>();

         try{

            connection  =   MakeConnection.getConnection();
            statement   =   connection.createStatement();
            resultset   =   statement.executeQuery("select status from tqm_issuetestcases c,tqm_testcasestatus s where issueid='"+issueId+"' and c.statusid=s.statusid order by status asc");

            while(resultset.next()){
                status.add(resultset.getString(1));
            }
           
            Iterator iterator = status.iterator();
            while (iterator.hasNext()){
  
              String caseStatus =  (String) iterator.next();
              if(caseStatus.equalsIgnoreCase("Failed")||caseStatus.equalsIgnoreCase("Not Run")||caseStatus.equalsIgnoreCase("Yet to Test")){
                  flag=false;
              }
            }
           
        }
        catch(Exception e){
           logger.error(e.getMessage());
        }
        finally{
            try{

                if(resultset!=null){
                    resultset.close();
                }
            }
            catch(SQLException e){
               logger.error(e.getMessage());
            }
            try{
                if(statement!=null){
                    statement.close();
                }
            }
            catch(SQLException e){
             logger.error(e.getMessage());
            }
            try{
                if(connection!=null){
                    connection.close();
                }
            }
            catch(SQLException e){
             logger.error(e.getMessage());
            }
        }
        return flag;
    }


}
