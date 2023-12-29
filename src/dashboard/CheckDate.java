/*
 * CheckDate.java
 *
 * Created on February 8, 2007, 11:02 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package dashboard;

import org.apache.log4j.Logger;
//import org.apache.log4j.Level;

import java.util.*;



/**
 *
 * @author Balaguru Ramasamy
 */
public class CheckDate {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CheckDate.class);
    
    /**
     * Creates a new instance of CheckDate
     */
    public CheckDate() {
    }
    
    
        
        private static HashMap<String,Integer> hm = new HashMap<String,Integer>();
        
        static{
        
        hm.put("Jan",0);
        hm.put("Feb",1);
        hm.put("Mar",2);
        hm.put("Apr",3);
        hm.put("May",4);
        hm.put("Jun",5);
        hm.put("Jul",6);
        hm.put("Aug",7);
        hm.put("Sep",8);
        hm.put("Oct",9);
        hm.put("Nov",10);
        hm.put("Dec",11);	
        
    }
    
    public static boolean getFlag(String charDate){
        
        

//    	parsing date,month,year from the string charDate
        
 
	        int t    = charDate.indexOf('-');
		int last = charDate.lastIndexOf('-');
		
		int day    = Integer.parseInt(charDate.substring(0,t));
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - " + day);
		}
		String mon = charDate.substring((t+1), last);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Mon" + mon);
		}
                mon = mon.toLowerCase();
                String convert = String.valueOf(mon.charAt(0));
                String replace = convert;
                convert = convert.toUpperCase();
                
                mon = mon.replace(replace, convert);
                
                int  month = hm.get(mon);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Month" + month);
		}
		int year   = Integer.parseInt(charDate.substring(last+1));
                year       = year + 2000; 

		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Year" + year);
		}
                Calendar c = Calendar.getInstance();
                c.set(year,month,day);
                
                Date current = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(current);
                
                Calendar calendar = Calendar.getInstance();
                calendar.set(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH));
                
                boolean flag = calendar.after(c);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - " + flag);
		}
                
                return flag;
                
		
               
    }
    public static boolean getClosedIssueFlag(String charDate,String modifiedOnDate){



//    	parsing date,month,year from the string charDate
            boolean flag    =   false;
            if(!charDate.equalsIgnoreCase("NA") ){
	        int t    = charDate.indexOf('-');
		int last = charDate.lastIndexOf('-');

		int day    = Integer.parseInt(charDate.substring(0,t));
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - " + day);
		}
		String mon = charDate.substring((t+1), last);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Mon" + mon);
		}
                mon = mon.toLowerCase();
                String convert = String.valueOf(mon.charAt(0));
                String replace = convert;
                convert = convert.toUpperCase();

                mon = mon.replace(replace, convert);

                int  month = hm.get(mon);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Month" + month);
		}
		int year   = Integer.parseInt(charDate.substring(last+1));
                year       = year + 2000;

		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Year" + year);
		}
                Calendar c = Calendar.getInstance();
                c.set(year,month,day);

                Date current = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(current);
// manipulating modified on date if it is a closed issue
                int mt    = modifiedOnDate.indexOf('-');
		int mlast = modifiedOnDate.lastIndexOf('-');

		int mday    = Integer.parseInt(modifiedOnDate.substring(0,t));
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - " + mday);
		}
		String mmon = modifiedOnDate.substring((mt+1), mlast);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Mon" + mmon);
		}
                mmon = mmon.toLowerCase();
                String mconvert = String.valueOf(mmon.charAt(0));
                String mreplace = mconvert;
                mconvert = mconvert.toUpperCase();

                mmon = mmon.replace(mreplace, mconvert);

                int  mmonth = hm.get(mmon);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Month" + mmonth);
		}
		int myear   = Integer.parseInt(modifiedOnDate.substring(mlast+1));
                myear       = myear + 2000;

		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - Year" + myear);
		}



                

                Calendar calendar = Calendar.getInstance();
                calendar.set(myear,mmonth,mday);

                 flag = calendar.after(c);
		if (logger.isDebugEnabled()) {
			logger.debug("getFlag(String) - " + flag);
		}
 //               logger.info("Duedate-->"+charDate+"Modified-->"+modifiedOnDate+"Flag-->"+flag);
               
        }
         return flag;

    }
    
    
}
