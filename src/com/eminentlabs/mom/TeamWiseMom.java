/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.PlannedIssueReport;
import com.eminent.timesheet.Users;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.GetProjects;
import com.eminent.util.ProjectFinder;
import com.eminent.util.SendMail;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.formbean.MomForClientFormbean;
import com.eminentlabs.wrm.User;
import com.eminentlabs.wrm.WRMMailMaintainDAO;
import dashboard.CheckCategory;
import dashboard.TestCases;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class TeamWiseMom {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("TeamWiseMom");
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    SimpleDateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");
    Calendar c = new GregorianCalendar();
    Date date = c.getTime();
    private String heldOn;
    Map<String, String> momTeamMembers = new LinkedHashMap();
    Map<String, String> selectedMembers = new LinkedHashMap();
    private String pid;
    private String pname;
    private String category = "NA";
    private int noOfTestCases;
    private int heldat;
    private int currentUserId;
    private boolean displayMode = false;
    private int createdBy;
    private String startTimeH;
    private String startTimeM;
    private String endTimeH;
    private String endTimeM;
    private String discussion;
    private String mrating;
    private String mfeedback;
    private String message;
    private String escalationPoints;
    private String rPerson;
    private int momClientId;
    private boolean projectAccess = false, preWrm = false;
    List<MomForClientFormbean> momForClients = new ArrayList();
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    List<IssueFormBean> wrmplanIssueDetails = new ArrayList();
    List<IssueFormBean> additionalClosedIssueDetails = new ArrayList();
    List<ApmWrmPlan> wrmPlanList = new ArrayList();
    Map<String, String> issueStatus = new HashMap<>();

    public void setAll(HttpServletRequest request) {

        currentUserId = (Integer) request.getSession().getAttribute("uid");
        String mClientId = request.getParameter("momClientId");
        momClientId = MoMUtil.parseInteger(mClientId, 0);
        if (momClientId == 0) {
            saveMomForClient(request);
        }
        pid = request.getParameter("pid");
        heldOn = sdfs.format(date);
        String projectId = request.getParameter("pid");
        pname = GetProjects.getProjectName(pid);
        category = CheckCategory.getCategory(pname);
        String cases[][] = TestCases.showTestCases(pid);
        noOfTestCases = cases.length;
        int project = MoMUtil.parseInteger(projectId, 0);
        int day = ProjectFinder.getProjectWRMDay(Integer.valueOf(projectId));
        if (day == 0) {
            day = 2;
        }
        Calendar wrmcal = new GregorianCalendar();
        wrmcal.set(Calendar.DAY_OF_WEEK, day);
        int curDay = wrmcal.get(Calendar.DAY_OF_WEEK);
        if (day >= curDay) {
            wrmcal.add(Calendar.DATE, -7);
        }
        Date wrmStartDate = wrmcal.getTime();

        Calendar wrmcala = Calendar.getInstance();
        System.out.println("wrmStartDate : " + wrmStartDate);

        wrmcala.setTime(wrmStartDate);
        if (curDay == day) {
            wrmcala.add(Calendar.DATE, 7);
        }
        System.out.println("wrmcala : " + wrmcala.getTime());
        HashMap<String, String> momTeamMember = GetProjectMembers.getTeamMembers(projectId);
        momTeamMembers = GetProjectMembers.sortHashMapByValues(momTeamMember, true);
        if (project != 0) {
            Date maxHeldon = null;
            Date heldDate = null;

            List<MomForClient> momForClientList = getMFCList(project);
            for (MomForClient mfc : momForClientList) {
                MomForClientFormbean mfcf = new MomForClientFormbean();
                if (momClientId != 0) {
                    if (mfc.getMomClientId() == momClientId) {
                        pid = String.valueOf(mfc.getPid());
                        heldOn = sdfs.format(mfc.getHeldOn());
                        wrmcala.setTime(mfc.getHeldOn());
                        heldDate = mfc.getHeldOn();
                        heldat = mfc.getHeldAt();
                        createdBy = mfc.getCreatedBy();
                        String start = mfc.getStartTime();
                        String end = mfc.getEndTime();
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
                        discussion = mfc.getDiscussion();
                        if (mfc.getRating() == null) {
                            mrating = "Good";
                        } else {
                            mrating = mfc.getRating();
                        }
                        if (mfc.getFeedback() == null) {
                            mfeedback = "";
                        } else {
                            mfeedback = mfc.getFeedback();
                        }

                        if (mfc.getResponsiblePerson() != null && mfc.getResponsiblePerson() != 0) {
                            rPerson = String.valueOf(mfc.getResponsiblePerson());
                        }
                        escalationPoints = mfc.getEscalation();
                        for (MomClientAttendies mca : mfc.getMomClientAttendiesList()) {
                            String uid = String.valueOf(mca.getAttendie());

                            selectedMembers.put(uid, member.get(mca.getAttendie()));

                        }
                        if (request.getParameter("message") != null) {
                            message = request.getParameter("message");
                        }
                    }
                }
                String name = "";
                mfcf.setMomClientId(mfc.getMomClientId());
                mfcf.setCreateBy(mfc.getCreatedBy());

                if (maxHeldon == null) {
                    maxHeldon = mfc.getHeldOn();
                } else {
                    if (maxHeldon.compareTo(mfc.getHeldOn()) < 0) {
                        maxHeldon = mfc.getHeldOn();
                    }
                }

                mfcf.setHeldOn(sdf.format(mfc.getHeldOn()));
                mfcf.setHeldAt(getHeldAt().get(mfc.getHeldAt()));
                if (mfc.getEscalation() != null) {
                    mfcf.setEscalation(mfc.getEscalation());
                } else {
                    mfcf.setEscalation("NA");
                }
                for (MomClientAttendies mca : mfc.getMomClientAttendiesList()) {

                    name = name + member.get(mca.getAttendie()) + ",";

                }
                if (name.length() > 0) {
                    if (name.length() > 100) {
                        mfcf.setMinattendies(name.substring(0, 99) + "......");
                    } else {
                        mfcf.setMinattendies(name.substring(0, name.length() - 1));
                    }
                    mfcf.setAttendies(name.substring(0, name.length() - 1));
                }
                if (mfcf.getAttendies() == null) {
                    mfcf.setAttendies("NA");
                }
                mfcf.setDiscussion(mfc.getDiscussion());
                mfcf.setStartTime(mfc.getStartTime());
                mfcf.setEndTime(mfc.getEndTime());
                if (mfc.getEscalation() != null) {
                    mfcf.setEscalation(mfc.getEscalation());
                } else {
                    mfcf.setEscalation("NA");
                }
                if (mfc.getResponsiblePerson() != null && mfc.getResponsiblePerson() != 0) {
                    mfcf.setResponsiblePerson(member.get(mfc.getResponsiblePerson()));
                } else {
                    mfcf.setResponsiblePerson("NA");
                }

                // setting rating value to output formbean
                if (mfc.getRating() == null) {
                    mfcf.setmRating("Good"); // default rating is good
                } else {
                    mfcf.setmRating(mfc.getRating());
                }
                momForClients.add(mfcf);
            }
            if (createdBy == currentUserId) {
                logger.info(heldDate + "," + maxHeldon + "," + createdBy + "," + currentUserId);
                if (heldDate != null) {
                    if (maxHeldon.compareTo(heldDate) > 0) {
                    } else if (maxHeldon.compareTo(heldDate) == 0) {
                        displayMode = true;
                    } else {
                        displayMode = true;

                    }
                }
                logger.info(displayMode);
            }

            logger.info(displayMode);
        }
        Date today = new Date();
        SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
        Date dae = getMaxHeldOn(Integer.parseInt(pid));
        String d1 = sdformat.format(today);
        String d2 = sdformat.format(wrmcala.getTime());
        if (dae != null) {
            String d3 = sdformat.format(dae);
            if (d1.equals(d2) && !d1.equals(d3)) {
                wrmPlanList = findLastWRMDay(Long.valueOf(projectId));
                issueStatus = getPreWRMIssueStatus(pid);
                preWrm = true;
            } else {
                wrmPlanList = findByWRMDayAndPId(Long.valueOf(projectId), wrmcala.getTime());
            }
        }
        List<String> issueList = new ArrayList();

        String issuenos = "";
        for (ApmWrmPlan apmWrmPlan : wrmPlanList) {
            if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                issueList.add(apmWrmPlan.getIssueid().trim());
            }
        }
        // logger.info("issuenos+" + issuenos);
        PlannedIssueReport pir = new PlannedIssueReport();
        if (issueList.size() > 0) {
            wrmplanIssueDetails = pir.getIssuesDetail(issueList);
        }
        List<IssueFormBean> additionalClosedIssueDetailsa = new ArrayList();
        TeamWiseMom t = new TeamWiseMom();

        long prid = MoMUtil.parseLong(pid, 0l);
        int wrmid = t.findMaxWRMDay(prid);
        if (wrmid == momClientId) {
            additionalClosedIssueDetailsa = additionalClosed(pid, momClientId);
            List<String> issuesClosed = new ArrayList<String>();
            for (IssueFormBean isfb : wrmplanIssueDetails) {
                if (isfb.getRating() != null) {
                    issuesClosed.add(isfb.getIssueId());
                }
            }
            for (IssueFormBean isfb : additionalClosedIssueDetailsa) {
                if (!issuesClosed.contains(isfb.getIssueId())) {
                    additionalClosedIssueDetails.add(isfb);
                }
            }
        } else {
            additionalClosedIssueDetailsa = additionalClosed(pid, wrmid);
            List<String> issuesClosed = new ArrayList<String>();
            for (IssueFormBean isfb : wrmplanIssueDetails) {
                if (isfb.getRating() != null) {
                    issuesClosed.add(isfb.getIssueId());
                }
            }
            for (IssueFormBean isfb : additionalClosedIssueDetailsa) {
                if (!issuesClosed.contains(isfb.getIssueId())) {
                    additionalClosedIssueDetails.add(isfb);
                }
            }
        }

    }

    public void saveMomForClient(HttpServletRequest request) {
        String prid = request.getParameter("pid");
        String heldOnStr = request.getParameter("heldOn");
        String heldAt = request.getParameter("heldAt");
        String attendies[] = request.getParameterValues("attendiesFinal");
        String discussionPoints = request.getParameter("comments");
        String rating = request.getParameter("rating");
        String feedback = request.getParameter("feedback");
        String startH = request.getParameter("startH");
        String startM = request.getParameter("startM");
        String endH = request.getParameter("endH");
        String endM = request.getParameter("endM");
        String escalation = request.getParameter("escalationPoints");
        String responsiblePerson = request.getParameter("responsiblePerson");
        if (discussionPoints == null) {
            discussionPoints = " ";
        }
        MomForClient momForClient = new MomForClient();

        List<ApmWrmPlan> wrmPlannedList = new ArrayList();

        int projectid = MoMUtil.parseInteger(prid, 0);
        if (heldOnStr != null && projectid != 0) {
            momForClient.setMomClientId(MoMUtil.getMomCleientId());
            momForClient.setPid(projectid);
            momForClient.setPmanager(GetProjectManager.getProjectManagerByPID(momForClient.getPid()));
            momForClient.setDiscussion(discussionPoints);
            momForClient.setStartTime(startH + ":" + startM);
            momForClient.setEndTime(endH + ":" + endM);
            momForClient.setCreatedBy(currentUserId);
            momForClient.setRating(rating);
            momForClient.setFeedback(feedback);
            if (heldAt.equals("0")) {
                momForClient.setHeldAt(MoMUtil.parseInteger(heldAt, 0));
            } else {
                momForClient.setHeldAt(MoMUtil.parseInteger(heldAt, 0));
            }
            momForClient.setCreatedOn(date);
            momForClient.setModifiedOn(date);
            if (escalation != null && !escalation.equals("")) {
                momForClient.setEscalation(escalation);
            }
            if (responsiblePerson != null && !responsiblePerson.equals("0")) {
                int respesrson = MoMUtil.parseInteger(responsiblePerson, 0);
                if (respesrson != 0) {
                    momForClient.setResponsiblePerson(respesrson);
                }
            }
            try {
                momForClient.setHeldOn(sdfs.parse(heldOnStr));
            } catch (ParseException ex) {
                logger.error("saveMomForClient:" + ex.getMessage());
            }

            if (attendies != null) {
                String attendiesNames = "";
                for (int i = 0; i < attendies.length; i++) {
                    int userId = MoMUtil.parseInteger(attendies[i], 0);
                    if (userId != 0) {
                        MomClientAttendies momClientAttendies = new MomClientAttendies();
                        momClientAttendies.setId(MoMUtil.getMomCleientAttId());
                        momClientAttendies.setMomClientId(momForClient);
                        momClientAttendies.setAttendie(userId);
                        momForClient.getMomClientAttendiesList().add(momClientAttendies);
                        DAOFactory.createMOMForClient(momForClient);
                        attendiesNames = attendiesNames + member.get(userId) + ",";
                    }
                }
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
                String Subject = "eTracker WRM Held at " + customer + " On " + mailFormatHeldOn;
                String issueList = "";
                wrmPlannedList = findByWRMDayAndPId(Long.valueOf(prid), date);
                List<String> pissueList = new ArrayList();

                for (ApmWrmPlan apmWrmPlan : wrmPlannedList) {
                    if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                        pissueList.add(apmWrmPlan.getIssueid().trim());
                    }
                }
                for (ApmWrmPlan wrmPlan : wrmPlannedList) {
                    String comment = request.getParameter(wrmPlan.getIssueid().trim() + "reviewcomment");
                    if (comment != null) {
                        wrmPlan.setComments(comment);
                        wrmPlan.setStatus("Active");
                        DAOFactory.upateApmWrmPlan(wrmPlan);
                    }
                }
                PlannedIssueReport pir = new PlannedIssueReport();
                if (wrmPlannedList.size() > 0) {
                    issueList = issueList + " <tr style='font-weight: bold;color: blue;'><td colspan='16'>Issues Reviewed and Committed for Next Week</td></tr>"
                            + "<tr style='background-color:#E8EEF7;'><td colspan='16'><table style='width: 100%;' id='wrmPlanTable' class='tablesorter'>"
                            + "<thead><tr style='text-align:left;background-color:#C3D9FF'><TH class='header' width='12%'><font><b>Issue No</b></font></TH><TH class=\"header\" width=\"7%\"><font><b>Module</b></font></TH><TH class='header' width='28%'><font><b>Subject</b></font></TH>"
                            + "<th class='header'><font><b>Review Comments</b></font></th></tr></thead>";

                    int k = 0;
                    for (IssueFormBean isfb : pir.getIssuesDetail(pissueList)) {
                        k++;
                        if ((k % 2) == 0) {

                            issueList = issueList + "<tr bgcolor='#E8EEF7' height='23'>";
                        } else {
                            issueList = issueList + "<tr bgcolor='white' height='23'>";
                        }

                        issueList = issueList + "<td width='11%' title=" + isfb.getType() + "><a href=http://www.eminentlabs.com/eTracker/Issuesummaryview.jsp?issueid=" + isfb.getIssueId() + ">" + isfb.getIssueId() + "</a></td>"
                                + "<td width='7%' title=" + isfb.getmName() + ">" + isfb.getRedMName() + "</td><td width='29%' >" + isfb.getSubject() + "</td>"
                                + "<td>";

                        String comments = null;

                        for (ApmWrmPlan awp : wrmPlannedList) {
                            if (awp.getIssueid().equalsIgnoreCase(isfb.getIssueId())) {
                                comments = awp.getComments();
                            }
                        }
                        if (comments == null) {
                            comments = "";
                        }

                        issueList = issueList + comments + "</td></tr>";
                    }
                    issueList = issueList + "</table></td></tr>";
                }
                String mailContent = "<table style='width:100%;'><tr style='background-color: #E8EEF7;height:21px;'>"
                        + "<td style='font-weight: bold;width:14%;'>Held On </td><td style='width:8%;'>" + mailFormatHeldOn + "</td>"
                        + "<td style='font-weight: bold;width:8%;'>Held At </td><td  style='width:30%;'>" + customer + "</td>"
                        + "<td style='font-weight: bold;width:12%;'>Start Time</td><td  style='width:8%;'>" + startH + ":" + startM + "</td>"
                        + "<td style='font-weight: bold;width:12%;'>End Time</td><td  style='width:8%;'>" + endH + ":" + endM + "</td>"
                        + "</tr>"
                        + "<tr style='height:21px;'>"
                        + "<td style='font-weight: bold;'>Attendies </td><td colspan='7' align='left' id='tdattendies'>" + attendiesNames + "</td>"
                        + "</tr>" + issueList
                        + "<tr style='background-color: white;'>"
                        + "<td style='font-weight: bold;'>Points Discussed </td><td colspan='7' align='left' id='tddiscussion'>"
                        + "<font size='2' face='Verdana, Arial, Helvetica, sans-serif'> " + discussionPoints + "</font></td>"
                        + "</tr>"
                        + "<tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;width:8%;'>Rating </td><td  style='width:30%;'>" + rating + "</td>"
                        + "<td style='font-weight: bold;width:12%;'>Feedback</td><td  style='width:8%;'>" + feedback + "</td></tr>";
                if (escalation != null && !escalation.equals("")) {
                    escalation = escalation + "";
                } else {
                    escalation = "Nil";
                }
                mailContent = mailContent + "<tr style='background-color: white;height:21px;'><td style='font-weight: bold;'>Escalation</td>"
                        + "<td colspan='7' >" + escalation + "</td>"
                        + "</tr>";
                if (responsiblePerson != null && !responsiblePerson.equals("0")) {
                    int respesrson = MoMUtil.parseInteger(responsiblePerson, 0);
                    if (respesrson != 0) {
                        mailContent = mailContent + "<tr  >"
                                + "<td  style='font-weight: bold;'>Responsible Person</td><td colspan='7' >" + member.get(respesrson) + "</td></tr>";
                    }
                }

                String htmlTableEnd = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                mailContent = mailContent + "</table>" + htmlTableEnd;
                String email = GetProjectMembers.getProjectManager(Long.valueOf(prid));
                List<User> wrmMailNotificationUsers = WRMMailMaintainDAO.getWRMMailUserByPid(Long.valueOf(prid));
                SendMail.WRMMail(mailContent, Subject, member.get(currentUserId), email, wrmMailNotificationUsers);
                message = heldOnStr + "Weekly review meeting Added successfully";
            }

        }

    }

    public void updateMomForClient(HttpServletRequest request) {
        String mClientId = request.getParameter("momClientId");
        String heldOnStr = request.getParameter("heldOn");
        String heldAt = request.getParameter("heldAt");
        String attendies[] = request.getParameterValues("attendiesFinal");
        String discussionPoints = request.getParameter("comments");
        String rating = request.getParameter("rating");
        String feedback = request.getParameter("feedback");
        String startH = request.getParameter("startH");
        String startM = request.getParameter("startM");
        String endH = request.getParameter("endH");
        String endM = request.getParameter("endM");
        String escalation = request.getParameter("escalationPoints");
        String responsiblePerson = request.getParameter("responsiblePerson");
        momClientId = MoMUtil.parseInteger(mClientId, 0);
        if (momClientId != 0) {
            deleteByClientId(momClientId);
            MomForClient updatemfc = findByMomClientId(momClientId);
            pid = String.valueOf(updatemfc.getPid());
            updatemfc.setPmanager(GetProjectManager.getProjectManagerByPID(updatemfc.getPid()));
            updatemfc.setDiscussion(discussionPoints);
            updatemfc.setStartTime(startH + ":" + startM);
            updatemfc.setEndTime(endH + ":" + endM);
            updatemfc.setEscalation(escalation);
            int respesrson = MoMUtil.parseInteger(responsiblePerson, 0);
            updatemfc.setResponsiblePerson(respesrson);
            if (heldAt.equals("0")) {
                updatemfc.setHeldAt(MoMUtil.parseInteger(heldAt, 0));
            } else {
                updatemfc.setHeldAt(MoMUtil.parseInteger(heldAt, 0));
            }
            updatemfc.setModifiedOn(date);
            updatemfc.setRating(rating);
            updatemfc.setFeedback(feedback);
            try {
                updatemfc.setHeldOn(sdfs.parse(heldOnStr));
            } catch (ParseException ex) {
                logger.error("updateMomForClient:" + ex.getMessage());
            }
            List<ApmWrmPlan> wrmPlannedList = new ArrayList();

            if (attendies != null) {
                String attendiesNames = "";
                logger.info("logger.info(attendies.length);" + attendies.length);
                for (int i = 0; i < attendies.length; i++) {
                    int userId = MoMUtil.parseInteger(attendies[i], 0);
                    if (userId != 0) {

                        MomClientAttendies momClientAttendies = new MomClientAttendies();
                        momClientAttendies.setId(MoMUtil.getMomCleientAttId());
                        momClientAttendies.setMomClientId(updatemfc);
                        momClientAttendies.setAttendie(userId);
                        updatemfc.getMomClientAttendiesList().add(momClientAttendies);
                        DAOFactory.updateMomForClient(updatemfc);
                        attendiesNames = attendiesNames + member.get(userId) + ",";
                    }
                }
                if (attendiesNames.length() > 2) {
                    attendiesNames = attendiesNames.substring(0, attendiesNames.length() - 1);
                }
                String mailFormatHeldOn = "";
                try {
                    mailFormatHeldOn = sdf.format(sdfs.parse(heldOnStr));
                } catch (ParseException ex) {
                    logger.info("updateMomForClient:" + ex.getMessage());
                }
                String customer = "Eminent";
                if (updatemfc.getHeldAt() == 0) {
                    customer = GetProjects.getCustomer(updatemfc.getPid());
                }

                String Subject = "eTracker WRM Held at " + customer + " On " + mailFormatHeldOn;

                String issueList = "";
                wrmPlannedList = findByWRMDayAndPId(updatemfc.getPid(), updatemfc.getHeldOn());
                List<String> pissueList = new ArrayList();

                for (ApmWrmPlan wrmPlan : wrmPlannedList) {
                    String comment = request.getParameter(wrmPlan.getIssueid().trim() + "reviewcomment");
                    if (comment != null) {
                        wrmPlan.setComments(comment);
                        wrmPlan.setStatus("Active");
                        DAOFactory.upateApmWrmPlan(wrmPlan);
                    }
                }

                for (ApmWrmPlan apmWrmPlan : wrmPlannedList) {
                    if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                        pissueList.add(apmWrmPlan.getIssueid().trim());
                    }
                }
                PlannedIssueReport pir = new PlannedIssueReport();
                if (wrmPlannedList.size() > 0) {
                    issueList = issueList + " <tr style='font-weight: bold;color: blue;'><td colspan='16'>Issues Reviewed and Committed for Next Week</td></tr>"
                            + "<tr style='background-color:#E8EEF7;'><td colspan='16'><table style='width: 100%;' id='wrmPlanTable' class='tablesorter'>"
                            + "<thead><tr style='text-align:left;background-color:#C3D9FF'><TH class='header' width='12%'><font><b>Issue No</b></font></TH><TH class=\"header\" width=\"7%\"><font><b>Module</b></font></TH><TH class='header' width='28%'><font><b>Subject</b></font></TH>"
                            + "<th class='header'><font><b>Review Comments</b></font></th></tr></thead>";

                    int k = 0;
                    for (IssueFormBean isfb : pir.getIssuesDetail(pissueList)) {
                        k++;
                        if ((k % 2) == 0) {

                            issueList = issueList + "<tr bgcolor='#E8EEF7' height='23'>";
                        } else {
                            issueList = issueList + "<tr bgcolor='white' height='23'>";
                        }

                        issueList = issueList + "<td width='11%' title=" + isfb.getType() + "><a href=http://www.eminentlabs.com/eTracker/Issuesummaryview.jsp?issueid=" + isfb.getIssueId() + ">" + isfb.getIssueId() + "</a></td>"
                                + "<td width='7%' title=" + isfb.getmName() + ">" + isfb.getRedMName() + "</td><td width='29%' >" + isfb.getSubject() + "</td>"
                                + "<td>";

                        String comments = null;

                        for (ApmWrmPlan awp : wrmPlannedList) {
                            if (awp.getIssueid().equalsIgnoreCase(isfb.getIssueId())) {
                                comments = awp.getComments();
                            }
                        }
                        if (comments == null) {
                            comments = "";
                        }

                        issueList = issueList + comments + "</td></tr>";
                    }
                    issueList = issueList + "</table></td></tr>";
                }
                String mailContent = "<table style='width:100%;'><tr style='background-color: #E8EEF7;height:21px;'>"
                        + "<td style='font-weight: bold;width:14%;'>Held On </td><td style='width:8%;'>" + mailFormatHeldOn + "</td>"
                        + "<td style='font-weight: bold;width:8%;'>Held At </td><td  style='width:30%;'>" + customer + "</td>"
                        + "<td style='font-weight: bold;width:12%;'>Start Time</td><td  style='width:8%;'>" + startH + ":" + startM + "</td>"
                        + "<td style='font-weight: bold;width:12%;'>End Time</td><td  style='width:8%;'>" + endH + ":" + endM + "</td>"
                        + "</tr>"
                        + "<tr style='height:21px;'>"
                        + "<td style='font-weight: bold;'>Attendies </td><td colspan='7' align='left' id='tdattendies'>" + attendiesNames + "</td>"
                        + "</tr>" + issueList
                        + "<tr style='background-color: white;'>"
                        + "<td style='font-weight: bold;'>Points Discussed </td><td colspan='7' align='left' id='tddiscussion'>"
                        + "<font size='2' face='Verdana, Arial, Helvetica, sans-serif'> " + discussionPoints + "</font></td>"
                        + "</tr>"
                        + "<tr style='background-color: #E8EEF7;height:21px;'><td style='font-weight: bold;width:8%;'>Rating </td><td  style='width:30%;'>" + rating + "</td>"
                        + "<td style='font-weight: bold;width:12%;'>Feedback</td><td  style='width:8%;'>" + feedback + "</td></tr>";

                if (escalation != null && !escalation.equals("")) {
                    mailContent = mailContent + "<tr style='background-color: #FFFFFF;height:21px;'><td style='font-weight: bold;'>Escalation</td>"
                            + "<td colspan='7' >" + escalation + "</td>"
                            + "</tr>";
                } else {
                    mailContent = mailContent + "<tr style='background-color: #E8EEF7;'><td style='font-weight: bold;'>Escalation</td>"
                            + "<td colspan='7' >Nil</td>"
                            + "</tr>";
                }

                if (respesrson != 0) {
                    mailContent = mailContent + "<tr  >"
                            + "<td style='font-weight: bold;'>Responsible Person</td><td colspan='7' >" + member.get(respesrson) + "</td></tr>";
                }

                String htmlTableEnd = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                mailContent = mailContent + "</table>" + htmlTableEnd;
                String email = GetProjectMembers.getProjectManager(Long.valueOf(pid));
                List<User> wrmMailNotificationUsers = WRMMailMaintainDAO.getWRMMailUserByPid(Long.valueOf(pid));
                SendMail.WRMMail(mailContent, Subject, member.get(currentUserId), email, wrmMailNotificationUsers);
                message = heldOnStr + " Weekly review meeting Updated successfully";
            }

        }
    }

    public List<MomForClient> getMFCList(int pid) {
        List<MomForClient> momForClientList = new ArrayList();

        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomForClient.findByPid");
            query.setParameter("pid", pid);
            momForClientList = (List<MomForClient>) query.list();
        } catch (Exception e) {
            logger.error("getMFCList" + e.getMessage());
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
        return momForClientList;
    }

    public MomForClient findByMomClientId(int momClientId) {
        MomForClient momForClient = new MomForClient();

        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            momForClient = (MomForClient) session.get(MomForClient.class, momClientId);

        } catch (Exception e) {
            logger.error("findByMomClientId" + e.getMessage());
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
        return momForClient;
    }

    public ApmWrmPlan findByWRMId(long wrmId) {
        ApmWrmPlan apmWrmPlan = new ApmWrmPlan();

        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            apmWrmPlan = (ApmWrmPlan) session.get(ApmWrmPlan.class, wrmId);

        } catch (Exception e) {
            logger.error("findByMomClientId" + e.getMessage());
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
        return apmWrmPlan;
    }

    public List<Integer> getClientIds(int pid) {
        List<Integer> momClientIds = new ArrayList();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomForClient.findMomClientIdByPid");
            query.setParameter("pid", pid);
            momClientIds = (List<Integer>) query.list();
        } catch (Exception e) {
            logger.error("getClientIds" + e.getMessage());
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
        return momClientIds;
    }

    public Date getMaxHeldOn(int pid) {
        Date heldOn = null;
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomForClient.findMaxHeldOn");
            query.setParameter("pid", pid);
            heldOn = (Date) query.uniqueResult();
        } catch (Exception e) {
            logger.error("getMaxHeldOn" + e.getMessage());
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
        return heldOn;
    }

    public Users getUser(int userid) {

        Session session = null;
        Users user = new Users();
        try {

            session = HibernateFactory.getCurrentSession();
            user = (Users) session.get(Users.class, userid);
        } catch (Exception e) {
            logger.error("getUser" + e.getMessage());
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
        return user;
    }

    public void deleteByClientId(int momclientId) {
        logger.info(momclientId);
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

            conn = MakeConnection.getConnection();
            String query = "Delete from MOM_CLIENT_ATTENDIES m where m.MOM_CLIENT_ID = ? ";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, momclientId);

            rs = pstmt.executeQuery();

        } catch (Exception e) {
            logger.info("deleteByClientId" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }

                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
    }

    public List<MomForClientFormbean> printWRM(HttpServletRequest request) {

        String printMomClientId = request.getParameter("momClientId");
        pid = request.getParameter("pid");
        Integer current_userId = (Integer) request.getSession().getAttribute("userid_curr");
        String userId = current_userId.toString();
        int roleId = (Integer) request.getSession().getAttribute("Role");

        if (pid == null) {
            int id = MoMUtil.parseInteger(printMomClientId, 0);
            if (id != 0) {
                MomForClient mfc = findByMomClientId(id);
                if (mfc != null) {
                    MomForClientFormbean mfcf = new MomForClientFormbean();
                    pid = mfc.getPid().toString();
                    String customer = "Eminent";
                    if (mfc.getHeldAt() == 0) {
                        customer = GetProjects.getCustomer(mfc.getPid());
                    }
                    mfcf.setMomClientId(mfc.getMomClientId());
                    mfcf.setCreateBy(mfc.getCreatedBy());
                    mfcf.setHeldOn(sdf.format(mfc.getHeldOn()));
                    mfcf.setHeldAt(customer);
                    if (mfc.getEscalation() != null) {
                        mfcf.setEscalation(mfc.getEscalation());
                    } else {
                        mfcf.setEscalation("Nil");
                    }
                    String name = "";
                    for (MomClientAttendies mca : mfc.getMomClientAttendiesList()) {

                        name = name + member.get(mca.getAttendie()) + ",";

                    }
                    if (name.length() > 0) {
                        mfcf.setAttendies(name.substring(0, name.length() - 1));
                    }
                    if (mfcf.getAttendies() == null) {
                        mfcf.setAttendies("NA");
                    }
                    mfcf.setDiscussion(mfc.getDiscussion());
                    mfcf.setStartTime(mfc.getStartTime());
                    mfcf.setEndTime(mfc.getEndTime());
                    String rating = null, feedback = null;
                    if (mfc.getRating() == null) {
                        rating = "Good";
                    } else {
                        rating = mfc.getRating();
                    }
                    if (mfc.getFeedback() == null) {
                        feedback = "";
                    } else {
                        feedback = mfc.getFeedback();
                    }
                    mfcf.setmRating(rating);
                    mfcf.setmFeedback(feedback);
                    if (mfc.getEscalation() != null) {
                        mfcf.setEscalation(mfc.getEscalation());
                    } else {
                        mfcf.setEscalation("NA");
                    }
                    if (mfc.getResponsiblePerson() != null && mfc.getResponsiblePerson() != 0) {
                        mfcf.setResponsiblePerson(member.get(mfc.getResponsiblePerson()));
                    } else {
                        mfcf.setResponsiblePerson("Na");
                    }
                    wrmPlanList = findByWRMDayAndPId(mfc.getPid(), mfc.getHeldOn());
                    mfcf.setWrmPlanList(wrmPlanList);
                    List<String> issueList = new ArrayList();

                    String issuenos = "";
                    for (ApmWrmPlan apmWrmPlan : wrmPlanList) {
                        if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                            issueList.add(apmWrmPlan.getIssueid().trim());
                        }
                    }
                    //logger.info("issuenos+" + issuenos);
                    PlannedIssueReport pir = new PlannedIssueReport();
                    if (issueList.size() > 0) {
                        mfcf.setWrmplanIssueDetails(pir.getIssuesDetail(issueList));
                    }
                    List<IssueFormBean> additionalClosedIssueDetailsa = new ArrayList();
                    additionalClosedIssueDetailsa = additionalClosed(pid, id);
                    List<String> issuesClosed = new ArrayList<String>();
                    for (IssueFormBean isfb : mfcf.getWrmplanIssueDetails()) {
                        if (isfb.getRating() != null) {
                            issuesClosed.add(isfb.getIssueId());
                        }
                    }
                    for (IssueFormBean isfb : additionalClosedIssueDetailsa) {
                        if (!issuesClosed.contains(isfb.getIssueId())) {
                            additionalClosedIssueDetails.add(isfb);
                        }
                    }
                    mfcf.setAdditonalClosedIssueDetails(additionalClosedIssueDetails);

                    momForClients.add(mfcf);
                }

            }
            if (roleId != 1) {
                projectAccess = GetProjectMembers.isAssigned(userId, pid);
            } else {
                projectAccess = true;
            }
        } else {
            if (roleId != 1) {
                projectAccess = GetProjectMembers.isAssigned(userId, pid);
            } else {
                projectAccess = true;
            }

            int projectId = MoMUtil.parseInteger(pid, 0);

            String customer = GetProjects.getCustomer(projectId);
            List<MomForClient> momForClientList = getMFCList(projectId);
            for (MomForClient mfc : momForClientList) {
                MomForClientFormbean mfcf = new MomForClientFormbean();

                String name = "";
                mfcf.setMomClientId(mfc.getMomClientId());
                mfcf.setCreateBy(mfc.getCreatedBy());
                mfcf.setHeldOn(sdf.format(mfc.getHeldOn()));
                if (mfc.getHeldAt() == 0) {
                    mfcf.setHeldAt(customer);
                } else {
                    mfcf.setHeldAt("Eminent");
                }
                if (mfc.getEscalation() != null) {
                    mfcf.setEscalation(mfc.getEscalation());
                } else {
                    mfcf.setEscalation("NA");
                }
                for (MomClientAttendies mca : mfc.getMomClientAttendiesList()) {

                    name = name + member.get(mca.getAttendie()) + ",";

                }
                if (name.length() > 0) {
                    mfcf.setAttendies(name.substring(0, name.length() - 1));
                }
                if (mfcf.getAttendies() == null) {
                    mfcf.setAttendies("NA");
                }
                mfcf.setDiscussion(mfc.getDiscussion());
                mfcf.setStartTime(mfc.getStartTime());
                mfcf.setEndTime(mfc.getEndTime());
                if (mfc.getEscalation() != null) {
                    mfcf.setEscalation(mfc.getEscalation());
                } else {
                    mfcf.setEscalation("Nil");
                }
                if (mfc.getResponsiblePerson() != null && mfc.getResponsiblePerson() != 0) {
                    mfcf.setResponsiblePerson(member.get(mfc.getResponsiblePerson()));
                } else {
                    mfcf.setResponsiblePerson("Na");
                }
                String rating = null, feedback = null;
                if (mfc.getRating() == null) {
                    rating = "Good";
                } else {
                    rating = mfc.getRating();
                }
                if (mfc.getFeedback() == null) {
                    feedback = "";
                } else {
                    feedback = mfc.getFeedback();
                }
                mfcf.setmRating(rating);
                mfcf.setmFeedback(feedback);
                List<ApmWrmPlan> wrmPlanLista = new ArrayList();
                wrmPlanLista = findByWRMDayAndPId(mfc.getPid(), mfc.getHeldOn());
                mfcf.setWrmPlanList(wrmPlanLista);
                List<String> issueList = new ArrayList();

                String issuenos = "";
                for (ApmWrmPlan apmWrmPlan : wrmPlanLista) {
                    if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                        issueList.add(apmWrmPlan.getIssueid().trim());
                    }
                }
                PlannedIssueReport pir = new PlannedIssueReport();
                if (issueList.size() > 0) {
                    mfcf.setWrmplanIssueDetails(pir.getIssuesDetail(issueList));
                }
                List<IssueFormBean> additionalClosedIssueDetailsa = new ArrayList();
                List<IssueFormBean> additionalClosedIssueDetailsb = new ArrayList();
                additionalClosedIssueDetailsa = additionalClosed(pid, mfc.getMomClientId());
                List<String> issuesClosed = new ArrayList<String>();
                for (IssueFormBean isfb : mfcf.getWrmplanIssueDetails()) {
                    if (isfb.getRating() != null) {
                        issuesClosed.add(isfb.getIssueId());
                    }
                }
                for (IssueFormBean isfb : additionalClosedIssueDetailsa) {
                    if (!issuesClosed.contains(isfb.getIssueId())) {
                        additionalClosedIssueDetailsb.add(isfb);
                    }
                }
                mfcf.setAdditonalClosedIssueDetails(additionalClosedIssueDetailsb);
                momForClients.add(mfcf);

            }
        }

        return momForClients;

    }

    public List<ApmWrmPlan> findByWRMDayAndPId(long pid, Date wrmDay) {
        Session session = null;
        List<ApmWrmPlan> findByWRMDayAndPId = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmWrmPlan.findByWrmdayAndPid");
            query.setParameter("wrmday", wrmDay);
            query.setParameter("pid", pid);
            findByWRMDayAndPId = (List<ApmWrmPlan>) query.list();
            if (findByWRMDayAndPId == null) {
                findByWRMDayAndPId = new ArrayList();
            }
            logger.info("findByWRMDayAndPId: " + findByWRMDayAndPId.size());
        } catch (Exception e) {
            logger.error("findByWRMDayAndPId" + e);
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
        return findByWRMDayAndPId;

    }

    public List<ApmWrmPlan> findLastWRMDay(long pid) {
        Session session = null;
        List<ApmWrmPlan> findByWRMDayAndPId = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmWrmPlan.findLastWrmIssueByPid");
            query.setParameter("pid", pid);
            findByWRMDayAndPId = (List<ApmWrmPlan>) query.list();
            if (findByWRMDayAndPId == null) {
                findByWRMDayAndPId = new ArrayList();
            }
            logger.info("findByWRMDayAndPId: " + findByWRMDayAndPId.size());
        } catch (Exception e) {
            logger.error("findByWRMDayAndPId" + e.getMessage());
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
        return findByWRMDayAndPId;

    }

    public Integer findMaxWRMDay(long pid) {
        Session session = null;
        int id = 0;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createQuery("select Max(a.momClientId) from MomForClient a where a.pid=:pid");
            query.setParameter("pid", (int) (long) pid);
            id = (Integer) query.uniqueResult();
            logger.info("findByWRMDayAndPId: " + id);
        } catch (Exception e) {
            logger.error("findByWRMDayAndPId" + e.getMessage());
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
        return id;

    }

    public List<IssueFormBean> additionalClosed(String pid, long wrmid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
        try {

            conn = MakeConnection.getConnection();
            String query = "select i.issueid,type,module, subject,description,rating from issue i,issuestatus s,project p,modules m where i.pid=p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and s.status='Closed' and  i.issueid in(select distinct(issueid) from APM_ADDITIONAL_CLOSED where wrmid='" + wrmid + "') and i.pid='" + pid + "'";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                IssueFormBean isfb = new IssueFormBean();
                isfb.setIssueId(rs.getString("issueid"));
                isfb.setType(rs.getString("type"));
                isfb.setmName(rs.getString("module"));
                if (isfb.getmName().length() >= 10) {
                    isfb.setRedMName(isfb.getmName().substring(0, 9) + "..");
                } else {
                    isfb.setRedMName(rs.getString("module"));
                }
                String sub = rs.getString("subject");
                if (sub.length() > 42) {
                    sub = sub.substring(0, 42) + "...";
                }
                isfb.setSubject(sub);
                isfb.setDescription(rs.getString("description"));
                String rating = rs.getString("rating");

                String color = "#33CC66";
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
                isfb.setRatingColor(color);
                issuesList.add(isfb);
            }
        } catch (Exception e) {
            logger.error("deleteByClientId" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }

                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issuesList;
    }

    public Map<String, String> getPreWRMIssueStatus(String pid) {

        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        Map<String, String> status = new HashMap<>();
        try {

            conn = MakeConnection.getConnection();
            String query = "select ic.issueid,ic.STATUS,ic.COMMENT_DATE from ( \n"
                    + "select issueid as issue,max(COMMENT_DATE) as maxDate from ISSUECOMMENTS where to_char(COMMENT_DATE,'dd-Mon-YYYY') <= (select max(m.HELD_ON) from MOM_FOR_CLIENT m where PID=" + pid + ")\n"
                    + "and ISSUEID in (select ISSUEID from APM_WRM_PLAN where WRMDAY=(select max(m.HELD_ON) from MOM_FOR_CLIENT m where PID=" + pid + ")\n"
                    + ") group by issueid ) r\n"
                    + "inner join ISSUECOMMENTS ic on ic.ISSUEID=r.issue and ic.COMMENT_DATE=r.maxDate\n"
                    + "";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                status.put(rs.getString(1), rs.getString(2));
            }
        } catch (Exception e) {
            logger.error("getPreWRMIssueStatus" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }

                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return status;
    }

    public Map<String, String> getRatingList() {
        Map<String, String> ratingList = new LinkedHashMap();
        ratingList.put("Excellent", "");
        ratingList.put("Good", "");
        ratingList.put("Average", "");
        ratingList.put("Need Improvement", "");
        return ratingList;
    }

    public Map<Integer, String> getHeldAt() {
        Map<Integer, String> heldAtList = new LinkedHashMap();
        heldAtList.put(0, "Client");
        heldAtList.put(1, "Eminent");
        return heldAtList;
    }

    public int getMomClientId() {
        return momClientId;
    }

    public void setMomClientId(int momClientId) {
        this.momClientId = momClientId;
    }

    public Map<String, String> getMomTeamMembers() {
        return momTeamMembers;
    }

    public void setMomTeamMembers(Map<String, String> momTeamMembers) {
        this.momTeamMembers = momTeamMembers;
    }

    public String getHeldOn() {
        return heldOn;
    }

    public void setHeldOn(String heldOn) {
        this.heldOn = heldOn;
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

    public int getNoOfTestCases() {
        return noOfTestCases;
    }

    public void setNoOfTestCases(int noOfTestCases) {
        this.noOfTestCases = noOfTestCases;
    }

    public int getHeldat() {
        return heldat;
    }

    public void setHeldat(int heldat) {
        this.heldat = heldat;
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

    public String getMrating() {
        return mrating;
    }

    public void setMrating(String mrating) {
        this.mrating = mrating;
    }

    public String getMfeedback() {
        return mfeedback;
    }

    public void setMfeedback(String mfeedback) {
        this.mfeedback = mfeedback;
    }

    public String getEscalationPoints() {
        return escalationPoints;
    }

    public void setEscalationPoints(String escalationPoints) {
        this.escalationPoints = escalationPoints;
    }

    public String getrPerson() {
        return rPerson;
    }

    public void setrPerson(String rPerson) {
        this.rPerson = rPerson;
    }

    public List<MomForClientFormbean> getMomForClients() {
        return momForClients;
    }

    public Map<String, String> getSelectedMembers() {
        return selectedMembers;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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

    public int getCurrentUserId() {
        return currentUserId;
    }

    public void setCurrentUserId(int currentUserId) {
        this.currentUserId = currentUserId;
    }

    public void setSelectedMembers(Map<String, String> selectedMembers) {
        this.selectedMembers = selectedMembers;
    }

    public void setMomForClients(List<MomForClientFormbean> momForClients) {
        this.momForClients = momForClients;
    }

    public boolean isProjectAccess() {
        return projectAccess;
    }

    public void setProjectAccess(boolean projectAccess) {
        this.projectAccess = projectAccess;
    }

    public List<IssueFormBean> getWrmplanIssueDetails() {
        return wrmplanIssueDetails;
    }

    public void setWrmplanIssueDetails(List<IssueFormBean> wrmplanIssueDetails) {
        this.wrmplanIssueDetails = wrmplanIssueDetails;
    }

    public List<IssueFormBean> getAdditionalClosedIssueDetails() {
        return additionalClosedIssueDetails;
    }

    public void setAdditionalClosedIssueDetails(List<IssueFormBean> additionalClosedIssueDetails) {
        this.additionalClosedIssueDetails = additionalClosedIssueDetails;
    }

    public List<ApmWrmPlan> getWrmPlanList() {
        return wrmPlanList;
    }

    public void setWrmPlanList(List<ApmWrmPlan> wrmPlanList) {
        this.wrmPlanList = wrmPlanList;
    }

    public Map<String, String> getIssueStatus() {
        return issueStatus;
    }

    public void setIssueStatus(Map<String, String> issueStatus) {
        this.issueStatus = issueStatus;
    }

    public boolean isPreWrm() {
        return preWrm;
    }

    public void setPreWrm(boolean preWrm) {
        this.preWrm = preWrm;
    }

}
