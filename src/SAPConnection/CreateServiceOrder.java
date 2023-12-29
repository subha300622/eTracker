package SAPConnection;


import com.sap.conn.jco.AbapException;
import com.sap.conn.jco.JCo;
import com.sap.conn.jco.JCoContext;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoField;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoRepository;
import com.sap.conn.jco.JCoStructure;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.ext.DestinationDataProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author RN.Khans
 */
public class CreateServiceOrder {

    static String DESTINATION_NAME1 = "ABAP_AS_WITHOUT_POOL";
    static String DESTINATION_NAME2 = "ABAP_AS_WITH_POOL";

    static {
        Properties connectProperties = new Properties();
        connectProperties.setProperty(DestinationDataProvider.JCO_ASHOST, "192.168.18.3");
        connectProperties.setProperty(DestinationDataProvider.JCO_SYSNR, "00");
        connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT, "200");
        connectProperties.setProperty(DestinationDataProvider.JCO_USER, "ESPLTEAM");
        connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD, "eminent@1234");
        connectProperties.setProperty(DestinationDataProvider.JCO_LANG, "en");
        connectProperties.setProperty(DestinationDataProvider.JCO_SAPROUTER, "/H/59.90.136.226/H/");
        createDestinationDataFile(DESTINATION_NAME1, connectProperties);
        connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, "3");
        connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT, "10");
        createDestinationDataFile(DESTINATION_NAME2, connectProperties);

    }

    static void createDestinationDataFile(String destinationName, Properties connectProperties) {
        File destCfg = new File(destinationName + ".jcoDestination");
        try {
            FileOutputStream fos = new FileOutputStream(destCfg, false);
            connectProperties.store(fos, "for tests only !");
            fos.close();
        } catch (Exception e) {
            throw new RuntimeException("Unable to create the destination files", e);
        }
    }

    public static void create() throws JCoException {
        
        String serviceOrder;
        Date date = new Date();
        Date current = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");

        try {
            current = sdf.parse(sdf.format(date));
        } catch (ParseException ex) {
            Logger.getLogger(CreateServiceOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        JCoDestination destination = JCoDestinationManager.getDestination(DESTINATION_NAME2);
        JCoFunction function = destination.getRepository().getFunction("BAPI_ALM_ORDER_MAINTAIN");
        JCoTable methodTable = function.getTableParameterList().getTable("IT_METHODS");
        JCoTable headerTable = function.getTableParameterList().getTable("IT_HEADER");
        JCoTable operationTable = function.getTableParameterList().getTable("IT_OPERATION");
        JCoTable objectTable = function.getTableParameterList().getTable("IT_OBJECTLIST");
        JCoTable etTable = function.getTableParameterList().getTable("ET_NUMBERS");
        JCoTable returnStructure = function.getTableParameterList().getTable("RETURN");
        if (function == null) {
            throw new RuntimeException("BAPI_ALM_ORDER_MAINTAIN not found in SAP.");
        } else {
            JCoContext.begin(destination);
            methodTable.appendRow();
            methodTable.setValue("REFNUMBER", "000001");
            methodTable.setValue("OBJECTTYPE", "HEADER");
            methodTable.setValue("METHOD", "CREATE");
            methodTable.setValue("OBJECTKEY", "%00000000001");
            
            methodTable.appendRow();
            methodTable.setValue("REFNUMBER", "000001");
            methodTable.setValue("OBJECTTYPE", "");
            methodTable.setValue("METHOD", "SAVE");
            methodTable.setValue("OBJECTKEY", "%00000000001");

            headerTable.appendRow();
            headerTable.setValue("ORDERID", "%00000000001");
            headerTable.setValue("ORDER_TYPE", "SM02");
            headerTable.setValue("PLANPLANT", "U101");
            headerTable.setValue("MN_WK_CTR", "WC1MF8");
            headerTable.setValue("START_DATE", current);

            methodTable.appendRow();
            methodTable.setValue("REFNUMBER", "000001");
            methodTable.setValue("OBJECTTYPE", "OPERATION");
            methodTable.setValue("METHOD", "CREATE");
            methodTable.setValue("OBJECTKEY", "%000000000010010");

            operationTable.appendRow();
            operationTable.setValue("ACTIVITY", "0010");
            operationTable.setValue("CONTROL_KEY", "SM02");
            operationTable.setValue("DESCRIPTION", "calling from java");

            objectTable.appendRow();
//            objectTable.setValue("FUNCT_LOC", "YB50000/00000001");
            objectTable.setValue("EQUIPMENT", "10000059");            
            
            try {
                function.execute(destination);
            } catch (AbapException e) {
                
            }
            if (!(returnStructure.getString("TYPE").equals("")
                    || returnStructure.getString("TYPE").equals("S")
                    || returnStructure.getString("TYPE").equals("W"))) {
                throw new RuntimeException(returnStructure.getString("MESSAGE"));
            }
             serviceOrder = etTable.getString("AUFNR_NEW");

            JCoFunction function1 = destination.getRepository().getFunction("BAPI_TRANSACTION_COMMIT");
            function1.getImportParameterList().setValue("WAIT", "10");
            function1.execute(destination);
            JCoContext.end(destination);
        }
        
    }

    public static void main(String args[]) throws JCoException {
        create();
    }

    public static String create(String complaint, String location, String equipment, String reported, String natureComplaint) throws JCoException {
        
     String DESTINATION_NAME1 = "ABAP_AS_WITHOUT_POOL";
     String DESTINATION_NAME2 = "ABAP_AS_WITH_POOL";
    
        Properties connectProperties = new Properties();
        connectProperties.setProperty(DestinationDataProvider.JCO_ASHOST, "192.168.18.3");
        connectProperties.setProperty(DestinationDataProvider.JCO_SYSNR, "00");
        connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT, "200");
        connectProperties.setProperty(DestinationDataProvider.JCO_USER, "ESPLTEAM");
        connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD, "eminent@1234");
        connectProperties.setProperty(DestinationDataProvider.JCO_LANG, "en");
        connectProperties.setProperty(DestinationDataProvider.JCO_SAPROUTER, "/H/59.90.136.226/H/");
        createDestinationDataFile(DESTINATION_NAME1, connectProperties);
        connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, "3");
        connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT, "10");
        createDestinationDataFile(DESTINATION_NAME2, connectProperties);

    
       
        String serviceOrder;
        Date date = new Date();
        Date current = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");

        try {
            current = sdf.parse(sdf.format(date));
        } catch (ParseException ex) {
            Logger.getLogger(CreateServiceOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        JCoDestination destination = JCoDestinationManager.getDestination(DESTINATION_NAME2);
        JCoFunction function = destination.getRepository().getFunction("BAPI_ALM_ORDER_MAINTAIN");
        JCoTable methodTable = function.getTableParameterList().getTable("IT_METHODS");
        JCoTable headerTable = function.getTableParameterList().getTable("IT_HEADER");
        JCoTable operationTable = function.getTableParameterList().getTable("IT_OPERATION");
        JCoTable objectTable = function.getTableParameterList().getTable("IT_OBJECTLIST");
        JCoTable etTable = function.getTableParameterList().getTable("ET_NUMBERS");
        JCoTable returnStructure = function.getTableParameterList().getTable("RETURN");
        if (function == null) {
            throw new RuntimeException("BAPI_ALM_ORDER_MAINTAIN not found in SAP.");
        } else {
            JCoContext.begin(destination);
            methodTable.appendRow();
            methodTable.setValue("REFNUMBER", "000001");
            methodTable.setValue("OBJECTTYPE", "HEADER");
            methodTable.setValue("METHOD", "CREATE");
            methodTable.setValue("OBJECTKEY", "%00000000001");
            
            methodTable.appendRow();
            methodTable.setValue("REFNUMBER", "000001");
            methodTable.setValue("OBJECTTYPE", "");
            methodTable.setValue("METHOD", "SAVE");
            methodTable.setValue("OBJECTKEY", "%00000000001");

            headerTable.appendRow();
            headerTable.setValue("ORDERID", "%00000000001");
            headerTable.setValue("ORDER_TYPE", "SM02");
            headerTable.setValue("PLANPLANT", "U101");
            headerTable.setValue("MN_WK_CTR", "WC1MF8");
            headerTable.setValue("START_DATE", current);

            methodTable.appendRow();
            methodTable.setValue("REFNUMBER", "000001");
            methodTable.setValue("OBJECTTYPE", "OPERATION");
            methodTable.setValue("METHOD", "CREATE");
            methodTable.setValue("OBJECTKEY", "%000000000010010");

            operationTable.appendRow();
            operationTable.setValue("ACTIVITY", "0010");
            operationTable.setValue("CONTROL_KEY", "SM02");
            operationTable.setValue("DESCRIPTION", natureComplaint);

            objectTable.appendRow();
//            objectTable.setValue("FUNCT_LOC", "YB50000/00000001");
            objectTable.setValue("EQUIPMENT", equipment);            
            
            try {
                function.execute(destination);
            } catch (AbapException e) {
                
            }
            if (!(returnStructure.getString("TYPE").equals("")
                    || returnStructure.getString("TYPE").equals("S")
                    || returnStructure.getString("TYPE").equals("W"))) {
                throw new RuntimeException(returnStructure.getString("MESSAGE"));
            }
             serviceOrder = etTable.getString("AUFNR_NEW");

            JCoFunction function1 = destination.getRepository().getFunction("BAPI_TRANSACTION_COMMIT");
            function1.getImportParameterList().setValue("WAIT", "10");
            function1.execute(destination);
            JCoContext.end(destination);
        }
        return serviceOrder;
    }

}
