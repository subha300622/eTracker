package com.eminent.examples;

//import org.apache.log4j.Logger;
//import org.apache.log4j.PropertyConfigurator;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.log4j.Logger;

public class CalculateValue {
	/**
	 * Logger for this class
	 */
static Logger logger = null;

    static {
        logger = Logger.getLogger(GenerateValue.class.getName());
    }
/*	public int P1S1=100;
	public int P1S2=90;
	public int P2S1=81;
	public int P2S2=73;
	public int P3S1=58;
	public int P4S1=47;
	public int P1S3=37;
	public int P2S3=30;
	public int P3S2=21;
	public int P4S2=15;
	public int P3S3=10;
	public int P4S3=7;
	public int P1S4=4;
	public int P2S4=3;
	public int P3S4=2;
	public int P4S4=1;
	
	*/
	static int value=0;

	
	public void CreateValue() throws SQLException
	{
		

	Connection connection=null;
	ResultSet rs=null;
	Statement st=null;
	int val;
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
		st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("select severity,priority from issue where createdby='122'and  to_date(createdon, 'DD-Mon-YY') between '01-Feb-08' and  '29-Feb-08'");
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
		
	}
	catch(Exception e){
			logger.error("Errorfgdggffgfg: " + e.getMessage());
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
				logger.error("Errorfgdggffgfg: " + e.getMessage());
			
		}
	}

		
	}
	
	public void CompletedValue(){
		

		Connection connection=null;
		ResultSet rs=null;
		Statement st=null;
		int val;
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
			st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs=st.executeQuery("select issue.severity,issue.priority,issuecomments.status from issue,issuecomments where issue.issueid=issuecomments.issueid and commentedby='122'and status='ReadytoBuild'and  to_date(createdon, 'DD-Mon-YY') between '01-Feb-08' and  '29-Feb-08'");
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
			logger.error("Errorfgdggffgfg: " + e.getMessage());
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
				logger.error("Errorfgdggffgfg: " + e.getMessage());
				
			}
		}
		

		
	}
	
	public static void main(String []args) throws Exception{
		

		CalculateValue c=new CalculateValue();
		c.CreateValue();
		c.CompletedValue();

		
	}

}
