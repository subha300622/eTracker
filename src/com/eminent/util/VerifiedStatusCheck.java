package com.eminent.util;
import java.sql.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Administrator
 */
public class VerifiedStatusCheck {
    static Logger logger = null;
    static {
        logger = Logger.getLogger("VerifiedStatusCheck");

    }
    public static int GetExceedIssues(int userId){
        int noOfIssues = 0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
        try{
		connection=MakeConnection.getConnection();
                
                statement = connection.createStatement();
                resultset = statement.executeQuery("select count(*) as NoofIssues from issue,issuestatus where status='Verified' and assignedto="+userId+" and issue.issueid=issuestatus.issueid and (select sysdate- due_date from dual )> 0 order by modifiedon desc");
                while(resultset.next()){
                    noOfIssues = resultset.getInt("NoofIssues");
                }
 //               System.out.println("No of issues in verified status"+noOfIssues);
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
        return noOfIssues;
    }
        public static int GetIssues(int userId){
        int noOfIssues = 0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
        try{
		connection=MakeConnection.getConnection();

                statement = connection.createStatement();
                resultset = statement.executeQuery("select count(*) as NoofIssues from issue,issuestatus where status='Verified' and assignedto="+userId+" and issue.issueid=issuestatus.issueid and (select sysdate- due_date from dual )< 0 order by modifiedon desc");
                while(resultset.next()){
                    noOfIssues = resultset.getInt("NoofIssues");
                }
 //               System.out.println("No of issues in verified status"+noOfIssues);
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
        return noOfIssues;
    }
    public static int GetTimesheet(int userId){
        int noOfIssues = 0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
        try{
		connection=MakeConnection.getConnection();

                statement = connection.createStatement();
                resultset = statement.executeQuery("select count(*) as NoofTimesheet from timesheet where ACCOUNTSTATUS is null and assignedto="+userId);
                while(resultset.next()){
                    noOfIssues = resultset.getInt("NoofTimesheet");
                }
 //               System.out.println("No of issues in verified status"+noOfIssues);
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
        return noOfIssues;
    }
public static int GetNewIssues(int userId,String lastloginDate){
        int noOfIssues = 0;
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
        try{
		connection=MakeConnection.getConnection();
                statement = connection.createStatement();
                resultset = statement.executeQuery("select Distinct(i.issueid) as NoofIssues  from issue i,issuestatus s,issuecomments ic where  i.issueid=s.issueid and ic.issueid=i.issueid and s.status<>'Closed' and ic.commentedby <> '"+userId+"' and COMMENT_DATE >TO_TIMESTAMP('"+lastloginDate+"','dd-Mon-yyyy HH24:MI:SS') and assignedto='"+userId+"'  group by i.issueid,Comment_date");
                
                while(resultset.next()){
                    noOfIssues++; 
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
        return noOfIssues;
    }
}
