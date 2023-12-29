package com.pack.eminent.applicant;
import java.util.*;
import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;
/*
 * getApplicantStatus.java
 *
 * Created on May 9, 2008, 4:44 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Balaguru Ramasamy
 */
public class Applicant {
    
    /** Creates a new instance of getApplicantStatus */
    public Applicant() {
    }
 
     private static HashMap<String,String> hm = new HashMap<String,String>();
     private static HashMap<String,String> hmInternal = new HashMap<String,String>();
     static Logger logger = null;
    
        
	
    
        
        static{
            
        logger = Logger.getLogger("ProjectFinder");
        
        hm.put("Blank","Registered");
        hm.put("RNS","Registration Not Approved");
        hm.put("RW","Registration Waitlisted");
        hm.put("RS","Registration Approved");
        
        hm.put("ANS","Online Test Not Approved");
        hm.put("AW","Oline Test Approval Waitlisted");
        hm.put("AS","Online Test Approved");
        
        hm.put("WNS","Online Test Not Cleared");
        hm.put("WW","Online Test Cleared But Waitlisted");
        hm.put("WS","Online Test Cleared");
        
        hm.put("INS","Competency Interview Not Scheduled");
        hm.put("IW","Competency Interview Waitlisted");
        hm.put("IS","Competency Interview Scheduled");
        
        hm.put("ECN","Competency Interview Not Selected");
        hm.put("ECR","Competency Interview Waitlisted");
        hm.put("ECW","Competency Interview Rescheduled");
        hm.put("ECS","Competency Interview Selected");
        
        hm.put("MNS","Client Interview Not Scheduled");
        hm.put("MW","Client Interview Waitlisted");
        hm.put("MS","Client Interview Scheduled");
        
        hm.put("CNS","Client Interview Not Selected");
        hm.put("CW","Client Interview Waitlisted");
        hm.put("CR","Client Interview Rescheduled");
        hm.put("CS","Client Interwiew Selected");
        
        
        hmInternal.put("Blank","R");
        hmInternal.put("RNS","RNA");
        hmInternal.put("RW","RW");
        hmInternal.put("RS","RA");
        
        hmInternal.put("ANS","OTNA");
        hmInternal.put("AW","OTAW");
        hmInternal.put("AS","OTA");
        
        hmInternal.put("WNS","OTNC");
        hmInternal.put("WW","OTCW");
        hmInternal.put("WS","OTC");
        
        hmInternal.put("INS","CINSD");
        hmInternal.put("IW","CIWD");
        hmInternal.put("IS","CISD");
        
        hmInternal.put("ECN","CINS");
        hmInternal.put("ECR","CIW");
        hmInternal.put("ECW","CIR");
        hmInternal.put("ECS","CIS");
        
        hmInternal.put("MNS","CNSD");
        hmInternal.put("MW","CWD");
        hmInternal.put("MS","CSD");
        
        hmInternal.put("CNS","CNS");
        hmInternal.put("CW","CW");
        hmInternal.put("CR","CR");
        hmInternal.put("CS","CS");
        
    }
    
    public static String getApplicantStatus(String status){
        
        String statusDetail = (String)hm.get(status);
        
        
        return statusDetail;
    }
    
    public static String getApplicantStatusShortcut(String status){
        
        String statusDetail = (String)hmInternal.get(status);
        
        
        return statusDetail;
    }
    
    
    public  static String validateLock(String apId) {
		

		
		
		Connection connection = null;
		Statement statement   = null;
		ResultSet          rs = null;
		String available      = "yes";
                if(apId != null) {
                    int id = Integer.parseInt(apId);
                
                
	
			
			try {
				connection = MakeConnection.getSAPConnection();
				statement  = connection.createStatement();
                                //Checking whether the module is available in the project or not
				rs  = statement.executeQuery("select reqid from yapn where apid = "+id+" ");
				
                                        if(rs.next()) {
                                            if(!rs.getString("reqid").equalsIgnoreCase("")) {
                                                available = "no";
                                            }
                                            
                                        }
								
			
				
			} catch(Exception e) {
				logger.error("Error while checking the applicant"+e.getMessage());
			} finally {
				try {
				if(rs!=null) {
					rs.close();
				}
                                if(statement!=null) {
					statement.close();
				}
				
				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Error while checking the applicant"+ex.getMessage());
				}
			}
                }
	
		return available;
		
	}
    
}
