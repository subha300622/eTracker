/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.tqm;
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
public class TqmPerformance {
    static Logger logger=Logger.getLogger("TQMPerformance");
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
        String monthValue[][]=new String[12][5];
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
            int ctcCreated    =getCTC(start,end);
            int ptcCreated    =getPTC(start,end);
            int tepCreated    =getTEP(start,end);
           

            monthValue[i][0]    =   mon;
            monthValue[i][1]  =   ((Integer)ctcCreated).toString();
            monthValue[i][2]  =   ((Integer)ptcCreated).toString();
            monthValue[i][3]  =   ((Integer)tepCreated).toString();
            monthValue[i][4]  =   ((Integer)month).toString();


        }
        return monthValue;
    }
    public static int getCTC(String start,String end){
        int noOfCTC=0;
        Connection connection=null;
        Statement statement=null;
	ResultSet resultset=null;
         try{
                String query="select ctcid from tqm_ctcm where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') between '"+start+"' and '"+end+"'";
                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();
                noOfCTC=resultset.getRow();

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
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
        }
        return noOfCTC;
    }
    public static int getPTC(String start,String end){
        int noOfPTC=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select ptcid from tqm_ptcm where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') between '"+start+"' and '"+end+"'";
                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();
                noOfPTC =   resultset.getRow();
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
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfPTC;
    }
public static int getTEP(String start,String end){
        int noOfTEP=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select tepid from tqm_testcaseexecutionplan where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') between '"+start+"' and '"+end+"'";
                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                resultset = statement.executeQuery(query);
                resultset.last();
                noOfTEP =   resultset.getRow();
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
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfTEP;
    }
}
