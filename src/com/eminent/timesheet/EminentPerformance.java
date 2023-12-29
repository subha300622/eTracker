package com.eminent.timesheet;
import pack.eminent.encryption.MakeConnection;
import java.util.HashMap;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import org.apache.log4j.Logger;

/**
 *
 * @author Administrator
 */
public class EminentPerformance {
    static Logger logger=Logger.getLogger("EminentPerformance");
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
            int workedIssues    =   getWorkedIssues(start,end);
            int closedIssues    =   getClosedIssues(start,end);
            int createdIssues   =   getCreatedIssues(start,end);
            int openIssues      =   getOpenIssues(start,end);
            logger.info("Total Open Issues"+openIssues);
            monthValue[i][0]    =   mon;
            monthValue[i][1]  =   ((Integer)workedIssues).toString();
            monthValue[i][2]  =   ((Integer)closedIssues).toString();
            monthValue[i][3]  =   ((Integer)createdIssues).toString();
            monthValue[i][4]  =   ((Integer)month).toString();
            monthValue[i][5]  =   ((Integer)openIssues).toString();

        }
        return monthValue;
    }
    public static int getOpenIssues(String start,String end){
        int noOfOpenIssues=0;
        Connection connection=null;
        Statement statement=null;
	ResultSet resultset=null;
         try{
                String query=   "Select i.issueid,status from issue i , issuestatus s where i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY')<'"+end+"' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY')<'"+start+"') ";
                logger.info("Open Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery(query);
                while(resultset.next()){
                   noOfOpenIssues++;


                }

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception e){
             logger.error(e.getMessage());
            }try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception e){
             logger.error(e.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception e){
              logger.error(e.getMessage());
            }
        }
        return noOfOpenIssues;
    }
    public static int getWorkedIssues(String start,String end){
        int noOfWorkedIssues=0;
        Connection connection=null;
        Statement statement=null;
	ResultSet resultset=null;
         try{
                String query="select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and comments!='Assigning to PM as due date exceeded' and to_date(to_char(comment_date, 'DD-Mon-YY '),'DD-Mon-YY ') between '"+start+"' and '"+end+"'  order by modifiedon desc";
                logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery(query);
                while(resultset.next()){
                   noOfWorkedIssues++;


                }

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception e){
                logger.error(e.getMessage());
            }
            try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception e){
               logger.error(e.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
        return noOfWorkedIssues;
    }
    public static int getClosedIssues(String start,String end){
        int noOfClosedIssues=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select distinct issuecomments.issueid, modifiedon  from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') between '"+start+"' and '"+end+"' and to_date(to_char(modifiedon,'DD-Mon-YY'), 'DD-Mon-YY') between '"+start+"' and '"+end+"'  order by modifiedon desc";
               logger.info("Closed Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery(query);
                while(resultset.next()){
                    noOfClosedIssues++;


                }

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception e){
               logger.error(e.getMessage());
            }
            try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception e){
               logger.error(e.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception e){
               logger.error(e.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfClosedIssues;
    }
    public static int getCreatedIssues(String start,String end){
        int noOfCreatedIssues=0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
         try{


                String query="select distinct issueid, modifiedon  from issue where to_date(to_char(createdon,'DD-Mon-YY'), 'DD-Mon-YY') between '"+start+"' and '"+end+"' order by modifiedon desc";
                logger.info("Created Query"+query);
		connection=MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery(query);
                while(resultset.next()){
                    noOfCreatedIssues++;


                }

	}
	catch(Exception e){
		logger.error(e.getMessage());
	}
        finally{
            try{
                 if(resultset!=null) {
                    resultset.close();
		 }

            }catch(Exception e){
               logger.error(e.getMessage());
            }
            try{
                 if(statement!=null) {
			statement.close();
		 }

            }catch(Exception e){
              logger.error(e.getMessage());
            }
            try{
                if(connection!=null) {
                    connection.close();
		}

            }catch(Exception e){
                logger.error(e.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfCreatedIssues;
    }

}
