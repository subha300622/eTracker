package com.eminent.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class MyViewUtils {
    static Logger logger    =   Logger.getLogger("MyViewUtils");
    public static int getIssueCount(String query){
        int noOfIssues=0;
	Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
	try{
                logger.info("MyView Query"+query);
		connection=MakeConnection.getConnection();
		statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		resultset=statement.executeQuery(query);
		resultset.last();
		noOfIssues=resultset.getRow();

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
	finally{
		try{

		if(resultset!=null) {
			resultset.close();
		}
        if(statement!=null) {
			statement.close();
		}
		if(connection!=null) {
			connection.close();
		}
		}
		catch(Exception ex){
			logger.error(ex.getMessage());
		}
	}
        return noOfIssues;
    }

}
