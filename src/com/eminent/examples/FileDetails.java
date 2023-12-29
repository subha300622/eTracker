package com.eminent.examples;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;

public class FileDetails {
	 static Logger logger = Logger.getLogger("FileDetails");
	public static void test(){
		
		Connection connection=null;
		Statement statement=null;
		ResultSet resultset=null;
		String issueid=null;
		
		try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");

		statement=connection.createStatement();
		
		issueid="E27062009009";
		resultset=statement.executeQuery("select * from fileattach where issueid='"+issueid+"'");

        if(resultset!=null){
		if(resultset.next()){
		
        }
        else{
        }
        }else{
        }
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
		
	}
        
//        public static void main(String[] args){
//            String nameoftc    =   "upload###upload###Tamilvelan T***Not Run***36681&&&5";
//            String testScript  =   nameoftc.substring(0, nameoftc.indexOf("###")) ;
//            String expRslt     =   nameoftc.substring(nameoftc.indexOf("###")+3,nameoftc.lastIndexOf("###"));
//            String createdBy   =   nameoftc.substring(nameoftc.lastIndexOf("###")+3,nameoftc.indexOf("***")-2);
//            String ptcId       =   nameoftc.substring(nameoftc.indexOf("***")+3,nameoftc.lastIndexOf("***"));
//            String tscId       =   nameoftc.substring(nameoftc.lastIndexOf("***")+3,nameoftc.lastIndexOf("&&&"));
//            String noOffiles   =   nameoftc.substring(nameoftc.lastIndexOf("&&&")+3);
//            
//        }

}
