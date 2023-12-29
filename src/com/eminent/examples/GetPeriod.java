/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.Timestamp;
/**
 *
 * @author Administrator
 */
public class GetPeriod {
    public static void main(String[] args){
        String issueId ="R092009112";
         if(issueId.startsWith("E")){
                }else if(issueId.startsWith("R")){
                }
                else{
                }

        String timeSheetId ="T092009112";
        String year = timeSheetId.substring(3,7);
        String month = timeSheetId.substring(1,3);
        String userId= timeSheetId.substring(7,10);
//        String textMonth=monthSelect.get(Integer.parseInt(month));
        String period=month+" "+year;
        Timestamp ts=new Timestamp(new java.util.Date().getTime());
        String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(ts);

        period   =   "11-2009*12-2011";
                    String    start   =   period.substring(0, period.indexOf('*'));
                    String     end     =   period.substring(period.indexOf('*')+1,period.length() );
                     String   startMonth  =   start.substring(0, start.indexOf('-'));
                    String    endMonth  =   end.substring(0, end.indexOf('-'));

                    String    startYear  =   start.substring(start.indexOf('-')+1, start.length());
                    String    endYear  =   end.substring(end.indexOf('-')+1, end.length());
                       
    }


}
