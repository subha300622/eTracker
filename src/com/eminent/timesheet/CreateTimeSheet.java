/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.timesheet;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.util.GetProjectMembers;
import java.util.List;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;
import java.sql.Timestamp;
import org.apache.log4j.Logger;
import java.math.BigDecimal;
import javax.mail.internet.*;
import javax.mail.Message;
import javax.mail.Authenticator;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import com.pack.*;
import com.eminentlabs.appraisal.AppraisalUtil;
import com.eminentlabs.timesheet.dao.TimesheetDAO;
import com.eminentlabs.timesheet.dao.TimesheetDAOImpl;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.ResourceBundle;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Administrator
 */
public class CreateTimeSheet {

    static Logger logger = Logger.getLogger("Create TimeSheet");
    private static ResourceBundle rb = null;

    static {
        rb = ResourceBundle.getBundle("Resources");
    }
    private static final HashMap<Integer, String> monthSelect = new HashMap();

    static {

        monthSelect.put(0, "Jan");
        monthSelect.put(1, "Feb");
        monthSelect.put(2, "Mar");
        monthSelect.put(3, "Apr");
        monthSelect.put(4, "May");
        monthSelect.put(5, "Jun");
        monthSelect.put(6, "Jul");
        monthSelect.put(7, "Aug");
        monthSelect.put(8, "Sep");
        monthSelect.put(9, "Oct");
        monthSelect.put(10, "Nov");
        monthSelect.put(11, "Dec");

    }

    public static boolean checkTimesheet(String passedId) {
        boolean flag = false;

        logger.info("Timesheet Id Passed>>>" + passedId);

        SessionFactory factory = HibernateUtil.getSessionFactory();
        Session session = factory.openSession();
        Query query = session.createQuery("from usertimesheets");
        List l = query.list();
        for (Iterator i = l.iterator(); i.hasNext();) {
            Timesheet t = (Timesheet) i.next();
            String timeSheetId = t.getTimesheetid();
//            logger.info("Timesheet Id Fetched>>>"+timeSheetId);
            if (timeSheetId.equalsIgnoreCase(passedId)) {
                flag = true;
            }
        }
        session.close();
        logger.info("TimesheetFlag>>>" + flag);
        return flag;
    }

    public static String createTimeSheet(String timeSheetId, int userId, String accomplishments, String learning, String hardship, String suggestion, String plan) {
        String requestMessage = null;
        TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
        try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            org.hibernate.Session sess = sessionFactory.openSession();
            sess.beginTransaction();

            Timestamp date = new Timestamp(new java.util.Date().getTime());

            requestMessage = "There is problem in Timesheet Approval Request. Please contact Administrator";

            TimesheetMaintanance timesheetMaintanance = timesheetDAO.findByRequester(userId);
            int assignedto = 112;
            String status = "Need Info";
            if (timesheetMaintanance == null) {
            } else {
                if (timesheetMaintanance.getNeedinfoApprover() != 0) {
                    assignedto = timesheetMaintanance.getNeedinfoApprover();
                    status = "Need Info";
                } else if (timesheetMaintanance.getTimesheetApprover() != 0) {
                    assignedto = timesheetMaintanance.getTimesheetApprover();
                    status = "Yet to approve";
                } else {
                    assignedto = 112;
                }
            }
            char eligibility = 'N';
//            if(AppraisalUtil.appraisalEligibility(userId)){
//                eligibility  =   'Y';
//            }
            Timesheet ts = new Timesheet();
            ts.setTimesheetid(timeSheetId);
            ts.setUsers(GetUser(userId));
            ts.setRequestedon(date);
            ts.setAssignedto(BigDecimal.valueOf(assignedto));
            ts.setAccomplishments(accomplishments);
            ts.setLearning(learning);
            ts.setHardship(hardship);
            ts.setSuggestion(suggestion);
            ts.setPlan(plan);
            ts.setAppraisalEligibility(eligibility);
            ts.setApprovalstatus(status);
            sess.save("usertimesheets", ts);
            sess.getTransaction().commit();
            sess.close();

            requestMessage = "You are created a Timesheet Approval Request successfully";

            //Sending mail once timesheet is created
            String subject = "Time Sheet Approval Request Created by " + GetProjectMembers.getUserName(((Integer) userId).toString());
            String from = GetProjectMembers.getMail(((Integer) userId).toString());
            String to = GetProjectMembers.getMail(((Integer) assignedto).toString());
            String requestedBy = GetProjectMembers.getUserName(((Integer) userId).toString());

            String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(new java.util.Date().getTime());

            String htmlContent = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td> <td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7 ><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Accomplishments</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + accomplishments + "</td></tr>"
                    + "<tr ><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >New Learnings</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + learning + "</td></tr>"
                    + "<tr bgcolor='#E8EEF7' ><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Sugessitons</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + suggestion + "</td></tr>"
                    + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>HardShip</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + hardship + "</td></tr>"
                    + "<tr bgcolor='#E8EEF7'><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Next Month Plan</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + plan + "</td></tr>"
                    + "</table>";

            SendMail(htmlContent, from, to, subject, requestedBy);

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return requestMessage;
    }

    public static void GetInfo(String timeSheetId, int owner, int assignedto, int infoby, String status, String info) {
        try {
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            org.hibernate.Session sess = sessionFactory.openSession();
            org.hibernate.Session sess1 = sessionFactory.openSession();
            sess.beginTransaction();
            sess1.beginTransaction();

            Timestamp date = new Timestamp(new java.util.Date().getTime());

            //Updating  Approval status and assignedto in Timesheet Table
            String hql = "update usertimesheets set approvalstatus = :status,assignedto=:assi where timesheetid = :newtimeseet";
            Query query = sess.createQuery(hql);
            query.setString("newtimeseet", timeSheetId);
            query.setInteger("assi", assignedto);
            query.setString("status", status);
            int rowCount = query.executeUpdate();
            sess.getTransaction().commit();
            sess.close();

            Timesheetinfo tc = new Timesheetinfo();
            tc.setTimesheet(GetTimeSheetDetails(timeSheetId));
            tc.setInfoaddedon(date);
            tc.setUsersByInfoby(GetUser(infoby));
            tc.setUsersByInfoto(GetUser(assignedto));
            tc.setInfo(info);

            sess1.save("sheetinfo", tc);
            sess1.getTransaction().commit();
            sess1.close();
            String subject = "Time Sheet Info Needed ";
            //Sending mail once timesheet is Updated
            if (status.equalsIgnoreCase("Need Info")) {
                subject = "Time Sheet Info Needed ";
            } else if (status.equalsIgnoreCase("Approved")) {
                subject = "Time Sheet assigned for approval";
            }
            String from = GetProjectMembers.getMail(((Integer) infoby).toString());
            String to = GetProjectMembers.getMail(((Integer) assignedto).toString());
            String requestedBy = GetProjectMembers.getUserName(((Integer) owner).toString());

            String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(new java.util.Date().getTime());

            String htmlContent = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td> <td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Info</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + info + "</td></tr>"
                    + "</table>";

            SendMail(htmlContent, from, to, subject, requestedBy);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static Users GetUser(int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        org.hibernate.Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from users where userid='" + userId + "'");
        List l = query.list();
        int i = 0;
        Users user = (Users) l.get(i);
        session.close();
        return user;
    }

    public static List GetTimeSheet(int userId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        org.hibernate.Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from usertimesheets where assignedto='" + userId + "' and accountstatus is null order by requestedon asc");
        List l = query.list();
        session.close();
        return l;

    }

    public static List GetTimeSheet() {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        org.hibernate.Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from usertimesheets where accountstatus is null order by requestedon asc");
        List l = query.list();
        session.close();
        return l;

    }

    public static Timesheet GetTimeSheetDetails(String timeSheetId) {
        Timesheet timesheet = null;
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();

            Query query = session.createQuery("from usertimesheets where timesheetid='" + timeSheetId + "'");
            List l = query.list();
            int size = l.size();
            if (size > 0) {
                int i = 0;
                timesheet = (Timesheet) l.get(i);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return timesheet;

    }

    public static void ApproveTimeSheet(String timeSheetId, int percentage, String feedback, String appreciation, int approvedby, String status, String esplHours, String meetingHours, String wonAccounts, String metdecisionmaker, String identifieddecisionmaker, String metinfluencers, String identifiedinfluencers) {
        try {
            TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            org.hibernate.Session sess = sessionFactory.openSession();
            sess.beginTransaction();
            int meetingHrs = 0;
            int esplHrs = 0;
            int userId = Integer.parseInt((timeSheetId.substring(7, timeSheetId.length())));
            TimesheetMaintanance timesheetMaintanance = timesheetDAO.findByRequester(userId);
            int assignedto = 103;
            if (timesheetMaintanance == null) {
            } else {
                if (timesheetMaintanance.getAttendanceApprover() != 0) {
                    assignedto = timesheetMaintanance.getAttendanceApprover();
                } else {
                    assignedto = 103;
                }
            }
            if (esplHours == null) {
                esplHrs = 0;
            } else {
                esplHrs = Integer.parseInt(esplHours);
            }
            if (meetingHours == null) {
                meetingHrs = 0;
            } else {
                meetingHrs = Integer.parseInt(meetingHours);
            }

            Timestamp s = new Timestamp(new java.util.Date().getTime());
            String hql = "update usertimesheets set approvalpercentage = :appper,APPROVALSTATUS=:status,appreciation=:newapp,feedback=:newfeed,approvedby=:newappby,approvedon=:newon,assignedto=:assi,hoursInOffice=:hoursInOffice,hoursInMeeting=:hoursInMeeting,wonAccounts=:wonAccounts,metDecisionMaker=:metdecisionmaker,identityDecisionMaker=:identifieddecisionmaker,metInfluencer=:metinfluencers,identityInfluencer=:identifiedinfluencers where timesheetid = :newtimeseet";
            Query query = sess.createQuery(hql);
            query.setString("newtimeseet", timeSheetId);
            query.setString("status", status);
            query.setInteger("assi", assignedto);
            query.setInteger("appper", percentage);
            query.setInteger("newappby", approvedby);
            query.setString("newapp", appreciation);
            query.setString("newfeed", feedback);
            query.setTimestamp("newon", s);
            query.setInteger("hoursInOffice", esplHrs);
            query.setInteger("hoursInMeeting", meetingHrs);
            query.setString("wonAccounts", wonAccounts);
            query.setString("metdecisionmaker", metdecisionmaker);
            query.setString("identifieddecisionmaker", identifieddecisionmaker);
            query.setString("metinfluencers", metinfluencers);
            query.setString("identifiedinfluencers", identifiedinfluencers);
            int rowCount = query.executeUpdate();
//            System.out.println("Updated"+rowCount);

            sess.getTransaction().commit();
            sess.close();

            //Sending mail once timesheet is Approved
            Timesheet timesheet = GetTimeSheetDetails(timeSheetId);

            String subject = "Time Sheet Approved by " + GetProjectMembers.getUserName(((Integer) approvedby).toString());
            String attRequest = "Attendance Approval Request Created by " + GetProjectMembers.getUserName(((Integer) userId).toString());
            String from = GetProjectMembers.getMail(((Integer) approvedby).toString());
            String to = GetProjectMembers.getMail(((Integer) userId).toString());
            String attendance = GetProjectMembers.getMail(((Integer) assignedto).toString());
            String approvedBy = GetProjectMembers.getUserName(((Integer) approvedby).toString());
            String requestedBy = GetProjectMembers.getUserName(((Integer) userId).toString());

            String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(new java.util.Date().getTime());
            String requestedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(timesheet.getRequestedon());

            String htmlContent = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Timesheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >RequestedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td> "
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td><b>ApprovedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Approved By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) approvedby).toString()) + "</td></tr>"
                    + "<tr ><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Approval Percentage</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + percentage + " %</td></tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Appreciation</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + appreciation + "</td></tr>"
                    + "<tr ><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Feedback</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + feedback + "</td></tr>"
                    + "</table>";

            String attendanceApproval = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Timesheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >RequestedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td> "
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td><b>ApprovedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Approved By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) approvedby).toString()) + "</td></tr>"
                    + "</table>";

            SendMail(htmlContent, from, to, subject, approvedBy);
            SendMail(attendanceApproval, to, attendance, attRequest, requestedBy);

        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void AttendanceApproval(String timeSheetId, float totalworkingdays, String feedback, float attendance, int approvedby) {
        try {
            TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            org.hibernate.Session sess = sessionFactory.openSession();
            sess.beginTransaction();
            int userId = Integer.parseInt((timeSheetId.substring(7, timeSheetId.length())));
            TimesheetMaintanance timesheetMaintanance = timesheetDAO.findByRequester(userId);
            int assignedto = 103;
            if (timesheetMaintanance == null) {
            } else {
                if (timesheetMaintanance.getAccountsApprover() != 0) {
                    assignedto = timesheetMaintanance.getAccountsApprover();
                } else {
                    assignedto = 103;
                }
            }
            Timestamp s = new Timestamp(new java.util.Date().getTime());
            String hql = "update usertimesheets set attendance = :appper,workingdays=:newapp,ATTENDENCEUPDATEDBY=:newappby,ATTENDENCEUPDATEDON=:newon,assignedto=:assi,ATTENDENCEREMARK=:newfeed where timesheetid = :newtimeseet";
            Query query = sess.createQuery(hql);
            query.setString("newtimeseet", timeSheetId);
            query.setInteger("assi", assignedto);
            query.setFloat("appper", attendance);
            query.setFloat("newapp", totalworkingdays);
            query.setInteger("newappby", approvedby);
            query.setString("newfeed", feedback);
            query.setTimestamp("newon", s);
            int rowCount = query.executeUpdate();
//            System.out.println("Updated"+rowCount);

            sess.getTransaction().commit();
            sess.close();
            //Sending mail once timesheet is Approved
            Timesheet timesheet = GetTimeSheetDetails(timeSheetId);
            String subject = "Attendance Approved by " + GetProjectMembers.getUserName(((Integer) approvedby).toString());
            String accRequest = "Account Approval Request Created by " + GetProjectMembers.getUserName(((Integer) userId).toString());
            String from = GetProjectMembers.getMail(((Integer) approvedby).toString());
            String to = GetProjectMembers.getMail(((Integer) userId).toString());
            String account = GetProjectMembers.getMail(((Integer) assignedto).toString());
            String approver = GetProjectMembers.getUserName(((Integer) approvedby).toString());
            String requestedBy = GetProjectMembers.getUserName(((Integer) userId).toString());

            String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(new java.util.Date().getTime());
            String requestedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(timesheet.getRequestedon());

            String htmlContent = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Timesheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >RequestedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td> "
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Total Working Days</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + totalworkingdays + " Days</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Attendance</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + attendance + " Days</td></tr>"
                    + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >ApprovedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Approved By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) approvedby).toString()) + "</td></tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Remarks</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + feedback + "</td></tr>"
                    + "</table>";

            String accountContent = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Timesheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >RequestedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td> "
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr  bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Total Working Days</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + totalworkingdays + " Days</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Attendance</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + attendance + " Days</td></tr>"
                    + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >ApprovedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Approved By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) approvedby).toString()) + "</td></tr>"
                    + "</table>";

            SendMail(htmlContent, from, to, subject, approver);
            SendMail(accountContent, to, account, accRequest, requestedBy);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void AccountsApproval(String timeSheetId, String feedback, int approvedby) {
        try {
            TimesheetDAO timesheetDAO = new TimesheetDAOImpl();
            SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            org.hibernate.Session sess = sessionFactory.openSession();
            sess.beginTransaction();
            int userId = Integer.parseInt((timeSheetId.substring(7, timeSheetId.length())));
            TimesheetMaintanance timesheetMaintanance = timesheetDAO.findByRequester(userId);
            int assignedto = 103;
            if (timesheetMaintanance == null) {
            } else {
                if (timesheetMaintanance.getAccountsApprover() != 0) {
                    assignedto = timesheetMaintanance.getAccountsApprover();
                } else {
                    assignedto = 103;
                }
            }
            String status = "Accounted";
            Timestamp s = new Timestamp(new java.util.Date().getTime());
            String hql = "update usertimesheets set ACCOUNTSTATUS = :appper,ACCOUNTUPDATEDBY=:newapp,ACCOUNTSREMARKS=:feedback,ACCOUNTSUPDATEDON=:newon,assignedto=:assi where timesheetid = :newtimeseet";
            Query query = sess.createQuery(hql);
            query.setString("newtimeseet", timeSheetId);
            query.setInteger("assi", assignedto);
            query.setString("appper", status);
            query.setInteger("newapp", approvedby);
            query.setString("feedback", feedback);
            query.setTimestamp("newon", s);
            int rowCount = query.executeUpdate();
            //           System.out.println("Updated"+rowCount);

            sess.getTransaction().commit();
            sess.close();

            //Sending mail once timesheet is Approved
            Timesheet timesheet = GetTimeSheetDetails(timeSheetId);
            String subject = "Accounts Approved by " + GetProjectMembers.getUserName(((Integer) approvedby).toString());
            String from = GetProjectMembers.getMail(((Integer) userId).toString());
            String to = GetProjectMembers.getMail(((Integer) assignedto).toString());
            String requestedBy = GetProjectMembers.getUserName(((Integer) userId).toString());

            String formattedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(new java.util.Date().getTime());
            String requestedDate = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(timesheet.getRequestedon());
            String htmlContent = "<table align=center>"
                    + "<tr bgcolor=#E8EEF7><td colspan=4><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>TimeSheet Details</b></td></tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >TimeSheet Id</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + timeSheetId + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Timesheet of</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >RequestedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + requestedBy + "</td> "
                    + "</tr>"
                    + "<tr>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Period</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetPeriod(timeSheetId) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Assigned To</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) assignedto).toString()) + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >ApprovedOn</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + formattedDate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Approved By</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectMembers.getUserName(((Integer) approvedby).toString()) + "</td></tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Narration</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + feedback + "</td></tr>"
                    + "</table>";

            SendMail(htmlContent, from, to, subject, requestedBy);

        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static String GetPeriod(String timeSheetId) {
        String period = null;
        String year = timeSheetId.substring(3, 7);
        String month = timeSheetId.substring(1, 3);
        String textMonth = monthSelect.get(Integer.parseInt(month));
        period = textMonth + " " + year;
        return period;
    }

    public static void SendMail(String htmlContent, String from, String to, String subject, String sender) {

        try {

            String mail = rb.getString("mail");
            if (mail.equalsIgnoreCase("yes")) {
                //Edited by sowjanya
                MimeMessage msg = MakeConnection.getMailConnections();
                //Edit end by sowjanya
                msg.setFrom(new InternetAddress("admin@eminentlabs.net", sender));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(from));
                msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

                String endLine = "</table><br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br>";

                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

                htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;

                msg.setSubject(subject);
                msg.setContent(htmlContent, "text/html");

                Transport.send(msg);
            }
//            logger.info("Eminentlabs Leave Approval - Send mail");
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static List GetCommentDetails(String timeSheetId) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        org.hibernate.Session session = sessionFactory.openSession();
        session.beginTransaction();
        Timesheetinfo timesheetinfo = null;
        Query query = session.createQuery("from sheetinfo where timesheetid='" + timeSheetId + "' order by infoaddedon asc");
        List l = query.list();
        int size = l.size();
        if (size > 0) {
            int i = 0;
            timesheetinfo = (Timesheetinfo) l.get(i);
        }
        session.close();

        return l;

    }

    public static HashMap getTimeSheet(String timeSheetId) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap updatedUsers = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select OWNER,ASSIGNEDTO,APPROVALSTATUS from Timesheet where timesheetid like '" + timeSheetId + "%'");
            while (resultset.next()) {
                updatedUsers.put(resultset.getInt("OWNER"), resultset.getInt("ASSIGNEDTO"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return updatedUsers;

    }

}
