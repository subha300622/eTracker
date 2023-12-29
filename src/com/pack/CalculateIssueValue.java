package com.pack;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;

import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;
public class CalculateIssueValue {
	static Logger logger = Logger.getLogger("Calculate Issue Vale");
	static int value=0;
	int totalvalue=0;
	static String start,end;
	private static HashMap<Integer,String> hm = new HashMap<Integer,String>();
    
    static{
    
    hm.put(0,"Jan");
    hm.put(1,"Feb");
    hm.put(2,"Mar");
    hm.put(3,"Apr");
    hm.put(4,"May");
    hm.put(5,"Jun");
    hm.put(6,"Jul");
    hm.put(7,"Aug");
    hm.put(8,"Sep");
    hm.put(9,"Oct");
    hm.put(10,"Nov");
    hm.put(11,"Dec");	
    
}
    
    public static void GetDate()
    {
  
//    	calculating start and end date of this month
		Calendar cal = new GregorianCalendar();
                         
        int year = cal.get(Calendar.YEAR);             
        int month = cal.get(Calendar.MONTH);         
        int maxday=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        
       
        start="1"+"-"+hm.get(month)+"-"+year;
        end=maxday+"-"+hm.get(month)+"-"+year;
        logger.info("Start Date of month"+start);
        logger.info("End Dateof month"+end);
       
    }
	public static int CreateValue(int UserId) throws SQLException
	{
		value=0;
	Connection connection=null;
	ResultSet rs=null;
	Statement st=null;
	int val;
	try{
	//	Class.forName("oracle.jdbc.driver.OracleDriver");
		
	//	connection=DriverManager.getConnection("jdbc:oracle:thin:@eblr001:1521:XE", "etracker", "eminent");
		GetDate();
		connection=MakeConnection.getConnection();
		st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("select severity,priority from issue where createdby='"+UserId+"'and  to_char(createdon, 'DD-Mon-YY') between '"+start+"' and '"+end+"'");
		while(rs.next()){
				val=0;
				String severity=rs.getString(1);
				String priority=rs.getString(2);
				String sev=severity.substring(0,severity.indexOf("-")).trim();
				String pri=priority.substring(0,severity.indexOf("-")).trim();
				String finalval=pri+sev;
				if(finalval.equals("P1S1")){
					val=100;
				}
				else if(finalval.equals("P1S2")){
					val=90;
				}
				else if(finalval.equals("P2S1")){
					val=81;
				}
				else if(finalval.equals("P2S2")){
					val=73;
				}
				if(finalval.equals("P3S1")){
					val=58;
				}
				else if(finalval.equals("P4S1")){
					val=47;
				}
				else if(finalval.equals("P1S3")){
					val=37;
				}
				else if(finalval.equals("P2S3")){
					val=30;
				}
				if(finalval.equals("P3S2")){
					val=21;
				}
				else if(finalval.equals("P4S2")){
					val=15;
				}
				else if(finalval.equals("P3S3")){
					val=10;
				}
				else if(finalval.equals("P4S3")){
					val=7;
				}
				if(finalval.equals("P1S4")){
					val=4;
				}
				else if(finalval.equals("P2S3")){
					val=3;
				}
				else if(finalval.equals("P3S4")){
					val=2;
				}
				else if(finalval.equals("P4S4")){
					val=1;
				}
				
				value=value+val;
			
		}
		CompletedValue(UserId);
	}
	catch(Exception e){
			logger.error("CreateValue(int)"+e.getMessage());
	}
	finally{
		try{
		if(st!=null) {
			st.close();
		}
		if(rs!=null) {
			rs.close();
		}
		if(connection!=null) {
			connection.close();
		}
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
	}
	
	return value;
	}
	
	public static void CompletedValue(int UserId){
		Connection connection=null;
		ResultSet rs=null;
		Statement st=null;
		int val;
		
		try{
			connection=MakeConnection.getConnection();
			st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs=st.executeQuery("select issue.severity,issue.priority,issuecomments.status from issue,issuecomments where issue.issueid=issuecomments.issueid and commentedby='"+UserId+"'and status='Code Review' and  to_char(comment_date, 'DD-Mon-YY') between '"+start+"' and '"+end+"'");
			while(rs.next()){
				
					val=0;
					String severity=rs.getString(1);
					String priority=rs.getString(2);
					String sev=severity.substring(0,severity.indexOf("-")).trim();
					String pri=priority.substring(0,severity.indexOf("-")).trim();
					
					String readytobuildstatus=pri+sev;
					
					if(readytobuildstatus.equals("P1S1")){
						val=100*16;
					}
					else if(readytobuildstatus.equals("P1S2")){
						val=90*15;
					}
					else if(readytobuildstatus.equals("P2S1")){
						val=81*14;
					}
					else if(readytobuildstatus.equals("P2S2")){
						val=73*13;
					}
					if(readytobuildstatus.equals("P3S1")){
						val=58*12;
					}
					else if(readytobuildstatus.equals("P4S1")){
						val=47*11;
					}
					else if(readytobuildstatus.equals("P1S3")){
						val=37*10;
					}
					else if(readytobuildstatus.equals("P2S3")){
						val=30*9;
					}
					if(readytobuildstatus.equals("P3S2")){
						val=21*8;
					}
					else if(readytobuildstatus.equals("P4S2")){
						val=15*7;
					}
					else if(readytobuildstatus.equals("P3S3")){
						val=10*6;
						
					}
					else if(readytobuildstatus.equals("P4S3")){
						val=7*5;
					}
					if(readytobuildstatus.equals("P1S4")){
						val=4*4;
					}
					else if(readytobuildstatus.equals("P2S3")){
						val=3*3;
					}
					else if(readytobuildstatus.equals("P3S4")){
						val=2*2;
					}
					else if(readytobuildstatus.equals("P4S4")){
						val=1*1;
					}
					
					value=value+val;
					
			}
		}
		catch(Exception e){
			logger.error("CompletedValue(int)"+e.getMessage());
		}
		finally{
			try{
			if(st!=null) {
				st.close();
			}
			if(rs!=null) {
				rs.close();
			}
			if(connection!=null) {
				connection.close();
			}
			}
			catch(Exception e){
				logger.error(e.getMessage());
			}
		}
		
	}
    public static int getValue(int userID){
         int uservalue=0;
         Connection connection  = null;
         Statement   st=null;
         ResultSet	rs=null;
        try{
           
         connection=MakeConnection.getConnection();
		st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("select value from users where userid='"+userID+"'");
			while(rs.next()){
                uservalue=rs.getInt("value");
            }
        }
        catch(Exception e){
            logger.error(e.getMessage());
        }
         finally{
            try{
		if(st!=null) {
			st.close();
		}
		
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
            try{
		
		if(rs!=null) {
			rs.close();
		}
		
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
                    try{
                            if(connection!=null&& !connection.isClosed()){
                                connection.close();
                            }
                    }
                    catch(SQLException s){
                        logger.error(s.getMessage());
                    }
                }
        return uservalue;
    }
    public static float getEstimatedValue(int userID){
         float uservalue=0;
         Connection connection  = null;
         Statement   st = null;
         ResultSet	rs=null;
         
        try{
           
         connection=MakeConnection.getConnection();
		st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("select sum(estimated_time) as value from issue i, issuestatus s where s.issueid=i.issueid and status!='Closed' and assignedto="+userID+" and estimated_time is not null");
			while(rs.next()){
                uservalue=rs.getFloat("value");
            }
        }
        catch(Exception e){
            logger.error(e.getMessage());
        }
         finally{
            try{
		if(st!=null) {
			st.close();
		}
		
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
            try{
		
		if(rs!=null) {
			rs.close();
		}
		
		}
		catch(Exception e){
			logger.error(e.getMessage());
		}
                    try{
                            if(connection!=null&& !connection.isClosed()){
                                connection.close();
                            }
                    }
                    catch(SQLException s){
                        logger.error(s);
                    }
                }
        return uservalue;
    }
	

}
