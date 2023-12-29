/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.scheduler;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import java.util.ArrayList;
import com.pack.MyAuthenticator;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.text.*;
import com.eminent.util.GetDate;
import com.eminent.util.GetName;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;


/**
 *
 * @author Tamilvelan
 */
public class NotUpdatedMail implements Job{
static Logger logger = null;

    static {
        logger = Logger.getLogger("NotUpdatedMail");
    }
    public void execute(JobExecutionContext arg0) throws JobExecutionException{
         try{
             
                String htmlContent          =   null;

                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                 String today=GetDate.getStringDate();


                ArrayList al   = ScheduleHelper.getNonCommentedUser();


                int noOfUser    =   al.size();

                if(noOfUser>0){
                for(int i=0;i<noOfUser;i++){

               
                    if(ScheduleHelper.getAssignmentCount((String)al.get(i))>0){
                    htmlContent ="<table><tr><td colspan=10><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>Kindly note that you haven't updated any issues(MyIssues or MyAssignments) in eTracker&trade; today ("+today+")</font></td></tr>";
                   



                    
                            String endLine="</table><br>Thanks,";
                            String signature="<br>eTracker&trade;<br>";
                            String emi      =   "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                            String lineBreak =  "<br>";

                            String htmlTableEnd="<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                            htmlContent = htmlContent+endLine+signature+htmlTableEnd+lineBreak+emi;
                           

                            String userName = GetName.getFirstName((String)al.get(i));
//Edited by sowjanya
                           MimeMessage msg= MakeConnection.getSupportMailConnections();
                           //Edit end by sowjanya

                            msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs\u2122 eTracker\u2122","UTF-8"));
 //                           msg.addRecipient(Message.RecipientType.BCC, new InternetAddress("ttamilvelan@eminentlabs.net"));
                            msg.addRecipient(Message.RecipientType.BCC, new InternetAddress("tgopal@eminentlabs.net"));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress((String)al.get(i)));
//                          msg.addRecipient(Message.RecipientType.TO, new InternetAddress((String)al.get(i)));
                            msg.setSubject("Dear "+userName+", Need Your Kind Attention on eTracker\u2122 MyAssignment Issues","UTF-8");
                            msg.setContent(htmlContent,"text/html");
                            Transport.send(msg);

                }else{
                }
                }
                }
                
         }
         catch(Exception e){
             logger.error(e.getMessage());
         }
    }


}
