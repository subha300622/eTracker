
package com.eminent.examples;

//import org.apache.log4j.Logger;
//import org.apache.log4j.PropertyConfigurator;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import org.apache.log4j.Logger;
public class GenerateValue {

static Logger logger = null;

    static {
        logger = Logger.getLogger(GenerateValue.class.getName());
    }



	/**
	 * Logger for this class
	 */
//	private static final Logger logger = Logger.getLogger("Calculate Value");
	static int value=0;
	static int newtask[][]={
		{32, 32, 320, 100, 100, 100, 3200, 800, 100, 640, 100, 100 },
		{30, 30, 300,  90,  90,  90, 2880, 720,  90, 600,  90,  90 },
		{28, 28, 280,  81,  81,  81, 2592, 648,  81, 560,  81,  81 },
		{26, 26, 260,  73,  73,  73, 2336, 584,  73, 520,  73,  73 },
		{24, 24, 240,  58,  58,  58, 1856, 464,  58, 480,  58,  58 },
		{22, 22, 220,  47,  47,  47, 1504, 376,  47, 440,  47,  47 },
		{20, 20, 200,  37,  37,  37, 1184, 296,  37, 400,  37,  37 },
		{18, 18, 180,  30,  30,  30,  960, 240,  30, 360,  30,  30 },
		{16, 16, 160,  21,  21,  21,  672, 168,  21, 320,  21,  21 },
		{14, 14, 130,  15,  15,  15,  480, 120,  15, 280,  15,  15 },
		{12, 12, 120,  10,  10,  12,  384,  96,  12, 240,  10,  10 },
		{10, 10, 100,   7,   7,  10,  320,  80,  10, 200,   7,   7 },
		{ 8, 8,   80,   4,   4,   8,  256,  64,   8, 160,   4,   4 },
		{ 6, 6,   60,   3,   3,   6,  192,  48,   6, 120,   3,   3 },
		{ 4, 4,   40,   2,   2,   4,  128,  32,   4,  80,   2,   2 },
		{ 2, 2,   20,   1,   1,   2,   64,  16,   2,  40,   1,   1 }
							};
	
	static int enhancement[][]={
		{32, 32, 320, 100, 100, 100, 2400, 600, 100, 480, 100, 100 },
		{30, 30, 300,  90,  90,  90, 2160, 540,  90, 450,  90,  90 },
		{28, 28, 280,  81,  81,  81, 1944, 486,  81, 420,  81,  81 },
		{26, 26, 260,  73,  73,  73, 1752, 438,  73, 390,  73,  73 },
		{24, 24, 240,  58,  58,  58, 1392, 348,  58, 360,  58,  58 },
		{22, 22, 220,  47,  47,  47, 1128, 282,  47, 330,  47,  47 },
		{20, 20, 200,  37,  37,  37,  888, 222,  37, 300,  37,  37 },
		{18, 18, 180,  30,  30,  30,  720, 180,  30, 270,  30,  30 },
		{16, 16, 160,  21,  21,  21,  504, 126,  21, 240,  21,  21 },
		{14, 14, 130,  15,  15,  15,  360,  90,  15, 210,  15,  15 },
		{12, 12, 120,  10,  10,  12,  288,  72,  12, 180,  10,  10 },
		{10, 10, 100,   7,   7,  10,  240,  60,  10, 150,   7,   7 },
		{ 8, 8,   80,   4,   4,   8,  192,  48,   8, 120,   4,   4 },
		{ 6, 6,   60,   3,   3,   6,  144,  36,   6,  90,   3,   3 },
		{ 4, 4,   40,   2,   2,   4,   96,  24,   4,  60,   2,   2 },
		{ 2, 2,   20,   1,   1,   2,   48,  12,   2,  30,   1,   1 }
		};
	
	static int bug[][]={
		{32, 32, 320, 100, 100, 100, 1600, 400, 100, 320, 100, 100 },
		{30, 30, 300,  90,  90,  90, 1440, 360,  90, 300,  90,  90 },
		{28, 28, 280,  81,  81,  81, 1296, 324,  81, 280,  81,  81 },
		{26, 26, 260,  73,  73,  73, 1168, 292,  73, 260,  73,  73 },
		{24, 24, 240,  58,  58,  58,  928, 232,  58, 240,  58,  58 },
		{22, 22, 220,  47,  47,  47,  752, 188,  47, 220,  47,  47 },
		{20, 20, 200,  37,  37,  37,  592, 148,  37, 200,  37,  37 },
		{18, 18, 180,  30,  30,  30,  480, 120,  30, 180,  30,  30 },
		{16, 16, 160,  21,  21,  21,  336,  84,  21, 160,  21,  21 },
		{14, 14, 140,  15,  15,  15,  240,  60,  15, 140,  15,  15 },
		{12, 12, 120,  10,  10,  12,  192,  48,  12, 120,  10,  10 },
		{10, 10, 100,   7,   7,  10,  160,  40,  10, 100,   7,   7 },
		{ 8, 8,   80,   4,   4,   8,  128,  32,   8,  80,   4,   4 },
		{ 6, 6,   60,   3,   3,   6,   96,  24,   6,  60,   3,   3 },
		{ 4, 4,   40,   2,   2,   4,   64,  16,   4,  40,   2,   2 },
		{ 2, 2,   20,   1,   1,   2,   32,   8,   2,  20,   1,   1 }
		};

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
	GenerateValue(){
	
	
	HashMap<String,Integer> sevpri=new HashMap<String,Integer>();
	HashMap<String,Integer> status=new HashMap<String,Integer>();
	
	sevpri.put("P1S1",1);
	sevpri.put("P1S2",2);
	sevpri.put("P2S1",3);
	sevpri.put("P2S2",4);
	
	sevpri.put("P3S1",5);
	sevpri.put("P4S1",6);
	sevpri.put("P1S3",7);
	sevpri.put("P2S3",8);
	
	sevpri.put("P3S2",9);
	sevpri.put("P4S2",10);
	sevpri.put("P3S3",11);
	sevpri.put("P4S3",12);
	
	sevpri.put("P1S4",13);
	sevpri.put("P2S4",14);
	sevpri.put("P3S4",15);
	sevpri.put("P4S4",16);
	
	status.put("Unconfirmed"	, 1);
	status.put("Confirmed"		, 2);
	status.put("Investigation"	, 3);
	status.put("Workinprogress"	, 4);
	status.put("ReadytoBuild"	, 5);
	status.put("Verified"		, 6);
	status.put("Closed"			, 7);
	status.put("Reopen"			, 8);
	status.put("Duplicate"		, 9);
	status.put("Rejected"		, 10);
	status.put("Development"	, 11);
	status.put("QA"				, 12);
	status.put("Documentation"	, 13);
	
	}
	
	
	


	
	public void CreateValue() throws SQLException
	{
		

	Connection connection=null;
	ResultSet rs=null;
	Statement st=null;
//	int val;
	HashMap<String,String> hm=null;
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
		st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("select issueid,severity,priority,type from issue where createdby='106'and  to_date(createdon, 'DD-Mon-YY') between '01-Feb-08' and  '30-May-08'");
		while(rs.next()){
//				val=0;
				String issueid  =	rs.getString(1);
//				String severity =	rs.getString(2);
//				String priority =	rs.getString(3);
//				String type		=	rs.getString(4);
//				String sev=severity.substring(0,severity.indexOf("-")).trim();
//				String pri=priority.substring(0,severity.indexOf("-")).trim();
//				String finalval=pri+sev;

				
				hm=GetIssueStatus.getStatus(issueid);
					
				
				
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
				
//					System.out.println("Completed status-" +pri+sev);
				
				
				
			
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
		

		GenerateValue c=new GenerateValue();
		c.CreateValue();

	
		
	}

}
