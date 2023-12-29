package com.eminent.examples;
import java.sql.*;
import pack.eminent.encryption.MakeConnection;

public class TamilTest {
//	void dbTest(){
		
/*
	try{
		Connection connection=null;
		Statement st=null;
		ResultSet rs=null;
		Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
		
		connection=DriverManager.getConnection("jdbc:sapdb://192.168.1.215/nsp","sapnsp","emi1");
		st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=st.executeQuery("Select * from yapn");
		while(rs.next()){
			System.out.println(rs.getString(1)+" "+rs.getString(2));
		}
	}
	catch(Exception e){
		System.out.println("Exception"+e);
		
	}
	}
	public static void main(String []args){
		
		TamilTest s=new TamilTest();
		s.dbTest();
	}
*/
    public static void main(String []args){
    boolean flag    = false;
    Connection connection=null;
    Statement statement=null;
    ResultSet resultset=null;
    int roleid;
    String date =   "2010-07-01";
    System.out.println("SQL Date"+java.sql.Date.valueOf(date));

    
    try{
//		connection=MakeConnection.getConnection();
        Class.forName("oracle.jdbc.driver.OracleDriver");

		connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
		statement=connection.createStatement();
		resultset=statement.executeQuery("SELECT TS_TYPE,COUNT(*) AS COUNT from BPM_COMPANY C,BPM_BP BP,BPM_MAIN_PROCESS MP, BPM_SUB_PROCESS SP, BPM_SCENARIO SC, BPM_VARIANT VT, BPM_TESTCASE TC, BPM_TESTSTEP TS WHERE C.COMPANY_ID=BP.COMPANY_ID AND BP.BP_ID=MP.BP_ID AND MP.MP_ID=SP.MP_ID AND SP.SP_ID=SC.SP_ID AND SC.SCENARIO_ID = VT.SCENARIO_ID AND VT.VARIANT_ID = TC.VARIANT_ID AND TC.TESTCASE_ID=TS.TESTCASE_ID AND C.CLIENT_ID=10124 GROUP BY TS_TYPE");
		while(resultset.next()){

			System.out.print("test");
                        System.out.print(resultset.getString(1)+" ");
                        System.out.println(resultset.getInt(2));

		}


	}
	catch(Exception e){
		e.printStackTrace();
	}
    finally{
            try{
                 if(resultset!=null) {
					resultset.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                 if(statement!=null) {
					statement.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                if(connection!=null) {
					connection.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
    System.out.println("Flag"+flag);
    if(flag){
          System.out.println("Created by created");
     }
    else{
                      
                       System.out.println("Created by Manager");
                   }
     
    }

}
