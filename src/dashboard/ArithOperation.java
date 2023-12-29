/*
 * ArithOperation.java
 *
 * Created on February 8, 2007, 10:57 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package dashboard;
import java.text.DecimalFormat;
import java.text.NumberFormat;

/**
 *
 * @author ganesh
 */
public class ArithOperation {
    
    /** Creates a new instance of ArithOperation */
    public ArithOperation() {
    }
    
    
    public static String calcPercentage(int total,int closed){
        String percentage = null;
       if(total != 0){
        
        float percent = (float)closed/total*100;
        
        NumberFormat nf = new DecimalFormat("#.##");
        
        percentage = nf.format(percent);
        
        return percentage;
      }else{
           
        percentage = "N/A";
           
      }
         return percentage;      
    }
    public static String calcPercentagewithCeil(int total,int closed){
        String percentage = null;
       if(total != 0){
        
        double percent = (double)closed/total*100;
        percent=Math.ceil(percent);
        
        NumberFormat nf = new DecimalFormat("#.##");
        
        percentage = nf.format(percent);
        
        return percentage;
      }else{
           
        percentage = "N/A";
           
      }
         return percentage;      
    }
    public static String calcPercentagewithDecimal(float total,float closed){
        String percentage = null;
       if(total != 0){
        
        double percent = (double)closed/total*100;
        
        NumberFormat nf = new DecimalFormat("#.##");
        
        percentage = nf.format(percent);
        
        return percentage;
      }else{
           
        percentage = "N/A";
           
      }
         return percentage;      
    }
    
}
