/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.examples;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFCell;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;
import org.apache.log4j.Logger;

public class ReadColumn {
    
    static Logger logger = null;

    static {
        logger = Logger.getLogger(ReadColumn.class.getName());
    }
private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String DB_USER = "eminenttracker";
	private static final String DB_PASSWORD = "eminentlabs";
    @SuppressWarnings("unchecked")
    public static void main(String[] args) throws Exception {
//
// An excel file name. You can create a file name with a full
// path information.
//
        String fileName = "D:/Upload.xls";
        int userId      =   112;

// Create an ArrayList to store the data read from excel sheet.
//
        List sheetData = new ArrayList();

        FileInputStream fis = null;
        try {
//
// Create a FileInputStream that will be use to read the
// excel file.
//
            fis = new FileInputStream(fileName);

//
// Create an excel workbook from the file system.
//
            HSSFWorkbook workbook = new HSSFWorkbook(fis);
//
// Get the first sheet on the workbook.
//
            HSSFSheet sheet = workbook.getSheetAt(0);

//
// When we have a sheet object in hand we can iterator on
// each sheet's rows and on each row's cells. We store the
// data read on an ArrayList so that we can printed the
// content of the excel to the console.
//
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                HSSFRow row = (HSSFRow) rows.next();
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    data.add(cell);
                }

                sheetData.add(data);
            }
        } catch (IOException e) {
            logger.error("Errorfgdggffgfg: " + e.getMessage());
        } finally {
            if (fis != null) {
                fis.close();
            }
        }

        showExelData(sheetData);
//        try{
//        callOracleStoredProcOUTParameter(userId);
//        }catch(Exception e){
//            e.printStackTrace();
//        }
    }

    private static void showExelData(List sheetData) {
                Connection dbConnection = null;
		CallableStatement callableStatement = null,sc_callableStatement=null;
                CallableStatement vt_callableStatement = null,tc_callableStatement=null;
                CallableStatement ts_callableStatement = null,tsc_callableStatement=null;
//
// Iterates the data and print it out to the console.
//
        int mpId=116,userId  =   112,spId=0,tempSpId=0,scId=0,tempScId=0,vtId=0,tempVtId=0,tcId=0,tempTcId=0,tsId=0,tempTsId=0,tscId=0;
        String createSubProcessSql  = "{call BPM_SUB_PROCESS_UPLOAD(?,?,?,?)}";
        String createScenarioSql    = "{call BPM_SCENARIO_UPLOAD(?,?,?,?)}";
        String createVariantSql     = "{call BPM_VARIANT_UPLOAD(?,?,?,?)}";
        String createTestcaseSql    = "{call BPM_TESTCASE_UPLOAD(?,?,?,?)}";
        String createTeststepSql    = "{call BPM_TESTSTEP_UPLOAD(?,?,?,?)}";
        String createTestScriptSql  = "{call BPM_TESTSCRIPT_UPLOAD(?,?,?,?,?)}";
        try{
              dbConnection = getDBConnection();
                dbConnection.setAutoCommit(false);
        for (int i = 1; i < sheetData.size(); i++) {
            List list = (List) sheetData.get(i);
            //for (int j = 0; j < list.size(); j++) {
                HSSFCell sub = (HSSFCell) list.get(0);
                HSSFCell sc = (HSSFCell) list.get(1);
                HSSFCell vt = (HSSFCell) list.get(2);
                HSSFCell tc = (HSSFCell) list.get(3);
                HSSFCell ts = (HSSFCell) list.get(4);
                HSSFCell tsc = (HSSFCell) list.get(5);
                HSSFCell tsc1 = (HSSFCell) list.get(6);
//                System.out.print(sub.getRichStringCellValue().getString()+" , ");
//                System.out.print(sc.getRichStringCellValue().getString()+" , ");
//                System.out.print(vt.getRichStringCellValue().getString()+" , ");
//                System.out.print(tc.getRichStringCellValue().getString()+" , ");
//                System.out.print(ts.getRichStringCellValue().getString()+" , ");
//                System.out.print(tsc.getRichStringCellValue().getString());
                String subprocess = sub.getRichStringCellValue().getString();
                String scenario = sc.getRichStringCellValue().getString();
                String variant = vt.getRichStringCellValue().getString();
                String testcase = tc.getRichStringCellValue().getString();
                String teststep = ts.getRichStringCellValue().getString();
                String testscript =tsc.getRichStringCellValue().getString();
                String testscriptd =tsc1.getRichStringCellValue().getString();
                
                
                
//                String subprocess = ((HSSFCell) list.get(0)).getStringCellValue();
//                String scenario = ((HSSFCell) list.get(1)).getStringCellValue();
//                String variant = ((HSSFCell) list.get(2)).getStringCellValue();
//                String testcase = ((HSSFCell) list.get(3)).getStringCellValue();
//                String teststep = ((HSSFCell) list.get(4)).getStringCellValue();
//                String testscript = ((HSSFCell) list.get(5)).getStringCellValue();
                
              
                
                if(subprocess!=null&&!(("").equalsIgnoreCase(subprocess))){
                        callableStatement = dbConnection.prepareCall(createSubProcessSql);
			callableStatement.setString(1, subprocess);
			callableStatement.setInt(2, mpId);
			callableStatement.setInt(3, userId);
			callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
 			// execute getDBUSERByUserId store procedure
			callableStatement.executeUpdate();
 			spId  = callableStatement.getInt(4);
                }else{
                }
                
                if(scenario!=null&&!(("").equalsIgnoreCase(scenario))){
                        sc_callableStatement = dbConnection.prepareCall(createScenarioSql);
			sc_callableStatement.setString(1, scenario);
			sc_callableStatement.setInt(2, spId);
			sc_callableStatement.setInt(3, userId);
			sc_callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
 			// execute Scenario store procedure
			sc_callableStatement.executeUpdate();
 			scId  = sc_callableStatement.getInt(4);
                }
                
                if(variant!=null&&!(("").equalsIgnoreCase(variant))){
                        vt_callableStatement = dbConnection.prepareCall(createVariantSql);
			vt_callableStatement.setString(1,variant);
			vt_callableStatement.setInt(2, scId);
			vt_callableStatement.setInt(3, userId);
			vt_callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
 			// execute Variant store procedure
			vt_callableStatement.executeUpdate();
 			vtId  = vt_callableStatement.getInt(4);
                }
                if(testcase!=null&&!(("").equalsIgnoreCase(testcase))){
                    tc_callableStatement = dbConnection.prepareCall(createTestcaseSql);
			tc_callableStatement.setString(1, testcase);
			tc_callableStatement.setInt(2, vtId);
			tc_callableStatement.setInt(3, userId);
			tc_callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
 			// execute Test Case store procedure
			tc_callableStatement.executeUpdate();
 			tcId  = tc_callableStatement.getInt(4);
                }
                if(teststep!=null&&!(("").equalsIgnoreCase(teststep))){
                        ts_callableStatement = dbConnection.prepareCall(createTeststepSql);
			ts_callableStatement.setString(1, teststep);
			ts_callableStatement.setInt(2, tcId);
			ts_callableStatement.setInt(3, userId);
			ts_callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
 			// execute Test Step store procedure
			ts_callableStatement.executeUpdate();
 			tsId  = ts_callableStatement.getInt(4);
                        
                }
                if(testscript!=null&&!(("").equalsIgnoreCase(testscript))){
                    //Code for Test Script
                        tsc_callableStatement = dbConnection.prepareCall(createTestScriptSql);
			tsc_callableStatement.setString(1, testscript);
                        tsc_callableStatement.setString(2, testscriptd);
                         tsc_callableStatement.setString(3, "Q14042013001");
			tsc_callableStatement.setInt(4, tsId);
			tsc_callableStatement.setInt(5, userId);

 			// execute Test Step store procedure
			tsc_callableStatement.executeUpdate();
                }
                
                 
           
        }
        }catch(SQLException e){
            try{
             if(dbConnection != null){
                          dbConnection.rollback();
                    }
             logger.error("Errorfgdggffgfg: " + e.getMessage());
        
        }catch(SQLException ex){
            
                            logger.error("Errorfgdggffgfg: " + ex.getMessage());
        }
        }
        finally {
          
            try{
                   
			if (callableStatement != null) {
				callableStatement.close();
			}
                        if (sc_callableStatement != null) {
				sc_callableStatement.close();
			}
                        if (vt_callableStatement != null) {
				vt_callableStatement.close();
			}
                        if (tc_callableStatement != null) {
				tc_callableStatement.close();
			}
                        if (ts_callableStatement != null) {
				ts_callableStatement.close();
			}
                        if (tsc_callableStatement != null) {
				tsc_callableStatement.close();
			}
                        
 
			if (dbConnection != null) {
                                dbConnection.commit();
                                dbConnection.setAutoCommit(true);
				dbConnection.close();
			}
 
		}
        catch(SQLException e){
        }
    }
        
//        try{
//        callOracleStoredProcOUTParameter(userId);
//        }catch(Exception e){
//            e.printStackTrace();
//        }
    }
    private static void callOracleStoredProcOUTParameter(int userId) throws SQLException {
 
		Connection dbConnection = null;
		CallableStatement callableStatement = null,sc_callableStatement=null;
                CallableStatement vt_callableStatement = null,tc_callableStatement=null;
                CallableStatement ts_callableStatement = null,tsc_callableStatement=null;
//                CREATE OR REPLACE PROCEDURE BPM_SUB_PROCESS_UPLOAD ( SUB_PROCESS VARCHAR2, MP_ID NUMBER, CREATEDBY NUMBER, SP_ID OUT NUMBER) IS
//                BEGIN
//                INSERT INTO BPM_SUB_PROCESS(SP_ID,SUB_PROCESS,MP_ID,CREATEDBY,CREATEDON) VALUES(BPM_SP_ID_SEQ.nextval,SUB_PROCESS, MP_ID, CREATEDBY,SYSDATE) RETURNING SP_ID INTO SP_ID;
//                END;
		String createSubProcessSql = "{call BPM_SUB_PROCESS_UPLOAD(?,?,?,?)}";
                String createScenarioSql   = "{call BPM_SCENARIO_UPLOAD(?,?,?,?)}";
 
		try {
			dbConnection = getDBConnection();
                        dbConnection.setAutoCommit(false);
                        
			
//                        // code for sub process
//                        callableStatement = dbConnection.prepareCall(createSubProcessSql);
//			callableStatement.setString(1, "Sub Process 1");
//			callableStatement.setInt(2, 120);
//			callableStatement.setInt(3, userId);
//			callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
// 			// execute getDBUSERByUserId store procedure
//		//	callableStatement.executeUpdate();
// 			int spId  = callableStatement.getInt(4);
                        
                        //code for scenario
                        sc_callableStatement = dbConnection.prepareCall(createScenarioSql);
			sc_callableStatement.setString(1, "Scenario");
			sc_callableStatement.setInt(2, 398);
			sc_callableStatement.setInt(3, userId);
			sc_callableStatement.registerOutParameter(4, java.sql.Types.INTEGER);
 			// execute Scenario store procedure
			sc_callableStatement.executeUpdate();
 			int scId  = sc_callableStatement.getInt(4);
                        
                        
                        
                        dbConnection.commit();
                        dbConnection.setAutoCommit(true);
			
		} catch (SQLException e) {
 
			logger.error("Errorfgdggffgfg: " + e.getMessage());
                        try{
                    if(dbConnection != null){
                          dbConnection.rollback();
                    }
                    }catch(SQLException ex){
                             logger.error("Errorfgdggffgfg: " + e.getMessage());
                     }
 
		} finally {
 
			if (callableStatement != null) {
				callableStatement.close();
			}
 
			if (dbConnection != null) {
				dbConnection.close();
			}
 
		}
 
	}
    private static Connection getDBConnection() {
 
		Connection dbConnection = null;
 
		try {
 
			Class.forName(DB_DRIVER);
 
		} catch (ClassNotFoundException e) {
 
			logger.error("Errorfgdggffgfg: " + e.getMessage());
 
		}
 
		try {
 
			dbConnection = DriverManager.getConnection(
				DB_CONNECTION, DB_USER,DB_PASSWORD);
			return dbConnection;
 
		} catch (SQLException e) {
 
			logger.error("Errorfgdggffgfg: " + e.getMessage());
 
		}
 
		return dbConnection;
 
	}
}