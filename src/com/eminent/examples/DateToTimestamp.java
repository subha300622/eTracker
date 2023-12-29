/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

/**
 *
 * @author Administrator
 */


import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
public class DateToTimestamp {
   public static void main(String[] args) {
 try {    String str_date="20-Nov-2012";
          DateFormat formatter ;
          Date date ;
          formatter = new SimpleDateFormat("dd-MMM-yyyy");
              date = (Date)formatter.parse(str_date);
          java.sql.Timestamp timeStampDate = new
        Timestamp(date.getTime());
     Calendar cal = Calendar.getInstance();
     cal.setTime(date);
    
   
    } catch (ParseException e)
    {
    
    }

   }
}   