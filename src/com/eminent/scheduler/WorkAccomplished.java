/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.scheduler;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import java.util.Date;
import java.util.Calendar;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;



import com.pack.MyAuthenticator;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.text.*;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectManager;
import dashboard.CheckDate;
import com.eminent.util.GetDate;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author Tamilvelan
 */
public class WorkAccomplished implements Job{
    static Logger logger = null;

    static {
        logger = Logger.getLogger("WorkAccomplished");
    }

  public void execute(JobExecutionContext arg0) throws JobExecutionException{
      Connection connection=null;
	  Statement statement=null;
	  ResultSet modifiedIssuesRS=null;
      try{

        
        String yesterday =null;

		String issueid=null;
        String htmlContent  = null;
        Date date = null;
        int i=1;

		try{

            java.util.Date d = new java.util.Date();


	Calendar cal = Calendar.getInstance();
	cal.setTime(d);
    java.sql.Date dat = new java.sql.Date(cal.getTimeInMillis());

      
		connection=MakeConnection.getConnection();

		statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                String dateString = sdf.format(dat);
                                String today=sdf.format(GetDate.getDate());
                                yesterday    = GetDate.getYesterdayDate();
		modifiedIssuesRS=statement.executeQuery("select i.issueid as issueid, pname as project, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status ,i.rating from project p, issue i, issuestatus s where i.issueid = s.issueid and i.pid = p.pid and modifiedon='"+yesterday+"' order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc ");
        modifiedIssuesRS.last();
        int rowcount =modifiedIssuesRS.getRow();
        modifiedIssuesRS.beforeFirst();
        if(rowcount>0){
            htmlContent ="<table><tr><td colspan=10><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>This list shows all the "+rowcount+" issue(s) worked/updated on "+yesterday+". </td></tr>";
             htmlContent=htmlContent+"<TR bgcolor='#C3D9FF'><TD width='1%' TITLE='Severity'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>S</b></font></TD>"
                            +"<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Issue No</b></font></TD>"
                            +"<TD width=3% TITLE='Priority'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>P</b></font></TD>"
                            +"<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Project</b></font></TD>"
                            +"<TD width=29%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Subject</b></font></TD>"
                            +"<TD width=9%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Status</b></font></TD>"
                            +"<TD width=8%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Due Date</b></font></TD>"
                            +"<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>CreatedBy</b></font></TD>"
                            +"<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>AssignedTo</b></font></TD>"
                            +"<TD width=4% TITLE='In Days' ALIGN='CENTER'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Age</b></font></TD></TR>";


        }
        else{
            htmlContent ="<table><tr><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>There were no issues worked/updated on "+yesterday+".</font></tr></table>";
        }

        if(modifiedIssuesRS!=null){

		while(modifiedIssuesRS.next()){
                            String issueId 		 = modifiedIssuesRS.getString("issueid");
                            String project1	 = modifiedIssuesRS.getString("project");
                            String sub		 = modifiedIssuesRS.getString("subject");
                            String sev		 = modifiedIssuesRS.getString("severity");
                            String priority      = modifiedIssuesRS.getString("priority");
                            String desc          = modifiedIssuesRS.getString("description");
                            String rating        = modifiedIssuesRS.getString("rating");
                            String color="";
                            if (rating != null) {
                                if (rating.equalsIgnoreCase("Excellent")) {
                                    color = "#336600";

                                } else if (rating.equalsIgnoreCase("Good")) {
                                    color = "#33CC66";

                                } else if (rating.equalsIgnoreCase("Average")) {
                                    color = "#CC9900";

                                } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                    color = "#CC0000";
                                }
                            }
                            int assigned      =  modifiedIssuesRS.getInt("assignedto");
                            String p = "NA";
                            if(priority != null){
                                p = priority.substring(0,2);
                            }

                            String type          = modifiedIssuesRS.getString("type");
                           
                            Date dueDateFormat	 = modifiedIssuesRS.getDate("due_date");

                            String dueDate = "NA";
                            if(dueDateFormat != null){
                                dueDate = sdf.format(dueDateFormat);
                            }

                            int typ		= modifiedIssuesRS.getInt("createdby");
                            String createdBy    = GetProjectManager.getUserName(typ);

                            String assignedTo   = GetProjectManager.getUserName(assigned);

                            String sta		= modifiedIssuesRS.getString("status");
                            Date created        = modifiedIssuesRS.getDate("createdon");

                            String createdon = "NA";
                            if(created != null){
                                createdon = sdf.format(created);
                            }

                            Date   modifiedon1 = modifiedIssuesRS.getDate("modifiedon");

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


                           
                            htmlIssueNO  =   "<td width=10% ><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+issueId+"</font></td>";

                            if(sev.equals(s1)){
                                htmlSeverity    ="<td width=1% bgcolor=#FF0000></td>";
                            }else if(sev.equals(s2)){
                                htmlSeverity    ="<td width=1% bgcolor=#DF7401></td>";
                            }else if(sev.equals(s3)){
                                htmlSeverity    ="<td width=1% bgcolor=#F7FE2E></td>";
                            }else if(sev.equals(s4)){
                                htmlSeverity    ="<td width=1% bgcolor=#04B45F></td>";
                            }

                            htmlPriority    ="<td width=1%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+p+"</font></td>";

                            if(project1.length()<15)
                                {

                                    htmlProject="<td width=13%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+project1+"</font></td>";

                                }
                                else
                                {

                                    htmlProject="<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+project1.substring(0,15)+"..." +"</font></td>";

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

                                if( (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getClosedIssueFlag(dueDate,yesterday) == true)){


                            htmlDueDate ="<td width=9% title=Last Modified On"+dateString1+"><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=RED>"+dueDate +"</font></td>";
		
                                }else{
                                    htmlDueDate ="<td width=9% title=Last Modified On"+dateString1+"><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+dueDate +"</font></td>";
		

                                }



                            htmlStatus = "<td width=9% bgcolor='"+color+"'><font face=Verdana, Arial, Helvetica, sans-serif		size=1 color=#000000>"+sta+"</font></td>";

                            htmlCreatedBy ="<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+ createdBy +"</font></td>";

                            htmlAssignedTo ="<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+ assignedTo +"</font></td>";


                            htmlAge ="<td width=8% align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>"+age+" </font></td>";

                            if(( i % 2 ) != 0)
                            {

                                htmlRow="<tr bgcolor=white height=23>";

                            }
                            else
                            {


                                htmlRow="<tr bgcolor=#E8EEF7 height=23>";

                                }
                            String htmlRowEnd ="</tr>";

                            htmlContent=htmlContent+htmlRow+htmlSeverity+htmlIssueNO+htmlPriority+htmlProject+htmlSubject+htmlStatus+htmlDueDate+htmlCreatedBy+htmlAssignedTo+htmlAge+htmlRowEnd;

                            i++;
                                 
        }
                            String endLine="</table><br>Thanks,";
                            String signature="<br>eTracker&trade;<br>";
                            String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                            String lineBreak =  "<br>";

                            String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                            htmlContent = htmlContent+endLine+signature+htmlTableEnd+lineBreak+emi;
		}
        }
		catch(Exception e){
			logger.error(e.getMessage());
		}finally{
            try{
                if(modifiedIssuesRS!=null){
                    modifiedIssuesRS.close();
                }
            }
            catch(Exception e)
            {
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null){
                    statement.close();
                }
            }
            catch(Exception e)
            {
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null){
                    connection.close();

                }
            }
            catch(Exception e)
            {
                logger.error(e.getMessage());
            }
        }
     
//Edited by sowjanya
    	MimeMessage msg= MakeConnection.getSupportMailConnections();
        //Edit end by sowjanya
		msg.setFrom(new InternetAddress("admin@eminentlabs.net","Eminentlabs\u2122 eTracker\u2122","UTF-8"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress("mail2all@eminentlabs.net"));

		msg.setSubject("Eminentlabs\u2122 Work Accomplished on "+yesterday,"UTF-8");
                msg.setContent(htmlContent,"text/html");
        Transport.send(msg);
      
      }catch(Exception e){
          logger.error(e.getMessage());
      }
               finally{
            try{
                 if(modifiedIssuesRS!=null) {
					modifiedIssuesRS.close();
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
