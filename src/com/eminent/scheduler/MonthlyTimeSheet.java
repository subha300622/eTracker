/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.scheduler;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Job;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;

import pack.eminent.encryption.MakeConnection;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetName;
import dashboard.CheckDate;
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
public class MonthlyTimeSheet implements Job {
static Logger logger = null;

    static {
        logger = Logger.getLogger("MonthlyTimeSheet");
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

                for(int i=0;i<userSize;i++){

                    int rowcolor    =   0;
                    dueDateExceededRS=statement.executeQuery("select distinct issuecomments.issueid,pname as project, issue.priority,issue.severity,s.status,modifiedon,subject,createdby,assignedto,issue.due_date,createdon,type from issuecomments,issue,issuestatus s,project p where issue.issueid=issuecomments.issueid and issue.pid = p.pid and issue.issueid=s.issueid and to_date(comment_date, 'DD-Mon-YY') between '"+start+"' and '"+end+"' and commentedto='"+(String)al.get(i)+"'and commentedby='"+(String)al.get(i)+"' order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc");

                    dueDateExceededRS.last();
                    int rowcount =dueDateExceededRS.getRow();
                    dueDateExceededRS.beforeFirst();
                    int userId  =   Integer.parseInt((String)al.get(i));
                    String name =   GetProjectManager.getUserFullName(userId);
                    htmlContent ="<table><tr><td colspan=10> <font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>This list shows "+rowcount+" issue(s) worked by "+name+" for the month of "+monthSelect.get(month)+"  "+year+". <font></td></tr>";
                    htmlContent=htmlContent+"<TR bgcolor='#C3D9FF'><TD width='1%' TITLE='Severity'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>S</b></font></TD>"
                            +"<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Issue No</b></font></TD>"
                            +"<TD width=3% TITLE='Priority'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>P</b></font></TD>"
                            +"<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Project</b></font></TD>"
                            +"<TD width=29%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Subject</b></font></TD>"
                            +"<TD width=9%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Status</b></font></TD>"
                            +"<TD width=8%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>DueDate</b></font></TD>"
                            +"<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>CreatedBy</b></font></TD>"
                            +"<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>AssignedTo</b></font></TD>"
                            +"<TD width=4% TITLE='In Days' ALIGN='CENTER'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Age</b></font></TD></TR>";

                    while(dueDateExceededRS.next()){


                            String issueId 		 = dueDateExceededRS.getString("issueid");
                            String project1	 = dueDateExceededRS.getString("project");
                            String sub		 = dueDateExceededRS.getString("subject");
                            String sev		 = dueDateExceededRS.getString("severity");
                            String priority      = dueDateExceededRS.getString("priority");
                            int assigned      =  dueDateExceededRS.getInt("assignedto");
                            String p = "NA";
                            if(priority != null){
                                p = priority.substring(0,2);
                            }

                            String type          = dueDateExceededRS.getString("type");

                            Date dueDateFormat	 = dueDateExceededRS.getDate("due_date");

                            String dueDate = "NA";
                            if(dueDateFormat != null){
                                dueDate = sdf.format(dueDateFormat);
                            }

                            int typ		= dueDateExceededRS.getInt("createdby");
                            String createdBy    = GetProjectManager.getUserName(typ);

                            String assignedTo   = GetProjectManager.getUserName(assigned);

                            String sta		= dueDateExceededRS.getString("status");
                            Date created        = dueDateExceededRS.getDate("createdon");

                            String createdon = "NA";
                            if(created != null){
                                createdon = sdf.format(created);
                            }

                            Date   modifiedon1 = dueDateExceededRS.getDate("modifiedon");

                            String dateString1 = sdf.format(modifiedon1);




                            int age=GetAge.getIssueAge(createdon,sta,dateString1);


                            String s1="S1- Fatal";
                            String s2="S2- Critical";
                            String s3="S3- Important";
                            String s4="S4- Minor";

                            String htmlRow      =   null;
                            String htmlSeverity =   null;
                            String htmlPriority =   null;
                            String htmlIssueNO  =   null;
                            String htmlProject  =   null;
                            String htmlSubject  =   null;
                            String htmlStatus   =   null;
                            String htmlDueDate  =   null;
                            String htmlCreatedBy=   null;
                            String htmlAssignedTo=  null;
                            String htmlAge       =  null;




                            if(sev.equals(s1)){
                                htmlSeverity    ="<td width=1% bgcolor=#FF0000></td>";
                            }else if(sev.equals(s2)){
                                htmlSeverity    ="<td width=1% bgcolor=#DF7401></td>";
                            }else if(sev.equals(s3)){
                                htmlSeverity    ="<td width=1% bgcolor=#F7FE2E></td>";
                            }else if(sev.equals(s4)){
                                htmlSeverity    ="<td width=1% bgcolor=#04B45F></td>";
                            }

                            htmlIssueNO  =   "<td width=10%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+issueId+"</font></td>";

                            htmlPriority    ="<td width=1%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+p+"</font></td>";

                            if(project1.length()<15)
                                {

                                    htmlProject="<td width=10%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+project1+"</font></td>";

                                }
                                else
                                {

                                    htmlProject="<td width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+project1.substring(0,15)+"..." +"</font></td>";

                                }
                               if(sub.length()<42)
                                {

                                    htmlSubject="<td width=29% ><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+sub+"</font></td>";

                                }
                                else
                                {
                                 htmlSubject="<td width=29% ><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+sub.substring(0,42)+"..."+"</font></td>";

		                        }
                            htmlStatus = "<td width=9%><font face=Verdana, Arial, Helvetica, sans-serif		size=1 color=#000000>"+sta+"</font></td>";

                                if( (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)){


                            htmlDueDate ="<td width=8% title='Last Modified On'"+dateString1+"><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=RED>"+dueDate +"</font></td>";

                                }else{
                            htmlDueDate ="<td width=8% title='Last Modified On'"+dateString1+"><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+dueDate +"</font></td>";


                                }




                            htmlCreatedBy ="<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+ createdBy +"</font></td>";

                            htmlAssignedTo ="<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+ assignedTo +"</font></td>";


                            htmlAge ="<td width=4% align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+age+" </font></td>";

                            if(( rowcolor % 2 ) != 0)
                            {

                                htmlRow="<tr bgcolor=white height=23>";

                            }
                            else
                            {


                                htmlRow="<tr bgcolor=#E8EEF7 height=23>";

                                }
                            String htmlRowEnd ="</tr>";

                            htmlContent=htmlContent+htmlRow+htmlSeverity+htmlIssueNO+htmlPriority+htmlProject+htmlSubject+htmlStatus+htmlDueDate+htmlCreatedBy+htmlAssignedTo+htmlAge+htmlRowEnd;




                            rowcolor++;


                    }

                            String email = GetName.getEmail((String)al.get(i));
                            String endLine="</table><br>Thanks,";
                            String signature="<br>eTracker&trade;<br>";
                            String emi      =   "<br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                            String lineBreak =  "<br>";

                            String htmlTableEnd="<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                            htmlContent = htmlContent+endLine+signature+htmlTableEnd+lineBreak+emi;
                            //Edited by sowjanya
                          MimeMessage msg= MakeConnection.getSupportMailConnections();
                          //Edit end by sowjanya
                            msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs\u2122 eTracker\u2122","UTF-8"));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
 //                           msg.addRecipient(Message.RecipientType.BCC, new InternetAddress("ttamilvelan@eminentlabs.net"));

                            msg.setSubject(name+"'s Timesheet for the month of "+monthSelect.get(month)+"  "+year+".");
                            msg.setContent(htmlContent,"text/html");
                            Transport.send(msg);


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
