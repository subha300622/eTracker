/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.util.HashMap;
import java.sql.PreparedStatement;
import org.apache.log4j.Logger;



/**
 *
 * @author Tamilvelan
 */
public class FlowValue {
     static Logger logger = null;

    static {
        logger = Logger.getLogger("FlowValue");
    }
    public static HashMap getSPValue(String type,String Sp){
        Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;

        HashMap<String,Integer> values    =   new HashMap();
        try{

            Class.forName("oracle.jdbc.driver.OracleDriver");

            connection=DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.34:1521:XE", "eminenttracker", "eminentlabs");

       //     connection = MakeConnection.getConnection();
            statement   = connection.createStatement();

            if(type.equalsIgnoreCase("bug")){
                resultset   = statement.executeQuery("select s.status,"+Sp+" from bugvalue b,status_master s where b.status=s.status_id order by s.status_id asc");
            }
            else if(type.equalsIgnoreCase("enhancement")){
                resultset   = statement.executeQuery("select s.status,"+Sp+" from enhancementvalue b,status_master s where b.status=s.status_id order by s.status_id asc");
            }
            else if(type.equalsIgnoreCase("newtask")){
                resultset   = statement.executeQuery("select s.status,"+Sp+" from newtaskvalue b,status_master s where b.status=s.status_id order by s.status_id asc");
            }

            while(resultset.next()){

                values.put(resultset.getString(1),resultset.getInt(2));

                  



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
                catch(Exception e){
                   logger.error(e.getMessage());
                }
                try{
                    if(statement!=null){
                        statement.close();
                    }
                }
                catch(Exception e){
                   logger.error(e.getMessage());
                }
                try{
                    if(connection!=null){
                        connection.close();
                    }
                }
                catch(Exception e){
                   logger.error(e.getMessage());
                }
        }

        return values;

    }
    public static HashMap getPS(String issueId){

        Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;


        HashMap<String,String> PST    =   new HashMap();

        try{

            Class.forName("oracle.jdbc.driver.OracleDriver");

		connection=DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.34:1521:XE", "eminenttracker", "eminentlabs");
         //   connection = MakeConnection.getConnection();
            statement   = connection.createStatement();


            resultset   = statement.executeQuery("select priority,severity,type from issue where issueid='"+issueId+"'");


            while(resultset.next()){

                PST.put("priority",resultset.getString("priority"));
                PST.put("severity",resultset.getString("severity"));
                PST.put("type",resultset.getString("type"));
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
                catch(Exception e){
                   logger.error(e.getMessage());
                }
                try{
                    if(statement!=null){
                        statement.close();
                    }
                }
                catch(Exception e){
                   logger.error(e.getMessage());
                }
                try{
                    if(connection!=null){
                        connection.close();
                    }
                }
                catch(Exception e){
                   logger.error(e.getMessage());
                }
        }


        return PST;
    }

    public static void main(String[] args){
        String issueid="E24122008004";
        Connection connection = null;
        Statement statement   = null;
        ResultSet resultset   = null;
        PreparedStatement prestatement   =  null;

        HashMap<String,String> PST    =   new HashMap();

        HashMap<String,Integer> SPValues    =   new HashMap();

        PST         =  getPS(issueid);

        

        String priority =   PST.get("priority");
        String severity =   PST.get("severity");
        String PS       =priority.substring(0,priority.indexOf("-"))+severity.substring(0,severity.indexOf("-"));

        String type     =   PST.get("type");

  
        PS="P1S1";


        SPValues    =   getSPValue(type, PS);

    
        int i=0;

        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");
		
		connection=DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.34:1521:XE", "eminenttracker", "eminentlabs");
		statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		resultset=statement.executeQuery("select c.commentedby,c.status,c.commentedto from issuecomments c where c.issueid='"+issueid+"' order by comment_date");
        resultset.last();

        int rowcount=resultset.getRow();
        resultset.beforeFirst();
        String values[]       = new String[rowcount*4];
        String comments[][]     =new String[rowcount][3];

        while(resultset.next()){
/*
            values[i++]=resultset.getString(1);
            values[i++]=resultset.getString(2);
            values[i++]=resultset.getString(3);
            values[i++]=SPValues.get(resultset.getString(2)).toString();
  */
            comments[i][1] = resultset.getString(1);
            comments[i][2] = resultset.getString(2);
            comments[i][3] = resultset.getString(3);

            i++;

        }

        /*

        prestatement   =   connection.prepareStatement("update users set value=value+? where userid=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

        int j=3;
        for(int s=0;s<rowcount;s++,j=j+4){
            prestatement.setInt(1, Integer.parseInt(values[j]));
            prestatement.setInt(2, Integer.parseInt(values[j-3]));
            prestatement.addBatch();
        }
      prestatement.executeBatch();
      */
/*        int k=0;
        while(k<(rowcount*3)){
            System.out.print(values[k++]);
            System.out.print("\t"+values[k++]);
            System.out.println("\t"+values[k++]);
        }
  */
        }
        catch(Exception e){
           logger.error(e.getMessage());
        }

    }

}
