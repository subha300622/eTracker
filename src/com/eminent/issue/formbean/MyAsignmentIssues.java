
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

import static com.eminent.issue.formbean.MyAsignmentIssues.logger;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import com.eminent.resource.ResourceRequestBean;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminentlabs.appraisal.AppraisalUtil;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.erm.ERMUtil;
import com.eminentlabs.mom.MoMUtil;
import com.pack.CRMIssueBean;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class MyAsignmentIssues {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("MyAsignmentIssues");

    }
    private String requestpag;
    int pageNo;

    private Integer userId;
    private int total;
    private String assignmentType = "";
    private String url = null;
    private int bCount;
    private int cuCount;
    private int nxCount;
    private int atCount;
    private int alCount;
    private int noOfRequests;
    private int noOfTimeSheet;
    private int noOfTce;
    private int crmIssues;
    private String for_ward;
    private int resourceRequest;
    private int appraisalReq;
    private int ermAssignment;
    HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
    List<UserPlannedIssues> plannedIssuesList = new ArrayList<>();
    List<String> wrmIssueList = new ArrayList<String>();
    List<String> wrmTouchedIssues = new ArrayList();

    public void setAll(HttpServletRequest request) throws SQLException, Exception {
        request.getSession().setAttribute("forwardpage", "/MyAssignment/UpdateIssue.jsp");
        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy");
//        WrmIssuesController wic = new WrmIssuesController();
//        wrmTouchedIssues = wic.wrmTouchedByEspl("");
        String pageNumber = request.getParameter("pageNumber");
        String user = request.getParameter("userId");
        int requestUser = MoMUtil.parseInteger(user, 0);
        pageNo = MoMUtil.parseInteger(pageNumber, 1);
        int rowStart = 1, rowEnd = 15;
        rowStart = (pageNo - 1) * 15 + 1;
        rowEnd = rowStart + 14;
        Calendar c = Calendar.getInstance();
        Date start = c.getTime();
        String startDate = sdfs.format(start);
        userId = (Integer) request.getSession().getAttribute("userid_curr");
        if (requestUser > 0) {
            userId = requestUser;
        }
        CRMIssueBean CRMIssue = new CRMIssueBean();
        ResourceRequestBean resourceRequestBean = new ResourceRequestBean();

        String mail = (String) request.getSession().getAttribute("theName");
        requestpag = request.getParameter("manipulation");
        if (mail != null) {
            url = mail.substring(mail.indexOf("@") + 1, mail.length());
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            plannedIssuesList = MoMUtil.todayPlannedByUser(startDate, userId);
            crmIssues = CRMIssue.getCRMIssues(userId);
            for_ward = CRMIssue.getHigestCRMIssues(userId, userId);
            resourceRequest = resourceRequestBean.getResourceRequestNumber(userId);
            appraisalReq = AppraisalUtil.getNoOfAppraisalRequest(userId);
            ermAssignment = ERMUtil.getAssignedApplicantCount(userId);
            Map<String, Integer> counts = IssueDetails.bgcount(userId.toString());
            bCount = counts.get("bgcount");
            cuCount = counts.get("cwcount");
            nxCount = counts.get("nwcount");
            atCount = counts.get("atwcount");
            alCount = counts.get("allcount");
            noOfRequests = counts.get("wapcount");
            noOfTimeSheet = counts.get("tmscount");
            noOfTce = counts.get("tcecount");
        }
        String query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        if (request.getParameter("assignmentType") != null) {
            assignmentType = request.getParameter("assignmentType");
        } else {
            assignmentType = "all";
        }
        if (!url.equalsIgnoreCase("eminentlabs.net")) {
            assignmentType = "";
        }
        if (assignmentType.equalsIgnoreCase("backlog")) {
            query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date < sysdate-1 order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        } else if (assignmentType.equalsIgnoreCase("currentWeek")) {
            query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date > sysdate-1 and i.due_date<=(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        } else if (assignmentType.equalsIgnoreCase("nextWeek")) {
            query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) and i.due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        } else if (assignmentType.equalsIgnoreCase("afterTwoWeeks")) {
            query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        } else {
            query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        }
        myAssignments(userId, query, rowStart, rowEnd);
        wrmIssueList = wrmIssuesByuserid(userId);
        wrmTouchedIssues = wrmTouchedIssuesByuserid(userId);
    }

    public void myAssignments(int userId, String query, int rowStart, int rowEnd) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        Long startTime = cal.getTimeInMillis();
        try {

            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, userId);
            resultset = ps.executeQuery();
            cal.setTime(new Date());
            Long endTime = cal.getTimeInMillis();
            logger.info("MyAsignmentIssues **********resultset*****  total time :" + (endTime - startTime) + " ms");
            String totalissuenos = "";
            int i = 1;
            while (resultset.next()) {
                total++;
//                if (i > rowStart - 1 && i < rowEnd + 1) {
                //   if (resultset.next()) {
                totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
                //   }
//                }
                i++;
            }
            total = total / pageNo;
            logger.info("Total issues for the page" + totalissuenos);
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            List<LastAssginForm> lastAssign = new ArrayList<LastAssginForm>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                lastAssign = IssueDetails.lastAssign();
            }
            cal.setTime(new Date());
            endTime = cal.getTimeInMillis();
            logger.info("MyAsignmentIssues **********totalissuenos*****  total time :" + (endTime - startTime) + " ms");
            resultset.beforeFirst();
            i = 1;
            while (resultset.next()) {
//                if (i > rowStart - 1 && i < rowEnd + 1) {
                IssueFormBean isfb = new IssueFormBean();

                isfb.setSeverity(severityColor(resultset.getString("severity")));
                isfb.setIssueId(resultset.getString("issueid"));
                isfb.setType(resultset.getString("type"));

                String p = "NA";
                String pri = resultset.getString("priority");
                if (pri != null) {
                    p = pri.substring(0, 2);
                }
                isfb.setPriority(p);

                isfb.setpName(resultset.getString("project"));
                if (isfb.getpName().length() >= 15) {
                    isfb.setRedPName(isfb.getpName().substring(0, 14) + "..");
                } else {
                    isfb.setRedPName(resultset.getString("project"));
                }
                isfb.setmName(resultset.getString("module"));
                if (isfb.getmName().length() >= 10) {
                    isfb.setRedMName(isfb.getmName().substring(0, 9) + "..");
                } else {
                    isfb.setRedMName(resultset.getString("module"));
                }
                String sub = resultset.getString("subject");
                if (sub.length() > 42) {
                    sub = sub.substring(0, 42) + "...";
                }
                isfb.setSubject(sub);
                isfb.setDescription(resultset.getString("description"));
                String status = resultset.getString("status");
                isfb.setStatus(status);
                String dueDateFormat = resultset.getDate("due_date").toString();
                String dueDate = "NA";
                if (dueDateFormat != null) {
                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                }
                String dateString1 = sdf.format(dateConversion.parse(resultset.getDate("modifiedon").toString()));
                String create = sdf.format(dateConversion.parse(resultset.getDate("createdon").toString()));

                isfb.setDueDate(dueDate);
                if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                    isfb.setDueDateColor("red");
                } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                    isfb.setDueDateColor("red");
                } else {
                    isfb.setDueDateColor("#000000");
                }
                isfb.setModifiedOn(dateString1);
                isfb.setCreatedOn(create);
                if (resultset.getString("createdby") != null) {
                    isfb.setCreatedBy(member.get(Integer.valueOf(resultset.getString("createdby"))));
                }
                if (resultset.getString("assignedto") != null) {
                    isfb.setAssignto(member.get(Integer.valueOf(resultset.getString("assignedto"))));
                }
                int filesCount = 0;
                if (fileCountList.containsKey(resultset.getString("issueid"))) {
                    filesCount = fileCountList.get(resultset.getString("issueid"));
                }
                if (filesCount > 0) {
                    isfb.setRefer("View Files(" + filesCount + ")");
                } else {
                    isfb.setRefer("No Files");
                }
                int lastAsigneeAge = 1;
                if (lastAsigneeAgeList.containsKey(resultset.getString("issueid"))) {
                    lastAsigneeAge = lastAsigneeAgeList.get(resultset.getString("issueid"));
                }
                if (lastAsigneeAge == 1) {
                    lastAsigneeAge = resultset.getInt("age");
                }

                if (lastAsigneeAge == 0) {
                    lastAsigneeAge = lastAsigneeAge + 1;
                }
                isfb.setAge(resultset.getInt("age"));
                isfb.setLastAssigneeAge(lastAsigneeAge);

                for (LastAssginForm lastAssignForm : lastAssign) {
                    if (resultset.getString("issueid").equals(lastAssignForm.getIssueId())) {
                        isfb.setLastAssigneeName(lastAssignForm.getLastAssigneeName());
                        isfb.setLastModifiedOn(lastAssignForm.getLastModifiedOn());
                    }
                }
                issuesList.add(isfb);
//                }
                i++;
            }
            cal.setTime(new Date());
            endTime = cal.getTimeInMillis();
            logger.info("MyAsignmentIssues **********myAssignments*****  total time :" + (endTime - startTime) + " ms");
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

    }

    public static List getServiceOrderUsers() {
        List userList = new ArrayList();
        userList.add("112");
        userList.add("858");
        return userList;
    }

    public List<String> wrmIssues() {
        Session session = null;
        List<String> issueList = null;
        try {

            session = HibernateFactory.getCurrentSession();
            //  Query query = session.createSQLQuery("select i.issueid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed'");

            String sqlquery = "select i.issueid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select MAX(wrmday) as maxwrmday,pid from Apm_Wrm_Plan group by pid) apm where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid and to_char(ap.plannedon,'DD-Mon-YYYY')=apm.maxwrmday and ap.pid=apm.pid   and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed'";
            Query query = session.createSQLQuery(sqlquery);

            issueList = (List<String>) query.list();
            if (issueList == null) {
                issueList = new ArrayList();
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
        return issueList;

    }

    public List<String> wrmIssuesByuserid(int userid) {
        Session session = null;
        List<String> issueList = null;
        try {

            session = HibernateFactory.getCurrentSession();
            //  Query query = session.createSQLQuery("select i.issueid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed'");

            String sqlquery = "select i.issueid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select MAX(wrmday) as maxwrmday,pid from Apm_Wrm_Plan group by pid) apm where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid and to_char(ap.plannedon,'DD-Mon-YYYY')=apm.maxwrmday and ap.pid=apm.pid   and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' and i.assignedto = " + userid + "";
            Query query = session.createSQLQuery(sqlquery);

            issueList = (List<String>) query.list();
            if (issueList == null) {
                issueList = new ArrayList();
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
        return issueList;

    }

    public List<String> wrmTouchedIssuesByuserid(int userid) {
        Session session = null;
        List<String> issueList = null;
        try {

            session = HibernateFactory.getCurrentSession();
            //  Query query = session.createSQLQuery("select i.issueid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed'");

            String sqlquery = "select distinct(ISSUEID) from WRM_UPDATED where commentedby='" + userid + "'";
            Query query = session.createSQLQuery(sqlquery);

            issueList = (List<String>) query.list();
            if (issueList == null) {
                issueList = new ArrayList();
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
        return issueList;

    }

    public String checkPlannedIssues(HttpServletRequest request) {
        String message = "";
        String issueId = request.getParameter("issueid");
        userId = (Integer) request.getSession().getAttribute("userid_curr");
        List<UserPlannedIssues> updatedSeqIssueList = new LinkedList<>();
        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy");
        int seq = -1, noSeq = 0;
        Connection connection = null;
        Statement ps = null;
        ResultSet resultset = null;
        try {

            Calendar c = Calendar.getInstance();
            Date start = c.getTime();
            String startDate = sdfs.format(start);
            connection = MakeConnection.getConnection();
            String sqlquery = "select issue,slno,ic.COMMENTEDBY from (select issue,slno from (select Distinct(SUBSTR(task,0,12)) as issue,mut.sino as slno from mom_user_task mut \n"
                    + " where type='Issue' and tasktime='Planned' and userid='" + userId + "' and to_char(momdate,'dd-Mon-yyyy') = '" + startDate + "'),\n"
                    + "PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + startDate + "' order by slno) pl left join ISSUECOMMENTS ic on issue=ic.ISSUEID and ic.COMMENTEDBY='" + userId + "'\n"
                    + " and to_Date(to_char(ic.comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY')=to_Date(TO_CHAR(SYSDATE, 'DD-Mon-YYYY'),'DD-Mon-YY') ";
            ps = connection.prepareStatement(sqlquery, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = ps.executeQuery(sqlquery);
            while (resultset.next()) {
                UserPlannedIssues upi = new UserPlannedIssues();
                upi.setSino(resultset.getString(2));
                if (MoMUtil.parseInteger(upi.getSino(), 0) != 0) { // if no sequence,  noSeq = 0 else noSeq=1
                    noSeq = 1;
                }
                if (issueId.equalsIgnoreCase(resultset.getString(1))) { // seq for clicked isssue
                    seq = MoMUtil.parseInteger(upi.getSino(), 99);
                }
                upi.setIssueno(resultset.getString(1));
                upi.setCommenetBy(resultset.getString(3));
                updatedSeqIssueList.add(upi);
            }

            if (updatedSeqIssueList.isEmpty() || noSeq == 0) {  // no issues planned or no seq for all planned noSeq=0
                if (!updatedSeqIssueList.isEmpty() && seq == -1 && noSeq == 0) { // no seq for all planned (noSeq=0) but clicked not plannned seq=-1
                    message = "You can update only the planned issues";
                }
            } else {
                if (issueId.equalsIgnoreCase(updatedSeqIssueList.get(0).getIssueno())) { // toppest priority issue
                } else {
                    if (seq == -1) { //  unplannned 
                        for (UserPlannedIssues issues : updatedSeqIssueList) {
                            if (MoMUtil.parseInteger(issues.getSino(), 99) != 99 && issues.getCommenetBy() == null) {
                                message = "Please update order sequence " + issues.getSino() + " issue # " + issues.getIssueno()+" to proceed";
                                break;
                            } else if (MoMUtil.parseInteger(issues.getSino(), 99) == 99 && issues.getCommenetBy() == null) {
                                message = "You can update only the planned issues";
                                break;
                            }
                        }
                    } else {
                        for (UserPlannedIssues issues : updatedSeqIssueList) {
                            if (seq > MoMUtil.parseInteger(issues.getSino(), 99)) { // no planned or  no seq for particular
                                if (issues.getCommenetBy() == null) {
                                    message = "Please update order sequence " + issues.getSino() + " issue # " + issues.getIssueno()+" to proceed";
                                    break;
                                }
                            }
                        }
                    }

                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return message;
    }

    public String checkplannningSequ(List<UserPlannedIssues> updatedSeqIssueList, int seq, String clikcedSIssue) {
        String issue = "";
        if (clikcedSIssue.equalsIgnoreCase(updatedSeqIssueList.get(0).getIssueno())) {
            issue = "";
        } else {
            for (UserPlannedIssues issues : updatedSeqIssueList) {
                if (issues.getCommenetBy() == null) {
                    issue = issues.getSino() + "-" + issues.getIssueno();
                    break;
                }
            }
        }

        return issue;
    }

    public String getRequestpag() {
        return requestpag;
    }

    public void setRequestpag(String requestpag) {
        this.requestpag = requestpag;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getAssignmentType() {
        return assignmentType;
    }

    public void setAssignmentType(String assignmentType) {
        this.assignmentType = assignmentType;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getbCount() {
        return bCount;
    }

    public void setbCount(int bCount) {
        this.bCount = bCount;
    }

    public int getCuCount() {
        return cuCount;
    }

    public void setCuCount(int cuCount) {
        this.cuCount = cuCount;
    }

    public int getNxCount() {
        return nxCount;
    }

    public void setNxCount(int nxCount) {
        this.nxCount = nxCount;
    }

    public int getAtCount() {
        return atCount;
    }

    public void setAtCount(int atCount) {
        this.atCount = atCount;
    }

    public int getAlCount() {
        return alCount;
    }

    public void setAlCount(int alCount) {
        this.alCount = alCount;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public int getNoOfRequests() {
        return noOfRequests;
    }

    public void setNoOfRequests(int noOfRequests) {
        this.noOfRequests = noOfRequests;
    }

    public int getNoOfTimeSheet() {
        return noOfTimeSheet;
    }

    public void setNoOfTimeSheet(int noOfTimeSheet) {
        this.noOfTimeSheet = noOfTimeSheet;
    }

    public int getNoOfTce() {
        return noOfTce;
    }

    public void setNoOfTce(int noOfTce) {
        this.noOfTce = noOfTce;
    }

    public int getCrmIssues() {
        return crmIssues;
    }

    public void setCrmIssues(int crmIssues) {
        this.crmIssues = crmIssues;
    }

    public String getFor_ward() {
        return for_ward;
    }

    public void setFor_ward(String for_ward) {
        this.for_ward = for_ward;
    }

    public int getResourceRequest() {
        return resourceRequest;
    }

    public void setResourceRequest(int resourceRequest) {
        this.resourceRequest = resourceRequest;
    }

    public int getAppraisalReq() {
        return appraisalReq;
    }

    public void setAppraisalReq(int appraisalReq) {
        this.appraisalReq = appraisalReq;
    }

    public int getErmAssignment() {
        return ermAssignment;
    }

    public void setErmAssignment(int ermAssignment) {
        this.ermAssignment = ermAssignment;
    }

    public List<UserPlannedIssues> getPlannedIssuesList() {
        return plannedIssuesList;
    }

    public void setPlannedIssuesList(List<UserPlannedIssues> plannedIssuesList) {
        this.plannedIssuesList = plannedIssuesList;
    }

    public List<String> getWrmIssueList() {
        return wrmIssueList;
    }

    public void setWrmIssueList(List<String> wrmIssueList) {
        this.wrmIssueList = wrmIssueList;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<String> getWrmTouchedIssues() {
        return wrmTouchedIssues;
    }

    public void setWrmTouchedIssues(List<String> wrmTouchedIssues) {
        this.wrmTouchedIssues = wrmTouchedIssues;
    }
}
