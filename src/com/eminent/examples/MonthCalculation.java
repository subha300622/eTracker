
package com.eminent.examples;
import java.util.*;

/**
 *
 * @author Administrator
 */
public class MonthCalculation {
    private static HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();

	    static{

	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");

	}
    public static void main(String[] args){
        Calendar c=new GregorianCalendar();
        int month= c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        c.add(Calendar.MONTH,-1);

        
/*
        int setMonth =month-11;
        c.add(Calendar.MONTH, -11);

        for(int i=0;i<11;i++){
        month= c.get(Calendar.MONTH);
        year = c.get(Calendar.YEAR);
        c.add(Calendar.MONTH,1);
        System.out.println("Changed Month>>>>"+monthSelect.get(month)+"-"+year);
  */
        }


   

}
