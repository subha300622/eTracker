/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.*;
import com.eminent.util.WorkedTime;

/**
 *
 * @author Administrator
 */
public class TimeSheet {
 public static void main(String []args){
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
            try{
//		connection=MakeConnection.getConnection();
                Class.forName("oracle.jdbc.driver.OracleDriver");

                String selectedStartDate = "01-4-2009 00:00:00";
                String selectedEndDate = "30-4-2009 23:59:59";

		connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
		int age=WorkedTime.getHoldingTime("E20122008005", "112",selectedStartDate, selectedEndDate);

	}
	catch(Exception e){
		e.printStackTrace();
	}
    finally{
            try{
                 if(resultset!=null) {
					resultset.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                 if(statement!=null) {
					statement.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                if(connection!=null) {
					connection.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
 }
}
