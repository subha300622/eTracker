/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import com.eminent.util.GetAge;
import com.eminent.util.GetName;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.SendMail;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author TAMILVELAN
 */
public class ReassignIssues implements Job {

    static Logger logger = Logger.getLogger("Reassigning Issues");

    public void execute(JobExecutionContext context) throws JobExecutionException {
        // Getting All Active Project
        String projects[][] = getAllActiveProjects();
        String projectid = null;
        String projectm = null;
        for (int l = 0; l < projects.length; l++) {
            logger.info("Project Name--->" + projects[l][1]);
            String pmIssues = "";
            projectid = projects[l][0];
            projectm = projects[l][2];
            //Getting all users who have issues on projects
            ArrayList al = getMemebers(projectid, projectm);
            for (Iterator r = al.iterator(); r.hasNext();) {
                String userid = (String) r.next();
                // Intimating users for reassignment of Issue
                pmIssues = pmIssues + getUserIssues(projectid, userid, projectm);
            }
            String userName = GetName.getUserFirstName(projectm);
            String subject = "Dear " + userName + ", All the due date exceeded issue(s) are auto assigned to you for reassignment";
            String info = "<table><tr><td colspan=10><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>This list shows issue(s) exceeding the due date. Please do update the due date at the earliest and assign back to respective users.</font> </td></tr>";
            String header = "<TR bgcolor='#C3D9FF'><TD width='1%' TITLE='Severity'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>S</b></font></TD>"
                    + "<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Issue No</b></font></TD>"
                    + "<TD width=3% TITLE='Priority'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>P</b></font></TD>"
                    + "<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Project</b></font></TD>"
                    + "<TD width=29%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Subject</b></font></TD>"
                    + "<TD width=9%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Status</b></font></TD>"
                    + "<TD width=8%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>DueDate</b></font></TD>"
                    + "<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>CreatedBy</b></font></TD>"
                    + "<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>AssignedTo</b></font></TD>"
                    + "<TD width=4% TITLE='In Days' ALIGN='CENTER'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Age</b></font></TD></TR>";

            pmIssues = info + header + pmIssues;
            if (pmIssues.length() > 1500) {
                SendMail.reassigningIssue(pmIssues, Integer.parseInt(projectm), subject);
            }
        }

    }
    // Get All Active Projects

    public static String[][] getAllActiveProjects() {



        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        String version = null;
        String pnameversion = null;
        String pmanager = null;
        String projectDetails[][] = null;
        HashMap<String, String> projectdetails = new HashMap<String, String>();


        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select pid,pname,version,pmanager from project  where status in ('Work in progress','To be started') order by UPPER(PNAME) ASC");
//                                resultset=statement.executeQuery("select pid,pname,version,pmanager from project  where pid=10071 and status='Work in progress' order by UPPER(PNAME) ASC");
            resultset.last();
            int noOfRows = resultset.getRow();
            resultset.beforeFirst();
            projectDetails = new String[noOfRows][3];
            int i = 0;
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                version = resultset.getString(3);
                pnameversion = name + ":" + version;
                projectdetails.put(id, pnameversion);
                pmanager = resultset.getString("pmanager");
                projectDetails[i][0] = id;
                projectDetails[i][1] = pnameversion;
                projectDetails[i][2] = pmanager;
                i++;
            }


        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return projectDetails;

    }

    public static ArrayList getMemebers(String pid, String pmanager) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        ArrayList al = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
//				Class.forName("oracle.jdbc.driver.OracleDriver");

//				connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select distinct assignedto from issue i ,issuestatus s, users u where i.issueid=s.issueid and i.assignedto=u.userid and status!='Closed' and pid='" + pid + "' and assignedto!='" + pmanager + "' and due_date< to_date((select sysdate from dual),'DD-Mon-YY') and email like '%eminentlabs.net' order by assignedto asc");
            resultset.last();
            int noOfRows = resultset.getRow();
            logger.info("No Of Issues" + noOfRows);
            resultset.beforeFirst();

            while (resultset.next()) {
                al.add(resultset.getString(1));
            }


        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }


        return al;
    }

    public static String getUserIssues(String pid, String userid, String pmanager) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String htmlContent = "", info = null, header = null;
        String pmIssue = "";
        int rowcolor = 0;
        int noOfRows = 0;
        String admin = (String) GetProjectMembers.getAdminDetail().get("userid");
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("Select i.issueid as issueid, pname as project, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status from issue i,issuestatus s,project p where i.issueid = s.issueid and  i.pid = p.pid and i.pid='" + pid + "' and assignedto = '" + userid + "' and s.status != 'Closed' and i.due_date< to_date((select sysdate from dual),'DD-Mon-YY') order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc");
            resultset.last();
            noOfRows = resultset.getRow();
            //                              logger.info("No Of Projects"+noOfRows);
            resultset.beforeFirst();
            info = "<table><tr><td colspan=10><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>This list shows " + noOfRows + " issue(s) exceeding the due date. Please do update the same at the earliest or coordinate with your Project Manager for extending the due date.</font> </td></tr>";
            header = "<TR bgcolor='#C3D9FF'><TD width='1%' TITLE='Severity'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>S</b></font></TD>"
                    + "<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Issue No</b></font></TD>"
                    + "<TD width=3% TITLE='Priority'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>P</b></font></TD>"
                    + "<TD width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Project</b></font></TD>"
                    + "<TD width=29%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Subject</b></font></TD>"
                    + "<TD width=9%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Status</b></font></TD>"
                    + "<TD width=8%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>DueDate</b></font></TD>"
                    + "<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>CreatedBy</b></font></TD>"
                    + "<TD width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>AssignedTo</b></font></TD>"
                    + "<TD width=4% TITLE='In Days' ALIGN='CENTER'><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000><b>Age</b></font></TD></TR>";
            while (resultset.next()) {

                String issueId = resultset.getString("issueid");
                String project1 = resultset.getString("project");
                String sub = resultset.getString("subject");
                String sev = resultset.getString("severity");
                String priority = resultset.getString("priority");
                String desc = resultset.getString("description");
                int assigned = resultset.getInt("assignedto");
                String p = "NA";
                if (priority != null) {
                    p = priority.substring(0, 2);
                }

                String type = resultset.getString("type");

                Date dueDateFormat = resultset.getDate("due_date");

                String dueDate = "NA";
                if (dueDateFormat != null) {
                    dueDate = sdf.format(dueDateFormat);
                }

                int typ = resultset.getInt("createdby");
                String createdBy = GetProjectManager.getUserName(typ);
                //                          String createdBy    =   (String)getUserDetail(typ).get("username");
                String assignedTo = GetProjectManager.getUserName(assigned);
                //                        String assignedTo    =   (String)getUserDetail(assigned).get("username");
                String sta = resultset.getString("status");
                Date created = resultset.getDate("createdon");

                String createdon = "NA";
                if (created != null) {
                    createdon = sdf.format(created);
                }

                Date modifiedon1 = resultset.getDate("modifiedon");

                String dateString1 = sdf.format(modifiedon1);

                List<String> backlogIssueList=getBacklog(userid,pid);
                
                if(backlogIssueList.contains(issueId)==false){
                updateIssue(issueId, sta, priority, sev, pmanager, admin, dueDateFormat);
                int age = GetAge.getIssueAge(createdon, sta, dateString1);


                String s1 = "S1- Fatal";
                String s2 = "S2- Critical";
                String s3 = "S3- Important";
                String s4 = "S4- Minor";

                String htmlRow = null;
                String htmlSeverity = null;
                String htmlPriority = null;
                String htmlIssueNO = null;
                String htmlProject = null;
                String htmlSubject = null;
                String htmlStatus = null;
                String htmlDueDate = null;
                String htmlCreatedBy = null;
                String htmlAssignedTo = null;
                String htmlAge = null;




                if (sev.equals(s1)) {
                    htmlSeverity = "<td width=1% bgcolor=#FF0000></td>";
                } else if (sev.equals(s2)) {
                    htmlSeverity = "<td width=1% bgcolor=#DF7401></td>";
                } else if (sev.equals(s3)) {
                    htmlSeverity = "<td width=1% bgcolor=#F7FE2E></td>";
                } else if (sev.equals(s4)) {
                    htmlSeverity = "<td width=1% bgcolor=#04B45F></td>";
                }

                htmlIssueNO = "<td width=10%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + issueId + "</font></td>";

                htmlPriority = "<td width=1%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + p + "</font></td>";

                if (project1.length() < 15) {

                    htmlProject = "<td width=10%><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + project1 + "</font></td>";

                } else {

                    htmlProject = "<td width=10%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + project1.substring(0, 15) + "..." + "</font></td>";

                }
                if (sub.length() < 42) {

                    htmlSubject = "<td width=29% ><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + sub + "</font></td>";

                } else {
                    htmlSubject = "<td width=29% ><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + sub.substring(0, 42) + "..." + "</font></td>";

                }
                htmlStatus = "<td width=9%><font face=Verdana, Arial, Helvetica, sans-serif		size=1 color=#000000>" + sta + "</font></td>";

                if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {


                    htmlDueDate = "<td width=8% title='Last Modified On'" + dateString1 + "><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=RED>" + dueDate + "</font></td>";

                } else {
                    htmlDueDate = "<td width=8% title='Last Modified On'" + dateString1 + "><font	face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + dueDate + "</font></td>";


                }




                htmlCreatedBy = "<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + createdBy + "</font></td>";

                htmlAssignedTo = "<td width=13%><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + assignedTo + "</font></td>";


                htmlAge = "<td width=4% align=center><font face=Verdana, Arial, Helvetica, sans-serif size=1 color=#000000>" + age + " </font></td>";

                if ((rowcolor % 2) != 0) {

                    htmlRow = "<tr bgcolor=white height=23>";

                } else {


                    htmlRow = "<tr bgcolor=#E8EEF7 height=23>";

                }
                String htmlRowEnd = "</tr>";

                htmlContent = htmlContent + htmlRow + htmlSeverity + htmlIssueNO + htmlPriority + htmlProject + htmlSubject + htmlStatus + htmlDueDate + htmlCreatedBy + htmlAssignedTo + htmlAge + htmlRowEnd;




                rowcolor++;
                }else{
                    noOfRows=noOfRows-1;
                }

                


            }


        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        pmIssue = pmIssue + htmlContent;
        htmlContent = info + header + htmlContent;
        String userName = GetName.getUserFirstName(userid);
        String subject = "Dear " + userName + ", Your due date exceeded issue(s) are auto reassigned to your PM";
        if (noOfRows > 0) {
            SendMail.reassigningIssue(htmlContent, Integer.parseInt(userid), subject);
        }
        return pmIssue;
    }

    public static void updateIssue(String issueid, String status, String priority, String severity, String pmanager, String admin, Date Duedate) {
        Connection connection = null;
        PreparedStatement issueStatement = null, commentsStatement = null;

        try {

            connection = MakeConnection.getConnection();
            connection.setAutoCommit(false);

            issueStatement = connection.prepareStatement("update issue set assignedto='" + pmanager + "' where issueid='" + issueid + "'");
            issueStatement.executeUpdate();

            Timestamp date = new Timestamp(new java.util.Date().getTime());
            commentsStatement = connection.prepareStatement("insert into issuecomments(issueid,commentedby,comment_date,comments,status,commentedto,duedate,priority,severity) values(?,?,?,?,?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            commentsStatement.setString(1, issueid);
            commentsStatement.setString(2, admin.trim());
            commentsStatement.setTimestamp(3, date);
            commentsStatement.setString(4, "Assigning to PM as due date exceeded");
            commentsStatement.setString(5, status);
            commentsStatement.setString(6, pmanager.trim());
            commentsStatement.setDate(7, Duedate);
            commentsStatement.setString(8, priority);
            commentsStatement.setString(9, severity);
            commentsStatement.executeUpdate();

            connection.commit();
            connection.setAutoCommit(true);
        } catch (Exception e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (Exception rlbk) {
                logger.error(rlbk.getMessage());
            }
            logger.error(e.getMessage());
        } finally {
            try {
                if (issueStatement != null) {
                    issueStatement.close();
                }
                if (commentsStatement != null) {
                    commentsStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception close) {
                logger.error(close.getMessage());
            }
        }

    }

    public static List<String> getBacklog(String userid, String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> issueList=new ArrayList<String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select Distinct(i.ISSUEID) from project p,issue i,issuecomments ic,issuestatus s where i.pid=p.pid and i.pid='"+pid+"' and i.issueid=ic.issueid and s.issueid=i.issueid and (assignedto="+userid+" and ic.commentedby=i.assignedto  and i.due_date<sysdate and Comment_date between sysdate-5 and sysdate) OR (ic.commentedTo=p.pmanager and i.due_date<sysdate and Comment_date between sysdate-5 and sysdate)");
        while(resultset.next()){
            String getissueid=resultset.getString("issueid");
            issueList.add(getissueid);
        }
        logger.info("getBacklog"+issueList);
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("getBacklog"+e);
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return issueList;
    }
}
