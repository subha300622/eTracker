/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.controller;

import com.eminent.branch.BranchController;
import com.eminent.leaveUtil.LeaveBlancePeriodDAO;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.SendMail;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import com.eminentlabs.mom.MoMAttendance;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.MomFeedback;
import com.eminentlabs.mom.MomMaintanance;
import com.eminentlabs.mom.MomUserDetail;
import com.eminentlabs.mom.MomUserTask;
import com.eminentlabs.mom.formbean.MomUserAttandance;
import com.eminentlabs.mom.formbean.SendMomMailFromBean;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class MomMaintananceController {

    static Logger logger = Logger.getLogger("MomMaintananceController");
    List<MomMaintanance> momMaintanance = new ArrayList<MomMaintanance>();
    Set<Integer> totalUsers = new LinkedHashSet<Integer>();
    Map<Integer, String> notApplicableUsers = new LinkedHashMap<Integer, String>();
    Map<Integer, String> eminentUsers = new LinkedHashMap<Integer, String>();
    Map<Integer, List<MomMaintanance>> maintanace = new LinkedHashMap<Integer, List<MomMaintanance>>();

    public static void main(String args[]) {
        int array[] = {10, 20, 30, 20, 40, 40, 50, 60, 70, 80};// array of ten    
        int size = array.length;
        for (int i = 0; i < size; i++) {
            for (int j = i + 1; j < size; j++) {
                if (array[i] == array[j]) // checking one element with all the
                // element
                {
                    while (j < (size) - 1) {
                        array[j] = array[j];// shifting the values
                        j++;
                    }
                    size--;
                }
            }
        }

        for (int k = 0; k < size; k++) {
        }

    }

    public void setAll(HttpServletRequest request) {
        momMaintanance = findAll();

        if (request.getMethod().equalsIgnoreCase("post")) {
            String technicals[] = request.getParameter("technical").split(",");
            String functionals[] = request.getParameter("functional").split(",");
            String technicalHeads[] = request.getParameter("technicalHead").split(",");
            String overtechnicalHeads[] = request.getParameter("overtechnicalHeads").split(",");
            String nas[] = request.getParameter("notApplicable").split(",");
            if (technicals != null) {
                int i = 0, j = 1;
                for (String technical : technicals) {
                    if (!"".equals(technical)) {
                        int usera = MoMUtil.parseInteger(technical, 0);

                        if (usera > 0) {
                            MomMaintanance maintanance = findByList(momMaintanance, usera);
                            if (maintanance == null) {
                                MomMaintanance maintanancea = new MomMaintanance(0l, usera, 1, j);
                                ModelDAO.save("MomMaintanance", maintanancea);
                            } else {
                                MomMaintanance maintanancea = new MomMaintanance(maintanance.getMaintanceId(), usera, 1, j);
                                ModelDAO.update("MomMaintanance", maintanancea);
                            }
                            j++;
                        }
                    } else {

                    }
                }
                i++;
            }
            if (functionals != null) {
                int i = 0, j = 1;
                for (String functional : functionals) {
                    if (!"".equals(functional)) {
                        int usera = MoMUtil.parseInteger(functional, 0);
                        if (usera > 0) {
                            MomMaintanance maintanance = findByList(momMaintanance, usera);
                            if (maintanance == null) {
                                MomMaintanance maintanancea = new MomMaintanance(0l, usera, 2, j);
                                ModelDAO.save("MomMaintanance", maintanancea);
                            } else {
                                MomMaintanance maintanancea = new MomMaintanance(maintanance.getMaintanceId(), usera, 2, j);
                                ModelDAO.update("MomMaintanance", maintanancea);
                            }
                            j++;
                        }
                    }
                    i++;
                }
            }
            if (technicalHeads != null) {
                int i = 0, j = 1;
                for (String technicalHead : technicalHeads) {
                    if (!"".equals(technicalHead)) {
                        int usera = MoMUtil.parseInteger(technicalHead, 0);
                        if (usera > 0) {
                            MomMaintanance maintanance = findByList(momMaintanance, usera);
                            if (maintanance == null) {
                                MomMaintanance maintanancea = new MomMaintanance(0l, usera, 3, j);
                                ModelDAO.save("MomMaintanance", maintanancea);
                            } else {
                                MomMaintanance maintanancea = new MomMaintanance(maintanance.getMaintanceId(), usera, 3, j);
                                ModelDAO.update("MomMaintanance", maintanancea);
                            }
                            j++;
                        }
                    }
                    i++;
                }
            }
            if (overtechnicalHeads != null) {
                int i = 0, j = 1;
                for (String technicalHead : overtechnicalHeads) {
                    if (!"".equals(technicalHead)) {
                        int usera = MoMUtil.parseInteger(technicalHead, 0);
                        if (usera > 0) {
                            MomMaintanance maintanance = findByList(momMaintanance, usera);
                            if (maintanance == null) {
                                MomMaintanance maintanancea = new MomMaintanance(0l, usera, 4, j);
                                ModelDAO.save("MomMaintanance", maintanancea);
                            } else {
                                MomMaintanance maintanancea = new MomMaintanance(maintanance.getMaintanceId(), usera, 4, j);
                                ModelDAO.update("MomMaintanance", maintanancea);
                            }
                            j++;
                        }
                    }
                    i++;
                }
            }
            if (nas != null) {
                int i = 0, j = 1;
                for (String na : nas) {
                    if (!"".equals(na)) {
                        int usera = MoMUtil.parseInteger(na, 0);

                        if (usera > 0) {
                            MomMaintanance maintanance = findByList(momMaintanance, usera);
                            if (maintanance == null) {
                            } else {
                                ModelDAO.delete("MomMaintanance", maintanance);
                            }
                            j++;
                        }
                    } else {

                    }
                }
                i++;
            }
            momMaintanance = findAll();
        }
        maintanace = splitLists(momMaintanance);
        eminentUsers = GetProjectMembers.getEminentUsersOrder();
        int count = 0;

        if (!momMaintanance.isEmpty()) {
            for (Map.Entry<Integer, String> entry : eminentUsers.entrySet()) {

                for (MomMaintanance maintana : momMaintanance) {
                    if (entry.getKey() == maintana.getUserid()) {
                        count = 1;
                    }
                }
                if (count == 0) {
                    notApplicableUsers.put(entry.getKey(), entry.getValue());
                } else {
                    count = 0;
                }
            }
        } else {
            notApplicableUsers = eminentUsers;
        }
    }

    public void setSendMomAll(HttpServletRequest request) {
        momMaintanance = findAll();
        Map<Integer, Set<Integer>> branchwiseUsers = GetProjectMembers.getUsersByBranch();
        String branchId = request.getParameter("branch");
        int branch = 0;
        if (branchId != null) {
            if ("".equals(branchId)) {
                branch = 0;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        }
        if (branch > 0) {
            List<MomMaintanance> momUsersa = new ArrayList<MomMaintanance>();
            Set<Integer> users = branchwiseUsers.get(branch);
            if (users == null) {
            } else {
                for (MomMaintanance mmce : momMaintanance) {
                    for (Integer user : users) {
                        if (user == mmce.getUserid()) {
                            momUsersa.add(mmce);
                        }
                    }
                }
                momMaintanance.clear();
                momMaintanance.addAll(momUsersa);
            }
        }
        maintanace = splitLists(momMaintanance);
        eminentUsers = GetProjectMembers.getEminentUsersOrder();
        int count = 0;

        if (!momMaintanance.isEmpty()) {
            for (Map.Entry<Integer, String> entry : eminentUsers.entrySet()) {

                for (MomMaintanance maintana : momMaintanance) {
                    totalUsers.add(maintana.getUserid());
                    if (entry.getKey() == maintana.getUserid()) {
                        count = 1;
                    }
                }
                if (count == 0) {
                    notApplicableUsers.put(entry.getKey(), entry.getValue());
                } else {
                    count = 0;
                }
            }
        } else {
            notApplicableUsers = eminentUsers;
        }
    }

    public void setSendMomAll() {
        momMaintanance = findAll();
        maintanace = splitLists(momMaintanance);
        eminentUsers = GetProjectMembers.getEminentUsersOrder();
        int count = 0;

        if (!momMaintanance.isEmpty()) {
            for (Map.Entry<Integer, String> entry : eminentUsers.entrySet()) {

                for (MomMaintanance maintana : momMaintanance) {
                    totalUsers.add(maintana.getUserid());
                    if (entry.getKey() == maintana.getUserid()) {
                        count = 1;
                    }
                }
                if (count == 0) {
                    notApplicableUsers.put(entry.getKey(), entry.getValue());
                } else {
                    count = 0;
                }
            }
        } else {
            notApplicableUsers = eminentUsers;
        }
    }

    public Map<Integer, List<MomMaintanance>> splitLists(List<MomMaintanance> momMaintanance) {
        Map<Integer, List<MomMaintanance>> splitBy = new LinkedHashMap<Integer, List<MomMaintanance>>();
        int prev = -1;
        List<MomMaintanance> momMaintananceSplit = new ArrayList<MomMaintanance>();
        for (MomMaintanance maintanance : momMaintanance) {
            if (prev == -1) {

            } else if (prev != maintanance.getTeam()) {
                splitBy.put(prev, momMaintananceSplit);
                momMaintananceSplit = new ArrayList<MomMaintanance>();

            }
            momMaintananceSplit.add(maintanance);
            prev = maintanance.getTeam();
        }
        splitBy.put(prev, momMaintananceSplit);
        return splitBy;
    }

    public MomMaintanance findByList(List<MomMaintanance> momMaintanance, int userId) {
        MomMaintanance maintanancea = null;
        for (MomMaintanance maintanance : momMaintanance) {
            if (maintanance.getUserid() == userId) {
                maintanancea = maintanance;
                break;
            }
        }
        return maintanancea;
    }

    public Map<Integer, String> momTypeMaintanance() {
        Map<Integer, String> userType = new LinkedHashMap<Integer, String>();
        userType.put(1, "Technical");
        userType.put(2, "Functional");
        userType.put(3, "Technical Head");
//        userType.put(4, "Over All Technical Head");
        userType.put(0, "Not Applicable");

        return userType;
    }

    public List<MomMaintanance> findAll() {
        Session session = null;
        List<MomMaintanance> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomMaintanance.findAll");
            l = query.list();
            if (l == null) {
                l = new ArrayList<MomMaintanance>();
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return l;
    }

    public Map<Integer, String> findAllMomMembers() {
        Session session = null;
        Map<Integer, String> momMemberMap = new LinkedHashMap<Integer, String>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery("select m.userid, firstname||' '||substr(lastname ,0,1) from mom_maintanance m, users u where u.userid=m.userid order by m.team, m.sino");
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                momMemberMap.put(((BigDecimal) row[0]).intValue(), row[1].toString());
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return momMemberMap;
    }

    public String allMomUsers() {
        Session session = null;
        String users = "";
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomMaintanance.findAllUsers");
            List<Integer> l = query.list();
            if (l == null) {
                l = new ArrayList<Integer>();
            }
            for (Integer user : l) {
                users = users + user + ",";
            }
            if (users.contains(",")) {
                users = users.substring(0, users.length() - 1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return users;
    }

    public String findByMultipleTeam(List<Integer> teams) {
        Session session = null;
        String users = "";
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MomMaintanance.findByMultipleTEAM");
            query.setParameter("team", teams);
            List<Integer> l = query.list();
            if (l == null) {
                l = new ArrayList<Integer>();
            }
            for (Integer user : l) {
                users = users + user + ",";
            }
            if (users.contains(",")) {
                users = users.substring(0, users.length() - 1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return users;
    }

    public void SetSendMomFeedBack(HttpServletRequest request, Set<Integer> totalUsers) {
        MoMUtil moMUtil = new MoMUtil();

        SendMomMailFromBean smmfb = new SendMomMailFromBean();

        Calendar calend = Calendar.getInstance();
        calend.setTime(new Date());
        long st = calend.getTimeInMillis();

        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
        SimpleDateFormat time = new SimpleDateFormat("HH");
        String timeFor = time.format(date);
        int current_time = Integer.parseInt(timeFor);
        int k=0;
        String sql=null;
        Connection dbConnection = null;
        Statement tsc_callableStatement = null;
        String startTime = request.getParameter("startTime");
        String momTeamsType = request.getParameter("momTeamType");
        String branch = request.getParameter("branch");
        String allowUnPlan = request.getParameter("allowUnPlan");
        int momTeamType = MoMUtil.parseInteger(momTeamsType, 0);
        String teamType = momTeamsType;
        if (momTeamType == 0) {
            teamType = "1,2,3";
        } else if (momTeamType == 2) {
            teamType = "2,3";
        }
        int userId = (Integer) request.getSession().getAttribute("uid");
        String[][] todayTaskDetails = null;
        String tasktime = "Planned";
        String momTime = "Morning";
        if (current_time > 14) {
            momTime = "Evening";
            tasktime = "Actual";
        } else {
            todayTaskDetails = MoMUtil.getTodayMOMDetail(dateFor, teamType);
        }
        try {
            dbConnection = MakeConnection.getConnection();
              dbConnection.setAutoCommit(false);
              tsc_callableStatement = dbConnection.createStatement();
            Date momstartTime = sdfs.parse(startTime);
            String chairPerson = request.getParameter("chairPerson");
            int cpId = MoMUtil.parseInteger(chairPerson, 0);
            int branchId = MoMUtil.parseInteger(branch, 0);
            logger.info("chairPerson" + chairPerson + "," + momTeamType);
            if (cpId != 0) {
                MomFeedback momFeedback = MoMUtil.uniqueMomFeedBack(momTime, date, momTeamType, branchId);
                if (momFeedback == null) {
                    MoMUtil.createMOMFeedBack(userId, cpId, momTime, momstartTime, date, null, momTeamType, branchId);
                }
            }
            List<MomUserTask> listMomUserTask = new ArrayList<MomUserTask>();
            List<MomUserTask> unplanTaskByUserList = new ArrayList<MomUserTask>();
            List<MomUserDetail> userdetailList = new ArrayList<MomUserDetail>();
            List<Integer> momUserList = new ArrayList<Integer>();

            Map<Integer, String> attendanceMap = new LinkedHashMap<Integer, String>();
            Map<Integer, List<String>> userwiseplanned=new LinkedHashMap<>();
            for (Integer momuserid : totalUsers) {
                String status = request.getParameter(momuserid + "status");
                String comments = request.getParameter(momuserid + "comments");
                String[] issues = request.getParameterValues(momuserid + "issue");
                String[] momPlanIssues = request.getParameterValues(momuserid + "momPlanIssue");
                String momPlantask[] = request.getParameterValues(momuserid + "momPlantask");
                momUserList.add(momuserid);
                if (status != null) {
                    attendanceMap.put(momuserid, status);

                    momUserList.add(momuserid);
                    if (issues != null) {
                        for (int j = 0; j < issues.length; j++) {

                            MomUserTask momUserTask = new MomUserTask();
                            momUserTask = MoMUtil.createTaskMomForProcuder(momuserid, issues[j], userId, "Issue", tasktime);
                            listMomUserTask.add(momUserTask);
                        }
                    }

                    if (tasktime.equalsIgnoreCase("Planned") && allowUnPlan.equalsIgnoreCase("true")) {
                        List<String> plannedIssues = new LinkedList<String>();
                        List<String> momPlannedIssues = new LinkedList<String>();
                        List<String> plannedTasks = new LinkedList<String>();
                        List<String> momPlannedTasks = new LinkedList<String>();

                        if (momPlanIssues != null) {
                            momPlannedIssues = Arrays.asList(momPlanIssues);
                        }
                        if (momPlantask != null) {
                            momPlannedTasks = Arrays.asList(momPlantask);
                        }
                        userwiseplanned.put(momuserid, momPlannedIssues);
                        
                        for (int i = 0; i < todayTaskDetails.length; i++) {
                            int momuser = MoMUtil.parseInteger(todayTaskDetails[i][0], 0);
                            if (momuser == momuserid) {
                                if (todayTaskDetails[i][1].equalsIgnoreCase("Issue")) {
                                    plannedIssues.add(todayTaskDetails[i][2].substring(0, 12));
                                }
                                if (todayTaskDetails[i][1].equalsIgnoreCase("Task")) {
                                    plannedTasks.add(todayTaskDetails[i][3]);
                                }
                            }
                        }

                        plannedIssues.removeAll(momPlannedIssues);
                        plannedTasks.removeAll(momPlannedTasks);
                        for (String unplannedIssue : plannedIssues) {

                            MomUserTask momuserTask = new MomUserTask();
                            momuserTask.setUserid(momuserid);
                            momuserTask.setTask(unplannedIssue);
                            momuserTask.setType("Issue");
                            unplanTaskByUserList.add(momuserTask);

                        }

                        for (String unplanTask : plannedTasks) {
                            MomUserTask momuserTask = new MomUserTask();
                            momuserTask.setMomtaskid(unplanTask);
                            unplanTaskByUserList.add(momuserTask);

                        }
                    }
                    MomUserDetail userdetail = new MomUserDetail();
                    userdetail.setUserid(momuserid);
                    userdetail.setCreatedby(userId);
                    userdetail.setStatus(status);
                    userdetail.setMomtime(momTime);
                    userdetail.setComment(comments);
                    userdetailList.add(userdetail);

                }
            }

            calend.setTime(new Date());
            long endd = calend.getTimeInMillis();
            long start = calend.getTimeInMillis();
            logger.info("total method " + (endd - st));

            Map<Integer, String> map = moMUtil.createIssueCountTaskProcedure(momUserList);

            calend.setTime(new Date());
            endd = calend.getTimeInMillis();
            logger.info("createTaskMomForProcuder()  total time taken :" + (endd - start) + " ms");
            start = endd;

            for (Map.Entry<Integer, String> entrySet : map.entrySet()) {
                MomUserTask momUserTaska = new MomUserTask();
                momUserTaska = MoMUtil.createTaskMomForProcuder(entrySet.getKey(), entrySet.getValue(), userId, "Count", tasktime);
                listMomUserTask.add(momUserTaska);
            }

            calend.setTime(new Date());
            start = calend.getTimeInMillis();

            moMUtil.updateMomUserTask(listMomUserTask);
            
            for (Map.Entry<Integer,List<String>>  entry:userwiseplanned.entrySet() ){
                k=0;
            for (String issue : entry.getValue()) {
                                    k++;//                            
                                    sql = "update PROJECT_PLANNED_ISSUE set sino=" + k + " where issueid='" + issue + "' and plannedon ='" + dateFor + "'";
                                    tsc_callableStatement.executeUpdate(sql);
                                    logger.info(sql);
                                    sql = "update mom_user_task  set sino=" + k + " where TASK like '%" + issue + "%' and MOMDATE  ='" + dateFor + "' and USERID=" + entry.getKey() + "";
                                    tsc_callableStatement.executeUpdate(sql);
                                    logger.info(sql);
                                }
            }
               dbConnection.commit();
               dbConnection.setAutoCommit(true);
            calend.setTime(new Date());
            endd = calend.getTimeInMillis();
            logger.info(" updateMomUserTask() total time taken :" + (endd - start));

            start = endd;

            moMUtil.unplanTaskByIssueAndUserId(unplanTaskByUserList);

            calend.setTime(new Date());
            endd = calend.getTimeInMillis();
            logger.info(" unplanTaskByIssueAndUserId() total time taken : " + (endd - start));

            start = endd;
            logger.info("userdetailList " + userdetailList.size());
            moMUtil.createMomDeatilsProcedure(userdetailList);

            calend.setTime(new Date());
            endd = calend.getTimeInMillis();
            logger.info(endd + " " + start + " createMomDeatilsProcedure " + (endd - start));

            smmfb.setStartTime(startTime);
            smmfb.setMomtime(momTime);
            smmfb.setAttendance(attendanceMap);
            smmfb.setTeamType(momTeamType);
            smmfb.setChairPerson(cpId);
            smmfb.setBranch(branchId);
            request.getSession().setAttribute("sendMomFormBean", smmfb);

        } catch (ParseException e) {
            logger.error(e.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        }finally {
            try {

                if (tsc_callableStatement != null) {
                    tsc_callableStatement.close();
                    logger.info("tsc_callableStatement closed");
                }

                if (dbConnection != null) {
                    dbConnection.close();
                    logger.info("dbConnection closed");
                }

            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }
            
    }

    public void sendMailMomajax(HttpServletRequest request) {
        HttpSession session = request.getSession();
        HashMap<Integer, String> member = GetProjectMembers.showUsers();
        SendMomMailFromBean sendMomformBean = (SendMomMailFromBean) session.getAttribute("sendMomFormBean");
        BranchController branchController = new BranchController();

        try {
            if (request.getParameter("sendmom").equalsIgnoreCase("sendMom")) {
                if (sendMomformBean == null) {

                } else {
                    String feedback = request.getParameter("feedback");
                    Map<Integer, String> PreviousattendanceForUsers = (Map<Integer, String>) session.getAttribute("perviousAttendance");

                    Map<Integer, String> attuser = sendMomformBean.getAttendance();
                    String username = member.get(sendMomformBean.getChairPerson());
                    Integer curruser = (Integer) session.getAttribute("userid_curr");
                    String loginUser = member.get(curruser);
                    Calendar cal = Calendar.getInstance();
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
                    String startMomTime = sendMomformBean.getStartTime().substring(sendMomformBean.getStartTime().lastIndexOf(' ') + 1).trim();
                    String team = "", location = "";
                    if (sendMomformBean.getTeamType() == 0) {
                        team = "All Team";
                    } else if (sendMomformBean.getTeamType() == 1) {
                        team = "Technical Team";
                    } else {
                        team = "Functional Team";
                    }
                    if (sendMomformBean.getBranch() == 0) {
                        location = "All Location";
                    } else {
                        branchController.getAllBranchMap();
                        location = branchController.getBranchMap().get(sendMomformBean.getBranch());
                    }
                    List<MomUserAttandance> momUserAttandanceList = getUserAttendanceByCurrentMonth(attuser);
                    String htmlContent = "";
                    htmlContent = "<b>" + sendMomformBean.getMomtime() + " meeting for : <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + team + "</font> <br/> Chair Person : <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + username + "</font><br/> Login User : <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + loginUser + "</font> <br/> Meeting time :  start <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + startMomTime + "</font> and end <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + sdf.format(cal.getTime()) + "</font></b><br/>"
                            + "<br/><table align='left' style='width:100%;border-collapse: collapse; border: 1px solid #ACC6EE'><tr style='border: 1px solid #ACC6EE;background:#C3D9FF'><th style='border: 1px solid #ACC6EE;'>User Name</th><th style='border: 1px solid #ACC6EE;'>Status</th>"
                            + "<th style='border: 1px solid #ACC6EE;'>Pr</th><th style='border: 1px solid #ACC6EE;'>In</th><th style='border: 1px solid #ACC6EE;'>Perm</th><th style='border: 1px solid #ACC6EE;'>Un</th><th style='border: 1px solid #ACC6EE;'>Client</th><th style='border: 1px solid #ACC6EE;'>ML</th><th style='border: 1px solid #ACC6EE;'>AL</th></tr>";
                    if (PreviousattendanceForUsers.isEmpty()) {
                        for (MomUserAttandance momUserAttandance : momUserAttandanceList) {
                            if (member.get(momUserAttandance.getUserid()) != null) {
                                htmlContent = htmlContent + "<tr style='border: 1px solid black;color:#ACC6EE;'><td style='border: 1px solid #ACC6EE;color:black; width:25%;'>" + member.get(momUserAttandance.getUserid()) + "</td>";
                                if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Unintimated")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:red'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Approved Leave")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:blue'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Intimated")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:orange'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Permission")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:#C9CB16'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:black'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                }
                            }
                            htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;color:black;text-align: center;'>" + momUserAttandance.getPresent() + "</td><td style='border: 1px solid #ACC6EE;color:orange;text-align: center;'>" + momUserAttandance.getIntimated() + "</td><td style='border: 1px solid #ACC6EE;color:#C9CB16;text-align: center;'>" + momUserAttandance.getPermission() + "</td><td style='border: 1px solid #ACC6EE;color:red;text-align: center;'>" + momUserAttandance.getUnintimated() + "</td><td style='border: 1px solid #ACC6EE;text-align: center;'>" + momUserAttandance.getClinet() + "</td><td style='border: 1px solid #ACC6EE;color:blue;text-align: center;'>" + momUserAttandance.getMedicalleave() + "</td><td style='border: 1px solid #ACC6EE;color:blue;text-align: center;'>" + momUserAttandance.getApproveleave() + "</td></tr>";
                        }
                    } else {
                        for (MomUserAttandance momUserAttandance : momUserAttandanceList) {
                            if (member.get(momUserAttandance.getUserid()) != null) {
                                if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase(PreviousattendanceForUsers.get(momUserAttandance.getUserid())) || (!PreviousattendanceForUsers.containsKey(momUserAttandance.getUserid()))) {
                                    htmlContent = htmlContent + "<tr style='border: 1px solid #ACC6EE;'><td style='border: 1px solid #ACC6EE;color:black;width:25%;'>" + member.get(momUserAttandance.getUserid()) + "</td>";
                                } else {
                                    htmlContent = htmlContent + "<tr style='border: 1px solid #ACC6EE; background:#2196f3'><td style='border: 1px solid #ACC6EE;color:black;width:25%;'>" + member.get(momUserAttandance.getUserid()) + "</td>";
                                }
                                if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Unintimated")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:red'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Approved Leave")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:blue'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Intimated")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:orange'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else if (attuser.get(momUserAttandance.getUserid()).equalsIgnoreCase("Permission")) {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:#C9CB16'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                } else {
                                    htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;text-align:center;color:black'>" + attuser.get(momUserAttandance.getUserid()) + "</td>";
                                }
                            }
                            htmlContent = htmlContent + "<td style='border: 1px solid #ACC6EE;color:black;text-align: center;'>" + momUserAttandance.getPresent() + "</td><td style='border: 1px solid #ACC6EE;color:orange;text-align: center;'>" + momUserAttandance.getIntimated() + "</td><td style='border: 1px solid #ACC6EE;color:#C9CB16;text-align: center;'>" + momUserAttandance.getPermission() + "</td><td style='border: 1px solid #ACC6EE;color:red;text-align: center;'>" + momUserAttandance.getUnintimated() + "</td><td style='border: 1px solid #ACC6EE;text-align: center;'>" + momUserAttandance.getClinet() + "</td><td style='border: 1px solid #ACC6EE;color:blue;text-align: center;'>" + momUserAttandance.getMedicalleave() + "</td><td style='border: 1px solid #ACC6EE;color:blue;text-align: center;'>" + momUserAttandance.getApproveleave() + "</td></tr>";
                        }
                    }
                    htmlContent = htmlContent + "</table><br>";
                    String feedBackContent = "<table align='left' style='width:100%;border-collapse: collapse; border: 1px solid #ACC6EE'><tr style='border: 1px solid #ACC6EE;'><td style='border: 1px solid #ACC6EE;width:25%;'><b>Feedback:</b></td><td style='border: 1px solid #ACC6EE;'>" + feedback + "</td></tr></table><br>";
                    String endLine = "<br>Thanks,";
                    String signature = "<br/>eTracker&trade;<br>";
                    String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                    String lineBreak = "<br>";
                    String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a><br>";
                    htmlContent = htmlContent + lineBreak + feedBackContent + lineBreak + endLine + signature + emi + lineBreak + htmlTableEnd;
                    String Subject = location + "-" + sendMomformBean.getMomtime() + " Mom  for " + team;
                    SendMail.sendMOMMail(htmlContent, Subject);
                }

            } else if (request.getParameter("sendmom").equalsIgnoreCase("sendFeedBack")) {
                String team = "", location = "";
                Integer mteam = MoMUtil.parseInteger(request.getParameter("momteam"), 0);
                Integer branch = MoMUtil.parseInteger(request.getParameter("branch"), 0);
                if (mteam == 0) {
                    team = "All Team";
                } else if (mteam == 1) {
                    team = "Technical Team";
                } else {
                    team = "Functional Team";
                }
                if (branch == 0) {
                    location = "All Location";
                } else {
                    branchController.getAllBranchMap();

                    location = branchController.getBranchMap().get(branch);
                }

                Integer curruser = (Integer) session.getAttribute("userid_curr");
                String loginUser = member.get(curruser);
                String momstartTime = request.getParameter("momstartTime");
                String momEndTime = request.getParameter("momEndTime");
                String chairperson = request.getParameter("chairperson");
                String feedback = request.getParameter("feedback");
                String momtime = request.getParameter("momtime");
                String discussion = request.getParameter("discussion");
                if (discussion == null || discussion.isEmpty() || discussion.equalsIgnoreCase("")) {
                    discussion = "NA";
                }
                String htmlContent = "<b>" + momtime + " meeting for : <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + team + "</font>  <br/> Chair Person : <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + chairperson + "</font><br/> Login User : <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + loginUser + "</font><br/> Meeting time :  start <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + momstartTime + "</font> and end <font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>" + momEndTime + "</font></b><br/>";
                String feedBackContent = "<br><table align='left' style='width:98%;border-collapse: collapse; border: 1px solid #ACC6EE'><tr style='border: 1px solid #ACC6EE;'><td style='border: 1px solid #ACC6EE;'><b>Feedback:</b></td><td style='border: 1px solid #ACC6EE;'>" + feedback + "</td></tr><tr style='border: 1px solid #ACC6EE;'><td style='border: 1px solid #ACC6EE;'><b>Discussion:</b></td><td style='border: 1px solid #ACC6EE;'>" + discussion + "</td></tr></table><br>";
                String endLine = "<br>Thanks,";
                String signature = "<br>eTracker&trade;<br>";
                String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                String lineBreak = "<br> <br>";
                String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a><br>";
                htmlContent = htmlContent + feedBackContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                String Subject = location + "-" + momtime + " Mom  for " + team + " feedback";
                SendMail.sendMOMMail(htmlContent, Subject);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            e.printStackTrace();
        } finally {
            session.removeAttribute("perviousAttendance");
            session.removeAttribute("sendMomFormBean");
        }
    }

    public List<MomUserAttandance> getUserAttendanceByCurrentMonth(Map<Integer, String> attuser) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        List<MomUserAttandance> momUserAttandanceList = new ArrayList<MomUserAttandance>();

        try {
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
            setTimeToBeginningOfDay(cal);
            Date start = cal.getTime();
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            setTimeToBeginningOfDay(cal);
            Date end = cal.getTime();

            String startdate = sdf.format(start);
            String enddate = sdf.format(end);

            List<MoMAttendance> moMAttendancesList = new LeaveBlancePeriodDAO().userAttendanceByMomths(startdate, enddate);
            for (Map.Entry<Integer, String> entry : attuser.entrySet()) {
                MomUserAttandance momUserAttandance = new MomUserAttandance();
                Integer present = 0;
                Integer intimated = 0;
                Integer permission = 0;
                Integer clientMeeting = 0;
                Integer unintimated = 0;
                Integer approveleave = 0;
                Integer medicalLeave = 0;
                for (MoMAttendance uds : moMAttendancesList) {
                    if (uds.getUserId().intValue() == entry.getKey()) {
                        if (uds.getStatus().equalsIgnoreCase("Present")) {
                            present = present + uds.getCount();
                        } else if (uds.getStatus().contains("Permission")) {
                            permission = permission + uds.getCount();
                        } else if (uds.getStatus().contains("Intimated")) {
                            intimated = intimated + uds.getCount();
                        } else if (uds.getStatus().contains("Client")) {
                            clientMeeting = clientMeeting + uds.getCount();
                        } else if (uds.getStatus().contains("Unintimated")) {
                            unintimated = unintimated + uds.getCount();
                        } else if (uds.getStatus().contains("Medical")) {
                            medicalLeave = medicalLeave + uds.getCount();
                        } else if (uds.getStatus().contains("Approved")) {
                            approveleave = approveleave + uds.getCount();
                        }
                    }
                }
                momUserAttandance.setPresent(present);
                momUserAttandance.setPermission(permission);
                momUserAttandance.setIntimated(intimated);
                momUserAttandance.setUnintimated(unintimated);
                momUserAttandance.setMedicalleave(medicalLeave);
                momUserAttandance.setApproveleave(approveleave);
                momUserAttandance.setClinet(clientMeeting);
                momUserAttandance.setUserid(entry.getKey());
                momUserAttandanceList.add(momUserAttandance);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return momUserAttandanceList;
    }

    private static void setTimeToBeginningOfDay(Calendar calendar) {
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
    }

    public void getPreviousAttendance(HttpServletRequest request) {
        String dateFor = request.getParameter("datefor");
        String mtime = request.getParameter("mtime");
        Map<Integer, String> attendanceForUsers = MoMUtil.attendanceDetailsWithTime(dateFor, mtime);
        request.getSession().setAttribute("perviousAttendance", attendanceForUsers);
    }

    public List<MomMaintanance> getMomMaintanance() {
        return momMaintanance;
    }

    public void setMomMaintanance(List<MomMaintanance> momMaintanance) {
        this.momMaintanance = momMaintanance;
    }

    public Map<Integer, String> getEminentUsers() {
        return eminentUsers;
    }

    public void setEminentUsers(Map<Integer, String> eminentUsers) {
        this.eminentUsers = eminentUsers;
    }

    public Map<Integer, List<MomMaintanance>> getMaintanace() {
        return maintanace;
    }

    public void setMaintanace(Map<Integer, List<MomMaintanance>> maintanace) {
        this.maintanace = maintanace;
    }

    public Map<Integer, String> getNotApplicableUsers() {
        return notApplicableUsers;
    }

    public void setNotApplicableUsers(Map<Integer, String> notApplicableUsers) {
        this.notApplicableUsers = notApplicableUsers;
    }

    public Set<Integer> getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(Set<Integer> totalUsers) {
        this.totalUsers = totalUsers;
    }

}
