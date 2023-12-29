/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.*;
import java.util.*;

/**
 *
 * @author ADAL
 */
public class StatusFlow {
    public static void main(String[] args){
        Connection connection=null;
        Statement statement =null;
        ResultSet resultset =null;
        HashSet <String>collection = new HashSet <String>();
    try{
		Class.forName("oracle.jdbc.driver.OracleDriver");

                connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
		statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		resultset=statement.executeQuery("select status from tqm_issuetestcases c,tqm_testcasestatus s where issueid='E07122009002' and c.statusid=s.statusid order by status asc");
                ResultSetMetaData rsmd=resultset.getMetaData();
                int NoofColumns=rsmd.getColumnCount();
                String status[] =new String[NoofColumns];
                int i=0;
		while(resultset.next()){

  //                  System.out.println("Status  :"+resultset.getString("status"));
                 
                    collection.add(resultset.getString("status"));
		}
                    //Create a iterator
    Iterator iterator = collection.iterator();
    while (iterator.hasNext()){
    }

	}
	catch(Exception e){
			e.printStackTrace();
	}
	finally{
		try{
			if(statement!=null){
				statement.close();
			}
			if(resultset!=null){
				resultset.close();
			}

		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception ex){
			ex.printStackTrace();
		}

}
    }


}
