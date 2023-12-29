package com.eminent.examples;

import java.util.*;
import java.text.SimpleDateFormat;
import org.apache.log4j.Logger;

public class GetDays {

    static Logger logger = null;

    static {
        logger = Logger.getLogger(GetDays.class.getName());
    }

    public static void main(String[] args) {
//        Connection connection=null;
//        Statement statement =null;
//        ResultSet resultset =null;

        try {
            Calendar c = new GregorianCalendar();
            int month = c.get(Calendar.MONTH);
            int year = c.get(Calendar.YEAR);
            c.add(Calendar.DAY_OF_MONTH, -30);
            for (int i = 0; i < 30; i++) {
                c.add(Calendar.DAY_OF_MONTH, 1);
                Date date = c.getTime();
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                String dateFor = sdf.format(date);

            }
            /*
             Class.forName("oracle.jdbc.driver.OracleDriver");

             connection=DriverManager.getConnection("jdbc:oracle:thin:@eminentlabs.com:1521:XE", "eminenttracker", "prodDB");
             statement=connection.createStatement();
             resultset=statement.executeQuery("insert into issue_support(issueid,projecttype,phase,subphase) values('E10112009001','Support','Project Preparation','Actual situation analysis')");
		

             while(resultset.next()){
			
             System.out.println("Issueid=="+resultset.getString("issueid")+"--->Subject=="+resultset.getString("subject")+"----Accomplishments"+resultset.getString("createdby"));
             System.out.println("projectid"+resultset.getString("pid"));
             System.out.println("Module Id"+resultset.getString("MODULE_ID"));
             System.out.println("Desc"+resultset.getString("DESCRIPTION"));
             }
             */
        } catch (Exception e) {
            logger.error( e.getMessage());
        } finally {
            try {
//			if(statement!=null){
//				statement.close();
//			}
//			if(resultset!=null){
//				resultset.close();
//			}
//
//		if(connection!=null){
//			connection.close();
//		}
            } catch (Exception ex) {
                logger.error( ex.getMessage());
            }

        }
    }

}
