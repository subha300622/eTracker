package com.eminent.examples;
import java.sql.PreparedStatement;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Vector;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;


/**
 *
 * @author Tamilvelan
 */
public class UploadBP {
    public static void main(String[] args){
        String fileName =   "D:\\BPM\\3. Business Process.xls";
        Vector dataHolder   =   readExcel(fileName);
        printCellDate(dataHolder);
    }
    public static Vector readExcel(String fileName){
        Vector cellVectorHolder =   new Vector();
        try{
            FileInputStream file    =   new FileInputStream(fileName);
            POIFSFileSystem fileSystem  =   new POIFSFileSystem(file);
            HSSFWorkbook workbook       =   new HSSFWorkbook(fileSystem);
            HSSFSheet   workSheet       =   workbook.getSheetAt(0);

            Iterator rowIte        =    workSheet.rowIterator();

            while(rowIte.hasNext()){

                HSSFRow row     =   (HSSFRow)rowIte.next();
                Iterator cellIter   = row.cellIterator();
                Vector cellStorage  =   new Vector();
                while(cellIter.hasNext()){
                    HSSFCell    cell    =   (HSSFCell)cellIter.next();
                    cellStorage.addElement(cell);
                }
                cellVectorHolder.addElement(cellStorage);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return cellVectorHolder;
    }
    private static void printCellDate(Vector data){
        Connection connection=null;
        ResultSet resultset=null;
	Statement statement=null;
        PreparedStatement createClient  =   null;
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
        statement=connection.createStatement();
        
        createClient = connection.prepareStatement("insert into BPM_BP(BP_ID,BP_NAME,COMPANY_ID,COMPANY_NAME,CLIENT_ID,CLIENT_NAME) values(?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        for(int i=0;i<data.size();i++){
            resultset=statement.executeQuery("select BPM_BP_ID_SEQ.nextval as nextvalue from dual");
            resultset.next();
            int nextValue = resultset.getInt("nextvalue");
            String stringValue="";
            Vector cellStoreVector  =   (Vector)data.elementAt(i);
            createClient.setInt(1, nextValue);
             for(int j=0;j<cellStoreVector.size();j++){
               HSSFCell cell    =   (HSSFCell)cellStoreVector.elementAt(j);
               stringValue=  cell.toString();

                   createClient.setString((j+2), stringValue);

            }


           createClient.addBatch();

        }
        createClient.executeBatch();
        }catch(Exception e){
            e.printStackTrace();
        }
        finally{
            try{
            if(resultset!=null){
                resultset.close();
            }
            if(createClient!=null){
                createClient.close();
            }
            if(statement!=null){
                statement.close();
            }
            if(connection!=null){
                connection.close();
            }

            }catch(Exception e){
                e.printStackTrace();
            }
        }
        }
    }



