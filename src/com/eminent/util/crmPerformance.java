/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.util;
import pack.eminent.encryption.MakeConnection;
import java.util.HashMap;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 *
 * @author TAMILVELAN
 */
public class crmPerformance {
    static Logger logger=Logger.getLogger("CRMPerformance");
    private static HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();

	    static{

	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");

	}
    public static String[][] getValue(){
        Calendar c=new GregorianCalendar();
        int month= c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        c.add(Calendar.MONTH, -11);
        String monthValue[][]=new String[12][6];
        for(int i=0;i<=11;i++){
            month= c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH,1);
            String mon=monthSelect.get(month)+"-"+year;
//            logger.info("Time Sheet Month"+month);


            Calendar cale=Calendar.getInstance();
            cale.set(year, month, 1);
            int maxday = cale.getActualMaximum(Calendar.DATE);
            String start="1"+"-"+monthSelect.get(month)+"-"+year;
            String end=maxday+"-"+monthSelect.get(month)+"-"+year;
            int createdContacts         =   getCreatedContact(start,end);
            int createdLeads            =   getCreatedLeads(start,end);
            int createdOpportunities    =   getCreatedOpportunities(start,end);
            int createdAccounts         =   getCreatedAccounts(start,end);

            monthValue[i][0]    =   mon;
            monthValue[i][1]  =   ((Integer)createdContacts).toString();
            monthValue[i][2]  =   ((Integer)createdLeads).toString();
            monthValue[i][3]  =   ((Integer)createdOpportunities).toString();
            monthValue[i][4]  =   ((Integer)createdAccounts).toString();
            monthValue[i][5]  =   ((Integer)month).toString();


        }
        return monthValue;
    }
    public static int getCreatedContact(String start,String end){
        int noOfCreatedContact=0;
        Connection connection=null;
	PreparedStatement pt=null;
        Statement statement=null;
	ResultSet resultset=null;
         try{
                String query="select contactid from contact where to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"'  order by modifiedon desc";
                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();

                noOfCreatedContact=resultset.getRow();
               

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                 if(pt!=null) {
			pt.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
        }
        return noOfCreatedContact;
    }
    public static int getCreatedLeads(String start,String end){
        int noOfCreatedLeads=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select leadid from lead where to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"'  order by modifiedon desc";
 //               logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();
                noOfCreatedLeads=resultset.getRow();

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
        }
        logger.info("Month"+start+"Leads Issues"+noOfCreatedLeads);
        return noOfCreatedLeads;
    }
    public static int getCreatedOpportunities(String start,String end){
        int noOfCreatedOpportunities=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select opportunityid from opportunity where to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"'  order by modifiedon desc";
//                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();
                noOfCreatedOpportunities=resultset.getRow();

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
        }
        logger.info("Month"+start+"Oppor"+noOfCreatedOpportunities);
        return noOfCreatedOpportunities;
    }
     public static int getCreatedAccounts(String start,String end){
        int noOfCreatedAccounts=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select accountid from account where to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') between '"+start+"' and '"+end+"'  order by modifiedon desc";
//                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();
                noOfCreatedAccounts=resultset.getRow();

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
        }
        logger.info("Month"+start+"Accounts"+noOfCreatedAccounts);
        return noOfCreatedAccounts;
    }

}
