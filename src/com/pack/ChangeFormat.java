/*
 * ChangeFormat.java
 *
 * Created on February 6, 2007, 5:48 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.pack;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import java.util.HashMap;

/**
 *
 * @author sprakash
 */
public class ChangeFormat {

    static Logger logger = Logger.getLogger("ChangeFormat");

    /**
     * Creates a new instance of ChangeFormat
     */
    public ChangeFormat() {
        logger.setLevel(Level.DEBUG);
    }
    private static HashMap<Integer, String> hm = new HashMap<Integer, String>();
    private static HashMap<String, Integer> Mon = new HashMap<String, Integer>();

    static {

        hm.put(1, "Jan");
        hm.put(2, "Feb");
        hm.put(3, "Mar");
        hm.put(4, "Apr");
        hm.put(5, "May");
        hm.put(6, "Jun");
        hm.put(7, "Jul");
        hm.put(8, "Aug");
        hm.put(9, "Sep");
        hm.put(10, "Oct");
        hm.put(11, "Nov");
        hm.put(12, "Dec");

    }

    static {

        Mon.put("Jan", 1);
        Mon.put("Feb", 2);
        Mon.put("Mar", 3);
        Mon.put("Apr", 4);
        Mon.put("May", 5);
        Mon.put("Jun", 6);
        Mon.put("Jul", 7);
        Mon.put("Aug", 8);
        Mon.put("Sep", 9);
        Mon.put("Oct", 10);
        Mon.put("Nov", 11);
        Mon.put("Dec", 12);

    }

    public static String getDateFormat(String date) throws Exception {
                  //try
        //{
        logger.info("Date from Page" + date);
        String day = null;
        String mon = null;
        String year = null;
        String ret = null;
        int first = date.indexOf("-");
        int last = date.lastIndexOf("-");
        day = date.substring(0, first);
        mon = date.substring(first + 1, last);
        year = date.substring(last + 1, last + 5);
        if (Integer.parseInt(day) < 10) {
            day = "0" + Integer.parseInt(day);
        }
        if (Integer.parseInt(mon) < 10) {
            mon = "0" + Integer.parseInt(mon);
        }
        logger.debug("Date obtained:" + day + mon + year);

        ret = year + "-" + mon + "-" + day;
        logger.info("Date printed" + ret);
                  //}catch(Exception e)
        //{
        //  logger.error("error in changeformat");
        //}
        return ret;
    }

    public static String changeDateFormat(String date) throws Exception {
       
            //try
        //{
        String day = null;
        String mon = null;
        String year = null;
        String ret = null;
        int first = date.indexOf("-");
        int last = date.lastIndexOf("-");
        day = date.substring(0, first);
        mon = hm.get(Integer.parseInt(date.substring(first + 1, last)));
        year = date.substring(last + 1, last + 5);
        logger.debug("Date obtained:" + day + mon + year);
        logger.info("Date printed" + year + mon + day);
        ret = day + "-" + mon + "-" + year;

                  //}catch(Exception e)
        //{
        //  logger.error("error in changeformat");
        //}
        return ret;
    }

    public static String getDate(String date) throws Exception {
                  //try
        //{
        String day = null;
        String mon = null;
        String year = null;
        String ret = null;
        int first = date.indexOf("/");
        int last = date.lastIndexOf("/");
        mon = date.substring(0, first);
        day = date.substring(first + 1, last);
        year = date.substring(last + 1, last + 5);
        logger.debug("Date obtained:" + day + mon + year);
        logger.info("Date printed" + year + mon + day);
        ret = day + "-" + mon + "-" + year;

                  //}catch(Exception e)
        //{
        //  logger.error("error in changeformat");
        //}
        return ret;
    }

    public static String getNumberDate(String date) throws Exception {
                  //try
        //{
        String day = null;
        int mon;
        String year = null;
        String ret = null;
        int first = date.indexOf("-");
        int last = date.lastIndexOf("-");
        day = date.substring(0, first);
        String monthValue = date.substring(first + 1, last);
        mon = Mon.get(monthValue);
        year = date.substring(last + 1, date.length());
        logger.debug("Date obtained:" + day + mon + year);
        logger.info("Date printed" + year + mon + day);
        ret = day + "-" + mon + "-" + (2010 + year);

                  //}catch(Exception e)
        //{
        //  logger.error("error in changeformat");
        //}
        return ret;
    }
}
