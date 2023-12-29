/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.meeting;

import com.eminent.util.GetProjectMembers;
import com.eminent.util.GetProjects;
import com.eminent.util.SendMail;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.wrm.User;
import dashboard.CheckCategory;
import dashboard.TestCases;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author vanithaalliraj
 */
public class MeetingController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("TeamWiseMom");
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    SimpleDateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");

    private String heldOn;
    Map<String, String> momTeamMembers = new LinkedHashMap();
    Map<String, String> selectedMembers = new LinkedHashMap();
    private String pid;
    private String pname;
    private String category = "NA";
    private int heldat;
    private int currentUserId;
    private boolean displayMode = false;
    private int createdBy;
    private String startTimeH = "";
    private String startTimeM = "";
    private String endTimeH = "";
    private String endTimeM = "";
    private String subject;
    private String discussion;
    private String message;
    private int meetingId;
    private int noOfTestCases;
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    List<ApmMeetings> apmMeetings = new ArrayList<>();

    public String getHeldOn() {
        return heldOn;
    }

    public void setHeldOn(String heldOn) {
        this.heldOn = heldOn;
    }

    public Map<String, String> getMomTeamMembers() {
        return momTeamMembers;
    }

    public void setMomTeamMembers(Map<String, String> momTeamMembers) {
        this.momTeamMembers = momTeamMembers;
    }

    public Map<String, String> getSelectedMembers() {
        return selectedMembers;
    }

    public void setSelectedMembers(Map<String, String> selectedMembers) {
        this.selectedMembers = selectedMembers;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getHeldat() {
        return heldat;
    }

    public void setHeldat(int heldat) {
        this.heldat = heldat;
    }

    public int getCurrentUserId() {
        return currentUserId;
    }

    public void setCurrentUserId(int currentUserId) {
        this.currentUserId = currentUserId;
    }

    public boolean isDisplayMode() {
        return displayMode;
    }

    public void setDisplayMode(boolean displayMode) {
        this.displayMode = displayMode;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getStartTimeH() {
        return startTimeH;
    }

    public void setStartTimeH(String startTimeH) {
        this.startTimeH = startTimeH;
    }

    public String getStartTimeM() {
        return startTimeM;
    }

    public void setStartTimeM(String startTimeM) {
        this.startTimeM = startTimeM;
    }

    public String getEndTimeH() {
        return endTimeH;
    }

    public void setEndTimeH(String endTimeH) {
        this.endTimeH = endTimeH;
    }

    public String getEndTimeM() {
        return endTimeM;
    }

    public void setEndTimeM(String endTimeM) {
        this.endTimeM = endTimeM;
    }

    public String getDiscussion() {
        return discussion;
    }

    public void setDiscussion(String discussion) {
        this.discussion = discussion;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getMeetingId() {
        return meetingId;
    }

    public void setMeetingId(int meetingId) {
        this.meetingId = meetingId;
    }

    public int getNoOfTestCases() {
        return noOfTestCases;
    }

    public void setNoOfTestCases(int noOfTestCases) {
        this.noOfTestCases = noOfTestCases;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public List<ApmMeetings> getApmMeetings() {
        return apmMeetings;
    }

    public void setApmMeetings(List<ApmMeetings> apmMeetings) {
        this.apmMeetings = apmMeetings;
    }

    public void setAll(HttpServletRequest request) {

        currentUserId = (Integer) request.getSession().getAttribute("uid");
        String meetId = request.getParameter("meetingId");
        meetingId = MoMUtil.parseInteger(meetId, 0);
        if (request.getMethod().equalsIgnoreCase("post")) {
            saveMeeting(request);
        }
        pid = request.getParameter("pid");
        String projectId = request.getParameter("pid");
        pname = GetProjects.getProjectName(pid);
        category = CheckCategory.getCategory(pname);
        noOfTestCases = TestCases.showTestCases(pid).length;
        momTeamMembers = GetProjectMembers.sortHashMapByValues(GetProjectMembers.getTeamMembers(projectId), true);
        apmMeetings = getMeetingList(MoMUtil.parseInteger(projectId, 0));

        if (!apmMeetings.isEmpty()) {
            for (ApmMeetings meeting : apmMeetings) {
                if (meetingId == meeting.getMeetingId()) {
                    heldOn = sdfs.format(meeting.getHeldOn());
                    heldat = meeting.getHeldAt();
                    subject = meeting.getSubject();
                    discussion = meeting.getDiscussion();
                    String start = meeting.getStartTime();
                    String end = meeting.getEndTime();
                    if (start != null) {
                        String timeSplit[] = start.split(":");
                        if (timeSplit.length == 2) {
                            startTimeH = timeSplit[0];
                            startTimeM = timeSplit[1];
                        } else {
                            startTimeH = "00";
                            startTimeM = "00";
                        }
                    }
                    if (end != null) {
                        String timeSplit[] = end.split(":");
                        if (timeSplit.length == 2) {
                            endTimeH = timeSplit[0];
                            endTimeM = timeSplit[1];
                        } else {
                            endTimeH = "00";
                            endTimeM = "00";
                        }
                    }

                    for (ApmMeetingParticipants mca : meeting.getApmMeetingParticipantsList()) {
                        selectedMembers.put(String.valueOf(mca.getParticipant()), member.get(mca.getParticipant()));
                    }
                }
            }
        }

    }

    public Map<Integer, String> getHeldAt() {
        Map<Integer, String> heldAtList = new LinkedHashMap();
        heldAtList.put(0, "Client");
        heldAtList.put(1, "Eminent");
        return heldAtList;
    }

    public List<ApmMeetings> getMeetingList(int pid) {
        List<ApmMeetings> apmMeetingList = new ArrayList();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmMeetings.findByPid");
            query.setParameter("pid", pid);
            apmMeetingList = (List<ApmMeetings>) query.list();
        } catch (Exception e) {
            logger.error("getMeetingList" + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }
                }
            }
        }
        return apmMeetingList;
    }

    public void deleteMeetingParticipants(int mid) {
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmMeetingParticipants.deleteMeetingId");
            query.setParameter("meetingId", mid);
            query.executeUpdate();
        } catch (Exception e) {
            logger.error("deleteMeetingParticipants" + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }
                }
            }
        }
    }

    public void saveMeeting(HttpServletRequest request) {
        String meetId = request.getParameter("meetingId");
        meetingId = MoMUtil.parseInteger(meetId, 0);
        String prid = request.getParameter("pid");
        String heldOnStr = request.getParameter("heldOn");
        String heldAt = request.getParameter("heldAt");
        String attendies[] = request.getParameterValues("attendiesFinal");
        subject = request.getParameter("subject");
        String startH = request.getParameter("startH");
        String startM = request.getParameter("startM");
        String endH = request.getParameter("endH");
        String endM = request.getParameter("endM");

        ApmMeetings meeting = new ApmMeetings();
        int projectid = MoMUtil.parseInteger(prid, 0);
        if (heldOnStr != null && projectid != 0) {
            try {
                if (meetingId == 0) {
                    meeting.setMeetingId(getMeetId());
                } else {
                    meeting.setMeetingId(meetingId);
                }
                meeting.setPid(projectid);
                meeting.setSubject(subject);
                meeting.setStartTime(startH + ":" + startM);
                meeting.setEndTime(endH + ":" + endM);
                meeting.setCreatedBy(currentUserId);
                if (heldAt.equals("0")) {
                    meeting.setHeldAt(MoMUtil.parseInteger(heldAt, 0));
                } else {
                    meeting.setHeldAt(MoMUtil.parseInteger(heldAt, 0));
                }
                meeting.setCreatedOn(new Date());
                meeting.setModifiedOn(new Date());
                meeting.setHeldOn(sdfs.parse(heldOnStr));
                meeting.getApmMeetingParticipantsList().clear();

                if (attendies != null) {
                    if (meetingId != 0) {
                        deleteMeetingParticipants(meetingId);
                    }
                    String attendiesNames = "";
                    List<ApmMeetingParticipants> apmMeetingParticipantses = new ArrayList<>();
                    for (int i = 0; i < attendies.length; i++) {
                        int userId = MoMUtil.parseInteger(attendies[i], 0);
                        if (userId != 0) {
                            ApmMeetingParticipants participants = new ApmMeetingParticipants();
                            participants.setId(getParticipantId());
                            participants.setParticipant(userId);
                            participants.setMeetingId(meeting);
                            apmMeetingParticipantses.add(participants);
                            attendiesNames = attendiesNames + member.get(userId) + ",";
                        }
                    }
                    meeting.setApmMeetingParticipantsList(apmMeetingParticipantses);
                    System.out.println("meeting : " + meeting.toString());
                    ModelDAO.saveOrUpdate("ApmMeetings", meeting);

                    if (attendiesNames.length() > 2) {
                        attendiesNames = attendiesNames.substring(0, attendiesNames.length() - 1);
                    }
                    String mailFormatHeldOn = "";
                    try {
                        mailFormatHeldOn = sdf.format(sdfs.parse(heldOnStr));
                    } catch (ParseException ex) {
                        logger.info("saveMomForClient:" + ex.getMessage());
                    }
                    String customer = "Eminent";
                    if (MoMUtil.parseInteger(heldAt, 0) == 0) {
                        customer = GetProjects.getCustomer(projectid);
                    }
                    String Subject = "Meeting scheduled at " + customer + " on " + mailFormatHeldOn;

                    String mailContent = "<table style='width:100%;'><tr style='background-color: #E8EEF7;height:21px;'>"
                            + "<td style='font-weight: bold;width:14%;'>Meeing On </td><td style='width:8%;'>" + mailFormatHeldOn + "</td>"
                            + "<td style='font-weight: bold;width:8%;'>Meeing At </td><td  style='width:30%;'>" + customer + "</td>"
                            + "<td style='font-weight: bold;width:12%;'>Start Time</td><td  style='width:8%;'>" + startH + ":" + startM + "</td>"
                            + "<td style='font-weight: bold;width:12%;'>End Time</td><td  style='width:8%;'>" + endH + ":" + endM + "</td>"
                            + "</tr>"
                            + "<tr style='height:21px;'>"
                            + "<td style='font-weight: bold;'>Participants </td><td colspan='7' align='left' id='tdattendies'>" + attendiesNames + "</td>"
                            + "</tr>"
                            + "<tr style='background-color: white;'>"
                            + "<td style='font-weight: bold;'>Subject</td><td colspan='7' align='left' id='tddiscussion'>"
                            + "<font size='2' face='Verdana, Arial, Helvetica, sans-serif'> " + subject + "</font></td>"
                            + "</tr>";

                    String htmlTableEnd = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                    mailContent = mailContent + "</table>" + htmlTableEnd;
                    System.out.println(Subject);
                    System.out.println(mailContent);
                    String email = GetProjectMembers.getProjectManager(Long.valueOf(prid));
                    List<User> wrmMailNotificationUsers = new ArrayList<>();
                    SendMail.WRMMail(mailContent, Subject, member.get(currentUserId), email, wrmMailNotificationUsers);
                    message = "Meeting Scheduled Successfully";
                    heldat = 0;
                    heldOn = "";
                    startTimeH = "";
                    startTimeM = "";
                    endTimeH = "";
                    endTimeM = "";
                    subject = "";
                    discussion = "";
                    selectedMembers = new HashMap<>();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                logger.error("error saveMeeting " + ex.getMessage());
            }

        }
    }

    public static int getMeetId() {
        Connection connection = null;
        Statement statement = null, dropSeqeunceSt = null;
        ResultSet resultset = null, dropSequence = null;

        int momclientid = 1;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select APM_MEETINGS_SEQ.nextval from dual");
            if (resultset.next()) {
                momclientid = resultset.getInt(1);
            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence APM_MEETINGS_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("CREATE SEQUENCE   APM_MEETINGS_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE");
                dropSequence = dropSeqeunceSt.executeQuery("select APM_MEETINGS_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                momclientid = dropSequence.getInt("nextvalue");
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
        return momclientid;

    }

    public static int getParticipantId() {
        Connection connection = null;
        Statement statement = null, dropSeqeunceSt = null;
        ResultSet resultset = null, dropSequence = null;
        int momclientid = 1;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select APM_MEETING_PARTICIPANTS_SEQ.nextval from dual");
            if (resultset.next()) {
                momclientid = resultset.getInt(1);
            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence APM_MEETING_PARTICIPANTS_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("CREATE SEQUENCE   MOM_FOR_CLIENT_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE");
                dropSequence = dropSeqeunceSt.executeQuery("select MOM_FOR_CLIENT_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                momclientid = dropSequence.getInt("nextvalue");
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
        return momclientid;

    }

    public String checkUserAvailability() {
        String res = "";
        try {

        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }
}
