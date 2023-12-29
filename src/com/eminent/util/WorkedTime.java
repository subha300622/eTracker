/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.util;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;
import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author Administrator
 */
public class WorkedTime {
static Logger logger = Logger.getLogger("Worked Time");
public static int getHoldingTime(String issueId, String userId ,String selectedDate,String lastSelectedDate) throws Exception{
                logger.info("Start Calculate Timing......");
                Connection connection   =   null;
		Statement stForComments = null, st = null, stForInterval = null, stForCreatedon = null, stForAssignedTo = null, stForSysdate = null;
		Statement stForFlag = null;
                ResultSet rs = null, rsForComments = null, rsForInterval = null, rsForCreatedon = null, rsForAssignedTo = null, rsForSysdate = null;
		ResultSet rsForFlag = null;
                int holdingTime = 0;
		int rowCount = 0;
                String createdOn = null;

                String interval = null;
                int currentUser = Integer.parseInt(userId);
                String retDate = null;
		String toDate = null;
		logger.setLevel(Level.ERROR);

                int exclude = 0;

                String myFormatString = "dd-MM-yyyy";
                SimpleDateFormat df = new SimpleDateFormat(myFormatString);
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
 
                Date fDate =df.parse(selectedDate.substring(0,selectedDate.indexOf(" ")));
                Date lDate =df.parse(lastSelectedDate.substring(0,selectedDate.indexOf(" ")));
                
                String firstDate =sdf.format(fDate);
                String lastDate =sdf.format(lDate);




                // Retrieving all the comments and total number of counts for this issue id
		String queryForComments = "select commentedby, commentedto, to_char(comment_date, 'dd-mm-yy hh24:mi:ss') as commentdate, comment_date from issuecomments where comment_date between '"+firstDate+"' and '"+lastDate+"'and issueid = '"+issueId+"' order by comment_date asc";
                String query = "select count(*) as rowcount from issuecomments where issueid = '"+issueId+"' and comment_date between '"+firstDate+"' and '"+lastDate+"'";
		String queryForInterval = null;
		try{

                    //Retrieving the current month and year
                    connection =    MakeConnection.getConnection();
                  
                    stForFlag = connection.createStatement();
                  
                    
                    
                    // Counting the total number of rows in comment history
                    st = connection.createStatement();
                    rs = st.executeQuery(query);
                    if(rs.next()){
                        rowCount = rs.getInt("rowcount");

                    } else {
                        rowCount = 0;
                    }
 //                   logger.info("Query"+queryForComments);

                    logger.info("Row Count"+rowCount);
                    /* If there is only one row then we can calculate the interval directly checking only one condition
                     Who is holding the issue currently?. If the same person holds the we can use sysdate and created date to calculate the interval
                     If he doesn't hold, we should use created date and comment date to calculate the interval */
                    if(rowCount == 1) {
                        String queryForcreatedon = "select to_char(createdon, 'dd-mm-yy hh24:mi:ss') as createdon from issue where issueid = '"+issueId+"'";
                        stForCreatedon = connection.createStatement();
                        rsForCreatedon = stForCreatedon.executeQuery(queryForcreatedon);
                        if (rsForCreatedon.next()) {
                            createdOn = rsForCreatedon.getString("createdon");
                        }

                        logger.info("Original Created On"+createdOn);

                        //If created on is not in the current month, we should reset the created on to first day of the current month
                        String queryForFlag = "select (to_date('"+createdOn+"','dd-mm-yy hh24:mi:ss') - to_date('"+selectedDate+"','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                            rsForFlag = stForFlag.executeQuery(queryForFlag);
                            if(rsForFlag.next()) {
                                retDate = rsForFlag.getString("flag");
                                retDate = retDate.substring(0, 1);
  //                              logger.info("Flag of Created On"+retDate);
                            }
                            if(retDate.equalsIgnoreCase("-")) {
                                createdOn = selectedDate;
                            }

                            if(rsForFlag != null) {
                                rsForFlag.close();
                            }
                            if(stForFlag != null) {
                                stForFlag.close();
                            }
                        logger.info("Changed Created On"+createdOn);
                        // Finding the current assigned person
                        stForAssignedTo = connection.createStatement();
                        rsForAssignedTo = stForAssignedTo.executeQuery("select assignedto from issue where issueid = '"+issueId+"'");
                        int assignedTo = 0;
                        if(rsForAssignedTo.next()){
                            assignedTo = rsForAssignedTo.getInt("assignedto");
                        }
                        if(currentUser == assignedTo) {

                            queryForInterval = "select (to_date('"+lastSelectedDate+"','dd-mm-yy hh24:mi:ss')- to_date('"+createdOn+"','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                            exclude = getExcludeTime(createdOn, lastSelectedDate);
                              logger.info("Exclude Start1"+createdOn);
                              logger.info("Exclude End1"+lastSelectedDate);
                        } else {
                            stForComments = connection.createStatement();
                            rsForComments = stForComments.executeQuery(queryForComments);
                            String commentDate = null;
                            if(rsForComments.next()) {
                                commentDate = rsForComments.getString("commentdate");
                            }

                            queryForInterval = "select ( to_date('"+commentDate+"','dd-mm-yy hh24:mi:ss')- to_date('"+createdOn+"','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                            exclude = getExcludeTime(createdOn, commentDate);
                        }
   //                     logger.info("Query for Interval"+queryForInterval);
                        stForInterval = connection.createStatement();
                        rsForInterval = stForInterval.executeQuery(queryForInterval);
                        if(rsForInterval.next()){
                            Long duration = rsForInterval.getLong("interval");
                            interval = duration.toString();

                        }
                      
//                        logger.info("interval1  : "+interval);
                        if( Integer.parseInt(interval) != 0) {
                            holdingTime = Integer.parseInt(interval) - exclude;
                        } else {
                            holdingTime = Integer.parseInt(interval);
                        }

                    } else if(rowCount > 1){
                        // Finding the transition rows
                        String commentedTo = null;
                        int start = 0;
                        boolean begin = false;
                        boolean end = false;
                        int assignedTo = 0;
                        ArrayList<Integer> al = new ArrayList<Integer>();
                       
                        stForComments = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rsForComments = stForComments.executeQuery(queryForComments);
                       
                        for (int i = 1; i <= rowCount; i++) {
                            rsForComments.absolute(i);
                            commentedTo = rsForComments.getString("commentedto");
                            if(commentedTo.equalsIgnoreCase("Nil")) {
                                rsForComments.absolute(i+1);
                                commentedTo = rsForComments.getString("commentedby");
                                assignedTo = Integer.parseInt(commentedTo);
                            } else {
                                assignedTo = Integer.parseInt(commentedTo);
                            }

                            if(currentUser == assignedTo){
                                start++;
                                if(start == 1 || end == true) {
                                    al.add(i);
                                    begin = true;
                                }
                            } else if ( begin == true) {
                                    al.add(i);
                                    end = true;
                                    begin = false;
                                    start = 0;
                            }

                        }
                     
                        // Calculating the interval
                        String startDate = null, endDate = null;
                        int addInterval = 0;
                        boolean still = false;

                        logger.info("Array List"+al);
                        int limit = al.size();


                        if(al.size() % 2 != 0){
                            limit = limit - 1;
                            still = true;
                        }
                        for(int j = 0; j < limit; j += 2) {
                            rsForComments.absolute(al.get(j));
                            startDate = rsForComments.getString("commentdate");
    //                        logger.info(" Start Date"+startDate);
                            //If comment date is not in the current month, we should reset the comment date to first day of the current month for both start date and end date
                            String queryForFlag = "select (to_date('"+startDate+"','dd-mm-yy hh24:mi:ss') - to_date('"+selectedDate+"','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
   //                         logger.info("Query for Flg"+queryForFlag);
                            rsForFlag = stForFlag.executeQuery(queryForFlag);
                            if(rsForFlag.next()) {
                                retDate = rsForFlag.getString("flag");
                                retDate = retDate.substring(0, 1);
                            }
                            if(retDate.equalsIgnoreCase("-")) {
                                startDate = selectedDate;
                            }
                            if(rsForFlag != null) {
                                rsForFlag.close();
                            }
                            rsForComments.absolute(al.get((j+1)));
                            endDate = rsForComments.getString("commentdate");
                            queryForFlag = "select (to_date('"+endDate+"','dd-mm-yy hh24:mi:ss') - to_date('"+selectedDate+"','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                            rsForFlag = stForFlag.executeQuery(queryForFlag);
                            if(rsForFlag.next()) {
                                retDate = rsForFlag.getString("flag");
                                retDate = retDate.substring(0, 1);
                            }
                           logger.info("End Date"+endDate);
                            Date date1 = df.parse(selectedDate);
                            Date date2 = df.parse(endDate);


                            if(retDate.equalsIgnoreCase("-")) {
                                endDate = selectedDate;
                            }else if(date2.after(date1)){
                                 endDate = selectedDate;
                            }
                            if(rsForFlag != null) {
                                rsForFlag.close();
                            }
                            queryForInterval = "select ( to_date('"+endDate+"','dd-mm-yy hh24:mi:ss')- to_date('"+startDate+"','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                            
                            stForInterval = connection.createStatement();
                            rsForInterval = stForInterval.executeQuery(queryForInterval);
                            if(rsForInterval.next()){
                                Long duration = rsForInterval.getLong("interval");
                                    interval =duration.toString();
    //                                logger.info("interval  : "+interval);
                                if( Integer.parseInt(interval) != 0) {
                                    logger.info("Exclude Start Date2"+startDate);
                                    logger.info("Exclude End Date2"+endDate);
                                    exclude = getExcludeTime(startDate, endDate);
                                    addInterval = addInterval + Integer.parseInt(interval) - exclude;
                                } else {
                                    addInterval = addInterval + Integer.parseInt(interval);
                                }
                                if(rsForInterval != null) {
                                    rsForInterval.close();
                                }
                                if(stForInterval != null) {
                                    stForInterval.close();
                                }
                        }

                        }

                        if(still == true){

                            Statement stStatus = connection.createStatement();
                            ResultSet rsStatus = stStatus.executeQuery("select status from issuestatus where issueid = '"+issueId+"'");
                            String status = null;
                            if(rsStatus.next()) {
                                status = rsStatus.getString("status");
                            }

                            if(rsStatus != null)
				rsStatus.close();

                            if(stStatus != null)
				stStatus.close();


                            //Checking whether all the comments are for only the current user

                            boolean all = false;
                            Statement stAll = connection.createStatement();
                            ResultSet rsAll = stAll.executeQuery("select count(*) AS count from issuecomments where issueid = '"+issueId+"' and commentedto != '"+userId+"'");
                            if(rsAll.next()){
                                int get = rsAll.getInt("count");
                                if(get == 0) {
                                    all = true;
                                }
                            }

                            // Deciding the start date, if all the comments are only for the current user, assign start date as created on date. Or else start date should be from oone of comment date
                            if(all == true) {
                                String queryForcreatedon = "select to_char(createdon, 'dd-mm-yy hh24:mi:ss') as createdon from issue where issueid = '"+issueId+"'";
                                stForCreatedon = connection.createStatement();
                                rsForCreatedon = stForCreatedon.executeQuery(queryForcreatedon);
                                if (rsForCreatedon.next()) {
                                    startDate = rsForCreatedon.getString("createdon");
                                }

                                //If created on is not in the current month, we should reset the created on to first day of the current month
                                String queryForFlag = "select (to_date('"+startDate+"','dd-mm-yy hh24:mi:ss') - to_date('"+lastSelectedDate+"','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                                rsForFlag = stForFlag.executeQuery(queryForFlag);
                                if(rsForFlag.next()) {
                                    retDate = rsForFlag.getString("flag");
                                    retDate = retDate.substring(0, 1);
                                }
                                if(retDate.equalsIgnoreCase("-")) {
                                    startDate = selectedDate;
                                }

                                if(rsForFlag != null) {
                                    rsForFlag.close();
                                }
                                if(stForFlag != null) {
                                    stForFlag.close();
                                }
                             } else {

                                int lastIndex = al.size() - 1;
                                rsForComments.absolute(al.get(lastIndex));
                                startDate = rsForComments.getString("commentdate");
                                logger.info("flag start date"+startDate);
                                //If comment date is in the current month, we should reset the comment date on to first day of the current month for both start date and end date
                                String queryForFlag = "select (to_date('"+startDate+"','dd-mm-yy hh24:mi:ss') - to_date('"+lastSelectedDate+"','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                                
                                rsForFlag = stForFlag.executeQuery(queryForFlag);
                                if(rsForFlag.next()) {
                                    retDate = rsForFlag.getString("flag");
                                    retDate = retDate.substring(0, 1);
                                }
                                if(retDate.equalsIgnoreCase("-")) {
                                    startDate = selectedDate;
                                }

                                //Closing resultset and statement
                                if(rsForFlag != null) {
                                    rsForFlag.close();
                                }
                                if(stForFlag != null) {
                                    stForFlag.close();
                                }

                                }

                                //Checking whether this issue has already been closed or not
                                exclude = 0;
                                if(!status.equalsIgnoreCase("Closed")){
                                    
                                    queryForInterval = "select (to_date('"+lastSelectedDate+"','dd-mm-yy hh24:mi:ss') - to_date('"+startDate+"','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                                   exclude = getExcludeTime(startDate, lastSelectedDate);
//                                     logger.info("Exclude Start3"+startDate);
//                                    logger.info("Exclude End3"+lastSelectedDate);
                                } else {
                                    rsForComments.last();
                                    String closeCommentDate = rsForComments.getString("commentdate");
                                    queryForInterval = "select (to_date('"+closeCommentDate+"','dd-mm-yy hh24:mi:ss') - to_date('"+startDate+"','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                                    exclude = getExcludeTime(startDate, closeCommentDate);
                                     logger.info("Exclude Start4"+startDate);
                                     logger.info("Exclude End4"+closeCommentDate);
                                }
                               logger.info("queryForInterval"+queryForInterval);
                                stForInterval = connection.createStatement();
                                rsForInterval = stForInterval.executeQuery(queryForInterval);
                                if(rsForInterval.next()){
                                Long duration = rsForInterval.getLong("interval");
                                interval = duration.toString();
                                logger.info("interval  : "+interval);
                                logger.info("Exclude  : "+exclude);
                                if( Integer.parseInt(interval) != 0) {
                                    addInterval = addInterval + Integer.parseInt(interval) - exclude;
                                } else {
                                    addInterval = addInterval + Integer.parseInt(interval);
                                }
                            }
                        }


                        holdingTime = addInterval;

                    } else {
                        interval = "1";
                    }





		}
		catch(Exception e){
			logger.error("Error while calculating the time"+ e.getMessage());
		}
		finally{
			if(rs != null)
				rs.close();

                        if(rsForAssignedTo != null)
				rsForAssignedTo.close();
			if(rsForComments != null)
				rsForComments.close();
			if(rsForCreatedon != null)
				rsForCreatedon.close();
                        if(rsForInterval != null)
				rsForInterval.close();
                        if(st != null)
				st.close();
                        if(stForAssignedTo != null)
				stForAssignedTo.close();
                        if(stForComments != null)
				stForComments.close();
                        if(stForCreatedon != null)
				stForCreatedon.close();
                        if(stForInterval != null)
				stForInterval.close();
                        if(connection != null)
                                connection.close();
		}
                if(holdingTime == -1 || holdingTime == -2) {
                    holdingTime = 0;
                }
                logger.info("Caluculation completed....");
		return holdingTime;
	}

        public static int getExcludeTime(String start, String end) {

         int exclude =0;
        logger.info("Start"+start);
        logger.info("End"+end);
        try{
        Calendar c = Calendar.getInstance();
        Calendar d = Calendar.getInstance();

        int startYear = Integer.parseInt(start.substring((start.lastIndexOf("-")+1), start.indexOf(" ")));
        int startMonth = Integer.parseInt(start.substring((start.indexOf("-")+1), start.lastIndexOf("-")))-1;
        int startDay = Integer.parseInt(start.substring(0, start.indexOf("-")));
        int startHour = Integer.parseInt(start.substring((start.indexOf(":")-2), start.indexOf(":")));
        int startMin = Integer.parseInt(start.substring((start.lastIndexOf(":")-2), start.lastIndexOf(":")));
        int startSec = Integer.parseInt(start.substring((start.lastIndexOf(":")+1), (start.lastIndexOf(":")+3)));
        int startHourSec = (startHour*3600) + (startMin*60) +(startSec);

        if(startYear<2000){
            startYear=startYear+2000;
        }

        c.set(startYear, startMonth, startDay);

        int endYear = Integer.parseInt(end.substring((end.lastIndexOf("-")+1),end.indexOf(" ")));
        int endMonth = Integer.parseInt(end.substring((end.indexOf("-")+1),end.lastIndexOf("-")))-1;
        int endDay = Integer.parseInt(end.substring(0,end.indexOf("-")));
        int endHour = Integer.parseInt(end.substring((end.indexOf(":")-2), end.indexOf(":")));
        int endMin = Integer.parseInt(end.substring((end.lastIndexOf(":")-2), end.lastIndexOf(":")));
        int endSec = Integer.parseInt(end.substring((end.lastIndexOf(":")+1), (end.lastIndexOf(":")+3)));
        int endHourSec = (endHour*3600) + (endMin*60) +(endSec);

        if(endYear<2000){
            endYear=endYear+2000;
        }

        d.set(endYear, endMonth, endDay);

       
        int startOffset = 0;
        int endOffset = 0;

        if(c.get(Calendar.DAY_OF_WEEK) != 1 && c.get(Calendar.DAY_OF_WEEK) != 7) {
            if(startHourSec < 64800 & startHourSec >= 50400) {
                startOffset = 10;
            } else if(startHourSec >= 32400 & startHourSec <= 46800) {
                startOffset = 9 ;
            } else if(startHourSec >= 64800) {
                startOffset = 10 + (startHour - 18);
            } else if(startHourSec < 32400) {
                startOffset = startHour;
            } else if (startHourSec > 46800 & startHourSec < 50400 ) {
                startOffset = 9;
            }
        } else {
            startOffset = startHour;
        }


        if(d.get(Calendar.DAY_OF_WEEK) != 1 && d.get(Calendar.DAY_OF_WEEK) != 7) {
            if(endHourSec < 64800 & endHourSec >= 50400) {
                endOffset = 6 ;
            } else if(endHourSec >= 32400 & endHourSec <= 46800) {
                endOffset = 7 ;
            } else if(endHourSec >= 64800) {
                endOffset = 24 - endHour ;
            } else if(endHourSec < 32400) {
                endOffset = 16 - endHour;
            } else if (endHourSec > 46800 & endHourSec < 50400 ) {
                endOffset = 6;
            }
        } else {
            endOffset = 24 - endHour;
        }

        int holidays = 0;
        int totalDays = 1;
        if(!c.equals(d)) {

                if(c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
                    holidays ++;
                }
             do{
               c.add(Calendar.DAY_OF_MONTH, 1);
                if(c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
                    holidays ++;
                }
                totalDays++;
             }while (!c.equals(d));
        } else if ( c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
            holidays = 1;
        }
/*
        logger.info("Holidays"+holidays);
        logger.info("Total days"+totalDays);
        logger.info("Start Offset"+startOffset);
        logger.info("End Offset"+endOffset);
  */
        exclude = ( holidays * 24 ) + ((totalDays-holidays)*16) - startOffset - endOffset;
        logger.info("Exclude"+exclude);
        }
        catch(Exception e){
            logger.error(e.getMessage());
        }
        return exclude;

        }


}
