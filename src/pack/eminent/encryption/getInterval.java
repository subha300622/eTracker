/*
 * getInterval.java
 *
 * Created on March 9, 2007, 10:58 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package pack.eminent.encryption;

import java.util.Calendar;
public class getInterval {
	
	public static Calendar getCalendarInstance(String date){
		
		
			
			
			//getting date,month,year from the string start date
				
			    int t=date.indexOf('-');
				int last=date.lastIndexOf('-');
				
				String getDate=date.substring(0,t);
				String getMonth=date.substring((t+1), last);
				String getYear=date.substring(last+1);
				int day   = Integer.parseInt(getDate);
				int month = Integer.parseInt(getMonth);
				int year  = Integer.parseInt(getYear);
				
				Calendar calendar=Calendar.getInstance();
		   		calendar.set(year,(month-1),day);
		        
		   		return calendar;
	}
	
       public static int calculateInterval(String startDate,String endDate) {
		
		Calendar from = getCalendarInstance(startDate);
		Calendar to   = getCalendarInstance(endDate);
		
	        int interval = 1;

	   		if(from.equals(to)){
	   			
	   			interval=1;
	   		
	   		}else{
	   			do{
	   	   			from.add(Calendar.DAY_OF_MONTH,1);
	   	   		    int compare = from.get(Calendar.DAY_OF_WEEK);

	   	   			if(!((compare == 7) || (compare == 1))){
	   	   			interval+=1;
	   	   		
	   	   			}
	   	   			
	   	   		  }while(!from.equals(to));
	   		}
	   		
	   		return interval*8;
	   }
}

