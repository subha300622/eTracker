/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Tamilvelan
 */
public class CreatedCRM {
    public static void main(String[] args){
                Connection connection=null;
		Statement statement=null;
		ResultSet resultset=null;
		

		try{
		Class.forName("oracle.jdbc.driver.OracleDriver");

		connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");

		statement=connection.createStatement();

		
		resultset=statement.executeQuery("select contactid,createdon from contact order by contactid");

        
		while(resultset.next()){

		
                }

        
		}
		catch(Exception e){
			e.printStackTrace();
		}
    }

}
