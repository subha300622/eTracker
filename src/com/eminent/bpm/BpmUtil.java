/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.bpm;

import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import pack.eminent.encryption.MakeConnection;
import com.eminent.util.GetProjects;
import com.eminentlabs.userBPM.BPMUtil;
import com.eminentlabs.userBPM.CreateBPM;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Tamilvelan
 */
public class BpmUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("BpmUtil");
    }

    public static String[][] getTree(int spId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String projectDetails[][] = null;
        int rowcount = 0, count = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("SELECT SUB_PROCESS,SCENARIO,VARIANT,TESTCASE,TESTSTEP,TEST_SCRIPT,EXPECTED_RESULT,S4.VARIANT_ID,S4.SCENARIO_ID,S4.TESTCASE_ID,S4.TESTSTEP_ID,TESTSCRIPT_ID,s4.SC_TYPE,s4.VT_TYPE,s4.TC_TYPE,s4.TS_TYPE FROM (SELECT S3.VARIANT_ID,S3.SCENARIO_ID,s3.SC_TYPE,S3.TESTCASE_ID,TESTSTEP_ID,SUB_PROCESS,SCENARIO,VARIANT,TESTCASE,TESTSTEP, s3.VT_TYPE,s3.TC_TYPE,TS_TYPE FROM (SELECT s2.VARIANT_ID,s2.SCENARIO_ID,TESTCASE_ID,SUB_PROCESS,SCENARIO,VARIANT,TESTCASE,s2.SC_TYPE,s2.VT_TYPE,TC_TYPE FROM (SELECT VARIANT_ID, S1.SCENARIO_ID,s1.SC_TYPE,SUB_PROCESS,SCENARIO,VARIANT,VT_TYPE FROM (select SC.SCENARIO_ID,SUB_PROCESS,SCENARIO,sc.SC_TYPE FROM BPM_SUB_PROCESS SP JOIN BPM_SCENARIO SC ON SP.SP_ID=SC.SP_ID AND Sc.SP_ID= " + spId + ")S1 LEFT JOIN BPM_VARIANT VT ON S1.SCENARIO_ID = VT.SCENARIO_ID order by S1.SCENARIO_ID) S2 LEFT JOIN BPM_TESTCASE TC ON S2.VARIANT_ID = TC.VARIANT_ID order by s2.SCENARIO_ID,S2.VARIANT_ID)  S3 LEFT JOIN BPM_TESTSTEP TS ON S3.TESTCASE_ID = TS.TESTCASE_ID ORDER BY S3.SCENARIO_ID,S3.VARIANT_ID,S3.TESTCASE_ID,TESTSTEP_ID) S4 LEFT JOIN BPM_TESTSCRIPT TS ON S4.TESTSTEP_ID = TS.TESTSTEP_ID ORDER BY S4.SCENARIO_ID,S4.VARIANT_ID,S4.TESTCASE_ID, S4.TESTSTEP_ID, TESTSCRIPT_ID");
            resultset.last();

            rowcount = resultset.getRow();
            projectDetails = new String[rowcount][11];
            resultset.beforeFirst();
            while (resultset.next()) {
                projectDetails[count][0] = resultset.getString(1);
                projectDetails[count][1] = resultset.getString(2);
                projectDetails[count][2] = resultset.getString(3);
                projectDetails[count][3] = resultset.getString(4);
                projectDetails[count][4] = resultset.getString(5);
                projectDetails[count][5] = resultset.getString(6);
                projectDetails[count][6] = resultset.getString(7);
                projectDetails[count][7] = resultset.getString(13);
                projectDetails[count][8] = resultset.getString(14);
                projectDetails[count][9] = resultset.getString(15);
                projectDetails[count][10] = resultset.getString(16);
                //                   logger.info(count+" Script  :"+projectDetails[count][5]);
                count++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());

            }
        }

        return projectDetails;

    }

    public static String readExcel(InputStream file, int userId, int spId, String pId) {
        // Create an ArrayList to store the data read from excel sheet.
//
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {"Sub Process", "Scenario", "Scenario Type", "Variant", "Variant Type", "Test Case", "Test Case Type", "Test Step", "Test Step Type", "Description", "Expected Result"};
        String excelProcess[] = new String[11];
        try {

//
// Create an excel workbook from the file system.
//
            HSSFWorkbook workbook = new HSSFWorkbook(file);
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
                logger.info("NO of Cell" + row.getLastCellNum());
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    data.add(cell.getStringCellValue());
                    logger.info("Cell Value is: " + cell.getStringCellValue());
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                        logger.info("Column " + noOfColumn + "'s Value is: " + cell.getStringCellValue());
                    }
                }

                sheetData.add(data);
                noOfRows++;
            }
        } catch (IOException e) {
            logger.error(e.getMessage());

        }

        logger.info("No of Column Available is" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 11) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else {
            status = storeExcelData(sheetData, userId, spId, pId);
        }

        return status;
    }

    public static String readTsExcel(InputStream file, int userId, int tsId, String pId) {
        // Create an ArrayList to store the data read from excel sheet.
//
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {"Description", "Expected Result"};
        String excelProcess[] = new String[2];
        try {

//
// Create an excel workbook from the file system.
//
            HSSFWorkbook workbook = new HSSFWorkbook(file);
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
                logger.info("NO of Cell" + row.getLastCellNum());
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    data.add(cell.getStringCellValue());
                    logger.info("Cell Value is: " + cell.getStringCellValue());
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                        logger.info("Column " + noOfColumn + "'s Value is: " + cell.getStringCellValue());
                    }
                }

                sheetData.add(data);
                noOfRows++;
            }
        } catch (IOException e) {
            logger.error(e.getMessage());

        }

        logger.info("No of Column Available is" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 2) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else {
            status = storeTsExcelData(sheetData, userId, tsId, pId);
        }

        return status;
    }

    public static String readTsXlsx(InputStream file, int userId, int tsId, String pId) {
        // Create an ArrayList to store the data read from excel sheet.
//
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {"Description", "Expected Result"};
        String excelProcess[] = new String[2];
        try {

//
// Create an excel workbook from the file system.
//
            XSSFWorkbook workbook = new XSSFWorkbook(file);
//
// Get the first sheet on the workbook.
//
            XSSFSheet sheet = workbook.getSheetAt(0);

//
// When we have a sheet object in hand we can iterator on
// each sheet's rows and on each row's cells. We store the
// data read on an ArrayList so that we can printed the
// content of the excel to the console.
//
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                XSSFRow row = (XSSFRow) rows.next();
                logger.info("NO of Cell" + row.getLastCellNum());
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    XSSFCell cell = (XSSFCell) cells.next();
                    data.add(cell.getStringCellValue());
                    logger.info("Cell Value is: " + cell.getStringCellValue());
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                        logger.info("Column " + noOfColumn + "'s Value is: " + cell.getStringCellValue());
                    }
                }

                sheetData.add(data);
                noOfRows++;
            }
        } catch (IOException e) {
            logger.error(e.getMessage());
        }

        logger.info("No of Column Available is" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 2) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else {
            status = storeTsExcelData(sheetData, userId, tsId, pId);
        }

        return status;
    }

    private static String storeTsExcelData(List sheetData, int userId, int tsId, String pId) {
        Connection dbConnection = null;
        CallableStatement sc_callableStatement = null;
        CallableStatement vt_callableStatement = null, tc_callableStatement = null;
        CallableStatement ts_callableStatement = null, tsc_callableStatement = null;
        String status = "";
//
// Iterates the data and print it out to the console.
//

        String createTestScriptSql = "{call BPM_TESTSCRIPT_UPLOAD(?,?,?,?,?)}";

        try {
            dbConnection = MakeConnection.getConnection();
            dbConnection.setAutoCommit(false);
            //           callableStatement = dbConnection.prepareCall(createSubProcessSql);

            tsc_callableStatement = dbConnection.prepareCall(createTestScriptSql);
            String mod = BPMUtil.getModule(tsId);
            String functionality = mod.substring(mod.indexOf(":") + 1, mod.length());
            int mid = Integer.parseInt(mod.substring(0, mod.indexOf(":")));
            String testscript = "";
            String testscriptd = "";
            int listSize = 0;
            logger.info("No of Rows Available in the sheet" + sheetData.size());
            for (int i = 1; i < sheetData.size(); i++) {
                List list = (List) sheetData.get(i);
                listSize = list.size();
                logger.info((i + 1) + "Size of the Row::::>  " + listSize);
                logger.info((i + 1) + "Size of the Row::::>  " + list);
                logger.info(i + ".");

                if (listSize > 1) {
                    testscript = (String) list.get(0);
                    testscriptd = (String) list.get(1);
                }

                logger.info(testscript);
                logger.info(testscriptd);

                if (testscript != null && !(("").equalsIgnoreCase(testscript)) && testscriptd != null && !(("").equalsIgnoreCase(testscriptd))) {
                    //Code for Test Script
                    String ptcId = CreateBPM.createPTC(Integer.parseInt(pId), mid, functionality, testscript, testscriptd, userId);
                    tsc_callableStatement.setString(1, testscript);
                    tsc_callableStatement.setString(2, testscriptd);
                    tsc_callableStatement.setString(3, ptcId);
                    tsc_callableStatement.setInt(4, tsId);
                    tsc_callableStatement.setInt(5, userId);

                    // execute Test Step store procedure
                    tsc_callableStatement.executeUpdate();
                    logger.info("Test Script Available::: " + testscript);
                }
                testscript = "";
                testscriptd = "";
                logger.info("");
            }
            status = "Success";
            dbConnection.commit();
            dbConnection.setAutoCommit(true);
        } catch (Exception e) {
            status = "File cannot be uploaded now. Please try again later or Contact Administrator";
            try {
                if (dbConnection != null) {
                    dbConnection.rollback();
                }
                logger.error(e.getMessage());

            } catch (SQLException ex) {
                logger.error(ex.getMessage());
            }

        } finally {
            try {

                if (sc_callableStatement != null) {
                    sc_callableStatement.close();
                    logger.info("sc_callableStatement closed");
                }
                if (vt_callableStatement != null) {
                    vt_callableStatement.close();
                    logger.info("vt_callableStatement closed");
                }
                if (tc_callableStatement != null) {
                    tc_callableStatement.close();
                    logger.info("tc_callableStatement closed");
                }
                if (ts_callableStatement != null) {
                    ts_callableStatement.close();
                    logger.info("ts_callableStatement closed");
                }
                if (tsc_callableStatement != null) {
                    tsc_callableStatement.close();
                    logger.info("tsc_callableStatement closed");
                }

                if (dbConnection != null) {
                    dbConnection.close();
                    logger.info("dbConnection closed");
                }

            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }

        return status;
    }

    public static String readXlsx(InputStream file, int userId, int spId, String pId) {
        // Create an ArrayList to store the data read from excel sheet.
//
        List sheetData = new ArrayList();
        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {"Sub Process", "Scenario", "Scenario Type", "Variant", "Variant Type", "Test Case", "Test Case Type", "Test Step", "Test Step Type", "Description", "Expected Result"};
        String excelProcess[] = new String[11];
        try {

//
// Create an excel workbook from the file system.
//
            XSSFWorkbook workbook = new XSSFWorkbook(file);
//
// Get the first sheet on the workbook.
//
            XSSFSheet sheet = workbook.getSheetAt(0);

//
// When we have a sheet object in hand we can iterator on
// each sheet's rows and on each row's cells. We store the
// data read on an ArrayList so that we can printed the
// content of the excel to the console.
//
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                XSSFRow row = (XSSFRow) rows.next();
                logger.info("NO of Cell" + row.getLastCellNum());
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    XSSFCell cell = (XSSFCell) cells.next();
                    data.add(cell.getStringCellValue());
                    logger.info("Cell Value is: " + cell.getStringCellValue());
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                        logger.info("Column " + noOfColumn + "'s Value is: " + cell.getStringCellValue());
                    }
                }

                sheetData.add(data);
                noOfRows++;
            }
        } catch (IOException e) {
            logger.error(e.getMessage());
        }

        logger.info("No of Column Available is" + noOfColumn);
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 11) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source downloaded excel structure seems to be tampered, the upload cannot be processed";
        } else {
            status = storeExcelData(sheetData, userId, spId, pId);
        }

        return status;
    }

    private static boolean compareHeader(String[] excelProcess, String[] process) {
        boolean flag = true;
        for (int i = 0; i < process.length; i++) {
            if (!process[i].equalsIgnoreCase(excelProcess[i])) {
                flag = false;
            }
        }
        return flag;
    }

    private static String storeExcelData(List sheetData, int userId, int spId, String pId) {

        Connection dbConnection = null;
        CallableStatement callableStatement = null, sc_callableStatement = null;
        CallableStatement vt_callableStatement = null, tc_callableStatement = null;
        CallableStatement ts_callableStatement = null, tsc_callableStatement = null;
        String status = "";
//
// Iterates the data and print it out to the console.
//
        int scId = 0, vtId = 0, tcId = 0, tsId = 0;
        //       String createSubProcessSql  = "{call BPM_SUB_PROCESS_UPLOAD(?,?,?,?)}";
        String createScenarioSql = "{call BPM_SCENARIO_UPLOAD(?,?,?,?,?)}";
        String createVariantSql = "{call BPM_VARIANT_UPLOAD(?,?,?,?,?,?,?,?,?,?)}";
        String createTestcaseSql = "{call BPM_TESTCASE_UPLOAD(?,?,?,?,?)}";
        String createTeststepSql = "{call BPM_TESTSTEP_UPLOAD(?,?,?,?,?)}";
        String createTestScriptSql = "{call BPM_TESTSCRIPT_UPLOAD(?,?,?,?,?)}";

        try {
            dbConnection = MakeConnection.getConnection();
            dbConnection.setAutoCommit(false);
            //           callableStatement = dbConnection.prepareCall(createSubProcessSql);
            sc_callableStatement = dbConnection.prepareCall(createScenarioSql);
            vt_callableStatement = dbConnection.prepareCall(createVariantSql);
            tc_callableStatement = dbConnection.prepareCall(createTestcaseSql);
            ts_callableStatement = dbConnection.prepareCall(createTeststepSql);
            tsc_callableStatement = dbConnection.prepareCall(createTestScriptSql);
            String moduleId = getVariantModule(userId, pId);
            logger.info("Module Id" + moduleId);
            String classification = "FT";
            String type = "Transaction";
            String priority = "Core";
            String tempTestcase = "";
            String subprocess = "", scenario = "", scType = "", variant = "", vaType = "", testcase = "", tcType = "", teststep = "", tsType = "", testscript = "", testscriptd = "";
            int listSize = 0;
            for (int i = 1; i < sheetData.size(); i++) {
                List list = (List) sheetData.get(i);
                listSize = list.size();
                logger.info((i + 1) + "Size of the Row::::>  " + listSize);
                logger.info(i + ".");
                if (listSize > 0) {
                    subprocess = (String) list.get(0);
                }
                if (listSize > 1) {
                    scenario = (String) list.get(1);
                }
                if (listSize > 2) {
                    scType = (String) list.get(2);
                    if (scType != null) {
                        if (!scType.equalsIgnoreCase("SAP")) {
                            scType = "Non SAP";
                        } else {
                            scType = "SAP";
                        }
                    }
                }
                if (listSize > 3) {
                    variant = (String) list.get(3);
                }
                if (listSize > 4) {
                    vaType = (String) list.get(4);
                    if (vaType != null) {
                        if (!vaType.equalsIgnoreCase("SAP")) {
                            vaType = "Non SAP";
                        } else {
                            vaType = "SAP";
                        }
                    }
                }
                if (listSize > 5) {
                    testcase = (String) list.get(5);
                }
                if (listSize > 6) {
                    tcType = (String) list.get(6);
                    if (tcType != null) {
                        if (!tcType.equalsIgnoreCase("SAP")) {
                            tcType = "Non SAP";
                        } else {
                            tcType = "SAP";
                        }
                    }
                }
                if (listSize > 7) {
                    teststep = (String) list.get(7);
                }
                if (listSize > 8) {
                    tsType = (String) list.get(8);
                    if (tsType != null) {
                        if (!tsType.equalsIgnoreCase("SAP")) {
                            tsType = "Non SAP";
                        } else {
                            tsType = "SAP";
                        }
                    }
                }
                if (listSize >= 10) {
                    testscript = (String) list.get(9);
                    testscriptd = (String) list.get(10);
                }

                logger.info(subprocess + " , ");
                logger.info(scenario + " , ");
                logger.info(variant + " , ");
                logger.info(testcase + " , ");
                logger.info(teststep + " , ");
                logger.info(testscript);
                logger.info(testscriptd);

                if (scenario != null && !(("").equalsIgnoreCase(scenario))) {
                    logger.info("Passed Sub Process Id" + spId);
                    sc_callableStatement.setString(1, scenario);
                    sc_callableStatement.setInt(2, spId);
                    sc_callableStatement.setInt(3, userId);
                    sc_callableStatement.setString(4, scType);
                    sc_callableStatement.registerOutParameter(5, java.sql.Types.INTEGER);
                    // execute Scenario store procedure
                    sc_callableStatement.executeUpdate();
                    scId = sc_callableStatement.getInt(5);
                    logger.info("Scenario Available" + scId);
                }

                if (variant != null && !(("").equalsIgnoreCase(variant))) {

                    vt_callableStatement.setString(1, variant);
                    vt_callableStatement.setInt(2, scId);
                    vt_callableStatement.setInt(3, Integer.parseInt(moduleId));
                    vt_callableStatement.setInt(4, Integer.parseInt(moduleId));
                    vt_callableStatement.setString(5, classification);
                    vt_callableStatement.setString(6, type);
                    vt_callableStatement.setString(7, priority);
                    vt_callableStatement.setInt(8, userId);
                    vt_callableStatement.setString(9, vaType);
                    vt_callableStatement.registerOutParameter(10, java.sql.Types.INTEGER);
                    // execute Variant store procedure
                    vt_callableStatement.executeUpdate();
                    vtId = vt_callableStatement.getInt(10);
                    logger.info("variant Available" + vtId);
                }
                if (testcase != null && !(("").equalsIgnoreCase(testcase))) {
                    tempTestcase = testcase;
                    tc_callableStatement.setString(1, testcase);
                    tc_callableStatement.setInt(2, vtId);
                    tc_callableStatement.setInt(3, userId);
                    tc_callableStatement.setString(4, tcType);
                    tc_callableStatement.registerOutParameter(5, java.sql.Types.INTEGER);
                    // execute Test Case store procedure
                    tc_callableStatement.executeUpdate();
                    tcId = tc_callableStatement.getInt(5);
                    logger.info("Test Case Available" + tcId);
                } else {
                    testcase = tempTestcase;
                }
                if (teststep != null && !(("").equalsIgnoreCase(teststep))) {

                    ts_callableStatement.setString(1, teststep);
                    ts_callableStatement.setInt(2, tcId);
                    ts_callableStatement.setInt(3, userId);
                    ts_callableStatement.setString(4, tsType);
                    ts_callableStatement.registerOutParameter(5, java.sql.Types.INTEGER);
                    // execute Test Step store procedure
                    ts_callableStatement.executeUpdate();
                    tsId = ts_callableStatement.getInt(5);
                    logger.info("Test Step Available" + tsId);

                }
                if (testscript != null && !(("").equalsIgnoreCase(testscript))) {
                    //Code for Test Script
                    String ptcId = CreateBPM.createPTC(Integer.parseInt(pId), Integer.parseInt(moduleId), testcase, testscript, testscriptd, userId);
                    tsc_callableStatement.setString(1, testscript);
                    tsc_callableStatement.setString(2, testscriptd);
                    tsc_callableStatement.setString(3, ptcId);
                    tsc_callableStatement.setInt(4, tsId);
                    tsc_callableStatement.setInt(5, userId);

                    // execute Test Step store procedure
                    tsc_callableStatement.executeUpdate();
                    logger.info("Test Script Available::: " + testscript);
                }

                logger.info("");
            }
            status = "Success";
            dbConnection.commit();
            dbConnection.setAutoCommit(true);
        } catch (Exception e) {
            status = "File cannot be uploaded now. Please try again later or Contact Administrator";
            try {
                if (dbConnection != null) {
                    dbConnection.rollback();
                }
                logger.error(e.getMessage());

            } catch (SQLException ex) {
                logger.info(ex.getMessage());
            }

        } finally {
            try {

                if (sc_callableStatement != null) {
                    sc_callableStatement.close();
                    logger.info("sc_callableStatement closed");
                }
                if (vt_callableStatement != null) {
                    vt_callableStatement.close();
                    logger.info("vt_callableStatement closed");
                }
                if (tc_callableStatement != null) {
                    tc_callableStatement.close();
                    logger.info("tc_callableStatement closed");
                }
                if (ts_callableStatement != null) {
                    ts_callableStatement.close();
                    logger.info("ts_callableStatement closed");
                }
                if (tsc_callableStatement != null) {
                    tsc_callableStatement.close();
                    logger.info("tsc_callableStatement closed");
                }

                if (dbConnection != null) {
                    dbConnection.close();
                    logger.info("dbConnection closed");
                }

            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }

        return status;
    }

    public static String getVariantModule(int userId, String pId) {
        String module = "";

        try {

            HashMap<String, String> mod = GetProjects.getModules(pId);
            if (userId == 216) {
                for (Map.Entry<String, String> entry : mod.entrySet()) {
                    if (entry.getValue().equals("MM")) {
                        module = entry.getKey();
                    }
                }
            } else if (userId == 218) {
                for (Map.Entry<String, String> entry : mod.entrySet()) {
                    if (entry.getValue().equals("PP")) {
                        module = entry.getKey();
                    }
                }
            } else if (userId == 226) {
                for (Map.Entry<String, String> entry : mod.entrySet()) {
                    if (entry.getValue().equals("SD")) {
                        module = entry.getKey();
                    }
                }
            } else if (userId == 301) {
                for (Map.Entry<String, String> entry : mod.entrySet()) {
                    if (entry.getValue().equals("FI") || entry.getValue().equals("CO")) {
                        module = entry.getKey();
                    }
                }
            } else if (userId == 469) {
                for (Map.Entry<String, String> entry : mod.entrySet()) {
                    if (entry.getValue().equals("QM")) {
                        module = entry.getKey();
                    }
                }
            } else {
                for (Map.Entry<String, String> entry : mod.entrySet()) {
                    if (entry.getValue().equals("ABAP")) {
                        module = entry.getKey();
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());

        }
        return module;
    }

    public static String getTestcase(int tsId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;

        String testcase = null;
        try {
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select TESTCASE from bpm_testcase where TESTCASE_ID=( select testcase_id from bpm_teststep where teststep_id=" + tsId + ")");
            while (resultset.next()) {
                testcase = resultset.getString(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return testcase;
    }
}
