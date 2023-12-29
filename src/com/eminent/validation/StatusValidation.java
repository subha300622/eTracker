/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.validation;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Balaguru Ramasamy
 */
public class StatusValidation {

     static Logger logger = null;
        static {
        logger = Logger.getLogger("StatusValidation");

        }
	public  static String isStatusCorrect(String status, String issueId){




		Connection connection=null;
		Statement statement = null, stCheck = null;
		ResultSet resultset = null, rsCheck = null;
		String name = null;
        String dbStatus = null;
		ArrayList<String> statusList =new ArrayList<String>();


			try{
				connection = MakeConnection.getConnection();
				statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

                // The following statement is used to get the latest status of the issue

				resultset = statement.executeQuery("select status from issuestatus where issueid = '"+issueId+"'");
				if(resultset.next()) {
                    
					dbStatus = resultset.getString("status");
			    }

                statusList.add(dbStatus);

                stCheck = connection.createStatement();
                rsCheck = stCheck.executeQuery("select status from status_master where status_id in (select s.status from status_master m, status_sub s where m.status = '"+dbStatus+"' and m.status_id = s.status_id ) order by upper(status) asc");
                while(rsCheck.next()) {
                    name = rsCheck.getString("status");
					statusList.add(name);
                }

                boolean flag = false;
                for(int i = 0; i < statusList.size(); i++) {
                    if(statusList.get(i).equalsIgnoreCase(status)) {
                        flag = true;
                    }
                }

                if (flag == false) {
                    status = dbStatus;
                }

                

            } catch(Exception e) {
				logger.error("Error while getting the status list"+e.getMessage());
			}
			finally{
				try{

				if(resultset!=null) {
					resultset.close();
				}
                if(statement!=null) {
					statement.close();
				}
                if(rsCheck!=null) {
					rsCheck.close();
				}
                if(stCheck!=null) {
					stCheck.close();
				}
				if(connection!=null) {
					connection.close();
				}
				}
				catch(Exception e){
					logger.error("Error while getting the status list"+e.getMessage());
				}
			}

		return status;

	}


    public  static String isSAPStatusCorrect(String type, String status, String issueId){




		Connection connection=null;
		Statement statement = null, stCheck = null;
		ResultSet resultset = null, rsCheck = null;
		String name = null;
        String dbStatus = null;
		ArrayList<String> statusList =new ArrayList<String>();

        if(type.equalsIgnoreCase("Upgradation")) {
            type = "UPGRADE";
        } else if(type.equalsIgnoreCase("Implementation")) {
            type = "IMPLEM";
        }

        String dbMasterTable = "SAP_" + type +"_STATUS_MASTER";
        String dbChildTable = "SAP_" + type +"_STATUS_SUB";


			try{
				connection = MakeConnection.getConnection();
				statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

                // The following statement is used to get the latest status of the issue

				resultset = statement.executeQuery("select status from issuestatus where issueid = '"+issueId+"'");
				if(resultset.next()) {

					dbStatus = resultset.getString("status");
			    }

                statusList.add(dbStatus);

                stCheck = connection.createStatement();
                rsCheck = stCheck.executeQuery("select status from "+ dbMasterTable +" where status_id in (select s.status from "+ dbMasterTable +"  m, "+ dbChildTable +" s where m.status = '"+dbStatus+"' and m.status_id = s.status_id ) order by upper(status) asc");
                while(rsCheck.next()) {
                    name = rsCheck.getString("status");
					statusList.add(name);
                }

                boolean flag = false;
                for(int i = 0; i < statusList.size(); i++) {
                    if(statusList.get(i).equalsIgnoreCase(status)) {
                        flag = true;
                    }
                }

                if (flag == false) {
                    status = dbStatus;
                }



            } catch(Exception e) {
				logger.error("Error while getting the SAP status list"+e.getMessage());
			}
			finally{
				try{

				if(resultset!=null) {
					resultset.close();
				}
                if(statement!=null) {
					statement.close();
				}
                if(rsCheck!=null) {
					rsCheck.close();
				}
                if(stCheck!=null) {
					stCheck.close();
				}
				if(connection!=null) {
					connection.close();
				}
				}
				catch(Exception e){
					logger.error("Error while getting the SAP status list"+e.getMessage());
				}
			}

		return status;

	}


}
