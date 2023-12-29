/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.branch.BranchController;
import com.eminent.issue.controller.Escalation;
import com.eminent.issue.dao.EscalationDAO;
import com.eminent.issue.dao.EscalationDAOImpl;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.mom.controller.MomMaintananceController;
import com.eminentlabs.mom.controller.SendMomMaintainController;
import com.eminentlabs.mom.controller.ViewMomController;
import com.eminentlabs.mom.formbean.FeedBackForm;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class FeedBackCommand {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger("FeedBackCommand");
    }
    private String requestpag;
    int requestpage, pageone, pageremain, rowcount;
    static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
    private String startTimeH;
    private String startTimeM;
    private String startTimeS;
    private String endTimeM;
    private String endTimeH;
    private String endTimeS;
    private int chairPerson;
    private String feedBack;
    private String dateFor;
    private int userId;
    private int momTeamType, branch;
    private String keys;
    private String lastFeedBack;
    private String discussion,escalationCount;
    List<MomMaintanance> momUsers = new ArrayList<MomMaintanance>();
    List<Escalation> escalatdIssues = new ArrayList<>();
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    MomMaintananceController mmc = new MomMaintananceController();
    Map<Integer, String> momTypeList = new LinkedHashMap<Integer, String>();
    List<String> modList = Arrays.asList(noOfIds);
    Calendar c = new GregorianCalendar();
    Date date = c.getTime();
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    SimpleDateFormat sdffulltime = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
    SimpleDateFormat fulltime = new SimpleDateFormat("HH:mm:ss a");
    SimpleDateFormat time = new SimpleDateFormat("HH");
    SimpleDateFormat mins = new SimpleDateFormat("mm");
    SimpleDateFormat secs = new SimpleDateFormat("ss");
    String timeFor = time.format(date);
    int current_time = Integer.parseInt(timeFor);
    String momTime = "Morning";
    MomFeedback momFeedback = new MomFeedback();
    List<FeedBackForm> momFeedbacks = new ArrayList<FeedBackForm>();
    List<FeedBackForm> totalFeedbacks = new ArrayList<FeedBackForm>();

    public void setAll(HttpServletRequest request) {
        HttpSession session = request.getSession();
        userId = (Integer) session.getAttribute("userid_curr");
        ViewMomController viewMomController = new ViewMomController();
        List<MomMaintanance> mmList = mmc.findAll();
        Map<Integer, List<MomMaintanance>> mmcSplit = mmc.splitLists(mmList);
        momTypeList = viewMomController.momTypeMaintanance();
        MomMaintanance mm = mmc.findByList(mmList, userId);
        String momTeamsType = request.getParameter("momTeamType");
        BranchController bc = new BranchController();
        bc.getAllBranchMap();
        Map<Integer,String> branchMap= bc.getBranchMap();
        EscalationDAO escalationDAO = new EscalationDAOImpl();
        escalationCount = escalationDAO.getEscalationCount();
        escalatdIssues = escalationDAO.getEscalation();
        branchMap.put(0, "All");
         SendMomMaintainController smmc = new SendMomMaintainController();
        smmc.getLocationNBranch(userId);
        if (mm == null) {
            if (momTeamsType == null) {
                momTeamType = 0;
            } else {
                momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
            }
        } else {
            if (momTeamsType == null) {
                momTeamType = mm.getTeam();
            } else {
                if ("".equals(momTeamsType)) {

                } else {
                    momTeamType = mm.getTeam();
                    momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
                }
            }
        }
        String branchId = request.getParameter("branch");
        if (branchId != null) {
            if ("".equals(branchId)) {
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = smmc.getSendMomMaintenance().getBranchId() == null ? (Integer) session.getAttribute("branch") : smmc.getSendMomMaintenance().getBranchId();
        }
        if (momTeamType == 1) {
            momUsers = mmcSplit.get(1);
        } else if (momTeamType == 2 || momTeamType == 3) {
            momUsers = mmcSplit.get(2);
            momUsers.addAll(mmcSplit.get(3));
            momTeamType = 2;
        } else {
            momUsers.addAll(mmList);
        }
        Map<Integer, Set<Integer>> branchwiseUsers = GetProjectMembers.getUsersByBranch();
        List<MomMaintanance> momUsersa = new ArrayList<MomMaintanance>();
       
        if(branch>0){
        Set<Integer> users = branchwiseUsers.get(branch);
        if (users == null) {
        } else {
            for (MomMaintanance mmce : momUsers) {
                for (Integer user : users) {
                    if (user == mmce.getUserid()) {
                        momUsersa.add(mmce);
                    }
                }
            }
            momUsers.clear();
            momUsers.addAll(momUsersa);
        }
        }
        keys = "";
        Map<Integer, List<MomMaintanance>> needTeams = mmc.splitLists(momUsers);
        for (Integer key : needTeams.keySet()) {
            keys = keys + key + ",";
        }
        keys = keys.substring(0, keys.length() - 1);
        updateMoMDetails(request);
        if (current_time > 14) {
            momTime = "Evening";
        }
        
        requestpag = request.getParameter("manipulation");
        request.getSession().setAttribute("forwardpage", "/MOM/feedBackCommand.jsp");
        List<Integer> teams = new ArrayList<Integer>();
        if (momTeamType == 0) {
            teams.add(momTeamType);
            teams.add(1);
            teams.add(2);
        } else {
            teams.add(momTeamType);
            teams.add(0);
        }

        List<MomFeedback> momFeedbacksList = MoMUtil.findAllMomFeedBacks(teams, branch);

        int i = 1;
        if (momFeedbacksList != null) {
            Date momdate = null;
            FeedBackForm feedBackForm = new FeedBackForm();
            for (MomFeedback mfb : momFeedbacksList) {
                if (momdate == null) {
                    feedBackForm.setMomdate(sdf.format(mfb.getMomdate()));
                    feedBackForm.setName(member.get(mfb.getChairperson()));
                    String momType = "";
                    if (momTypeList.get(mfb.getMomTeamType()) != null) {
                        momType = momTypeList.get(mfb.getMomTeamType());

                    } else {
                        momType = "All";

                    }
                    if (mfb.getFeedback() == null) {
                        mfb.setFeedback("NA");
                    }
                    if (mfb.getMomTime().equalsIgnoreCase("Morning")) {
                        String disscuss = "";
                        if (mfb.getDiscussion() == null) {
                        } else {
                            disscuss = "<b>Discussion : </b>" + mfb.getDiscussion();
                        }
                        if (mfb.getMomTeamType() == 0) {
                            feedBackForm.setMorningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/> " + disscuss);
                        } else {
                            feedBackForm.setMorningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        }
                    }
                    if (mfb.getMomTime().equalsIgnoreCase("Evening")) {
                        String disscuss = "";
                        if (mfb.getDiscussion() == null) {
                        } else {
                            disscuss = "<b>Discussion : </b>" + mfb.getDiscussion();
                        }
                        if (mfb.getMomTeamType() == 0) {
                            feedBackForm.setName(member.get(mfb.getChairperson()));
                            feedBackForm.setEveningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        } else {
                            feedBackForm.setName(member.get(mfb.getChairperson()));
                            feedBackForm.setEveningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        }
                    }
                } else if (momdate.compareTo(mfb.getMomdate()) == 0) {
                    String momType = "";
                    if (momTypeList.get(mfb.getMomTeamType()) != null) {
                        momType = momTypeList.get(mfb.getMomTeamType());

                    } else {
                        momType = "All";

                    }
                    if (mfb.getFeedback() == null) {
                        mfb.setFeedback("NA");
                    }
                    if (mfb.getMomTime().equalsIgnoreCase("Morning")) {
                        String disscuss = "";
                        if (mfb.getDiscussion() == null) {
                        } else {
                            disscuss = "<b>Discussion : </b>" + mfb.getDiscussion();
                        }
                        if (mfb.getMomTeamType() == 0) {
                            feedBackForm.setMorningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        } else {
                            feedBackForm.setMorningFeedBack(feedBackForm.getMorningFeedBack() + "<br/><br/>" + " <b>Branch </b> : " + branchMap.get(branch) + ",<b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        }
                    }
                    if (mfb.getMomTime().equalsIgnoreCase("Evening")) {
                        String disscuss = "";
                        if (mfb.getDiscussion() == null) {
                        } else {
                            disscuss = "<b>Discussion : </b>" + mfb.getDiscussion();
                        }
                        if (mfb.getMomTeamType() == 0) {
                            feedBackForm.setName(member.get(mfb.getChairperson()));
                            if (feedBackForm.getEveningFeedBack() == null) {
                                feedBackForm.setEveningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                            } else {
                                feedBackForm.setEveningFeedBack(feedBackForm.getEveningFeedBack() + "<br/><br/>" + " <b>Branch </b> : " + branchMap.get(branch) + ",<b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + "<b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                            }
                        } else {
                            feedBackForm.setName(member.get(mfb.getChairperson()));
                            if (feedBackForm.getEveningFeedBack() == null) {
                                feedBackForm.setEveningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + ", Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                            } else {
                                feedBackForm.setEveningFeedBack(feedBackForm.getEveningFeedBack() + "<br/><br/>" + " <b>Branch </b> : " + branchMap.get(branch) + ",<b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team </b> : (" + momType + ")" + ", <b>Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                            }
                        }
                    }

                } else {
                    totalFeedbacks.add(feedBackForm);
                    feedBackForm = new FeedBackForm();

                    feedBackForm.setMomdate(sdf.format(mfb.getMomdate()));
                    feedBackForm.setName(member.get(mfb.getChairperson()));
                    String momType = "";
                    if (momTypeList.get(mfb.getMomTeamType()) != null) {
                        momType = momTypeList.get(mfb.getMomTeamType());

                    } else {
                        momType = "All";

                    }
                    if (mfb.getFeedback() == null) {
                        mfb.setFeedback("NA");
                    }
                    if (mfb.getMomTime().equalsIgnoreCase("Morning")) {
                        String disscuss = "";
                        if (mfb.getDiscussion() == null) {
                        } else {
                            disscuss = "<b>Discussion : </b>" + mfb.getDiscussion();
                        }
                        if (mfb.getMomTeamType() == 0) {
                            feedBackForm.setMorningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + ", Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        } else {
                            feedBackForm.setMorningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + ", Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        }
                    }
                    if (mfb.getMomTime().equalsIgnoreCase("Evening")) {
                        String disscuss = "";
                        if (mfb.getDiscussion() == null) {
                        } else {
                            disscuss = "<b>Discussion : </b>" + mfb.getDiscussion();
                        }
                        if (mfb.getMomTeamType() == 0) {
                            feedBackForm.setName(member.get(mfb.getChairperson()));
                            feedBackForm.setEveningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + ", Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        } else {
                            feedBackForm.setName(member.get(mfb.getChairperson()));
                            feedBackForm.setEveningFeedBack("<b>Branch </b> : " + branchMap.get(branch) + ", <b>Chair Person</b> : " + member.get(mfb.getChairperson()) + ", <b>Team</b> : (" + momType + ")" + ", Start Time</b> : " + fulltime.format(mfb.getStarttime()) + ", <b>End Time</b> : " + fulltime.format(mfb.getEndtime()) + "<br/><br/>" + mfb.getFeedback() + "<br/><br/>" + disscuss);
                        }
                    }
                }
                momdate = mfb.getMomdate();
            }
            if (feedBackForm.getMomdate() != null) {
                totalFeedbacks.add(feedBackForm);
            }
            rowcount = totalFeedbacks.size();
            pageone = rowcount / 15;
            pageremain = rowcount % 15;
            if (pageremain > 0) {
                totalpage = pageone + 1;
            } else {
                totalpage = pageone;
            }

            if (requestpag != null) {
                requestpage = Integer.parseInt(requestpag);

                if (requestpage == 1) {
                    presentpage = 1;
                    issuenofrom = 1;
                    issuenoto = issuenofrom + 14;
                    if (issuenoto > rowcount) {
                        extra = issuenoto - rowcount;
                        issuenoto = issuenoto - extra;
                    }
                }
                if (requestpage == 2) {
                    presentpage = presentpage - 1;
                    if (presentpage <= 0) {
                        presentpage = 1;
                    }
                    if (presentpage == 1) {
                        issuenofrom = 1;
                        issuenoto = issuenofrom + 14;
                        if (issuenoto > rowcount) {
                            extra = issuenoto - rowcount;
                            issuenoto = issuenoto - extra;
                        }
                    } else {
                        issuenofrom = ((presentpage - 1) * 15 + 1);
                        issuenoto = issuenofrom + 14;
                        if (issuenoto > rowcount) {
                            extra = issuenoto - rowcount;
                            issuenoto = issuenoto - extra;
                        }
                    }
                }
                if (requestpage == 3) {
                    presentpage = presentpage + 1;
                    if (presentpage >= totalpage) {
                        presentpage = totalpage;
                    }
                    issuenofrom = ((presentpage - 1) * 15 + 1);
                    issuenoto = issuenofrom + 14;
                    if (issuenoto > rowcount) {
                        extra = issuenoto - rowcount;
                        issuenoto = issuenoto - extra;
                    }
                }
                if (requestpage == 4) {
                    presentpage = totalpage;
                    issuenofrom = ((presentpage - 1) * 15 + 1);
                    issuenoto = issuenofrom + 14;
                    if (issuenoto > rowcount) {
                        extra = issuenoto - rowcount;
                        issuenoto = issuenoto - extra;
                    }
                }
            } else {
                presentpage = 1;
                issuenofrom = 1;
                issuenoto = issuenofrom + 14;
                if (issuenoto > rowcount) {
                    extra = issuenoto - rowcount;
                    issuenoto = issuenoto - extra;
                }
            }
        }
        for (FeedBackForm feedBackForm : totalFeedbacks) {
            if (i > issuenofrom - 1 && i < issuenoto + 1) {
                momFeedbacks.add(feedBackForm);

            }
            i++;
        }
        dateFor = sdf.format(date);

        logger.info("momTeamType" + momTeamType);
        momFeedback = MoMUtil.uniqueMomFeedBack(momTime, date, momTeamType, branch);
        if (momFeedback != null) {
            startTimeH = time.format(momFeedback.getStarttime());
            startTimeM = mins.format(momFeedback.getStarttime());
            startTimeS = secs.format(momFeedback.getStarttime());
            endTimeH = time.format(momFeedback.getEndtime());
            endTimeM = mins.format(momFeedback.getEndtime());
            endTimeS = secs.format(momFeedback.getEndtime());
            chairPerson = momFeedback.getChairperson();
            feedBack = momFeedback.getFeedback();
            discussion = momFeedback.getDiscussion();
                branch=momFeedback.getBranchId();
            if (feedBack == null) {
                feedBack = "";
            }
        } else {
            startTimeH = "00";
            startTimeM = "00";
            startTimeS = "00";
            endTimeH = "00";
            endTimeM = "00";
            endTimeS = "00";
            feedBack = "";
        }
    }

    public String getProjectSplit() throws SQLException {
        String projectSplit = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, Integer> updatedUsers = new LinkedHashMap<String, Integer>();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select count, NVL(substr(pname,1,instr(pname,' ')),pname)  from project p, (select count(*)as count,p.pid from mom_user_task, PROJECT_PLANNED_ISSUE p where type='Issue' and p.status='Active' and tasktime='Planned' and to_char(momdate,'dd-MM-yyyy') = to_char(sysdate,'dd-MM-yyyy') and p.issueid=SUBSTR(task,0,12) and to_char(p.plannedon,'dd-MM-yyyy') = to_char(sysdate,'dd-MM-yyyy') group by p.pid) r where p.pid=r.pid order by count desc");
            updatedUsers = weeklyUnTouched();
            while (resultset.next()) {
                String name = resultset.getString(2).trim();
                if (updatedUsers.containsKey(name)) {
                    projectSplit = projectSplit + resultset.getString(2).trim() + "= " + resultset.getInt(1) + "/" + updatedUsers.get(name) + ", ";
                    updatedUsers.remove(name);
                } else {
                    projectSplit = projectSplit + resultset.getString(2).trim() + "= " + resultset.getInt(1) + "/0" + ", ";
                }

            }
            String noPlanned = "";
            for (Map.Entry<String, Integer> entry : updatedUsers.entrySet()) {
                noPlanned = noPlanned + entry.getKey().trim() + "= 0/" + entry.getValue() + ", ";
            }
            projectSplit = "Project Wise(Planned/WRM UnTouched) Count: " + projectSplit + noPlanned;
            if (projectSplit.contains(",")) {
                projectSplit = projectSplit.substring(0, projectSplit.length() - 2);
            }

        } catch (Exception e) {
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

        return projectSplit;
    }

    public Map<String, Integer> weeklyUnTouched() throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, Integer> updatedUsers = new LinkedHashMap<String, Integer>();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select (r.count-u.count) as final,NVL(substr(pname,1,instr(pname,' ')),pname) from updated u, (select count(Distinct(i.issueid)) as count,i.pid from issue i,issuestatus s,project p,Apm_Wrm_Plan ap where  ap.pid=i.pid and ap.pid=p.pid  and p.STATUS='Work in progress' And pmanager <> 104   and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select to_char(MAX(wrmday),'DD-Mon-YYYY'),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' group by i.pid )r,project p where u.pid=r.pid and r.pid=p.pid and r.count-u.count > 0 order by final desc");
            while (resultset.next()) {
                updatedUsers.put(resultset.getString(2).trim(), resultset.getInt(1));
            }
        } catch (Exception e) {
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

    public String consultantWiseUnTouched(String momTeamType) throws SQLException {
        String consultantSplit = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select count(Distinct(i.issueid))  as count,assignedTo from issuecomments ic,issue i ,issuestatus s,project p,modules m,users u, users us\n" +
" where ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid  and u.userid=i.assignedto  \n" +
"and i.module_id =m.moduleid and us.userid=i.createdby and s.status!='Closed' and i.issueid not\n" +
" in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,MOM_Maintanance mm  where mm.userid=ic.commentedby\n" +
" and mm.team in(" + momTeamType + ") and   ic.issueid=i.issueid and s.issueid=i.issueid   and i.issueid in(select Distinct(i.issueid) as issueid  from \n" +
"issuecomments ic,issue i ,issuestatus s,project p,users u, MOM_Maintanance mm   where mm.userid=ic.commentedby and mm.team in(" + momTeamType + ")\n" +
" and  to_date(ic.comment_date,'DD-MM-YY')=to_date(sysdate,'DD-MM-YY')   and  ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid and \n" +
"u.userid=i.assignedTo  And pmanager <> 104 and  s.status!='Closed' )) and i.issueid in(select issue from (select Distinct(SUBSTR(task,0,12)) \n" +
"as issue from mom_user_task t, mom_maintanance mm \n" +
" where mm.userid=t.userid and mm.team in (" + momTeamType + ") and type='Issue' and tasktime='Planned'\n" +
" and to_char(momdate,'dd-Mon-yyyy') = to_char(sysdate,'dd-Mon-yyyy')),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = to_char(sysdate,'dd-Mon-yyyy')) group by assignedto order by count desc");

            int count = 0;
            while (resultset.next()) {
                if (member.containsKey(resultset.getInt(2))) {
                    consultantSplit = consultantSplit + member.get(resultset.getInt(2)) + "= " + resultset.getInt(1) + ", ";
                    count = count + resultset.getInt(1);
                }

            }
            consultantSplit = "Consultant Wise UnTouched(" + count + "): " + consultantSplit;
            if (consultantSplit.contains(",")) {
                consultantSplit = consultantSplit.substring(0, consultantSplit.length() - 2);
            }

        } catch (Exception e) {
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

        return consultantSplit;
    }

    public void updateMoMDetails(HttpServletRequest request) {
        String cPerson = request.getParameter("chairPerson");
        String fBack = request.getParameter("feedBackComment");
        String disscussion = request.getParameter("discussionComment");
        String branchId = request.getParameter("branch");
        HttpSession session = request.getSession();
        userId = (Integer) request.getSession().getAttribute("userid_curr");
        int chPersonId = MoMUtil.parseInteger(cPerson, 0);
        if (branchId != null) {
            branch = MoMUtil.parseInteger(branchId, 0);
        } else {
            branch = (Integer) session.getAttribute("branch");
        }
        logger.info(chPersonId);

        if (fBack != null) {
            if (current_time > 14) {
                momTime = "Evening";
            }
            String startH = request.getParameter("startH");
            String startM = request.getParameter("startM");
            String startS = request.getParameter("startS");
            String endH = request.getParameter("endH");
            String endM = request.getParameter("endM");
            String endS = request.getParameter("endS");

            try {
                MomFeedback feedback = MoMUtil.uniqueMomFeedBack(momTime, date, momTeamType, branch);
                if (feedback != null) {
                    logger.info("feedback.getChairperson()" + feedback.getChairperson());
                    feedback.setChairperson(chPersonId);
                    feedback.setModifiedon(date);
                    feedback.setStarttime(sdffulltime.parse(sdf.format(date) + " " + startH + ":" + startM + ":" + startS));
                    feedback.setEndtime(sdffulltime.parse(sdf.format(date) + " " + endH + ":" + endM + ":" + endS));
                    feedback.setFeedback(fBack);
                    feedback.setFeedbackby(userId);
                    feedback.setMomTeamType(momTeamType);
                    feedback.setDiscussion(disscussion);
                    feedback.setBranchId(branch);
                    DAOFactory.createMOMFeedBack(feedback);
                    lastFeedBack = fBack;
                }
            } catch (Exception ex) {
                logger.error("Error message: " + ex.getMessage());
            }
        }
    }

    public int getCurrent_time() {
        return current_time;
    }

    public void setCurrent_time(int current_time) {
        this.current_time = current_time;
    }

    public MomFeedback getMomFeedback() {
        return momFeedback;
    }

    public void setMomFeedback(MomFeedback momFeedback) {
        this.momFeedback = momFeedback;
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

    public String getStartTimeS() {
        return startTimeS;
    }

    public void setStartTimeS(String startTimeS) {
        this.startTimeS = startTimeS;
    }

    public String getEndTimeM() {
        return endTimeM;
    }

    public void setEndTimeM(String endTimeM) {
        this.endTimeM = endTimeM;
    }

    public String getEndTimeH() {
        return endTimeH;
    }

    public void setEndTimeH(String endTimeH) {
        this.endTimeH = endTimeH;
    }

    public String getEndTimeS() {
        return endTimeS;
    }

    public void setEndTimeS(String endTimeS) {
        this.endTimeS = endTimeS;
    }

    public int getChairPerson() {
        return chairPerson;
    }

    public void setChairPerson(int chairPerson) {
        this.chairPerson = chairPerson;
    }

    public String getFeedBack() {
        return feedBack;
    }

    public void setFeedBack(String feedBack) {
        this.feedBack = feedBack;
    }

    public String getDateFor() {
        return dateFor;
    }

    public String getMomTime() {
        return momTime;
    }

    public void setMomTime(String momTime) {
        this.momTime = momTime;
    }

    public void setDateFor(String dateFor) {
        this.dateFor = dateFor;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public String getRequestpag() {
        return requestpag;
    }

    public void setRequestpag(String requestpag) {
        this.requestpag = requestpag;
    }

    public int getRequestpage() {
        return requestpage;
    }

    public void setRequestpage(int requestpage) {
        this.requestpage = requestpage;
    }

    public int getPageone() {
        return pageone;
    }

    public void setPageone(int pageone) {
        this.pageone = pageone;
    }

    public int getPageremain() {
        return pageremain;
    }

    public void setPageremain(int pageremain) {
        this.pageremain = pageremain;
    }

    public int getRowcount() {
        return rowcount;
    }

    public void setRowcount(int rowcount) {
        this.rowcount = rowcount;
    }

    public static int getTotalpage() {
        return totalpage;
    }

    public static void setTotalpage(int totalpage) {
        FeedBackCommand.totalpage = totalpage;
    }

    public static int getPagemanipulation() {
        return pagemanipulation;
    }

    public static void setPagemanipulation(int pagemanipulation) {
        FeedBackCommand.pagemanipulation = pagemanipulation;
    }

    public static int getPresentpage() {
        return presentpage;
    }

    public static void setPresentpage(int presentpage) {
        FeedBackCommand.presentpage = presentpage;
    }

    public List<MomMaintanance> getMomUsers() {
        return momUsers;
    }

    public void setMomUsers(List<MomMaintanance> momUsers) {
        this.momUsers = momUsers;
    }

    public String getKeys() {
        return keys;
    }

    public void setKeys(String keys) {
        this.keys = keys;
    }

    public static int getIssuenofrom() {
        return issuenofrom;
    }

    public static void setIssuenofrom(int issuenofrom) {
        FeedBackCommand.issuenofrom = issuenofrom;
    }

    public static int getIssuenoto() {
        return issuenoto;
    }

    public static void setIssuenoto(int issuenoto) {
        FeedBackCommand.issuenoto = issuenoto;
    }

    public Map<Integer, String> getMomTypeList() {
        return momTypeList;
    }

    public void setMomTypeList(Map<Integer, String> momTypeList) {
        this.momTypeList = momTypeList;
    }

    public int getMomTeamType() {
        return momTeamType;
    }

    public void setMomTeamType(int momTeamType) {
        this.momTeamType = momTeamType;
    }

    public List<FeedBackForm> getMomFeedbacks() {
        return momFeedbacks;
    }

    public void setMomFeedbacks(List<FeedBackForm> momFeedbacks) {
        this.momFeedbacks = momFeedbacks;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public String getLastFeedBack() {
        if (lastFeedBack != null) {
            String lines[] = lastFeedBack.split("\\n");
            lastFeedBack = "";
            for (String line : lines) {
                if (!line.isEmpty() || !line.equalsIgnoreCase("")) {
                    lastFeedBack = lastFeedBack + line.trim() + " <br/>";
                }
            }
        }
        return lastFeedBack;
    }

    public void setLastFeedBack(String lastFeedBack) {
        this.lastFeedBack = lastFeedBack;
    }

    public String getDiscussion() {
        if (discussion == null) {
            discussion = "";
        }
        return discussion;
    }

    public void setDiscussion(String discussion) {
        this.discussion = discussion;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

    public String getEscalationCount() {
        return escalationCount;
    }

    public void setEscalationCount(String escalationCount) {
        this.escalationCount = escalationCount;
    }

    public List<Escalation> getEscalatdIssues() {
        return escalatdIssues;
    }

    public void setEscalatdIssues(List<Escalation> escalatdIssues) {
        this.escalatdIssues = escalatdIssues;
    }
    
    

}
