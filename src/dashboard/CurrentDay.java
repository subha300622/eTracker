/*
 * CurrentDay.java
 *
 * Created on March 24, 2007, 5:42 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package dashboard;
import java.util.*;
import java.text.*;

/**
 *
 * @author ganesh
 */
public class CurrentDay {
    
    /**
     * Creates a new instance of CurrentDay
     */
    public CurrentDay() {
    }
    
    public static ArrayList<String> getDateTime(){
        
        java.util.Date date = new java.util.Date(); 
                                                
        Calendar c = Calendar.getInstance();
        c.setTime(date);
                                                
        int hour   = c.get(Calendar.HOUR_OF_DAY);
        int minute = c.get(Calendar.MINUTE);
        int second = c.get(Calendar.SECOND);
                                                
         String mts = (new Integer(minute)).toString();
                                                         
          if(mts.length() == 0){
                                                    
              mts = "00";
                                                    
          }else if(mts.length() == 1){
                                                    
              mts = "0"+mts;
                                                    
          }
         String sec = (new Integer(second)).toString();
         if(sec.length() == 0){
                                                    
              sec = "00";
                                                    
          }else if(sec.length() == 1){
                                                    
              sec = "0" + sec;
                                                    
          }
                                                
          String time = ((new Integer(hour)).toString()) +":"+ ((new Integer(minute)).toString())+":"+ ((new Integer(second)).toString());
                                                
          SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yy");
          String updatedOn    = df.format(date);
          
          ArrayList<String> al = new ArrayList<String>();
          al.add(updatedOn);
          al.add(time);
//          System.err.println(al.toString());
          return al;
    }
    
    
}
