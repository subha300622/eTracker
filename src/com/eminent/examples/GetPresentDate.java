package com.eminent.examples;
import java.sql.Connection;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import org.apache.log4j.Logger;

public class GetPresentDate {
    static Logger logger      =   Logger.getLogger("GetPresentDate");
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
    public static void getDate(){
        Connection connection=null;
		Statement statement=null;
		ResultSet resultset=null;
               Calendar cal = new GregorianCalendar();
                    try{
//				connection=MakeConnection.getConnection();
				Class.forName("oracle.jdbc.driver.OracleDriver");
				connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
				statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				resultset=statement.executeQuery("SELECT FROMDATE,TODATE FROM LEAVE WHERE REQUESTEDBY=420 AND APPROVAL=1 AND (TO_DATE(TO_CHAR(FROMDATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '1-Nov-11' AND '30-Nov-11' OR TO_DATE(TO_CHAR(TODATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '1-Nov-11' AND '30-Nov-11')");
                               
				while(resultset.next()){
                                    Date date   =   cal.getTime();
					 logger.info("Start date"+resultset.getDate(1));
                                         logger.info("End date"+resultset.getDate(2));
                                        logger.info((resultset.getDate(2).getTime()-resultset.getDate(1).getTime())/(24 * 60 * 60 * 1000));
                    //        days    =   days+resultset.getInt(1);
				}


			}
			catch(Exception e){
			logger.error(e.getMessage());
			}
			finally{
				try{

				if(resultset!=null) {
					resultset.close();
				}
                                if(statement!=null) {
					statement.close();
				}
				if(connection!=null) {
					connection.close();
				}
				}
				catch(Exception ex){
					logger.error(ex.getMessage());
				}
			}
    }
    public static void main(String []args){
    //    getDate();
        int mon = 7;
        int yr  = 2014;
        SimpleDateFormat sdf;
        Date endDateinD = null;
        sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String startDate="1"+"-"+hm.get(mon)+"-"+yr;
      
        try{
           // Validation for correct month
            Calendar startCalendar = new GregorianCalendar();
         String currDate = "1"+"-"+hm.get(startCalendar.get(Calendar.MONTH))+"-"+startCalendar.get(Calendar.YEAR);
         
         
   
        String startDateaval="1"+"-"+hm.get(mon)+"-"+yr;
         startCalendar.setTime(sdf.parse(currDate));
        Calendar endCalendar = new GregorianCalendar();
        endCalendar.setTime(sdf.parse(startDateaval));
         int diffYear = startCalendar.get(Calendar.YEAR) - endCalendar.get(Calendar.YEAR);
        int diffMonth = diffYear * 12 + startCalendar.get(Calendar.MONTH) - endCalendar.get(Calendar.MONTH);
        if(diffMonth<3){
                 startDate="1"+"-"+hm.get(mon-(3-diffMonth))+"-"+yr;
         
        }
        //end of Validation for correct month
        }catch(Exception e){
            
        }
        
        
        
        Calendar cale=Calendar.getInstance();
             cale.set(yr, mon, 1);
            int mday = cale.getActualMaximum(Calendar.DATE);

                
            String endDate=mday+"-"+hm.get(9)+"-"+yr;
        
        
        
        try{
          endDateinD=sdf.parse(endDate);
        }catch(Exception e){
            logger.error(e.getMessage());
        }
        cale.setTime(endDateinD);
        cale.add(Calendar.MONTH, -3);
        int monthq1 = cale.get(Calendar.MONTH);
        int maxdaya=cale.get(Calendar.DAY_OF_MONTH);
        int yeara  = cale.get(Calendar.YEAR);
        String startDatea="1"+"-"+hm.get(monthq1)+"-"+yeara;
        String endDatea=maxdaya+"-"+hm.get(monthq1)+"-"+yeara;
        
         
        logger.info("Start Date  :"+startDate);
        logger.info("End Date    :"+endDate);
        
        
        
        
    	Calendar cal = new GregorianCalendar();
        //        int era = cal.get(Calendar.ERA);               
        int year = cal.get(Calendar.YEAR);             
        int month = cal.get(Calendar.MONTH);         
//        int day = cal.get(Calendar.DAY_OF_MONTH);      
 //       int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); 
        int maxday=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        

        String start="1"+"-"+hm.get(month)+"-"+year;
        String end=maxday+"-"+hm.get(month)+"-"+year;



        cal.add(Calendar.MONTH, -1);
        month = cal.get(Calendar.MONTH);      

    	
    }
    


}
