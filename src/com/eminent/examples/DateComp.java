package com.eminent.examples;


import com.eminent.util.DateIterator;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author vanithaalliraj
 */
public class DateComp {
    
    public static void main(String[] args) throws Exception{
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

                int noofweek = 0, curryear = 0;
 Calendar now = Calendar.getInstance();
            Date start = sdf.parse("01-Dec-2020");
            Date end = sdf.parse("31-Dec-2020");
         Iterator<Date> dateslist = new DateIterator(start, end);
            noofweek = 0;
            curryear = 0;
            while (dateslist.hasNext()) {
                Date oneOfDate = dateslist.next();
                now.setTime(oneOfDate);
                noofweek = now.get(Calendar.WEEK_OF_YEAR);
                now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
                now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
                curryear = now.get(Calendar.YEAR);
                System.out.println(noofweek + "/" + curryear + "&&&" + dateRangeByWeekNumberAndYear(curryear, noofweek));            }
    }
     public static String dateRangeByWeekNumberAndYear(int year, int week) {
        String date = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            Calendar now = Calendar.getInstance();
            now.set(Calendar.YEAR, year);
            now.set(Calendar.WEEK_OF_YEAR, week);
            now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            Date yourDate = now.getTime();
            now.setTime(yourDate);//Set specific Date of which start and end you want
            date = sdf.format(now.getTime());//Date of Monday of current week
            now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
            now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            date = date + " to " + sdf.format(now.getTime());//Date of Sunday of current week
        } catch (Exception e) {
            date = "";
        }
        return date;
    }
    
}
