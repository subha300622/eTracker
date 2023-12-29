/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.scheduler;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.apache.log4j.*;
import com.pack.MyAuthenticator;
import java.util.Properties;
import java.util.HashMap;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.text.*;
import com.eminent.util.GetDate;
import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author Tamilvelan
 */
public class CustomerUpdateMail implements Job {
       Logger logger   =   Logger.getLogger("CustomerUpdateMail");
public void execute(JobExecutionContext arg0) throws JobExecutionException{

    try{
            String projects[][]                 =    ReassignIssues.getAllActiveProjects();
            String moduleName                    =    null;
            String openIssue                     =    null;
            String totalIssue                    =    null;
            String noOfWeeklyOpenIssues          =    null;
            String noOfWeeklyWorkedIssues        =    null;
            String noOfWeeklyClosedIssues        =    null;

            SimpleDateFormat sdf    =   new SimpleDateFormat("dd-MMM-yy");
            SimpleDateFormat sdf1    =   new SimpleDateFormat("dd MMM yy");
            String today            =   sdf.format(GetDate.getDate());
            String subjectDate      =   sdf1.format(GetDate.getDate());
//          String yesterday        =   GetDate.getYesterdayDate();

            for(int i=0;i<projects.length;i++){
            HashMap<String,Integer> hm = dashboard.MaxIssue.getIssueCount(projects[i][1]);
            
            int closed          =   hm.get("closed");
            int total           =   hm.get("closed") + hm.get("altogether");
            String percentage   =   dashboard.ArithOperation.calcPercentage(total,closed);

         

            String moduleDetails[][]   =   null;
            String memberDetails[][]   =   null;

             // Getting All the Modules
            moduleDetails=ScheduleHelper.getProjectStatus(projects[i][0]);

            int noOfModules     =   moduleDetails.length;
            int k               =   0;


            String htmlContent  =   null;


            htmlContent =   "<table border=2 align=center bordercolor='#000000'>";

            htmlContent =   htmlContent+"<tr><td colspan=6 bgcolor='#01DF01' align=center><font face=Verdana, Arial, Helvetica, sans-serif size=5 color=#000000><b>Weekly Status of "+projects[i][1].replace(":", " v")+"</b></font></td></tr>"
                            +"<tr><td></td><td colspan=3 align=center><font face=Verdana, Arial, Helvetica, sans-serif size=3 color=#000000><b>Weekly</td><td colspan=2 align=center><font face=Verdana, Arial, Helvetica, sans-serif size=3 color=#000000><b>Cumulative</td></tr>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=#000000><b>Modules</b><font></td>"
                            +"<td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=#000000><b>New Issues</b><font></td>"

                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=#000000><b>Worked Issues</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=#000000><b>Closed Issues</b><font></td>"

                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=#000000><b>Total Open Issues</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=#000000><b>Total Closed Issues</b><font></td>"
                            +"<tr>"
                            +"<tr bgcolor='#E8EEF7'>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>All Modules</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+ScheduleHelper.WeeklyTotalCreatedIssue(projects[i][0])+"</b><font></td>"

                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+ScheduleHelper.WeeklyTotalWorkedIssue(projects[i][0])+"</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+ScheduleHelper.WeeklyTotalClosedIssue(projects[i][0])+"</b><font></td>"

                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+(total-closed)+"</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+closed+"</b><font></td>"
                            +"</tr>";
             while(k<noOfModules){
                 moduleName             =   moduleDetails[k][0];
                 noOfWeeklyOpenIssues   =   moduleDetails[k][1];
                 noOfWeeklyWorkedIssues =   moduleDetails[k][2];
                 noOfWeeklyClosedIssues =   moduleDetails[k][3];
                 openIssue              =   moduleDetails[k][4];
                 totalIssue             =   moduleDetails[k][5];
                 String tr  =   null;
                 if(( k % 2 ) != 0)
                 {

                         tr   =   "<tr bgcolor='white'>";
                 }
                 else
                 {


                        tr    = "<tr bgcolor='#E8EEF7'>";

                 }
                 
                 htmlContent  =   htmlContent+tr+
                            "<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+moduleName+"</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+noOfWeeklyOpenIssues+"</b><font></td>"

                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+noOfWeeklyWorkedIssues+"</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+noOfWeeklyClosedIssues+"</b><font></td>"

                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+openIssue+"</b><font></td>"
                            +"<td align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>"+totalIssue+"</b><font></td>"
                            +"</tr>";
                 k++;
             }
            String endLine="</table><br>Thanks,";
            String signature="<br>eTracker&trade;<br>";
            String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak =  "<br>";

            String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

            htmlContent = htmlContent+endLine+signature+htmlTableEnd+lineBreak+emi;

          
            memberDetails=ScheduleHelper.getProjectMembers(projects[i][0]);

            int s=0;
            while(s<memberDetails.length){
                String email=memberDetails[s][2];
                //Edited by sowjanya
               MimeMessage msg= MakeConnection.getSupportMailConnections();
               //Edit end by sowjnaya
  //              msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs™ eTracker™"));
                msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs\u2122 eTracker\u2122","UTF-8"));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
  //              msg.addRecipient(Message.RecipientType.TO, new InternetAddress("ttamilvelan@eminentlabs.net"));
 //               System.out.println("Member====>"+email+":   Project"+projects[i][1].replace(":", " v"));
                msg.setSubject("Weekly Project Status of "+projects[i][1].replace(":", " v")+" on "+subjectDate);
                msg.setContent(htmlContent,"text/html");
                Transport.send(msg);
                
                

                s++;
            }
            }

    }
    catch(Exception e){
        logger.error(e.getMessage());
    }
}
}
