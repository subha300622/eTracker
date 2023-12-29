/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


package com.eminent.scheduler;

/**
 *
 * @author Tamilvelan
 */
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Job;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;

import pack.eminent.encryption.MakeConnection;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetName;
import com.eminent.timesheet.CreateTimeSheet;
import com.pack.MyAuthenticator;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class TimesheetApprovalRemainder  implements Job {
static Logger logger = null;

    static {
        logger = Logger.getLogger("TimesheetApprovalRemainder");
    }
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

    public void execute(JobExecutionContext context) throws JobExecutionException{
        Connection   connection            =   null;
        Statement    statement             =   null;
        ResultSet    dueDateExceededRS     =   null;

        try{

                String       htmlContent           =   null;
                ArrayList    al                    =   null;

                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                al=ScheduleHelper.getEminentlabsUser();

                int userSize    =   al.size();

                	//calculating start and end date of this month
                    Calendar cal = new GregorianCalendar();

                    int year = cal.get(Calendar.YEAR);
                    int month = cal.get(Calendar.MONTH);
                    int maxday=cal.getActualMaximum(cal.DAY_OF_MONTH);


                    String start="1"+"-"+monthSelect.get(month)+"-"+year;
                    String end=maxday+"-"+monthSelect.get(month)+"-"+year;

                connection  =   MakeConnection.getConnection();
                statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

                  htmlContent ="<table><tr><td></td></tr><tr><td colspan=10>Kindly update the time sheet assigned to you in your My Assignment. Please do ignore this message if already accomplished. Thank you for your cooperation. </td></tr>";
                  String endLine="</table><br>Thanks,";
                String signature="<br>eTracker&trade;<br>";
                String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak =  "<br>";

                String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                htmlContent = htmlContent+endLine+signature+htmlTableEnd+lineBreak+emi;
                for(int i=0;i<userSize;i++){


                            int userId  =   Integer.parseInt((String)al.get(i));
                            List l =CreateTimeSheet.GetTimeSheet(userId);
                            int noOfTimeSheet =   l.size();
                            if(noOfTimeSheet>0){
                            String name =   GetProjectManager.getUserFullName(userId);

                            String email = GetName.getEmail((String)al.get(i));
//Edited by sowjanya
                          MimeMessage msg= MakeConnection.getSupportMailConnections();
                          //Edit by sowjanya
                            msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs\u2122 eTracker\u2122","UTF-8"));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                            msg.addRecipient(Message.RecipientType.BCC, new InternetAddress("ttamilvelan@eminentlabs.net"));

                            msg.setSubject("Dear "+name+", Need Your Kind Attention on eTracker\u2122 Timesheet's in your MyAssignment");
                            msg.setContent(htmlContent,"text/html");

                            Transport.send(msg);
                    }

                }

        }
        catch(Exception e){
            logger.error(e.getMessage());
        }
                 finally{
            try{
                 if(dueDateExceededRS!=null) {
					dueDateExceededRS.close();
				}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                 if(statement!=null) {
					statement.close();
				}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
            try{
                if(connection!=null) {
					connection.close();
				}

            }catch(Exception ex){
                logger.error(ex.getMessage());
            }
        }

    }

}



