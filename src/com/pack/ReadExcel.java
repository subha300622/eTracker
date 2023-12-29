/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Muthu
 */
public class ReadExcel {

    public static Map<String, List> readingXlsx(InputStream file) {
        List sheetData = new ArrayList();

        Map<String, List> map = new HashMap<String, List>();

        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {
            "Title",
            "First Name",
            "Last Name",
            "Phone",
            "Official Email",
            "Mobile",
            "Company",
            "Due Date",
            "ERP",
            "Vendor",
            "Address",
            "City",
            "State",
            "Pincode"
        };
        String excelProcess[] = new String[14];

        try {
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet sheet = workbook.getSheetAt(0);
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                XSSFRow row = (XSSFRow) rows.next();
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    XSSFCell cell = (XSSFCell) cells.next();
                    if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                        if (DateUtil.isCellDateFormatted(cell)) {
                            data.add(cell.getDateCellValue());
                        } else {
                            data.add((int)cell.getNumericCellValue() + "");
                        }
                    } else {
                        data.add(cell.getStringCellValue());
                    }

                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                    }
                }

                sheetData.add(data);
                noOfRows++;
            }

        } catch (IOException e) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for IO Exception";
            e.printStackTrace();
        } catch (Exception e1) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for exception";
            e1.printStackTrace();
        }
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 14) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for colums < 14";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for header is not matching";
        } else {
            status = "success";
        }
        map.put(status, sheetData);
        return map;
    }

    public static Map<String, List> readingXls(InputStream file) {
        List sheetData = new ArrayList();

        Map<String, List> map = new HashMap<String, List>();

        int noOfRows = 0, noOfColumn = 0;
        String status = "";
        String process[] = {
            "Title",
            "First Name",
            "Last Name",
            "Phone",
            "Official Email",
            "Mobile",
            "Company",
            "Due Date",
            "ERP",
            "Vendor",
            "Address",
            "City",
            "State",
            "Pincode"
        };
        String excelProcess[] = new String[14];

        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file);
            HSSFSheet sheet = workbook.getSheetAt(0);
            Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
                HSSFRow row = (HSSFRow) rows.next();
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
                while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                        if (DateUtil.isCellDateFormatted(cell)) {
                            data.add(cell.getDateCellValue());
                        } else {
                            data.add((int)cell.getNumericCellValue() + "");
                        }
                    } else {
                        data.add(cell.getStringCellValue());
                    }
                    if (noOfRows == 0) {
                        excelProcess[noOfColumn] = cell.getStringCellValue();
                        noOfColumn++;
                    }
                }

                sheetData.add(data);
                noOfRows++;
            }

        } catch (IOException e) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for IO Exception";
            e.printStackTrace();
        } catch (Exception e1) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for exception";
            e1.printStackTrace();
        }
        if (noOfRows < 2) {
            status = "No Rows Available. Please Upload a Valid File";
        } else if (noOfColumn < 14) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for colums < 3";
        } else if (!compareHeader(excelProcess, process)) {
            status = "The source uploaded excel structure seems to be tampered, the upload cannot be processed for header is not matching";
        } else {
            status = "success";
        }
        map.put(status, sheetData);
        return map;
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
}
